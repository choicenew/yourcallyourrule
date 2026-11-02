// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $PluginsTable extends Plugins with TableInfo<$PluginsTable, PluginData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PluginsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
    'version',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<int> isEnabled = GeneratedColumn<int>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _pluginOrderMeta = const VerificationMeta(
    'pluginOrder',
  );
  @override
  late final GeneratedColumn<int> pluginOrder = GeneratedColumn<int>(
    'plugin_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAutoUpdateMeta = const VerificationMeta(
    'isAutoUpdate',
  );
  @override
  late final GeneratedColumn<int> isAutoUpdate = GeneratedColumn<int>(
    'is_auto_update',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _configJsonMeta = const VerificationMeta(
    'configJson',
  );
  @override
  late final GeneratedColumn<String> configJson = GeneratedColumn<String>(
    'config_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    url,
    version,
    description,
    isEnabled,
    pluginOrder,
    isAutoUpdate,
    configJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plugins';
  @override
  VerificationContext validateIntegrity(
    Insertable<PluginData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('plugin_order')) {
      context.handle(
        _pluginOrderMeta,
        pluginOrder.isAcceptableOrUnknown(
          data['plugin_order']!,
          _pluginOrderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pluginOrderMeta);
    }
    if (data.containsKey('is_auto_update')) {
      context.handle(
        _isAutoUpdateMeta,
        isAutoUpdate.isAcceptableOrUnknown(
          data['is_auto_update']!,
          _isAutoUpdateMeta,
        ),
      );
    }
    if (data.containsKey('config_json')) {
      context.handle(
        _configJsonMeta,
        configJson.isAcceptableOrUnknown(data['config_json']!, _configJsonMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PluginData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PluginData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}version'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_enabled'],
      )!,
      pluginOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plugin_order'],
      )!,
      isAutoUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_auto_update'],
      )!,
      configJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}config_json'],
      ),
    );
  }

  @override
  $PluginsTable createAlias(String alias) {
    return $PluginsTable(attachedDatabase, alias);
  }
}

class PluginData extends DataClass implements Insertable<PluginData> {
  final String id;
  final String name;
  final String url;
  final String version;
  final String? description;
  final int isEnabled;
  final int pluginOrder;
  final int isAutoUpdate;
  final String? configJson;
  const PluginData({
    required this.id,
    required this.name,
    required this.url,
    required this.version,
    this.description,
    required this.isEnabled,
    required this.pluginOrder,
    required this.isAutoUpdate,
    this.configJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['url'] = Variable<String>(url);
    map['version'] = Variable<String>(version);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_enabled'] = Variable<int>(isEnabled);
    map['plugin_order'] = Variable<int>(pluginOrder);
    map['is_auto_update'] = Variable<int>(isAutoUpdate);
    if (!nullToAbsent || configJson != null) {
      map['config_json'] = Variable<String>(configJson);
    }
    return map;
  }

  PluginsCompanion toCompanion(bool nullToAbsent) {
    return PluginsCompanion(
      id: Value(id),
      name: Value(name),
      url: Value(url),
      version: Value(version),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isEnabled: Value(isEnabled),
      pluginOrder: Value(pluginOrder),
      isAutoUpdate: Value(isAutoUpdate),
      configJson: configJson == null && nullToAbsent
          ? const Value.absent()
          : Value(configJson),
    );
  }

  factory PluginData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PluginData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      url: serializer.fromJson<String>(json['url']),
      version: serializer.fromJson<String>(json['version']),
      description: serializer.fromJson<String?>(json['description']),
      isEnabled: serializer.fromJson<int>(json['isEnabled']),
      pluginOrder: serializer.fromJson<int>(json['pluginOrder']),
      isAutoUpdate: serializer.fromJson<int>(json['isAutoUpdate']),
      configJson: serializer.fromJson<String?>(json['configJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'url': serializer.toJson<String>(url),
      'version': serializer.toJson<String>(version),
      'description': serializer.toJson<String?>(description),
      'isEnabled': serializer.toJson<int>(isEnabled),
      'pluginOrder': serializer.toJson<int>(pluginOrder),
      'isAutoUpdate': serializer.toJson<int>(isAutoUpdate),
      'configJson': serializer.toJson<String?>(configJson),
    };
  }

  PluginData copyWith({
    String? id,
    String? name,
    String? url,
    String? version,
    Value<String?> description = const Value.absent(),
    int? isEnabled,
    int? pluginOrder,
    int? isAutoUpdate,
    Value<String?> configJson = const Value.absent(),
  }) => PluginData(
    id: id ?? this.id,
    name: name ?? this.name,
    url: url ?? this.url,
    version: version ?? this.version,
    description: description.present ? description.value : this.description,
    isEnabled: isEnabled ?? this.isEnabled,
    pluginOrder: pluginOrder ?? this.pluginOrder,
    isAutoUpdate: isAutoUpdate ?? this.isAutoUpdate,
    configJson: configJson.present ? configJson.value : this.configJson,
  );
  PluginData copyWithCompanion(PluginsCompanion data) {
    return PluginData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      url: data.url.present ? data.url.value : this.url,
      version: data.version.present ? data.version.value : this.version,
      description: data.description.present
          ? data.description.value
          : this.description,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      pluginOrder: data.pluginOrder.present
          ? data.pluginOrder.value
          : this.pluginOrder,
      isAutoUpdate: data.isAutoUpdate.present
          ? data.isAutoUpdate.value
          : this.isAutoUpdate,
      configJson: data.configJson.present
          ? data.configJson.value
          : this.configJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PluginData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('version: $version, ')
          ..write('description: $description, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('pluginOrder: $pluginOrder, ')
          ..write('isAutoUpdate: $isAutoUpdate, ')
          ..write('configJson: $configJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    url,
    version,
    description,
    isEnabled,
    pluginOrder,
    isAutoUpdate,
    configJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PluginData &&
          other.id == this.id &&
          other.name == this.name &&
          other.url == this.url &&
          other.version == this.version &&
          other.description == this.description &&
          other.isEnabled == this.isEnabled &&
          other.pluginOrder == this.pluginOrder &&
          other.isAutoUpdate == this.isAutoUpdate &&
          other.configJson == this.configJson);
}

class PluginsCompanion extends UpdateCompanion<PluginData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> url;
  final Value<String> version;
  final Value<String?> description;
  final Value<int> isEnabled;
  final Value<int> pluginOrder;
  final Value<int> isAutoUpdate;
  final Value<String?> configJson;
  final Value<int> rowid;
  const PluginsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.url = const Value.absent(),
    this.version = const Value.absent(),
    this.description = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.pluginOrder = const Value.absent(),
    this.isAutoUpdate = const Value.absent(),
    this.configJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PluginsCompanion.insert({
    required String id,
    required String name,
    required String url,
    required String version,
    this.description = const Value.absent(),
    this.isEnabled = const Value.absent(),
    required int pluginOrder,
    this.isAutoUpdate = const Value.absent(),
    this.configJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       url = Value(url),
       version = Value(version),
       pluginOrder = Value(pluginOrder);
  static Insertable<PluginData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? url,
    Expression<String>? version,
    Expression<String>? description,
    Expression<int>? isEnabled,
    Expression<int>? pluginOrder,
    Expression<int>? isAutoUpdate,
    Expression<String>? configJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (url != null) 'url': url,
      if (version != null) 'version': version,
      if (description != null) 'description': description,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (pluginOrder != null) 'plugin_order': pluginOrder,
      if (isAutoUpdate != null) 'is_auto_update': isAutoUpdate,
      if (configJson != null) 'config_json': configJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PluginsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? url,
    Value<String>? version,
    Value<String?>? description,
    Value<int>? isEnabled,
    Value<int>? pluginOrder,
    Value<int>? isAutoUpdate,
    Value<String?>? configJson,
    Value<int>? rowid,
  }) {
    return PluginsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      version: version ?? this.version,
      description: description ?? this.description,
      isEnabled: isEnabled ?? this.isEnabled,
      pluginOrder: pluginOrder ?? this.pluginOrder,
      isAutoUpdate: isAutoUpdate ?? this.isAutoUpdate,
      configJson: configJson ?? this.configJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<int>(isEnabled.value);
    }
    if (pluginOrder.present) {
      map['plugin_order'] = Variable<int>(pluginOrder.value);
    }
    if (isAutoUpdate.present) {
      map['is_auto_update'] = Variable<int>(isAutoUpdate.value);
    }
    if (configJson.present) {
      map['config_json'] = Variable<String>(configJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PluginsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('version: $version, ')
          ..write('description: $description, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('pluginOrder: $pluginOrder, ')
          ..write('isAutoUpdate: $isAutoUpdate, ')
          ..write('configJson: $configJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $PluginsTable plugins = $PluginsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [plugins];
}

typedef $$PluginsTableCreateCompanionBuilder =
    PluginsCompanion Function({
      required String id,
      required String name,
      required String url,
      required String version,
      Value<String?> description,
      Value<int> isEnabled,
      required int pluginOrder,
      Value<int> isAutoUpdate,
      Value<String?> configJson,
      Value<int> rowid,
    });
typedef $$PluginsTableUpdateCompanionBuilder =
    PluginsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> url,
      Value<String> version,
      Value<String?> description,
      Value<int> isEnabled,
      Value<int> pluginOrder,
      Value<int> isAutoUpdate,
      Value<String?> configJson,
      Value<int> rowid,
    });

class $$PluginsTableFilterComposer
    extends Composer<_$LocalDatabase, $PluginsTable> {
  $$PluginsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pluginOrder => $composableBuilder(
    column: $table.pluginOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isAutoUpdate => $composableBuilder(
    column: $table.isAutoUpdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get configJson => $composableBuilder(
    column: $table.configJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PluginsTableOrderingComposer
    extends Composer<_$LocalDatabase, $PluginsTable> {
  $$PluginsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pluginOrder => $composableBuilder(
    column: $table.pluginOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isAutoUpdate => $composableBuilder(
    column: $table.isAutoUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get configJson => $composableBuilder(
    column: $table.configJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PluginsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $PluginsTable> {
  $$PluginsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<int> get pluginOrder => $composableBuilder(
    column: $table.pluginOrder,
    builder: (column) => column,
  );

  GeneratedColumn<int> get isAutoUpdate => $composableBuilder(
    column: $table.isAutoUpdate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get configJson => $composableBuilder(
    column: $table.configJson,
    builder: (column) => column,
  );
}

class $$PluginsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $PluginsTable,
          PluginData,
          $$PluginsTableFilterComposer,
          $$PluginsTableOrderingComposer,
          $$PluginsTableAnnotationComposer,
          $$PluginsTableCreateCompanionBuilder,
          $$PluginsTableUpdateCompanionBuilder,
          (
            PluginData,
            BaseReferences<_$LocalDatabase, $PluginsTable, PluginData>,
          ),
          PluginData,
          PrefetchHooks Function()
        > {
  $$PluginsTableTableManager(_$LocalDatabase db, $PluginsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PluginsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PluginsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PluginsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String> version = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> isEnabled = const Value.absent(),
                Value<int> pluginOrder = const Value.absent(),
                Value<int> isAutoUpdate = const Value.absent(),
                Value<String?> configJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PluginsCompanion(
                id: id,
                name: name,
                url: url,
                version: version,
                description: description,
                isEnabled: isEnabled,
                pluginOrder: pluginOrder,
                isAutoUpdate: isAutoUpdate,
                configJson: configJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String url,
                required String version,
                Value<String?> description = const Value.absent(),
                Value<int> isEnabled = const Value.absent(),
                required int pluginOrder,
                Value<int> isAutoUpdate = const Value.absent(),
                Value<String?> configJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PluginsCompanion.insert(
                id: id,
                name: name,
                url: url,
                version: version,
                description: description,
                isEnabled: isEnabled,
                pluginOrder: pluginOrder,
                isAutoUpdate: isAutoUpdate,
                configJson: configJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PluginsTable, PluginData>(table),
                  BaseReferences<_$LocalDatabase, $PluginsTable, PluginData>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PluginsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $PluginsTable,
      PluginData,
      $$PluginsTableFilterComposer,
      $$PluginsTableOrderingComposer,
      $$PluginsTableAnnotationComposer,
      $$PluginsTableCreateCompanionBuilder,
      $$PluginsTableUpdateCompanionBuilder,
      (PluginData, BaseReferences<_$LocalDatabase, $PluginsTable, PluginData>),
      PluginData,
      PrefetchHooks Function()
    >;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$PluginsTableTableManager get plugins =>
      $$PluginsTableTableManager(_db, _db.plugins);
}
