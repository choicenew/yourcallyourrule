import 'package:postgres/postgres.dart';
import 'package:pyro_sync_supabase/interfaces/supabase_sync_database.dart';
import 'package:pyro_sync_supabase/services/schema_generator.dart';

/// Initializes Supabase (Postgres) database schema
class SupabaseDbInitializer {
  final SupabaseSyncDatabase _database;

  SupabaseDbInitializer(this._database);

  /// Initialize database schema using connection string
  ///
  /// [connectionUri] - Postgres connection string
  ///   Format: postgresql://user:password@host:port/database
  Future<void> initializeSchema(String connectionUri) async {
    final uri = Uri.parse(connectionUri);
    final connection = await Connection.open(
      Endpoint(
        host: uri.host,
        database: uri.pathSegments.first,
        username: uri.userInfo.split(':').first,
        password: uri.userInfo.split(':').last,
        port: uri.port,
      ),
      settings: ConnectionSettings(sslMode: SslMode.require),
    );

    try {
      await connection.runTx((session) async {
        // 1. Create trigger function for updated_at
        await session.execute('''
          CREATE OR REPLACE FUNCTION update_updated_at_column()
          RETURNS TRIGGER AS \$\$
          BEGIN
             NEW.updated_at = now();
             RETURN NEW;
          END;
          \$\$ language 'plpgsql';
        ''');

        // 2. Generate and execute CREATE TABLE statements
        final tables = _database.syncTableNames
            .map((name) => _database.getTableSchema(name))
            .toList();

        final generator = SchemaGenerator();
        final sqlStatements = generator.generateSchema(tables);

        // 3. Execute all CREATE TABLE statements and create triggers
        for (final sql in sqlStatements) {
          await session.execute(sql);

          // Extract table name from SQL
          final match = RegExp(r'CREATE TABLE IF NOT EXISTS\s+(\w+)\s*\(')
              .firstMatch(sql);
          if (match != null) {
            final tableName = match.group(1)!;
            await _createTrigger(session, tableName);
          }
        }
      });
    } finally {
      await connection.close();
    }
  }

  /// Create trigger for updating updated_at column
  Future<void> _createTrigger(TxSession session, String tableName) async {
    await session.execute(
        'DROP TRIGGER IF EXISTS update_${tableName}_modtime ON $tableName;');
    await session.execute('''
      CREATE TRIGGER update_${tableName}_modtime
      BEFORE UPDATE ON $tableName
      FOR EACH ROW
      EXECUTE PROCEDURE update_updated_at_column();
    ''');
  }
}
