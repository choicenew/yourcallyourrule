/// Database abstraction for Supabase sync
///
/// Implement this interface to provide database access for any local database
/// (Drift, Isar, SQLFlite, Hive, ObjectBox, etc.)
abstract class SupabaseSyncDatabase {
  /// Get all table names that should be synced to Supabase
  List<String> get syncTableNames;

  /// Get table schema for Postgres generation
  ///
  /// Used by [SchemaGenerator] to create Postgres tables
  TableSchema getTableSchema(String tableName);

  /// Read records by their primary key IDs
  ///
  /// Returns list of records as JSON-compatible maps
  Future<List<Map<String, dynamic>>> readRecords(
    String tableName,
    List<String> ids,
  );

  /// Write/update records in batch
  ///
  /// [records] - List of JSON-compatible maps to write
  /// [replaceExisting] - If true, replace existing records (UPSERT),
  ///                     if false, ignore conflicts (INSERT OR IGNORE)
  Future<void> writeRecords(
    String tableName,
    List<Map<String, dynamic>> records, {
    bool replaceExisting = true,
  });

  /// Get primary key field name for a table
  ///
  /// Example: 'id', 'phone_number', 'pattern', etc.
  String getPrimaryKeyName(String tableName);
}

/// Table schema definition (database-agnostic)
class TableSchema {
  final String tableName;
  final List<ColumnSchema> columns;
  final List<String> primaryKeys;

  const TableSchema({
    required this.tableName,
    required this.columns,
    required this.primaryKeys,
  });
}

/// Column schema definition
class ColumnSchema {
  final String name;
  final ColumnType type;
  final bool nullable;

  const ColumnSchema({
    required this.name,
    required this.type,
    this.nullable = false,
  });
}

/// Generic column types that map to various database implementations
enum ColumnType {
  /// Integer type (int, INT, INTEGER)
  integer,

  /// Text/String type (TEXT, VARCHAR, String)
  text,

  /// Real/Double type (REAL, DOUBLE, double)
  real,

  /// Boolean type (BOOLEAN, INTEGER as bool, bool)
  boolean,

  /// DateTime type (DATETIME, TIMESTAMP, DateTime)
  dateTime,

  /// Binary/Blob type (BLOB, BYTEA, Uint8List)
  blob,
}
