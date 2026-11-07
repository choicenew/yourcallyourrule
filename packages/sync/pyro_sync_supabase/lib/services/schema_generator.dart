import 'package:pyro_sync_supabase/interfaces/supabase_sync_database.dart';

/// Generates Postgres schema from database-agnostic table definitions
class SchemaGenerator {
  /// Generate CREATE TABLE statements for all tables
  List<String> generateSchema(List<TableSchema> tables) {
    return tables.map(_generateCreateTableSql).toList();
  }

  /// Generate single CREATE TABLE statement
  String _generateCreateTableSql(TableSchema table) {
    final buffer = StringBuffer();
    buffer.writeln('CREATE TABLE IF NOT EXISTS ${table.tableName} (');

    // 1. Add all columns
    for (final column in table.columns) {
      // Skip system fields that we'll add separately
      if (column.name == 'updated_at' || column.name == 'modified_by_device') {
        continue;
      }

      final pgType = _mapColumnTypeToPostgres(column.type);

      // Check if this column is part of primary key
      final isPrimaryKey = table.primaryKeys.contains(column.name);
      final pkSuffix =
          (isPrimaryKey && table.primaryKeys.length == 1) ? ' PRIMARY KEY' : '';

      buffer.write('  ${column.name} $pgType$pkSuffix,');
      buffer.writeln();
    }

    // 2. Add composite primary key if needed
    if (table.primaryKeys.length > 1) {
      final pkNames = table.primaryKeys.join(', ');
      buffer.writeln('  PRIMARY KEY ($pkNames),');
    }

    // 3. Add system sync fields
    buffer.writeln('  updated_at timestamptz DEFAULT now(),');
    buffer.writeln('  modified_by_device text');

    buffer.writeln(');');

    return buffer.toString();
  }

  /// Map generic column type to Postgres type
  String _mapColumnTypeToPostgres(ColumnType type) {
    switch (type) {
      case ColumnType.integer:
        return 'integer';
      case ColumnType.real:
        return 'double precision';
      case ColumnType.boolean:
        return 'integer'; // Store booleans as 0/1
      case ColumnType.dateTime:
        return 'timestamptz';
      case ColumnType.blob:
        return 'bytea';
      case ColumnType.text:
        return 'text';
    }
  }
}
