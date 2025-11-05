// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_database.dart';

// ignore_for_file: type=lint
class $RemoteNumbersTable extends RemoteNumbers
    with TableInfo<$RemoteNumbersTable, RemoteNumberData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemoteNumbersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
    'count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _labelsJsonMeta = const VerificationMeta(
    'labelsJson',
  );
  @override
  late final GeneratedColumn<String> labelsJson = GeneratedColumn<String>(
    'labels_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    phoneNumber,
    name,
    label,
    priority,
    action,
    count,
    labelsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'remote_numbers';
  @override
  VerificationContext validateIntegrity(
    Insertable<RemoteNumberData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    }
    if (data.containsKey('labels_json')) {
      context.handle(
        _labelsJsonMeta,
        labelsJson.isAcceptableOrUnknown(data['labels_json']!, _labelsJsonMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {phoneNumber};
  @override
  RemoteNumberData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RemoteNumberData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      phoneNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}phone_number'],
          )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      label:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}label'],
          )!,
      priority:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}priority'],
          )!,
      action:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}action'],
          )!,
      count:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}count'],
          )!,
      labelsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}labels_json'],
      ),
    );
  }

  @override
  $RemoteNumbersTable createAlias(String alias) {
    return $RemoteNumbersTable(attachedDatabase, alias);
  }
}

class RemoteNumberData extends DataClass
    implements Insertable<RemoteNumberData> {
  final String id;
  final String phoneNumber;
  final String? name;
  final String label;
  final int priority;
  final String action;
  final int count;
  final String? labelsJson;
  const RemoteNumberData({
    required this.id,
    required this.phoneNumber,
    this.name,
    required this.label,
    required this.priority,
    required this.action,
    required this.count,
    this.labelsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['phone_number'] = Variable<String>(phoneNumber);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['label'] = Variable<String>(label);
    map['priority'] = Variable<int>(priority);
    map['action'] = Variable<String>(action);
    map['count'] = Variable<int>(count);
    if (!nullToAbsent || labelsJson != null) {
      map['labels_json'] = Variable<String>(labelsJson);
    }
    return map;
  }

  RemoteNumbersCompanion toCompanion(bool nullToAbsent) {
    return RemoteNumbersCompanion(
      id: Value(id),
      phoneNumber: Value(phoneNumber),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      label: Value(label),
      priority: Value(priority),
      action: Value(action),
      count: Value(count),
      labelsJson:
          labelsJson == null && nullToAbsent
              ? const Value.absent()
              : Value(labelsJson),
    );
  }

  factory RemoteNumberData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RemoteNumberData(
      id: serializer.fromJson<String>(json['id']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      name: serializer.fromJson<String?>(json['name']),
      label: serializer.fromJson<String>(json['label']),
      priority: serializer.fromJson<int>(json['priority']),
      action: serializer.fromJson<String>(json['action']),
      count: serializer.fromJson<int>(json['count']),
      labelsJson: serializer.fromJson<String?>(json['labelsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'name': serializer.toJson<String?>(name),
      'label': serializer.toJson<String>(label),
      'priority': serializer.toJson<int>(priority),
      'action': serializer.toJson<String>(action),
      'count': serializer.toJson<int>(count),
      'labelsJson': serializer.toJson<String?>(labelsJson),
    };
  }

  RemoteNumberData copyWith({
    String? id,
    String? phoneNumber,
    Value<String?> name = const Value.absent(),
    String? label,
    int? priority,
    String? action,
    int? count,
    Value<String?> labelsJson = const Value.absent(),
  }) => RemoteNumberData(
    id: id ?? this.id,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    name: name.present ? name.value : this.name,
    label: label ?? this.label,
    priority: priority ?? this.priority,
    action: action ?? this.action,
    count: count ?? this.count,
    labelsJson: labelsJson.present ? labelsJson.value : this.labelsJson,
  );
  RemoteNumberData copyWithCompanion(RemoteNumbersCompanion data) {
    return RemoteNumberData(
      id: data.id.present ? data.id.value : this.id,
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      name: data.name.present ? data.name.value : this.name,
      label: data.label.present ? data.label.value : this.label,
      priority: data.priority.present ? data.priority.value : this.priority,
      action: data.action.present ? data.action.value : this.action,
      count: data.count.present ? data.count.value : this.count,
      labelsJson:
          data.labelsJson.present ? data.labelsJson.value : this.labelsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RemoteNumberData(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('name: $name, ')
          ..write('label: $label, ')
          ..write('priority: $priority, ')
          ..write('action: $action, ')
          ..write('count: $count, ')
          ..write('labelsJson: $labelsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    phoneNumber,
    name,
    label,
    priority,
    action,
    count,
    labelsJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RemoteNumberData &&
          other.id == this.id &&
          other.phoneNumber == this.phoneNumber &&
          other.name == this.name &&
          other.label == this.label &&
          other.priority == this.priority &&
          other.action == this.action &&
          other.count == this.count &&
          other.labelsJson == this.labelsJson);
}

class RemoteNumbersCompanion extends UpdateCompanion<RemoteNumberData> {
  final Value<String> id;
  final Value<String> phoneNumber;
  final Value<String?> name;
  final Value<String> label;
  final Value<int> priority;
  final Value<String> action;
  final Value<int> count;
  final Value<String?> labelsJson;
  final Value<int> rowid;
  const RemoteNumbersCompanion({
    this.id = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.name = const Value.absent(),
    this.label = const Value.absent(),
    this.priority = const Value.absent(),
    this.action = const Value.absent(),
    this.count = const Value.absent(),
    this.labelsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemoteNumbersCompanion.insert({
    required String id,
    required String phoneNumber,
    this.name = const Value.absent(),
    required String label,
    this.priority = const Value.absent(),
    this.action = const Value.absent(),
    this.count = const Value.absent(),
    this.labelsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       phoneNumber = Value(phoneNumber),
       label = Value(label);
  static Insertable<RemoteNumberData> custom({
    Expression<String>? id,
    Expression<String>? phoneNumber,
    Expression<String>? name,
    Expression<String>? label,
    Expression<int>? priority,
    Expression<String>? action,
    Expression<int>? count,
    Expression<String>? labelsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (name != null) 'name': name,
      if (label != null) 'label': label,
      if (priority != null) 'priority': priority,
      if (action != null) 'action': action,
      if (count != null) 'count': count,
      if (labelsJson != null) 'labels_json': labelsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemoteNumbersCompanion copyWith({
    Value<String>? id,
    Value<String>? phoneNumber,
    Value<String?>? name,
    Value<String>? label,
    Value<int>? priority,
    Value<String>? action,
    Value<int>? count,
    Value<String?>? labelsJson,
    Value<int>? rowid,
  }) {
    return RemoteNumbersCompanion(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      label: label ?? this.label,
      priority: priority ?? this.priority,
      action: action ?? this.action,
      count: count ?? this.count,
      labelsJson: labelsJson ?? this.labelsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (labelsJson.present) {
      map['labels_json'] = Variable<String>(labelsJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemoteNumbersCompanion(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('name: $name, ')
          ..write('label: $label, ')
          ..write('priority: $priority, ')
          ..write('action: $action, ')
          ..write('count: $count, ')
          ..write('labelsJson: $labelsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NumberCountriesTable extends NumberCountries
    with TableInfo<$NumberCountriesTable, NumberCountryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NumberCountriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES remote_numbers (phone_number) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _countryIsoCodeMeta = const VerificationMeta(
    'countryIsoCode',
  );
  @override
  late final GeneratedColumn<String> countryIsoCode = GeneratedColumn<String>(
    'country_iso_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [phoneNumber, countryIsoCode];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'number_countries';
  @override
  VerificationContext validateIntegrity(
    Insertable<NumberCountryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('country_iso_code')) {
      context.handle(
        _countryIsoCodeMeta,
        countryIsoCode.isAcceptableOrUnknown(
          data['country_iso_code']!,
          _countryIsoCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_countryIsoCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {phoneNumber, countryIsoCode};
  @override
  NumberCountryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NumberCountryData(
      phoneNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}phone_number'],
          )!,
      countryIsoCode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}country_iso_code'],
          )!,
    );
  }

  @override
  $NumberCountriesTable createAlias(String alias) {
    return $NumberCountriesTable(attachedDatabase, alias);
  }
}

class NumberCountryData extends DataClass
    implements Insertable<NumberCountryData> {
  final String phoneNumber;
  final String countryIsoCode;
  const NumberCountryData({
    required this.phoneNumber,
    required this.countryIsoCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['phone_number'] = Variable<String>(phoneNumber);
    map['country_iso_code'] = Variable<String>(countryIsoCode);
    return map;
  }

  NumberCountriesCompanion toCompanion(bool nullToAbsent) {
    return NumberCountriesCompanion(
      phoneNumber: Value(phoneNumber),
      countryIsoCode: Value(countryIsoCode),
    );
  }

  factory NumberCountryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NumberCountryData(
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      countryIsoCode: serializer.fromJson<String>(json['countryIsoCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'countryIsoCode': serializer.toJson<String>(countryIsoCode),
    };
  }

  NumberCountryData copyWith({String? phoneNumber, String? countryIsoCode}) =>
      NumberCountryData(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        countryIsoCode: countryIsoCode ?? this.countryIsoCode,
      );
  NumberCountryData copyWithCompanion(NumberCountriesCompanion data) {
    return NumberCountryData(
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      countryIsoCode:
          data.countryIsoCode.present
              ? data.countryIsoCode.value
              : this.countryIsoCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NumberCountryData(')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('countryIsoCode: $countryIsoCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(phoneNumber, countryIsoCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NumberCountryData &&
          other.phoneNumber == this.phoneNumber &&
          other.countryIsoCode == this.countryIsoCode);
}

class NumberCountriesCompanion extends UpdateCompanion<NumberCountryData> {
  final Value<String> phoneNumber;
  final Value<String> countryIsoCode;
  final Value<int> rowid;
  const NumberCountriesCompanion({
    this.phoneNumber = const Value.absent(),
    this.countryIsoCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NumberCountriesCompanion.insert({
    required String phoneNumber,
    required String countryIsoCode,
    this.rowid = const Value.absent(),
  }) : phoneNumber = Value(phoneNumber),
       countryIsoCode = Value(countryIsoCode);
  static Insertable<NumberCountryData> custom({
    Expression<String>? phoneNumber,
    Expression<String>? countryIsoCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (countryIsoCode != null) 'country_iso_code': countryIsoCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NumberCountriesCompanion copyWith({
    Value<String>? phoneNumber,
    Value<String>? countryIsoCode,
    Value<int>? rowid,
  }) {
    return NumberCountriesCompanion(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryIsoCode: countryIsoCode ?? this.countryIsoCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (countryIsoCode.present) {
      map['country_iso_code'] = Variable<String>(countryIsoCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NumberCountriesCompanion(')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('countryIsoCode: $countryIsoCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PendingOperationsTable extends PendingOperations
    with TableInfo<$PendingOperationsTable, PendingOperationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingOperationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<String> timestamp = GeneratedColumn<String>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityId,
    operation,
    payload,
    timestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_operations';
  @override
  VerificationContext validateIntegrity(
    Insertable<PendingOperationData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PendingOperationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingOperationData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      entityId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}entity_id'],
          )!,
      operation:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}operation'],
          )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      ),
      timestamp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}timestamp'],
          )!,
    );
  }

  @override
  $PendingOperationsTable createAlias(String alias) {
    return $PendingOperationsTable(attachedDatabase, alias);
  }
}

class PendingOperationData extends DataClass
    implements Insertable<PendingOperationData> {
  final String id;
  final String entityId;
  final String operation;
  final String? payload;
  final String timestamp;
  const PendingOperationData({
    required this.id,
    required this.entityId,
    required this.operation,
    this.payload,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    if (!nullToAbsent || payload != null) {
      map['payload'] = Variable<String>(payload);
    }
    map['timestamp'] = Variable<String>(timestamp);
    return map;
  }

  PendingOperationsCompanion toCompanion(bool nullToAbsent) {
    return PendingOperationsCompanion(
      id: Value(id),
      entityId: Value(entityId),
      operation: Value(operation),
      payload:
          payload == null && nullToAbsent
              ? const Value.absent()
              : Value(payload),
      timestamp: Value(timestamp),
    );
  }

  factory PendingOperationData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingOperationData(
      id: serializer.fromJson<String>(json['id']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String?>(json['payload']),
      timestamp: serializer.fromJson<String>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entityId': serializer.toJson<String>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String?>(payload),
      'timestamp': serializer.toJson<String>(timestamp),
    };
  }

  PendingOperationData copyWith({
    String? id,
    String? entityId,
    String? operation,
    Value<String?> payload = const Value.absent(),
    String? timestamp,
  }) => PendingOperationData(
    id: id ?? this.id,
    entityId: entityId ?? this.entityId,
    operation: operation ?? this.operation,
    payload: payload.present ? payload.value : this.payload,
    timestamp: timestamp ?? this.timestamp,
  );
  PendingOperationData copyWithCompanion(PendingOperationsCompanion data) {
    return PendingOperationData(
      id: data.id.present ? data.id.value : this.id,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingOperationData(')
          ..write('id: $id, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, entityId, operation, payload, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingOperationData &&
          other.id == this.id &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.timestamp == this.timestamp);
}

class PendingOperationsCompanion extends UpdateCompanion<PendingOperationData> {
  final Value<String> id;
  final Value<String> entityId;
  final Value<String> operation;
  final Value<String?> payload;
  final Value<String> timestamp;
  final Value<int> rowid;
  const PendingOperationsCompanion({
    this.id = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PendingOperationsCompanion.insert({
    required String id,
    required String entityId,
    required String operation,
    this.payload = const Value.absent(),
    required String timestamp,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entityId = Value(entityId),
       operation = Value(operation),
       timestamp = Value(timestamp);
  static Insertable<PendingOperationData> custom({
    Expression<String>? id,
    Expression<String>? entityId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<String>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PendingOperationsCompanion copyWith({
    Value<String>? id,
    Value<String>? entityId,
    Value<String>? operation,
    Value<String?>? payload,
    Value<String>? timestamp,
    Value<int>? rowid,
  }) {
    return PendingOperationsCompanion(
      id: id ?? this.id,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<String>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingOperationsCompanion(')
          ..write('id: $id, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncRecordsTable extends SyncRecords
    with TableInfo<$SyncRecordsTable, SyncRecordData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncTimeMeta = const VerificationMeta(
    'syncTime',
  );
  @override
  late final GeneratedColumn<String> syncTime = GeneratedColumn<String>(
    'sync_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncTypeMeta = const VerificationMeta(
    'syncType',
  );
  @override
  late final GeneratedColumn<String> syncType = GeneratedColumn<String>(
    'sync_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pushedRecordCountMeta = const VerificationMeta(
    'pushedRecordCount',
  );
  @override
  late final GeneratedColumn<int> pushedRecordCount = GeneratedColumn<int>(
    'pushed_record_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pulledRecordCountMeta = const VerificationMeta(
    'pulledRecordCount',
  );
  @override
  late final GeneratedColumn<int> pulledRecordCount = GeneratedColumn<int>(
    'pulled_record_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncTime,
    syncType,
    status,
    pushedRecordCount,
    pulledRecordCount,
    errorMessage,
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncRecordData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sync_time')) {
      context.handle(
        _syncTimeMeta,
        syncTime.isAcceptableOrUnknown(data['sync_time']!, _syncTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_syncTimeMeta);
    }
    if (data.containsKey('sync_type')) {
      context.handle(
        _syncTypeMeta,
        syncType.isAcceptableOrUnknown(data['sync_type']!, _syncTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_syncTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('pushed_record_count')) {
      context.handle(
        _pushedRecordCountMeta,
        pushedRecordCount.isAcceptableOrUnknown(
          data['pushed_record_count']!,
          _pushedRecordCountMeta,
        ),
      );
    }
    if (data.containsKey('pulled_record_count')) {
      context.handle(
        _pulledRecordCountMeta,
        pulledRecordCount.isAcceptableOrUnknown(
          data['pulled_record_count']!,
          _pulledRecordCountMeta,
        ),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncRecordData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncRecordData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      syncTime:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}sync_time'],
          )!,
      syncType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}sync_type'],
          )!,
      status:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}status'],
          )!,
      pushedRecordCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pushed_record_count'],
      ),
      pulledRecordCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pulled_record_count'],
      ),
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      ),
    );
  }

  @override
  $SyncRecordsTable createAlias(String alias) {
    return $SyncRecordsTable(attachedDatabase, alias);
  }
}

class SyncRecordData extends DataClass implements Insertable<SyncRecordData> {
  final String id;
  final String syncTime;
  final String syncType;
  final String status;
  final int? pushedRecordCount;
  final int? pulledRecordCount;
  final String? errorMessage;
  final String? metadata;
  const SyncRecordData({
    required this.id,
    required this.syncTime,
    required this.syncType,
    required this.status,
    this.pushedRecordCount,
    this.pulledRecordCount,
    this.errorMessage,
    this.metadata,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sync_time'] = Variable<String>(syncTime);
    map['sync_type'] = Variable<String>(syncType);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || pushedRecordCount != null) {
      map['pushed_record_count'] = Variable<int>(pushedRecordCount);
    }
    if (!nullToAbsent || pulledRecordCount != null) {
      map['pulled_record_count'] = Variable<int>(pulledRecordCount);
    }
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    return map;
  }

  SyncRecordsCompanion toCompanion(bool nullToAbsent) {
    return SyncRecordsCompanion(
      id: Value(id),
      syncTime: Value(syncTime),
      syncType: Value(syncType),
      status: Value(status),
      pushedRecordCount:
          pushedRecordCount == null && nullToAbsent
              ? const Value.absent()
              : Value(pushedRecordCount),
      pulledRecordCount:
          pulledRecordCount == null && nullToAbsent
              ? const Value.absent()
              : Value(pulledRecordCount),
      errorMessage:
          errorMessage == null && nullToAbsent
              ? const Value.absent()
              : Value(errorMessage),
      metadata:
          metadata == null && nullToAbsent
              ? const Value.absent()
              : Value(metadata),
    );
  }

  factory SyncRecordData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncRecordData(
      id: serializer.fromJson<String>(json['id']),
      syncTime: serializer.fromJson<String>(json['syncTime']),
      syncType: serializer.fromJson<String>(json['syncType']),
      status: serializer.fromJson<String>(json['status']),
      pushedRecordCount: serializer.fromJson<int?>(json['pushedRecordCount']),
      pulledRecordCount: serializer.fromJson<int?>(json['pulledRecordCount']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      metadata: serializer.fromJson<String?>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'syncTime': serializer.toJson<String>(syncTime),
      'syncType': serializer.toJson<String>(syncType),
      'status': serializer.toJson<String>(status),
      'pushedRecordCount': serializer.toJson<int?>(pushedRecordCount),
      'pulledRecordCount': serializer.toJson<int?>(pulledRecordCount),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'metadata': serializer.toJson<String?>(metadata),
    };
  }

  SyncRecordData copyWith({
    String? id,
    String? syncTime,
    String? syncType,
    String? status,
    Value<int?> pushedRecordCount = const Value.absent(),
    Value<int?> pulledRecordCount = const Value.absent(),
    Value<String?> errorMessage = const Value.absent(),
    Value<String?> metadata = const Value.absent(),
  }) => SyncRecordData(
    id: id ?? this.id,
    syncTime: syncTime ?? this.syncTime,
    syncType: syncType ?? this.syncType,
    status: status ?? this.status,
    pushedRecordCount:
        pushedRecordCount.present
            ? pushedRecordCount.value
            : this.pushedRecordCount,
    pulledRecordCount:
        pulledRecordCount.present
            ? pulledRecordCount.value
            : this.pulledRecordCount,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    metadata: metadata.present ? metadata.value : this.metadata,
  );
  SyncRecordData copyWithCompanion(SyncRecordsCompanion data) {
    return SyncRecordData(
      id: data.id.present ? data.id.value : this.id,
      syncTime: data.syncTime.present ? data.syncTime.value : this.syncTime,
      syncType: data.syncType.present ? data.syncType.value : this.syncType,
      status: data.status.present ? data.status.value : this.status,
      pushedRecordCount:
          data.pushedRecordCount.present
              ? data.pushedRecordCount.value
              : this.pushedRecordCount,
      pulledRecordCount:
          data.pulledRecordCount.present
              ? data.pulledRecordCount.value
              : this.pulledRecordCount,
      errorMessage:
          data.errorMessage.present
              ? data.errorMessage.value
              : this.errorMessage,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncRecordData(')
          ..write('id: $id, ')
          ..write('syncTime: $syncTime, ')
          ..write('syncType: $syncType, ')
          ..write('status: $status, ')
          ..write('pushedRecordCount: $pushedRecordCount, ')
          ..write('pulledRecordCount: $pulledRecordCount, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    syncTime,
    syncType,
    status,
    pushedRecordCount,
    pulledRecordCount,
    errorMessage,
    metadata,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncRecordData &&
          other.id == this.id &&
          other.syncTime == this.syncTime &&
          other.syncType == this.syncType &&
          other.status == this.status &&
          other.pushedRecordCount == this.pushedRecordCount &&
          other.pulledRecordCount == this.pulledRecordCount &&
          other.errorMessage == this.errorMessage &&
          other.metadata == this.metadata);
}

class SyncRecordsCompanion extends UpdateCompanion<SyncRecordData> {
  final Value<String> id;
  final Value<String> syncTime;
  final Value<String> syncType;
  final Value<String> status;
  final Value<int?> pushedRecordCount;
  final Value<int?> pulledRecordCount;
  final Value<String?> errorMessage;
  final Value<String?> metadata;
  final Value<int> rowid;
  const SyncRecordsCompanion({
    this.id = const Value.absent(),
    this.syncTime = const Value.absent(),
    this.syncType = const Value.absent(),
    this.status = const Value.absent(),
    this.pushedRecordCount = const Value.absent(),
    this.pulledRecordCount = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncRecordsCompanion.insert({
    required String id,
    required String syncTime,
    required String syncType,
    required String status,
    this.pushedRecordCount = const Value.absent(),
    this.pulledRecordCount = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       syncTime = Value(syncTime),
       syncType = Value(syncType),
       status = Value(status);
  static Insertable<SyncRecordData> custom({
    Expression<String>? id,
    Expression<String>? syncTime,
    Expression<String>? syncType,
    Expression<String>? status,
    Expression<int>? pushedRecordCount,
    Expression<int>? pulledRecordCount,
    Expression<String>? errorMessage,
    Expression<String>? metadata,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncTime != null) 'sync_time': syncTime,
      if (syncType != null) 'sync_type': syncType,
      if (status != null) 'status': status,
      if (pushedRecordCount != null) 'pushed_record_count': pushedRecordCount,
      if (pulledRecordCount != null) 'pulled_record_count': pulledRecordCount,
      if (errorMessage != null) 'error_message': errorMessage,
      if (metadata != null) 'metadata': metadata,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? syncTime,
    Value<String>? syncType,
    Value<String>? status,
    Value<int?>? pushedRecordCount,
    Value<int?>? pulledRecordCount,
    Value<String?>? errorMessage,
    Value<String?>? metadata,
    Value<int>? rowid,
  }) {
    return SyncRecordsCompanion(
      id: id ?? this.id,
      syncTime: syncTime ?? this.syncTime,
      syncType: syncType ?? this.syncType,
      status: status ?? this.status,
      pushedRecordCount: pushedRecordCount ?? this.pushedRecordCount,
      pulledRecordCount: pulledRecordCount ?? this.pulledRecordCount,
      errorMessage: errorMessage ?? this.errorMessage,
      metadata: metadata ?? this.metadata,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (syncTime.present) {
      map['sync_time'] = Variable<String>(syncTime.value);
    }
    if (syncType.present) {
      map['sync_type'] = Variable<String>(syncType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (pushedRecordCount.present) {
      map['pushed_record_count'] = Variable<int>(pushedRecordCount.value);
    }
    if (pulledRecordCount.present) {
      map['pulled_record_count'] = Variable<int>(pulledRecordCount.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncRecordsCompanion(')
          ..write('id: $id, ')
          ..write('syncTime: $syncTime, ')
          ..write('syncType: $syncType, ')
          ..write('status: $status, ')
          ..write('pushedRecordCount: $pushedRecordCount, ')
          ..write('pulledRecordCount: $pulledRecordCount, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('metadata: $metadata, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncConfigTable extends SyncConfig
    with TableInfo<$SyncConfigTable, SyncConfigData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncConfigTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncTimeMeta = const VerificationMeta(
    'lastSyncTime',
  );
  @override
  late final GeneratedColumn<String> lastSyncTime = GeneratedColumn<String>(
    'last_sync_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncIntervalMeta = const VerificationMeta(
    'syncInterval',
  );
  @override
  late final GeneratedColumn<int> syncInterval = GeneratedColumn<int>(
    'sync_interval',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(24),
  );
  static const VerificationMeta _isAutoSyncMeta = const VerificationMeta(
    'isAutoSync',
  );
  @override
  late final GeneratedColumn<int> isAutoSync = GeneratedColumn<int>(
    'is_auto_sync',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lastSyncTime,
    syncInterval,
    isAutoSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_config';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncConfigData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('last_sync_time')) {
      context.handle(
        _lastSyncTimeMeta,
        lastSyncTime.isAcceptableOrUnknown(
          data['last_sync_time']!,
          _lastSyncTimeMeta,
        ),
      );
    }
    if (data.containsKey('sync_interval')) {
      context.handle(
        _syncIntervalMeta,
        syncInterval.isAcceptableOrUnknown(
          data['sync_interval']!,
          _syncIntervalMeta,
        ),
      );
    }
    if (data.containsKey('is_auto_sync')) {
      context.handle(
        _isAutoSyncMeta,
        isAutoSync.isAcceptableOrUnknown(
          data['is_auto_sync']!,
          _isAutoSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncConfigData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncConfigData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      lastSyncTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_sync_time'],
      ),
      syncInterval:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}sync_interval'],
          )!,
      isAutoSync:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}is_auto_sync'],
          )!,
    );
  }

  @override
  $SyncConfigTable createAlias(String alias) {
    return $SyncConfigTable(attachedDatabase, alias);
  }
}

class SyncConfigData extends DataClass implements Insertable<SyncConfigData> {
  final String id;
  final String? lastSyncTime;
  final int syncInterval;
  final int isAutoSync;
  const SyncConfigData({
    required this.id,
    this.lastSyncTime,
    required this.syncInterval,
    required this.isAutoSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || lastSyncTime != null) {
      map['last_sync_time'] = Variable<String>(lastSyncTime);
    }
    map['sync_interval'] = Variable<int>(syncInterval);
    map['is_auto_sync'] = Variable<int>(isAutoSync);
    return map;
  }

  SyncConfigCompanion toCompanion(bool nullToAbsent) {
    return SyncConfigCompanion(
      id: Value(id),
      lastSyncTime:
          lastSyncTime == null && nullToAbsent
              ? const Value.absent()
              : Value(lastSyncTime),
      syncInterval: Value(syncInterval),
      isAutoSync: Value(isAutoSync),
    );
  }

  factory SyncConfigData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncConfigData(
      id: serializer.fromJson<String>(json['id']),
      lastSyncTime: serializer.fromJson<String?>(json['lastSyncTime']),
      syncInterval: serializer.fromJson<int>(json['syncInterval']),
      isAutoSync: serializer.fromJson<int>(json['isAutoSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lastSyncTime': serializer.toJson<String?>(lastSyncTime),
      'syncInterval': serializer.toJson<int>(syncInterval),
      'isAutoSync': serializer.toJson<int>(isAutoSync),
    };
  }

  SyncConfigData copyWith({
    String? id,
    Value<String?> lastSyncTime = const Value.absent(),
    int? syncInterval,
    int? isAutoSync,
  }) => SyncConfigData(
    id: id ?? this.id,
    lastSyncTime: lastSyncTime.present ? lastSyncTime.value : this.lastSyncTime,
    syncInterval: syncInterval ?? this.syncInterval,
    isAutoSync: isAutoSync ?? this.isAutoSync,
  );
  SyncConfigData copyWithCompanion(SyncConfigCompanion data) {
    return SyncConfigData(
      id: data.id.present ? data.id.value : this.id,
      lastSyncTime:
          data.lastSyncTime.present
              ? data.lastSyncTime.value
              : this.lastSyncTime,
      syncInterval:
          data.syncInterval.present
              ? data.syncInterval.value
              : this.syncInterval,
      isAutoSync:
          data.isAutoSync.present ? data.isAutoSync.value : this.isAutoSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncConfigData(')
          ..write('id: $id, ')
          ..write('lastSyncTime: $lastSyncTime, ')
          ..write('syncInterval: $syncInterval, ')
          ..write('isAutoSync: $isAutoSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lastSyncTime, syncInterval, isAutoSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncConfigData &&
          other.id == this.id &&
          other.lastSyncTime == this.lastSyncTime &&
          other.syncInterval == this.syncInterval &&
          other.isAutoSync == this.isAutoSync);
}

class SyncConfigCompanion extends UpdateCompanion<SyncConfigData> {
  final Value<String> id;
  final Value<String?> lastSyncTime;
  final Value<int> syncInterval;
  final Value<int> isAutoSync;
  final Value<int> rowid;
  const SyncConfigCompanion({
    this.id = const Value.absent(),
    this.lastSyncTime = const Value.absent(),
    this.syncInterval = const Value.absent(),
    this.isAutoSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncConfigCompanion.insert({
    required String id,
    this.lastSyncTime = const Value.absent(),
    this.syncInterval = const Value.absent(),
    this.isAutoSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<SyncConfigData> custom({
    Expression<String>? id,
    Expression<String>? lastSyncTime,
    Expression<int>? syncInterval,
    Expression<int>? isAutoSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastSyncTime != null) 'last_sync_time': lastSyncTime,
      if (syncInterval != null) 'sync_interval': syncInterval,
      if (isAutoSync != null) 'is_auto_sync': isAutoSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncConfigCompanion copyWith({
    Value<String>? id,
    Value<String?>? lastSyncTime,
    Value<int>? syncInterval,
    Value<int>? isAutoSync,
    Value<int>? rowid,
  }) {
    return SyncConfigCompanion(
      id: id ?? this.id,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      syncInterval: syncInterval ?? this.syncInterval,
      isAutoSync: isAutoSync ?? this.isAutoSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lastSyncTime.present) {
      map['last_sync_time'] = Variable<String>(lastSyncTime.value);
    }
    if (syncInterval.present) {
      map['sync_interval'] = Variable<int>(syncInterval.value);
    }
    if (isAutoSync.present) {
      map['is_auto_sync'] = Variable<int>(isAutoSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncConfigCompanion(')
          ..write('id: $id, ')
          ..write('lastSyncTime: $lastSyncTime, ')
          ..write('syncInterval: $syncInterval, ')
          ..write('isAutoSync: $isAutoSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActiveDeletionProposalsTable extends ActiveDeletionProposals
    with TableInfo<$ActiveDeletionProposalsTable, ActiveDeletionProposalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActiveDeletionProposalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES remote_numbers (phone_number) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _proposalStartTimeMeta = const VerificationMeta(
    'proposalStartTime',
  );
  @override
  late final GeneratedColumn<String> proposalStartTime =
      GeneratedColumn<String>(
        'proposal_start_time',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _highestRiskLevelMeta = const VerificationMeta(
    'highestRiskLevel',
  );
  @override
  late final GeneratedColumn<String> highestRiskLevel = GeneratedColumn<String>(
    'highest_risk_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proposalCountMeta = const VerificationMeta(
    'proposalCount',
  );
  @override
  late final GeneratedColumn<int> proposalCount = GeneratedColumn<int>(
    'proposal_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _verifiedOwnerCountMeta =
      const VerificationMeta('verifiedOwnerCount');
  @override
  late final GeneratedColumn<int> verifiedOwnerCount = GeneratedColumn<int>(
    'verified_owner_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<String> lastUpdated = GeneratedColumn<String>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _verificationReportJsonMeta =
      const VerificationMeta('verificationReportJson');
  @override
  late final GeneratedColumn<String> verificationReportJson =
      GeneratedColumn<String>(
        'verification_report_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    phoneNumber,
    proposalStartTime,
    status,
    highestRiskLevel,
    proposalCount,
    verifiedOwnerCount,
    lastUpdated,
    verificationReportJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'active_deletion_proposals';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActiveDeletionProposalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('proposal_start_time')) {
      context.handle(
        _proposalStartTimeMeta,
        proposalStartTime.isAcceptableOrUnknown(
          data['proposal_start_time']!,
          _proposalStartTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proposalStartTimeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('highest_risk_level')) {
      context.handle(
        _highestRiskLevelMeta,
        highestRiskLevel.isAcceptableOrUnknown(
          data['highest_risk_level']!,
          _highestRiskLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_highestRiskLevelMeta);
    }
    if (data.containsKey('proposal_count')) {
      context.handle(
        _proposalCountMeta,
        proposalCount.isAcceptableOrUnknown(
          data['proposal_count']!,
          _proposalCountMeta,
        ),
      );
    }
    if (data.containsKey('verified_owner_count')) {
      context.handle(
        _verifiedOwnerCountMeta,
        verifiedOwnerCount.isAcceptableOrUnknown(
          data['verified_owner_count']!,
          _verifiedOwnerCountMeta,
        ),
      );
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    if (data.containsKey('verification_report_json')) {
      context.handle(
        _verificationReportJsonMeta,
        verificationReportJson.isAcceptableOrUnknown(
          data['verification_report_json']!,
          _verificationReportJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {phoneNumber};
  @override
  ActiveDeletionProposalData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActiveDeletionProposalData(
      phoneNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}phone_number'],
          )!,
      proposalStartTime:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}proposal_start_time'],
          )!,
      status:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}status'],
          )!,
      highestRiskLevel:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}highest_risk_level'],
          )!,
      proposalCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}proposal_count'],
          )!,
      verifiedOwnerCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}verified_owner_count'],
          )!,
      lastUpdated:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}last_updated'],
          )!,
      verificationReportJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verification_report_json'],
      ),
    );
  }

  @override
  $ActiveDeletionProposalsTable createAlias(String alias) {
    return $ActiveDeletionProposalsTable(attachedDatabase, alias);
  }
}

class ActiveDeletionProposalData extends DataClass
    implements Insertable<ActiveDeletionProposalData> {
  final String phoneNumber;
  final String proposalStartTime;
  final String status;
  final String highestRiskLevel;
  final int proposalCount;
  final int verifiedOwnerCount;
  final String lastUpdated;
  final String? verificationReportJson;
  const ActiveDeletionProposalData({
    required this.phoneNumber,
    required this.proposalStartTime,
    required this.status,
    required this.highestRiskLevel,
    required this.proposalCount,
    required this.verifiedOwnerCount,
    required this.lastUpdated,
    this.verificationReportJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['phone_number'] = Variable<String>(phoneNumber);
    map['proposal_start_time'] = Variable<String>(proposalStartTime);
    map['status'] = Variable<String>(status);
    map['highest_risk_level'] = Variable<String>(highestRiskLevel);
    map['proposal_count'] = Variable<int>(proposalCount);
    map['verified_owner_count'] = Variable<int>(verifiedOwnerCount);
    map['last_updated'] = Variable<String>(lastUpdated);
    if (!nullToAbsent || verificationReportJson != null) {
      map['verification_report_json'] = Variable<String>(
        verificationReportJson,
      );
    }
    return map;
  }

  ActiveDeletionProposalsCompanion toCompanion(bool nullToAbsent) {
    return ActiveDeletionProposalsCompanion(
      phoneNumber: Value(phoneNumber),
      proposalStartTime: Value(proposalStartTime),
      status: Value(status),
      highestRiskLevel: Value(highestRiskLevel),
      proposalCount: Value(proposalCount),
      verifiedOwnerCount: Value(verifiedOwnerCount),
      lastUpdated: Value(lastUpdated),
      verificationReportJson:
          verificationReportJson == null && nullToAbsent
              ? const Value.absent()
              : Value(verificationReportJson),
    );
  }

  factory ActiveDeletionProposalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActiveDeletionProposalData(
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      proposalStartTime: serializer.fromJson<String>(json['proposalStartTime']),
      status: serializer.fromJson<String>(json['status']),
      highestRiskLevel: serializer.fromJson<String>(json['highestRiskLevel']),
      proposalCount: serializer.fromJson<int>(json['proposalCount']),
      verifiedOwnerCount: serializer.fromJson<int>(json['verifiedOwnerCount']),
      lastUpdated: serializer.fromJson<String>(json['lastUpdated']),
      verificationReportJson: serializer.fromJson<String?>(
        json['verificationReportJson'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'proposalStartTime': serializer.toJson<String>(proposalStartTime),
      'status': serializer.toJson<String>(status),
      'highestRiskLevel': serializer.toJson<String>(highestRiskLevel),
      'proposalCount': serializer.toJson<int>(proposalCount),
      'verifiedOwnerCount': serializer.toJson<int>(verifiedOwnerCount),
      'lastUpdated': serializer.toJson<String>(lastUpdated),
      'verificationReportJson': serializer.toJson<String?>(
        verificationReportJson,
      ),
    };
  }

  ActiveDeletionProposalData copyWith({
    String? phoneNumber,
    String? proposalStartTime,
    String? status,
    String? highestRiskLevel,
    int? proposalCount,
    int? verifiedOwnerCount,
    String? lastUpdated,
    Value<String?> verificationReportJson = const Value.absent(),
  }) => ActiveDeletionProposalData(
    phoneNumber: phoneNumber ?? this.phoneNumber,
    proposalStartTime: proposalStartTime ?? this.proposalStartTime,
    status: status ?? this.status,
    highestRiskLevel: highestRiskLevel ?? this.highestRiskLevel,
    proposalCount: proposalCount ?? this.proposalCount,
    verifiedOwnerCount: verifiedOwnerCount ?? this.verifiedOwnerCount,
    lastUpdated: lastUpdated ?? this.lastUpdated,
    verificationReportJson:
        verificationReportJson.present
            ? verificationReportJson.value
            : this.verificationReportJson,
  );
  ActiveDeletionProposalData copyWithCompanion(
    ActiveDeletionProposalsCompanion data,
  ) {
    return ActiveDeletionProposalData(
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      proposalStartTime:
          data.proposalStartTime.present
              ? data.proposalStartTime.value
              : this.proposalStartTime,
      status: data.status.present ? data.status.value : this.status,
      highestRiskLevel:
          data.highestRiskLevel.present
              ? data.highestRiskLevel.value
              : this.highestRiskLevel,
      proposalCount:
          data.proposalCount.present
              ? data.proposalCount.value
              : this.proposalCount,
      verifiedOwnerCount:
          data.verifiedOwnerCount.present
              ? data.verifiedOwnerCount.value
              : this.verifiedOwnerCount,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
      verificationReportJson:
          data.verificationReportJson.present
              ? data.verificationReportJson.value
              : this.verificationReportJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActiveDeletionProposalData(')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('proposalStartTime: $proposalStartTime, ')
          ..write('status: $status, ')
          ..write('highestRiskLevel: $highestRiskLevel, ')
          ..write('proposalCount: $proposalCount, ')
          ..write('verifiedOwnerCount: $verifiedOwnerCount, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('verificationReportJson: $verificationReportJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    phoneNumber,
    proposalStartTime,
    status,
    highestRiskLevel,
    proposalCount,
    verifiedOwnerCount,
    lastUpdated,
    verificationReportJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActiveDeletionProposalData &&
          other.phoneNumber == this.phoneNumber &&
          other.proposalStartTime == this.proposalStartTime &&
          other.status == this.status &&
          other.highestRiskLevel == this.highestRiskLevel &&
          other.proposalCount == this.proposalCount &&
          other.verifiedOwnerCount == this.verifiedOwnerCount &&
          other.lastUpdated == this.lastUpdated &&
          other.verificationReportJson == this.verificationReportJson);
}

class ActiveDeletionProposalsCompanion
    extends UpdateCompanion<ActiveDeletionProposalData> {
  final Value<String> phoneNumber;
  final Value<String> proposalStartTime;
  final Value<String> status;
  final Value<String> highestRiskLevel;
  final Value<int> proposalCount;
  final Value<int> verifiedOwnerCount;
  final Value<String> lastUpdated;
  final Value<String?> verificationReportJson;
  final Value<int> rowid;
  const ActiveDeletionProposalsCompanion({
    this.phoneNumber = const Value.absent(),
    this.proposalStartTime = const Value.absent(),
    this.status = const Value.absent(),
    this.highestRiskLevel = const Value.absent(),
    this.proposalCount = const Value.absent(),
    this.verifiedOwnerCount = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.verificationReportJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActiveDeletionProposalsCompanion.insert({
    required String phoneNumber,
    required String proposalStartTime,
    this.status = const Value.absent(),
    required String highestRiskLevel,
    this.proposalCount = const Value.absent(),
    this.verifiedOwnerCount = const Value.absent(),
    required String lastUpdated,
    this.verificationReportJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : phoneNumber = Value(phoneNumber),
       proposalStartTime = Value(proposalStartTime),
       highestRiskLevel = Value(highestRiskLevel),
       lastUpdated = Value(lastUpdated);
  static Insertable<ActiveDeletionProposalData> custom({
    Expression<String>? phoneNumber,
    Expression<String>? proposalStartTime,
    Expression<String>? status,
    Expression<String>? highestRiskLevel,
    Expression<int>? proposalCount,
    Expression<int>? verifiedOwnerCount,
    Expression<String>? lastUpdated,
    Expression<String>? verificationReportJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (proposalStartTime != null) 'proposal_start_time': proposalStartTime,
      if (status != null) 'status': status,
      if (highestRiskLevel != null) 'highest_risk_level': highestRiskLevel,
      if (proposalCount != null) 'proposal_count': proposalCount,
      if (verifiedOwnerCount != null)
        'verified_owner_count': verifiedOwnerCount,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (verificationReportJson != null)
        'verification_report_json': verificationReportJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActiveDeletionProposalsCompanion copyWith({
    Value<String>? phoneNumber,
    Value<String>? proposalStartTime,
    Value<String>? status,
    Value<String>? highestRiskLevel,
    Value<int>? proposalCount,
    Value<int>? verifiedOwnerCount,
    Value<String>? lastUpdated,
    Value<String?>? verificationReportJson,
    Value<int>? rowid,
  }) {
    return ActiveDeletionProposalsCompanion(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      proposalStartTime: proposalStartTime ?? this.proposalStartTime,
      status: status ?? this.status,
      highestRiskLevel: highestRiskLevel ?? this.highestRiskLevel,
      proposalCount: proposalCount ?? this.proposalCount,
      verifiedOwnerCount: verifiedOwnerCount ?? this.verifiedOwnerCount,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      verificationReportJson:
          verificationReportJson ?? this.verificationReportJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (proposalStartTime.present) {
      map['proposal_start_time'] = Variable<String>(proposalStartTime.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (highestRiskLevel.present) {
      map['highest_risk_level'] = Variable<String>(highestRiskLevel.value);
    }
    if (proposalCount.present) {
      map['proposal_count'] = Variable<int>(proposalCount.value);
    }
    if (verifiedOwnerCount.present) {
      map['verified_owner_count'] = Variable<int>(verifiedOwnerCount.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<String>(lastUpdated.value);
    }
    if (verificationReportJson.present) {
      map['verification_report_json'] = Variable<String>(
        verificationReportJson.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActiveDeletionProposalsCompanion(')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('proposalStartTime: $proposalStartTime, ')
          ..write('status: $status, ')
          ..write('highestRiskLevel: $highestRiskLevel, ')
          ..write('proposalCount: $proposalCount, ')
          ..write('verifiedOwnerCount: $verifiedOwnerCount, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('verificationReportJson: $verificationReportJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProposalSubmissionsTable extends ProposalSubmissions
    with TableInfo<$ProposalSubmissionsTable, ProposalSubmissionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProposalSubmissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proposerIdMeta = const VerificationMeta(
    'proposerId',
  );
  @override
  late final GeneratedColumn<String> proposerId = GeneratedColumn<String>(
    'proposer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _submissionTimeMeta = const VerificationMeta(
    'submissionTime',
  );
  @override
  late final GeneratedColumn<String> submissionTime = GeneratedColumn<String>(
    'submission_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    proposerId,
    phoneNumber,
    submissionTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'proposal_submissions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProposalSubmissionData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('proposer_id')) {
      context.handle(
        _proposerIdMeta,
        proposerId.isAcceptableOrUnknown(data['proposer_id']!, _proposerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_proposerIdMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('submission_time')) {
      context.handle(
        _submissionTimeMeta,
        submissionTime.isAcceptableOrUnknown(
          data['submission_time']!,
          _submissionTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_submissionTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProposalSubmissionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProposalSubmissionData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      proposerId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}proposer_id'],
          )!,
      phoneNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}phone_number'],
          )!,
      submissionTime:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}submission_time'],
          )!,
    );
  }

  @override
  $ProposalSubmissionsTable createAlias(String alias) {
    return $ProposalSubmissionsTable(attachedDatabase, alias);
  }
}

class ProposalSubmissionData extends DataClass
    implements Insertable<ProposalSubmissionData> {
  final String id;
  final String proposerId;
  final String phoneNumber;
  final String submissionTime;
  const ProposalSubmissionData({
    required this.id,
    required this.proposerId,
    required this.phoneNumber,
    required this.submissionTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['proposer_id'] = Variable<String>(proposerId);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['submission_time'] = Variable<String>(submissionTime);
    return map;
  }

  ProposalSubmissionsCompanion toCompanion(bool nullToAbsent) {
    return ProposalSubmissionsCompanion(
      id: Value(id),
      proposerId: Value(proposerId),
      phoneNumber: Value(phoneNumber),
      submissionTime: Value(submissionTime),
    );
  }

  factory ProposalSubmissionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProposalSubmissionData(
      id: serializer.fromJson<String>(json['id']),
      proposerId: serializer.fromJson<String>(json['proposerId']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      submissionTime: serializer.fromJson<String>(json['submissionTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'proposerId': serializer.toJson<String>(proposerId),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'submissionTime': serializer.toJson<String>(submissionTime),
    };
  }

  ProposalSubmissionData copyWith({
    String? id,
    String? proposerId,
    String? phoneNumber,
    String? submissionTime,
  }) => ProposalSubmissionData(
    id: id ?? this.id,
    proposerId: proposerId ?? this.proposerId,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    submissionTime: submissionTime ?? this.submissionTime,
  );
  ProposalSubmissionData copyWithCompanion(ProposalSubmissionsCompanion data) {
    return ProposalSubmissionData(
      id: data.id.present ? data.id.value : this.id,
      proposerId:
          data.proposerId.present ? data.proposerId.value : this.proposerId,
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      submissionTime:
          data.submissionTime.present
              ? data.submissionTime.value
              : this.submissionTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProposalSubmissionData(')
          ..write('id: $id, ')
          ..write('proposerId: $proposerId, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('submissionTime: $submissionTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, proposerId, phoneNumber, submissionTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProposalSubmissionData &&
          other.id == this.id &&
          other.proposerId == this.proposerId &&
          other.phoneNumber == this.phoneNumber &&
          other.submissionTime == this.submissionTime);
}

class ProposalSubmissionsCompanion
    extends UpdateCompanion<ProposalSubmissionData> {
  final Value<String> id;
  final Value<String> proposerId;
  final Value<String> phoneNumber;
  final Value<String> submissionTime;
  final Value<int> rowid;
  const ProposalSubmissionsCompanion({
    this.id = const Value.absent(),
    this.proposerId = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.submissionTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProposalSubmissionsCompanion.insert({
    required String id,
    required String proposerId,
    required String phoneNumber,
    required String submissionTime,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       proposerId = Value(proposerId),
       phoneNumber = Value(phoneNumber),
       submissionTime = Value(submissionTime);
  static Insertable<ProposalSubmissionData> custom({
    Expression<String>? id,
    Expression<String>? proposerId,
    Expression<String>? phoneNumber,
    Expression<String>? submissionTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (proposerId != null) 'proposer_id': proposerId,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (submissionTime != null) 'submission_time': submissionTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProposalSubmissionsCompanion copyWith({
    Value<String>? id,
    Value<String>? proposerId,
    Value<String>? phoneNumber,
    Value<String>? submissionTime,
    Value<int>? rowid,
  }) {
    return ProposalSubmissionsCompanion(
      id: id ?? this.id,
      proposerId: proposerId ?? this.proposerId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      submissionTime: submissionTime ?? this.submissionTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (proposerId.present) {
      map['proposer_id'] = Variable<String>(proposerId.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (submissionTime.present) {
      map['submission_time'] = Variable<String>(submissionTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProposalSubmissionsCompanion(')
          ..write('id: $id, ')
          ..write('proposerId: $proposerId, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('submissionTime: $submissionTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProposalVotesTable extends ProposalVotes
    with TableInfo<$ProposalVotesTable, ProposalVoteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProposalVotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _voterIdMeta = const VerificationMeta(
    'voterId',
  );
  @override
  late final GeneratedColumn<String> voterId = GeneratedColumn<String>(
    'voter_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proposalIdMeta = const VerificationMeta(
    'proposalId',
  );
  @override
  late final GeneratedColumn<String> proposalId = GeneratedColumn<String>(
    'proposal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _voteTimeMeta = const VerificationMeta(
    'voteTime',
  );
  @override
  late final GeneratedColumn<String> voteTime = GeneratedColumn<String>(
    'vote_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isConsumedMeta = const VerificationMeta(
    'isConsumed',
  );
  @override
  late final GeneratedColumn<int> isConsumed = GeneratedColumn<int>(
    'is_consumed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    voterId,
    proposalId,
    voteTime,
    isConsumed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'proposal_votes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProposalVoteData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('voter_id')) {
      context.handle(
        _voterIdMeta,
        voterId.isAcceptableOrUnknown(data['voter_id']!, _voterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_voterIdMeta);
    }
    if (data.containsKey('proposal_id')) {
      context.handle(
        _proposalIdMeta,
        proposalId.isAcceptableOrUnknown(data['proposal_id']!, _proposalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_proposalIdMeta);
    }
    if (data.containsKey('vote_time')) {
      context.handle(
        _voteTimeMeta,
        voteTime.isAcceptableOrUnknown(data['vote_time']!, _voteTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_voteTimeMeta);
    }
    if (data.containsKey('is_consumed')) {
      context.handle(
        _isConsumedMeta,
        isConsumed.isAcceptableOrUnknown(data['is_consumed']!, _isConsumedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProposalVoteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProposalVoteData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      voterId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}voter_id'],
          )!,
      proposalId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}proposal_id'],
          )!,
      voteTime:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}vote_time'],
          )!,
      isConsumed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}is_consumed'],
          )!,
    );
  }

  @override
  $ProposalVotesTable createAlias(String alias) {
    return $ProposalVotesTable(attachedDatabase, alias);
  }
}

class ProposalVoteData extends DataClass
    implements Insertable<ProposalVoteData> {
  final String id;
  final String voterId;
  final String proposalId;
  final String voteTime;
  final int isConsumed;
  const ProposalVoteData({
    required this.id,
    required this.voterId,
    required this.proposalId,
    required this.voteTime,
    required this.isConsumed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['voter_id'] = Variable<String>(voterId);
    map['proposal_id'] = Variable<String>(proposalId);
    map['vote_time'] = Variable<String>(voteTime);
    map['is_consumed'] = Variable<int>(isConsumed);
    return map;
  }

  ProposalVotesCompanion toCompanion(bool nullToAbsent) {
    return ProposalVotesCompanion(
      id: Value(id),
      voterId: Value(voterId),
      proposalId: Value(proposalId),
      voteTime: Value(voteTime),
      isConsumed: Value(isConsumed),
    );
  }

  factory ProposalVoteData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProposalVoteData(
      id: serializer.fromJson<String>(json['id']),
      voterId: serializer.fromJson<String>(json['voterId']),
      proposalId: serializer.fromJson<String>(json['proposalId']),
      voteTime: serializer.fromJson<String>(json['voteTime']),
      isConsumed: serializer.fromJson<int>(json['isConsumed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'voterId': serializer.toJson<String>(voterId),
      'proposalId': serializer.toJson<String>(proposalId),
      'voteTime': serializer.toJson<String>(voteTime),
      'isConsumed': serializer.toJson<int>(isConsumed),
    };
  }

  ProposalVoteData copyWith({
    String? id,
    String? voterId,
    String? proposalId,
    String? voteTime,
    int? isConsumed,
  }) => ProposalVoteData(
    id: id ?? this.id,
    voterId: voterId ?? this.voterId,
    proposalId: proposalId ?? this.proposalId,
    voteTime: voteTime ?? this.voteTime,
    isConsumed: isConsumed ?? this.isConsumed,
  );
  ProposalVoteData copyWithCompanion(ProposalVotesCompanion data) {
    return ProposalVoteData(
      id: data.id.present ? data.id.value : this.id,
      voterId: data.voterId.present ? data.voterId.value : this.voterId,
      proposalId:
          data.proposalId.present ? data.proposalId.value : this.proposalId,
      voteTime: data.voteTime.present ? data.voteTime.value : this.voteTime,
      isConsumed:
          data.isConsumed.present ? data.isConsumed.value : this.isConsumed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProposalVoteData(')
          ..write('id: $id, ')
          ..write('voterId: $voterId, ')
          ..write('proposalId: $proposalId, ')
          ..write('voteTime: $voteTime, ')
          ..write('isConsumed: $isConsumed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, voterId, proposalId, voteTime, isConsumed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProposalVoteData &&
          other.id == this.id &&
          other.voterId == this.voterId &&
          other.proposalId == this.proposalId &&
          other.voteTime == this.voteTime &&
          other.isConsumed == this.isConsumed);
}

class ProposalVotesCompanion extends UpdateCompanion<ProposalVoteData> {
  final Value<String> id;
  final Value<String> voterId;
  final Value<String> proposalId;
  final Value<String> voteTime;
  final Value<int> isConsumed;
  final Value<int> rowid;
  const ProposalVotesCompanion({
    this.id = const Value.absent(),
    this.voterId = const Value.absent(),
    this.proposalId = const Value.absent(),
    this.voteTime = const Value.absent(),
    this.isConsumed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProposalVotesCompanion.insert({
    required String id,
    required String voterId,
    required String proposalId,
    required String voteTime,
    this.isConsumed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       voterId = Value(voterId),
       proposalId = Value(proposalId),
       voteTime = Value(voteTime);
  static Insertable<ProposalVoteData> custom({
    Expression<String>? id,
    Expression<String>? voterId,
    Expression<String>? proposalId,
    Expression<String>? voteTime,
    Expression<int>? isConsumed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (voterId != null) 'voter_id': voterId,
      if (proposalId != null) 'proposal_id': proposalId,
      if (voteTime != null) 'vote_time': voteTime,
      if (isConsumed != null) 'is_consumed': isConsumed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProposalVotesCompanion copyWith({
    Value<String>? id,
    Value<String>? voterId,
    Value<String>? proposalId,
    Value<String>? voteTime,
    Value<int>? isConsumed,
    Value<int>? rowid,
  }) {
    return ProposalVotesCompanion(
      id: id ?? this.id,
      voterId: voterId ?? this.voterId,
      proposalId: proposalId ?? this.proposalId,
      voteTime: voteTime ?? this.voteTime,
      isConsumed: isConsumed ?? this.isConsumed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (voterId.present) {
      map['voter_id'] = Variable<String>(voterId.value);
    }
    if (proposalId.present) {
      map['proposal_id'] = Variable<String>(proposalId.value);
    }
    if (voteTime.present) {
      map['vote_time'] = Variable<String>(voteTime.value);
    }
    if (isConsumed.present) {
      map['is_consumed'] = Variable<int>(isConsumed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProposalVotesCompanion(')
          ..write('id: $id, ')
          ..write('voterId: $voterId, ')
          ..write('proposalId: $proposalId, ')
          ..write('voteTime: $voteTime, ')
          ..write('isConsumed: $isConsumed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$RemoteDatabase extends GeneratedDatabase {
  _$RemoteDatabase(QueryExecutor e) : super(e);
  $RemoteDatabaseManager get managers => $RemoteDatabaseManager(this);
  late final $RemoteNumbersTable remoteNumbers = $RemoteNumbersTable(this);
  late final $NumberCountriesTable numberCountries = $NumberCountriesTable(
    this,
  );
  late final $PendingOperationsTable pendingOperations =
      $PendingOperationsTable(this);
  late final $SyncRecordsTable syncRecords = $SyncRecordsTable(this);
  late final $SyncConfigTable syncConfig = $SyncConfigTable(this);
  late final $ActiveDeletionProposalsTable activeDeletionProposals =
      $ActiveDeletionProposalsTable(this);
  late final $ProposalSubmissionsTable proposalSubmissions =
      $ProposalSubmissionsTable(this);
  late final $ProposalVotesTable proposalVotes = $ProposalVotesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    remoteNumbers,
    numberCountries,
    pendingOperations,
    syncRecords,
    syncConfig,
    activeDeletionProposals,
    proposalSubmissions,
    proposalVotes,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'remote_numbers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('number_countries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'remote_numbers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('active_deletion_proposals', kind: UpdateKind.delete),
      ],
    ),
  ]);
}

typedef $$RemoteNumbersTableCreateCompanionBuilder =
    RemoteNumbersCompanion Function({
      required String id,
      required String phoneNumber,
      Value<String?> name,
      required String label,
      Value<int> priority,
      Value<String> action,
      Value<int> count,
      Value<String?> labelsJson,
      Value<int> rowid,
    });
typedef $$RemoteNumbersTableUpdateCompanionBuilder =
    RemoteNumbersCompanion Function({
      Value<String> id,
      Value<String> phoneNumber,
      Value<String?> name,
      Value<String> label,
      Value<int> priority,
      Value<String> action,
      Value<int> count,
      Value<String?> labelsJson,
      Value<int> rowid,
    });

final class $$RemoteNumbersTableReferences
    extends
        BaseReferences<
          _$RemoteDatabase,
          $RemoteNumbersTable,
          RemoteNumberData
        > {
  $$RemoteNumbersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$NumberCountriesTable, List<NumberCountryData>>
  _numberCountriesRefsTable(_$RemoteDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.numberCountries,
        aliasName: $_aliasNameGenerator(
          db.remoteNumbers.phoneNumber,
          db.numberCountries.phoneNumber,
        ),
      );

  $$NumberCountriesTableProcessedTableManager get numberCountriesRefs {
    final manager = $$NumberCountriesTableTableManager(
      $_db,
      $_db.numberCountries,
    ).filter(
      (f) => f.phoneNumber.phoneNumber.sqlEquals(
        $_itemColumn<String>('phone_number')!,
      ),
    );

    final cache = $_typedResult.readTableOrNull(
      _numberCountriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ActiveDeletionProposalsTable,
    List<ActiveDeletionProposalData>
  >
  _activeDeletionProposalsRefsTable(_$RemoteDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.activeDeletionProposals,
        aliasName: $_aliasNameGenerator(
          db.remoteNumbers.phoneNumber,
          db.activeDeletionProposals.phoneNumber,
        ),
      );

  $$ActiveDeletionProposalsTableProcessedTableManager
  get activeDeletionProposalsRefs {
    final manager = $$ActiveDeletionProposalsTableTableManager(
      $_db,
      $_db.activeDeletionProposals,
    ).filter(
      (f) => f.phoneNumber.phoneNumber.sqlEquals(
        $_itemColumn<String>('phone_number')!,
      ),
    );

    final cache = $_typedResult.readTableOrNull(
      _activeDeletionProposalsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RemoteNumbersTableFilterComposer
    extends Composer<_$RemoteDatabase, $RemoteNumbersTable> {
  $$RemoteNumbersTableFilterComposer({
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

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelsJson => $composableBuilder(
    column: $table.labelsJson,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> numberCountriesRefs(
    Expression<bool> Function($$NumberCountriesTableFilterComposer f) f,
  ) {
    final $$NumberCountriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phoneNumber,
      referencedTable: $db.numberCountries,
      getReferencedColumn: (t) => t.phoneNumber,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NumberCountriesTableFilterComposer(
            $db: $db,
            $table: $db.numberCountries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> activeDeletionProposalsRefs(
    Expression<bool> Function($$ActiveDeletionProposalsTableFilterComposer f) f,
  ) {
    final $$ActiveDeletionProposalsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.phoneNumber,
          referencedTable: $db.activeDeletionProposals,
          getReferencedColumn: (t) => t.phoneNumber,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ActiveDeletionProposalsTableFilterComposer(
                $db: $db,
                $table: $db.activeDeletionProposals,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RemoteNumbersTableOrderingComposer
    extends Composer<_$RemoteDatabase, $RemoteNumbersTable> {
  $$RemoteNumbersTableOrderingComposer({
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

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelsJson => $composableBuilder(
    column: $table.labelsJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RemoteNumbersTableAnnotationComposer
    extends Composer<_$RemoteDatabase, $RemoteNumbersTable> {
  $$RemoteNumbersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<String> get labelsJson => $composableBuilder(
    column: $table.labelsJson,
    builder: (column) => column,
  );

  Expression<T> numberCountriesRefs<T extends Object>(
    Expression<T> Function($$NumberCountriesTableAnnotationComposer a) f,
  ) {
    final $$NumberCountriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phoneNumber,
      referencedTable: $db.numberCountries,
      getReferencedColumn: (t) => t.phoneNumber,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NumberCountriesTableAnnotationComposer(
            $db: $db,
            $table: $db.numberCountries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> activeDeletionProposalsRefs<T extends Object>(
    Expression<T> Function($$ActiveDeletionProposalsTableAnnotationComposer a)
    f,
  ) {
    final $$ActiveDeletionProposalsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.phoneNumber,
          referencedTable: $db.activeDeletionProposals,
          getReferencedColumn: (t) => t.phoneNumber,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ActiveDeletionProposalsTableAnnotationComposer(
                $db: $db,
                $table: $db.activeDeletionProposals,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RemoteNumbersTableTableManager
    extends
        RootTableManager<
          _$RemoteDatabase,
          $RemoteNumbersTable,
          RemoteNumberData,
          $$RemoteNumbersTableFilterComposer,
          $$RemoteNumbersTableOrderingComposer,
          $$RemoteNumbersTableAnnotationComposer,
          $$RemoteNumbersTableCreateCompanionBuilder,
          $$RemoteNumbersTableUpdateCompanionBuilder,
          (RemoteNumberData, $$RemoteNumbersTableReferences),
          RemoteNumberData,
          PrefetchHooks Function({
            bool numberCountriesRefs,
            bool activeDeletionProposalsRefs,
          })
        > {
  $$RemoteNumbersTableTableManager(
    _$RemoteDatabase db,
    $RemoteNumbersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RemoteNumbersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$RemoteNumbersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$RemoteNumbersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<int> count = const Value.absent(),
                Value<String?> labelsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemoteNumbersCompanion(
                id: id,
                phoneNumber: phoneNumber,
                name: name,
                label: label,
                priority: priority,
                action: action,
                count: count,
                labelsJson: labelsJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String phoneNumber,
                Value<String?> name = const Value.absent(),
                required String label,
                Value<int> priority = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<int> count = const Value.absent(),
                Value<String?> labelsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemoteNumbersCompanion.insert(
                id: id,
                phoneNumber: phoneNumber,
                name: name,
                label: label,
                priority: priority,
                action: action,
                count: count,
                labelsJson: labelsJson,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$RemoteNumbersTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            numberCountriesRefs = false,
            activeDeletionProposalsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (numberCountriesRefs) db.numberCountries,
                if (activeDeletionProposalsRefs) db.activeDeletionProposals,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (numberCountriesRefs)
                    await $_getPrefetchedData<
                      RemoteNumberData,
                      $RemoteNumbersTable,
                      NumberCountryData
                    >(
                      currentTable: table,
                      referencedTable: $$RemoteNumbersTableReferences
                          ._numberCountriesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$RemoteNumbersTableReferences(
                                db,
                                table,
                                p0,
                              ).numberCountriesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.phoneNumber == item.phoneNumber,
                          ),
                      typedResults: items,
                    ),
                  if (activeDeletionProposalsRefs)
                    await $_getPrefetchedData<
                      RemoteNumberData,
                      $RemoteNumbersTable,
                      ActiveDeletionProposalData
                    >(
                      currentTable: table,
                      referencedTable: $$RemoteNumbersTableReferences
                          ._activeDeletionProposalsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$RemoteNumbersTableReferences(
                                db,
                                table,
                                p0,
                              ).activeDeletionProposalsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.phoneNumber == item.phoneNumber,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RemoteNumbersTableProcessedTableManager =
    ProcessedTableManager<
      _$RemoteDatabase,
      $RemoteNumbersTable,
      RemoteNumberData,
      $$RemoteNumbersTableFilterComposer,
      $$RemoteNumbersTableOrderingComposer,
      $$RemoteNumbersTableAnnotationComposer,
      $$RemoteNumbersTableCreateCompanionBuilder,
      $$RemoteNumbersTableUpdateCompanionBuilder,
      (RemoteNumberData, $$RemoteNumbersTableReferences),
      RemoteNumberData,
      PrefetchHooks Function({
        bool numberCountriesRefs,
        bool activeDeletionProposalsRefs,
      })
    >;
typedef $$NumberCountriesTableCreateCompanionBuilder =
    NumberCountriesCompanion Function({
      required String phoneNumber,
      required String countryIsoCode,
      Value<int> rowid,
    });
typedef $$NumberCountriesTableUpdateCompanionBuilder =
    NumberCountriesCompanion Function({
      Value<String> phoneNumber,
      Value<String> countryIsoCode,
      Value<int> rowid,
    });

final class $$NumberCountriesTableReferences
    extends
        BaseReferences<
          _$RemoteDatabase,
          $NumberCountriesTable,
          NumberCountryData
        > {
  $$NumberCountriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RemoteNumbersTable _phoneNumberTable(_$RemoteDatabase db) =>
      db.remoteNumbers.createAlias(
        $_aliasNameGenerator(
          db.numberCountries.phoneNumber,
          db.remoteNumbers.phoneNumber,
        ),
      );

  $$RemoteNumbersTableProcessedTableManager get phoneNumber {
    final $_column = $_itemColumn<String>('phone_number')!;

    final manager = $$RemoteNumbersTableTableManager(
      $_db,
      $_db.remoteNumbers,
    ).filter((f) => f.phoneNumber.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_phoneNumberTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NumberCountriesTableFilterComposer
    extends Composer<_$RemoteDatabase, $NumberCountriesTable> {
  $$NumberCountriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get countryIsoCode => $composableBuilder(
    column: $table.countryIsoCode,
    builder: (column) => ColumnFilters(column),
  );

  $$RemoteNumbersTableFilterComposer get phoneNumber {
    final $$RemoteNumbersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phoneNumber,
      referencedTable: $db.remoteNumbers,
      getReferencedColumn: (t) => t.phoneNumber,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemoteNumbersTableFilterComposer(
            $db: $db,
            $table: $db.remoteNumbers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NumberCountriesTableOrderingComposer
    extends Composer<_$RemoteDatabase, $NumberCountriesTable> {
  $$NumberCountriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get countryIsoCode => $composableBuilder(
    column: $table.countryIsoCode,
    builder: (column) => ColumnOrderings(column),
  );

  $$RemoteNumbersTableOrderingComposer get phoneNumber {
    final $$RemoteNumbersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phoneNumber,
      referencedTable: $db.remoteNumbers,
      getReferencedColumn: (t) => t.phoneNumber,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemoteNumbersTableOrderingComposer(
            $db: $db,
            $table: $db.remoteNumbers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NumberCountriesTableAnnotationComposer
    extends Composer<_$RemoteDatabase, $NumberCountriesTable> {
  $$NumberCountriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get countryIsoCode => $composableBuilder(
    column: $table.countryIsoCode,
    builder: (column) => column,
  );

  $$RemoteNumbersTableAnnotationComposer get phoneNumber {
    final $$RemoteNumbersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phoneNumber,
      referencedTable: $db.remoteNumbers,
      getReferencedColumn: (t) => t.phoneNumber,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemoteNumbersTableAnnotationComposer(
            $db: $db,
            $table: $db.remoteNumbers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NumberCountriesTableTableManager
    extends
        RootTableManager<
          _$RemoteDatabase,
          $NumberCountriesTable,
          NumberCountryData,
          $$NumberCountriesTableFilterComposer,
          $$NumberCountriesTableOrderingComposer,
          $$NumberCountriesTableAnnotationComposer,
          $$NumberCountriesTableCreateCompanionBuilder,
          $$NumberCountriesTableUpdateCompanionBuilder,
          (NumberCountryData, $$NumberCountriesTableReferences),
          NumberCountryData,
          PrefetchHooks Function({bool phoneNumber})
        > {
  $$NumberCountriesTableTableManager(
    _$RemoteDatabase db,
    $NumberCountriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$NumberCountriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$NumberCountriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$NumberCountriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> phoneNumber = const Value.absent(),
                Value<String> countryIsoCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NumberCountriesCompanion(
                phoneNumber: phoneNumber,
                countryIsoCode: countryIsoCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String phoneNumber,
                required String countryIsoCode,
                Value<int> rowid = const Value.absent(),
              }) => NumberCountriesCompanion.insert(
                phoneNumber: phoneNumber,
                countryIsoCode: countryIsoCode,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$NumberCountriesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({phoneNumber = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (phoneNumber) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.phoneNumber,
                            referencedTable: $$NumberCountriesTableReferences
                                ._phoneNumberTable(db),
                            referencedColumn:
                                $$NumberCountriesTableReferences
                                    ._phoneNumberTable(db)
                                    .phoneNumber,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NumberCountriesTableProcessedTableManager =
    ProcessedTableManager<
      _$RemoteDatabase,
      $NumberCountriesTable,
      NumberCountryData,
      $$NumberCountriesTableFilterComposer,
      $$NumberCountriesTableOrderingComposer,
      $$NumberCountriesTableAnnotationComposer,
      $$NumberCountriesTableCreateCompanionBuilder,
      $$NumberCountriesTableUpdateCompanionBuilder,
      (NumberCountryData, $$NumberCountriesTableReferences),
      NumberCountryData,
      PrefetchHooks Function({bool phoneNumber})
    >;
typedef $$PendingOperationsTableCreateCompanionBuilder =
    PendingOperationsCompanion Function({
      required String id,
      required String entityId,
      required String operation,
      Value<String?> payload,
      required String timestamp,
      Value<int> rowid,
    });
typedef $$PendingOperationsTableUpdateCompanionBuilder =
    PendingOperationsCompanion Function({
      Value<String> id,
      Value<String> entityId,
      Value<String> operation,
      Value<String?> payload,
      Value<String> timestamp,
      Value<int> rowid,
    });

class $$PendingOperationsTableFilterComposer
    extends Composer<_$RemoteDatabase, $PendingOperationsTable> {
  $$PendingOperationsTableFilterComposer({
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

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PendingOperationsTableOrderingComposer
    extends Composer<_$RemoteDatabase, $PendingOperationsTable> {
  $$PendingOperationsTableOrderingComposer({
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

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PendingOperationsTableAnnotationComposer
    extends Composer<_$RemoteDatabase, $PendingOperationsTable> {
  $$PendingOperationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$PendingOperationsTableTableManager
    extends
        RootTableManager<
          _$RemoteDatabase,
          $PendingOperationsTable,
          PendingOperationData,
          $$PendingOperationsTableFilterComposer,
          $$PendingOperationsTableOrderingComposer,
          $$PendingOperationsTableAnnotationComposer,
          $$PendingOperationsTableCreateCompanionBuilder,
          $$PendingOperationsTableUpdateCompanionBuilder,
          (
            PendingOperationData,
            BaseReferences<
              _$RemoteDatabase,
              $PendingOperationsTable,
              PendingOperationData
            >,
          ),
          PendingOperationData,
          PrefetchHooks Function()
        > {
  $$PendingOperationsTableTableManager(
    _$RemoteDatabase db,
    $PendingOperationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PendingOperationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$PendingOperationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$PendingOperationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String?> payload = const Value.absent(),
                Value<String> timestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PendingOperationsCompanion(
                id: id,
                entityId: entityId,
                operation: operation,
                payload: payload,
                timestamp: timestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String entityId,
                required String operation,
                Value<String?> payload = const Value.absent(),
                required String timestamp,
                Value<int> rowid = const Value.absent(),
              }) => PendingOperationsCompanion.insert(
                id: id,
                entityId: entityId,
                operation: operation,
                payload: payload,
                timestamp: timestamp,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PendingOperationsTableProcessedTableManager =
    ProcessedTableManager<
      _$RemoteDatabase,
      $PendingOperationsTable,
      PendingOperationData,
      $$PendingOperationsTableFilterComposer,
      $$PendingOperationsTableOrderingComposer,
      $$PendingOperationsTableAnnotationComposer,
      $$PendingOperationsTableCreateCompanionBuilder,
      $$PendingOperationsTableUpdateCompanionBuilder,
      (
        PendingOperationData,
        BaseReferences<
          _$RemoteDatabase,
          $PendingOperationsTable,
          PendingOperationData
        >,
      ),
      PendingOperationData,
      PrefetchHooks Function()
    >;
typedef $$SyncRecordsTableCreateCompanionBuilder =
    SyncRecordsCompanion Function({
      required String id,
      required String syncTime,
      required String syncType,
      required String status,
      Value<int?> pushedRecordCount,
      Value<int?> pulledRecordCount,
      Value<String?> errorMessage,
      Value<String?> metadata,
      Value<int> rowid,
    });
typedef $$SyncRecordsTableUpdateCompanionBuilder =
    SyncRecordsCompanion Function({
      Value<String> id,
      Value<String> syncTime,
      Value<String> syncType,
      Value<String> status,
      Value<int?> pushedRecordCount,
      Value<int?> pulledRecordCount,
      Value<String?> errorMessage,
      Value<String?> metadata,
      Value<int> rowid,
    });

class $$SyncRecordsTableFilterComposer
    extends Composer<_$RemoteDatabase, $SyncRecordsTable> {
  $$SyncRecordsTableFilterComposer({
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

  ColumnFilters<String> get syncTime => $composableBuilder(
    column: $table.syncTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncType => $composableBuilder(
    column: $table.syncType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pushedRecordCount => $composableBuilder(
    column: $table.pushedRecordCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pulledRecordCount => $composableBuilder(
    column: $table.pulledRecordCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncRecordsTableOrderingComposer
    extends Composer<_$RemoteDatabase, $SyncRecordsTable> {
  $$SyncRecordsTableOrderingComposer({
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

  ColumnOrderings<String> get syncTime => $composableBuilder(
    column: $table.syncTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncType => $composableBuilder(
    column: $table.syncType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pushedRecordCount => $composableBuilder(
    column: $table.pushedRecordCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pulledRecordCount => $composableBuilder(
    column: $table.pulledRecordCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncRecordsTableAnnotationComposer
    extends Composer<_$RemoteDatabase, $SyncRecordsTable> {
  $$SyncRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncTime =>
      $composableBuilder(column: $table.syncTime, builder: (column) => column);

  GeneratedColumn<String> get syncType =>
      $composableBuilder(column: $table.syncType, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get pushedRecordCount => $composableBuilder(
    column: $table.pushedRecordCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pulledRecordCount => $composableBuilder(
    column: $table.pulledRecordCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);
}

class $$SyncRecordsTableTableManager
    extends
        RootTableManager<
          _$RemoteDatabase,
          $SyncRecordsTable,
          SyncRecordData,
          $$SyncRecordsTableFilterComposer,
          $$SyncRecordsTableOrderingComposer,
          $$SyncRecordsTableAnnotationComposer,
          $$SyncRecordsTableCreateCompanionBuilder,
          $$SyncRecordsTableUpdateCompanionBuilder,
          (
            SyncRecordData,
            BaseReferences<_$RemoteDatabase, $SyncRecordsTable, SyncRecordData>,
          ),
          SyncRecordData,
          PrefetchHooks Function()
        > {
  $$SyncRecordsTableTableManager(_$RemoteDatabase db, $SyncRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SyncRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SyncRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$SyncRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> syncTime = const Value.absent(),
                Value<String> syncType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> pushedRecordCount = const Value.absent(),
                Value<int?> pulledRecordCount = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncRecordsCompanion(
                id: id,
                syncTime: syncTime,
                syncType: syncType,
                status: status,
                pushedRecordCount: pushedRecordCount,
                pulledRecordCount: pulledRecordCount,
                errorMessage: errorMessage,
                metadata: metadata,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String syncTime,
                required String syncType,
                required String status,
                Value<int?> pushedRecordCount = const Value.absent(),
                Value<int?> pulledRecordCount = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncRecordsCompanion.insert(
                id: id,
                syncTime: syncTime,
                syncType: syncType,
                status: status,
                pushedRecordCount: pushedRecordCount,
                pulledRecordCount: pulledRecordCount,
                errorMessage: errorMessage,
                metadata: metadata,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$RemoteDatabase,
      $SyncRecordsTable,
      SyncRecordData,
      $$SyncRecordsTableFilterComposer,
      $$SyncRecordsTableOrderingComposer,
      $$SyncRecordsTableAnnotationComposer,
      $$SyncRecordsTableCreateCompanionBuilder,
      $$SyncRecordsTableUpdateCompanionBuilder,
      (
        SyncRecordData,
        BaseReferences<_$RemoteDatabase, $SyncRecordsTable, SyncRecordData>,
      ),
      SyncRecordData,
      PrefetchHooks Function()
    >;
typedef $$SyncConfigTableCreateCompanionBuilder =
    SyncConfigCompanion Function({
      required String id,
      Value<String?> lastSyncTime,
      Value<int> syncInterval,
      Value<int> isAutoSync,
      Value<int> rowid,
    });
typedef $$SyncConfigTableUpdateCompanionBuilder =
    SyncConfigCompanion Function({
      Value<String> id,
      Value<String?> lastSyncTime,
      Value<int> syncInterval,
      Value<int> isAutoSync,
      Value<int> rowid,
    });

class $$SyncConfigTableFilterComposer
    extends Composer<_$RemoteDatabase, $SyncConfigTable> {
  $$SyncConfigTableFilterComposer({
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

  ColumnFilters<String> get lastSyncTime => $composableBuilder(
    column: $table.lastSyncTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncInterval => $composableBuilder(
    column: $table.syncInterval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isAutoSync => $composableBuilder(
    column: $table.isAutoSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncConfigTableOrderingComposer
    extends Composer<_$RemoteDatabase, $SyncConfigTable> {
  $$SyncConfigTableOrderingComposer({
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

  ColumnOrderings<String> get lastSyncTime => $composableBuilder(
    column: $table.lastSyncTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncInterval => $composableBuilder(
    column: $table.syncInterval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isAutoSync => $composableBuilder(
    column: $table.isAutoSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncConfigTableAnnotationComposer
    extends Composer<_$RemoteDatabase, $SyncConfigTable> {
  $$SyncConfigTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lastSyncTime => $composableBuilder(
    column: $table.lastSyncTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get syncInterval => $composableBuilder(
    column: $table.syncInterval,
    builder: (column) => column,
  );

  GeneratedColumn<int> get isAutoSync => $composableBuilder(
    column: $table.isAutoSync,
    builder: (column) => column,
  );
}

class $$SyncConfigTableTableManager
    extends
        RootTableManager<
          _$RemoteDatabase,
          $SyncConfigTable,
          SyncConfigData,
          $$SyncConfigTableFilterComposer,
          $$SyncConfigTableOrderingComposer,
          $$SyncConfigTableAnnotationComposer,
          $$SyncConfigTableCreateCompanionBuilder,
          $$SyncConfigTableUpdateCompanionBuilder,
          (
            SyncConfigData,
            BaseReferences<_$RemoteDatabase, $SyncConfigTable, SyncConfigData>,
          ),
          SyncConfigData,
          PrefetchHooks Function()
        > {
  $$SyncConfigTableTableManager(_$RemoteDatabase db, $SyncConfigTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SyncConfigTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SyncConfigTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SyncConfigTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> lastSyncTime = const Value.absent(),
                Value<int> syncInterval = const Value.absent(),
                Value<int> isAutoSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncConfigCompanion(
                id: id,
                lastSyncTime: lastSyncTime,
                syncInterval: syncInterval,
                isAutoSync: isAutoSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> lastSyncTime = const Value.absent(),
                Value<int> syncInterval = const Value.absent(),
                Value<int> isAutoSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncConfigCompanion.insert(
                id: id,
                lastSyncTime: lastSyncTime,
                syncInterval: syncInterval,
                isAutoSync: isAutoSync,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncConfigTableProcessedTableManager =
    ProcessedTableManager<
      _$RemoteDatabase,
      $SyncConfigTable,
      SyncConfigData,
      $$SyncConfigTableFilterComposer,
      $$SyncConfigTableOrderingComposer,
      $$SyncConfigTableAnnotationComposer,
      $$SyncConfigTableCreateCompanionBuilder,
      $$SyncConfigTableUpdateCompanionBuilder,
      (
        SyncConfigData,
        BaseReferences<_$RemoteDatabase, $SyncConfigTable, SyncConfigData>,
      ),
      SyncConfigData,
      PrefetchHooks Function()
    >;
typedef $$ActiveDeletionProposalsTableCreateCompanionBuilder =
    ActiveDeletionProposalsCompanion Function({
      required String phoneNumber,
      required String proposalStartTime,
      Value<String> status,
      required String highestRiskLevel,
      Value<int> proposalCount,
      Value<int> verifiedOwnerCount,
      required String lastUpdated,
      Value<String?> verificationReportJson,
      Value<int> rowid,
    });
typedef $$ActiveDeletionProposalsTableUpdateCompanionBuilder =
    ActiveDeletionProposalsCompanion Function({
      Value<String> phoneNumber,
      Value<String> proposalStartTime,
      Value<String> status,
      Value<String> highestRiskLevel,
      Value<int> proposalCount,
      Value<int> verifiedOwnerCount,
      Value<String> lastUpdated,
      Value<String?> verificationReportJson,
      Value<int> rowid,
    });

final class $$ActiveDeletionProposalsTableReferences
    extends
        BaseReferences<
          _$RemoteDatabase,
          $ActiveDeletionProposalsTable,
          ActiveDeletionProposalData
        > {
  $$ActiveDeletionProposalsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RemoteNumbersTable _phoneNumberTable(_$RemoteDatabase db) =>
      db.remoteNumbers.createAlias(
        $_aliasNameGenerator(
          db.activeDeletionProposals.phoneNumber,
          db.remoteNumbers.phoneNumber,
        ),
      );

  $$RemoteNumbersTableProcessedTableManager get phoneNumber {
    final $_column = $_itemColumn<String>('phone_number')!;

    final manager = $$RemoteNumbersTableTableManager(
      $_db,
      $_db.remoteNumbers,
    ).filter((f) => f.phoneNumber.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_phoneNumberTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ActiveDeletionProposalsTableFilterComposer
    extends Composer<_$RemoteDatabase, $ActiveDeletionProposalsTable> {
  $$ActiveDeletionProposalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get proposalStartTime => $composableBuilder(
    column: $table.proposalStartTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get highestRiskLevel => $composableBuilder(
    column: $table.highestRiskLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get proposalCount => $composableBuilder(
    column: $table.proposalCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verifiedOwnerCount => $composableBuilder(
    column: $table.verifiedOwnerCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verificationReportJson => $composableBuilder(
    column: $table.verificationReportJson,
    builder: (column) => ColumnFilters(column),
  );

  $$RemoteNumbersTableFilterComposer get phoneNumber {
    final $$RemoteNumbersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phoneNumber,
      referencedTable: $db.remoteNumbers,
      getReferencedColumn: (t) => t.phoneNumber,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemoteNumbersTableFilterComposer(
            $db: $db,
            $table: $db.remoteNumbers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActiveDeletionProposalsTableOrderingComposer
    extends Composer<_$RemoteDatabase, $ActiveDeletionProposalsTable> {
  $$ActiveDeletionProposalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get proposalStartTime => $composableBuilder(
    column: $table.proposalStartTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get highestRiskLevel => $composableBuilder(
    column: $table.highestRiskLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get proposalCount => $composableBuilder(
    column: $table.proposalCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verifiedOwnerCount => $composableBuilder(
    column: $table.verifiedOwnerCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verificationReportJson => $composableBuilder(
    column: $table.verificationReportJson,
    builder: (column) => ColumnOrderings(column),
  );

  $$RemoteNumbersTableOrderingComposer get phoneNumber {
    final $$RemoteNumbersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phoneNumber,
      referencedTable: $db.remoteNumbers,
      getReferencedColumn: (t) => t.phoneNumber,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemoteNumbersTableOrderingComposer(
            $db: $db,
            $table: $db.remoteNumbers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActiveDeletionProposalsTableAnnotationComposer
    extends Composer<_$RemoteDatabase, $ActiveDeletionProposalsTable> {
  $$ActiveDeletionProposalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get proposalStartTime => $composableBuilder(
    column: $table.proposalStartTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get highestRiskLevel => $composableBuilder(
    column: $table.highestRiskLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get proposalCount => $composableBuilder(
    column: $table.proposalCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get verifiedOwnerCount => $composableBuilder(
    column: $table.verifiedOwnerCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );

  GeneratedColumn<String> get verificationReportJson => $composableBuilder(
    column: $table.verificationReportJson,
    builder: (column) => column,
  );

  $$RemoteNumbersTableAnnotationComposer get phoneNumber {
    final $$RemoteNumbersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phoneNumber,
      referencedTable: $db.remoteNumbers,
      getReferencedColumn: (t) => t.phoneNumber,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemoteNumbersTableAnnotationComposer(
            $db: $db,
            $table: $db.remoteNumbers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActiveDeletionProposalsTableTableManager
    extends
        RootTableManager<
          _$RemoteDatabase,
          $ActiveDeletionProposalsTable,
          ActiveDeletionProposalData,
          $$ActiveDeletionProposalsTableFilterComposer,
          $$ActiveDeletionProposalsTableOrderingComposer,
          $$ActiveDeletionProposalsTableAnnotationComposer,
          $$ActiveDeletionProposalsTableCreateCompanionBuilder,
          $$ActiveDeletionProposalsTableUpdateCompanionBuilder,
          (
            ActiveDeletionProposalData,
            $$ActiveDeletionProposalsTableReferences,
          ),
          ActiveDeletionProposalData,
          PrefetchHooks Function({bool phoneNumber})
        > {
  $$ActiveDeletionProposalsTableTableManager(
    _$RemoteDatabase db,
    $ActiveDeletionProposalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ActiveDeletionProposalsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$ActiveDeletionProposalsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$ActiveDeletionProposalsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> phoneNumber = const Value.absent(),
                Value<String> proposalStartTime = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> highestRiskLevel = const Value.absent(),
                Value<int> proposalCount = const Value.absent(),
                Value<int> verifiedOwnerCount = const Value.absent(),
                Value<String> lastUpdated = const Value.absent(),
                Value<String?> verificationReportJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActiveDeletionProposalsCompanion(
                phoneNumber: phoneNumber,
                proposalStartTime: proposalStartTime,
                status: status,
                highestRiskLevel: highestRiskLevel,
                proposalCount: proposalCount,
                verifiedOwnerCount: verifiedOwnerCount,
                lastUpdated: lastUpdated,
                verificationReportJson: verificationReportJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String phoneNumber,
                required String proposalStartTime,
                Value<String> status = const Value.absent(),
                required String highestRiskLevel,
                Value<int> proposalCount = const Value.absent(),
                Value<int> verifiedOwnerCount = const Value.absent(),
                required String lastUpdated,
                Value<String?> verificationReportJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActiveDeletionProposalsCompanion.insert(
                phoneNumber: phoneNumber,
                proposalStartTime: proposalStartTime,
                status: status,
                highestRiskLevel: highestRiskLevel,
                proposalCount: proposalCount,
                verifiedOwnerCount: verifiedOwnerCount,
                lastUpdated: lastUpdated,
                verificationReportJson: verificationReportJson,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$ActiveDeletionProposalsTableReferences(
                            db,
                            table,
                            e,
                          ),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({phoneNumber = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (phoneNumber) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.phoneNumber,
                            referencedTable:
                                $$ActiveDeletionProposalsTableReferences
                                    ._phoneNumberTable(db),
                            referencedColumn:
                                $$ActiveDeletionProposalsTableReferences
                                    ._phoneNumberTable(db)
                                    .phoneNumber,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ActiveDeletionProposalsTableProcessedTableManager =
    ProcessedTableManager<
      _$RemoteDatabase,
      $ActiveDeletionProposalsTable,
      ActiveDeletionProposalData,
      $$ActiveDeletionProposalsTableFilterComposer,
      $$ActiveDeletionProposalsTableOrderingComposer,
      $$ActiveDeletionProposalsTableAnnotationComposer,
      $$ActiveDeletionProposalsTableCreateCompanionBuilder,
      $$ActiveDeletionProposalsTableUpdateCompanionBuilder,
      (ActiveDeletionProposalData, $$ActiveDeletionProposalsTableReferences),
      ActiveDeletionProposalData,
      PrefetchHooks Function({bool phoneNumber})
    >;
typedef $$ProposalSubmissionsTableCreateCompanionBuilder =
    ProposalSubmissionsCompanion Function({
      required String id,
      required String proposerId,
      required String phoneNumber,
      required String submissionTime,
      Value<int> rowid,
    });
typedef $$ProposalSubmissionsTableUpdateCompanionBuilder =
    ProposalSubmissionsCompanion Function({
      Value<String> id,
      Value<String> proposerId,
      Value<String> phoneNumber,
      Value<String> submissionTime,
      Value<int> rowid,
    });

class $$ProposalSubmissionsTableFilterComposer
    extends Composer<_$RemoteDatabase, $ProposalSubmissionsTable> {
  $$ProposalSubmissionsTableFilterComposer({
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

  ColumnFilters<String> get proposerId => $composableBuilder(
    column: $table.proposerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get submissionTime => $composableBuilder(
    column: $table.submissionTime,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProposalSubmissionsTableOrderingComposer
    extends Composer<_$RemoteDatabase, $ProposalSubmissionsTable> {
  $$ProposalSubmissionsTableOrderingComposer({
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

  ColumnOrderings<String> get proposerId => $composableBuilder(
    column: $table.proposerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get submissionTime => $composableBuilder(
    column: $table.submissionTime,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProposalSubmissionsTableAnnotationComposer
    extends Composer<_$RemoteDatabase, $ProposalSubmissionsTable> {
  $$ProposalSubmissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get proposerId => $composableBuilder(
    column: $table.proposerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get submissionTime => $composableBuilder(
    column: $table.submissionTime,
    builder: (column) => column,
  );
}

class $$ProposalSubmissionsTableTableManager
    extends
        RootTableManager<
          _$RemoteDatabase,
          $ProposalSubmissionsTable,
          ProposalSubmissionData,
          $$ProposalSubmissionsTableFilterComposer,
          $$ProposalSubmissionsTableOrderingComposer,
          $$ProposalSubmissionsTableAnnotationComposer,
          $$ProposalSubmissionsTableCreateCompanionBuilder,
          $$ProposalSubmissionsTableUpdateCompanionBuilder,
          (
            ProposalSubmissionData,
            BaseReferences<
              _$RemoteDatabase,
              $ProposalSubmissionsTable,
              ProposalSubmissionData
            >,
          ),
          ProposalSubmissionData,
          PrefetchHooks Function()
        > {
  $$ProposalSubmissionsTableTableManager(
    _$RemoteDatabase db,
    $ProposalSubmissionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ProposalSubmissionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$ProposalSubmissionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$ProposalSubmissionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> proposerId = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String> submissionTime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProposalSubmissionsCompanion(
                id: id,
                proposerId: proposerId,
                phoneNumber: phoneNumber,
                submissionTime: submissionTime,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String proposerId,
                required String phoneNumber,
                required String submissionTime,
                Value<int> rowid = const Value.absent(),
              }) => ProposalSubmissionsCompanion.insert(
                id: id,
                proposerId: proposerId,
                phoneNumber: phoneNumber,
                submissionTime: submissionTime,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProposalSubmissionsTableProcessedTableManager =
    ProcessedTableManager<
      _$RemoteDatabase,
      $ProposalSubmissionsTable,
      ProposalSubmissionData,
      $$ProposalSubmissionsTableFilterComposer,
      $$ProposalSubmissionsTableOrderingComposer,
      $$ProposalSubmissionsTableAnnotationComposer,
      $$ProposalSubmissionsTableCreateCompanionBuilder,
      $$ProposalSubmissionsTableUpdateCompanionBuilder,
      (
        ProposalSubmissionData,
        BaseReferences<
          _$RemoteDatabase,
          $ProposalSubmissionsTable,
          ProposalSubmissionData
        >,
      ),
      ProposalSubmissionData,
      PrefetchHooks Function()
    >;
typedef $$ProposalVotesTableCreateCompanionBuilder =
    ProposalVotesCompanion Function({
      required String id,
      required String voterId,
      required String proposalId,
      required String voteTime,
      Value<int> isConsumed,
      Value<int> rowid,
    });
typedef $$ProposalVotesTableUpdateCompanionBuilder =
    ProposalVotesCompanion Function({
      Value<String> id,
      Value<String> voterId,
      Value<String> proposalId,
      Value<String> voteTime,
      Value<int> isConsumed,
      Value<int> rowid,
    });

class $$ProposalVotesTableFilterComposer
    extends Composer<_$RemoteDatabase, $ProposalVotesTable> {
  $$ProposalVotesTableFilterComposer({
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

  ColumnFilters<String> get voterId => $composableBuilder(
    column: $table.voterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proposalId => $composableBuilder(
    column: $table.proposalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get voteTime => $composableBuilder(
    column: $table.voteTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isConsumed => $composableBuilder(
    column: $table.isConsumed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProposalVotesTableOrderingComposer
    extends Composer<_$RemoteDatabase, $ProposalVotesTable> {
  $$ProposalVotesTableOrderingComposer({
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

  ColumnOrderings<String> get voterId => $composableBuilder(
    column: $table.voterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proposalId => $composableBuilder(
    column: $table.proposalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get voteTime => $composableBuilder(
    column: $table.voteTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isConsumed => $composableBuilder(
    column: $table.isConsumed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProposalVotesTableAnnotationComposer
    extends Composer<_$RemoteDatabase, $ProposalVotesTable> {
  $$ProposalVotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get voterId =>
      $composableBuilder(column: $table.voterId, builder: (column) => column);

  GeneratedColumn<String> get proposalId => $composableBuilder(
    column: $table.proposalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get voteTime =>
      $composableBuilder(column: $table.voteTime, builder: (column) => column);

  GeneratedColumn<int> get isConsumed => $composableBuilder(
    column: $table.isConsumed,
    builder: (column) => column,
  );
}

class $$ProposalVotesTableTableManager
    extends
        RootTableManager<
          _$RemoteDatabase,
          $ProposalVotesTable,
          ProposalVoteData,
          $$ProposalVotesTableFilterComposer,
          $$ProposalVotesTableOrderingComposer,
          $$ProposalVotesTableAnnotationComposer,
          $$ProposalVotesTableCreateCompanionBuilder,
          $$ProposalVotesTableUpdateCompanionBuilder,
          (
            ProposalVoteData,
            BaseReferences<
              _$RemoteDatabase,
              $ProposalVotesTable,
              ProposalVoteData
            >,
          ),
          ProposalVoteData,
          PrefetchHooks Function()
        > {
  $$ProposalVotesTableTableManager(
    _$RemoteDatabase db,
    $ProposalVotesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ProposalVotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$ProposalVotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ProposalVotesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> voterId = const Value.absent(),
                Value<String> proposalId = const Value.absent(),
                Value<String> voteTime = const Value.absent(),
                Value<int> isConsumed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProposalVotesCompanion(
                id: id,
                voterId: voterId,
                proposalId: proposalId,
                voteTime: voteTime,
                isConsumed: isConsumed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String voterId,
                required String proposalId,
                required String voteTime,
                Value<int> isConsumed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProposalVotesCompanion.insert(
                id: id,
                voterId: voterId,
                proposalId: proposalId,
                voteTime: voteTime,
                isConsumed: isConsumed,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProposalVotesTableProcessedTableManager =
    ProcessedTableManager<
      _$RemoteDatabase,
      $ProposalVotesTable,
      ProposalVoteData,
      $$ProposalVotesTableFilterComposer,
      $$ProposalVotesTableOrderingComposer,
      $$ProposalVotesTableAnnotationComposer,
      $$ProposalVotesTableCreateCompanionBuilder,
      $$ProposalVotesTableUpdateCompanionBuilder,
      (
        ProposalVoteData,
        BaseReferences<_$RemoteDatabase, $ProposalVotesTable, ProposalVoteData>,
      ),
      ProposalVoteData,
      PrefetchHooks Function()
    >;

class $RemoteDatabaseManager {
  final _$RemoteDatabase _db;
  $RemoteDatabaseManager(this._db);
  $$RemoteNumbersTableTableManager get remoteNumbers =>
      $$RemoteNumbersTableTableManager(_db, _db.remoteNumbers);
  $$NumberCountriesTableTableManager get numberCountries =>
      $$NumberCountriesTableTableManager(_db, _db.numberCountries);
  $$PendingOperationsTableTableManager get pendingOperations =>
      $$PendingOperationsTableTableManager(_db, _db.pendingOperations);
  $$SyncRecordsTableTableManager get syncRecords =>
      $$SyncRecordsTableTableManager(_db, _db.syncRecords);
  $$SyncConfigTableTableManager get syncConfig =>
      $$SyncConfigTableTableManager(_db, _db.syncConfig);
  $$ActiveDeletionProposalsTableTableManager get activeDeletionProposals =>
      $$ActiveDeletionProposalsTableTableManager(
        _db,
        _db.activeDeletionProposals,
      );
  $$ProposalSubmissionsTableTableManager get proposalSubmissions =>
      $$ProposalSubmissionsTableTableManager(_db, _db.proposalSubmissions);
  $$ProposalVotesTableTableManager get proposalVotes =>
      $$ProposalVotesTableTableManager(_db, _db.proposalVotes);
}
