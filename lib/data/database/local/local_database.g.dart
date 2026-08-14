// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $ContactsTable extends Contacts
    with TableInfo<$ContactsTable, ContactData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
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
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
    'avatar',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelIdsMeta = const VerificationMeta(
    'labelIds',
  );
  @override
  late final GeneratedColumn<String> labelIds = GeneratedColumn<String>(
    'label_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<int> isFavorite = GeneratedColumn<int>(
    'is_favorite',
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
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    phoneNumber,
    name,
    avatar,
    url,
    note,
    labelIds,
    isFavorite,
    lastUpdated,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContactData> instance, {
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
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(
        _avatarMeta,
        avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta),
      );
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('label_ids')) {
      context.handle(
        _labelIdsMeta,
        labelIds.isAcceptableOrUnknown(data['label_ids']!, _labelIdsMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      avatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar'],
      ),
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      labelIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_ids'],
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_favorite'],
      )!,
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_updated'],
      )!,
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

class ContactData extends DataClass implements Insertable<ContactData> {
  final String id;
  final String phoneNumber;
  final String name;
  final String? avatar;
  final String? url;
  final String? note;
  final String? labelIds;
  final int isFavorite;
  final String lastUpdated;
  const ContactData({
    required this.id,
    required this.phoneNumber,
    required this.name,
    this.avatar,
    this.url,
    this.note,
    this.labelIds,
    required this.isFavorite,
    required this.lastUpdated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || labelIds != null) {
      map['label_ids'] = Variable<String>(labelIds);
    }
    map['is_favorite'] = Variable<int>(isFavorite);
    map['last_updated'] = Variable<String>(lastUpdated);
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      phoneNumber: Value(phoneNumber),
      name: Value(name),
      avatar: avatar == null && nullToAbsent
          ? const Value.absent()
          : Value(avatar),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      labelIds: labelIds == null && nullToAbsent
          ? const Value.absent()
          : Value(labelIds),
      isFavorite: Value(isFavorite),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory ContactData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactData(
      id: serializer.fromJson<String>(json['id']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      name: serializer.fromJson<String>(json['name']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      url: serializer.fromJson<String?>(json['url']),
      note: serializer.fromJson<String?>(json['note']),
      labelIds: serializer.fromJson<String?>(json['labelIds']),
      isFavorite: serializer.fromJson<int>(json['isFavorite']),
      lastUpdated: serializer.fromJson<String>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'name': serializer.toJson<String>(name),
      'avatar': serializer.toJson<String?>(avatar),
      'url': serializer.toJson<String?>(url),
      'note': serializer.toJson<String?>(note),
      'labelIds': serializer.toJson<String?>(labelIds),
      'isFavorite': serializer.toJson<int>(isFavorite),
      'lastUpdated': serializer.toJson<String>(lastUpdated),
    };
  }

  ContactData copyWith({
    String? id,
    String? phoneNumber,
    String? name,
    Value<String?> avatar = const Value.absent(),
    Value<String?> url = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<String?> labelIds = const Value.absent(),
    int? isFavorite,
    String? lastUpdated,
  }) => ContactData(
    id: id ?? this.id,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    name: name ?? this.name,
    avatar: avatar.present ? avatar.value : this.avatar,
    url: url.present ? url.value : this.url,
    note: note.present ? note.value : this.note,
    labelIds: labelIds.present ? labelIds.value : this.labelIds,
    isFavorite: isFavorite ?? this.isFavorite,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
  ContactData copyWithCompanion(ContactsCompanion data) {
    return ContactData(
      id: data.id.present ? data.id.value : this.id,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      name: data.name.present ? data.name.value : this.name,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
      url: data.url.present ? data.url.value : this.url,
      note: data.note.present ? data.note.value : this.note,
      labelIds: data.labelIds.present ? data.labelIds.value : this.labelIds,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContactData(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('url: $url, ')
          ..write('note: $note, ')
          ..write('labelIds: $labelIds, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    phoneNumber,
    name,
    avatar,
    url,
    note,
    labelIds,
    isFavorite,
    lastUpdated,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContactData &&
          other.id == this.id &&
          other.phoneNumber == this.phoneNumber &&
          other.name == this.name &&
          other.avatar == this.avatar &&
          other.url == this.url &&
          other.note == this.note &&
          other.labelIds == this.labelIds &&
          other.isFavorite == this.isFavorite &&
          other.lastUpdated == this.lastUpdated);
}

class ContactsCompanion extends UpdateCompanion<ContactData> {
  final Value<String> id;
  final Value<String> phoneNumber;
  final Value<String> name;
  final Value<String?> avatar;
  final Value<String?> url;
  final Value<String?> note;
  final Value<String?> labelIds;
  final Value<int> isFavorite;
  final Value<String> lastUpdated;
  final Value<int> rowid;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.name = const Value.absent(),
    this.avatar = const Value.absent(),
    this.url = const Value.absent(),
    this.note = const Value.absent(),
    this.labelIds = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContactsCompanion.insert({
    required String id,
    required String phoneNumber,
    required String name,
    this.avatar = const Value.absent(),
    this.url = const Value.absent(),
    this.note = const Value.absent(),
    this.labelIds = const Value.absent(),
    this.isFavorite = const Value.absent(),
    required String lastUpdated,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       phoneNumber = Value(phoneNumber),
       name = Value(name),
       lastUpdated = Value(lastUpdated);
  static Insertable<ContactData> custom({
    Expression<String>? id,
    Expression<String>? phoneNumber,
    Expression<String>? name,
    Expression<String>? avatar,
    Expression<String>? url,
    Expression<String>? note,
    Expression<String>? labelIds,
    Expression<int>? isFavorite,
    Expression<String>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (name != null) 'name': name,
      if (avatar != null) 'avatar': avatar,
      if (url != null) 'url': url,
      if (note != null) 'note': note,
      if (labelIds != null) 'label_ids': labelIds,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContactsCompanion copyWith({
    Value<String>? id,
    Value<String>? phoneNumber,
    Value<String>? name,
    Value<String?>? avatar,
    Value<String?>? url,
    Value<String?>? note,
    Value<String?>? labelIds,
    Value<int>? isFavorite,
    Value<String>? lastUpdated,
    Value<int>? rowid,
  }) {
    return ContactsCompanion(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      url: url ?? this.url,
      note: note ?? this.note,
      labelIds: labelIds ?? this.labelIds,
      isFavorite: isFavorite ?? this.isFavorite,
      lastUpdated: lastUpdated ?? this.lastUpdated,
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
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (labelIds.present) {
      map['label_ids'] = Variable<String>(labelIds.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<int>(isFavorite.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<String>(lastUpdated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('url: $url, ')
          ..write('note: $note, ')
          ..write('labelIds: $labelIds, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CallHistoryTable extends CallHistory
    with TableInfo<$CallHistoryTable, CallHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CallHistoryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
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
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<String> endTime = GeneratedColumn<String>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _simDisplayNameMeta = const VerificationMeta(
    'simDisplayName',
  );
  @override
  late final GeneratedColumn<String> simDisplayName = GeneratedColumn<String>(
    'sim_display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _callTypeMeta = const VerificationMeta(
    'callType',
  );
  @override
  late final GeneratedColumn<String> callType = GeneratedColumn<String>(
    'call_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _simSlotIndexMeta = const VerificationMeta(
    'simSlotIndex',
  );
  @override
  late final GeneratedColumn<int> simSlotIndex = GeneratedColumn<int>(
    'sim_slot_index',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _carrierNameMeta = const VerificationMeta(
    'carrierName',
  );
  @override
  late final GeneratedColumn<String> carrierName = GeneratedColumn<String>(
    'carrier_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryIsoMeta = const VerificationMeta(
    'countryIso',
  );
  @override
  late final GeneratedColumn<String> countryIso = GeneratedColumn<String>(
    'country_iso',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subscriptionIdMeta = const VerificationMeta(
    'subscriptionId',
  );
  @override
  late final GeneratedColumn<int> subscriptionId = GeneratedColumn<int>(
    'subscription_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelIdsMeta = const VerificationMeta(
    'labelIds',
  );
  @override
  late final GeneratedColumn<String> labelIds = GeneratedColumn<String>(
    'label_ids',
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
    timestamp,
    endTime,
    duration,
    simDisplayName,
    callType,
    simSlotIndex,
    carrierName,
    countryIso,
    subscriptionId,
    labelIds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'call_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<CallHistoryData> instance, {
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
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    }
    if (data.containsKey('sim_display_name')) {
      context.handle(
        _simDisplayNameMeta,
        simDisplayName.isAcceptableOrUnknown(
          data['sim_display_name']!,
          _simDisplayNameMeta,
        ),
      );
    }
    if (data.containsKey('call_type')) {
      context.handle(
        _callTypeMeta,
        callType.isAcceptableOrUnknown(data['call_type']!, _callTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_callTypeMeta);
    }
    if (data.containsKey('sim_slot_index')) {
      context.handle(
        _simSlotIndexMeta,
        simSlotIndex.isAcceptableOrUnknown(
          data['sim_slot_index']!,
          _simSlotIndexMeta,
        ),
      );
    }
    if (data.containsKey('carrier_name')) {
      context.handle(
        _carrierNameMeta,
        carrierName.isAcceptableOrUnknown(
          data['carrier_name']!,
          _carrierNameMeta,
        ),
      );
    }
    if (data.containsKey('country_iso')) {
      context.handle(
        _countryIsoMeta,
        countryIso.isAcceptableOrUnknown(data['country_iso']!, _countryIsoMeta),
      );
    }
    if (data.containsKey('subscription_id')) {
      context.handle(
        _subscriptionIdMeta,
        subscriptionId.isAcceptableOrUnknown(
          data['subscription_id']!,
          _subscriptionIdMeta,
        ),
      );
    }
    if (data.containsKey('label_ids')) {
      context.handle(
        _labelIdsMeta,
        labelIds.isAcceptableOrUnknown(data['label_ids']!, _labelIdsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CallHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CallHistoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timestamp'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_time'],
      ),
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      ),
      simDisplayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sim_display_name'],
      ),
      callType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}call_type'],
      )!,
      simSlotIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sim_slot_index'],
      ),
      carrierName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}carrier_name'],
      ),
      countryIso: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_iso'],
      ),
      subscriptionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subscription_id'],
      ),
      labelIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_ids'],
      ),
    );
  }

  @override
  $CallHistoryTable createAlias(String alias) {
    return $CallHistoryTable(attachedDatabase, alias);
  }
}

class CallHistoryData extends DataClass implements Insertable<CallHistoryData> {
  final String id;
  final String phoneNumber;
  final String? name;
  final String timestamp;
  final String? endTime;
  final int? duration;
  final String? simDisplayName;
  final String callType;
  final int? simSlotIndex;
  final String? carrierName;
  final String? countryIso;
  final int? subscriptionId;
  final String? labelIds;
  const CallHistoryData({
    required this.id,
    required this.phoneNumber,
    this.name,
    required this.timestamp,
    this.endTime,
    this.duration,
    this.simDisplayName,
    required this.callType,
    this.simSlotIndex,
    this.carrierName,
    this.countryIso,
    this.subscriptionId,
    this.labelIds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['phone_number'] = Variable<String>(phoneNumber);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['timestamp'] = Variable<String>(timestamp);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<String>(endTime);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    if (!nullToAbsent || simDisplayName != null) {
      map['sim_display_name'] = Variable<String>(simDisplayName);
    }
    map['call_type'] = Variable<String>(callType);
    if (!nullToAbsent || simSlotIndex != null) {
      map['sim_slot_index'] = Variable<int>(simSlotIndex);
    }
    if (!nullToAbsent || carrierName != null) {
      map['carrier_name'] = Variable<String>(carrierName);
    }
    if (!nullToAbsent || countryIso != null) {
      map['country_iso'] = Variable<String>(countryIso);
    }
    if (!nullToAbsent || subscriptionId != null) {
      map['subscription_id'] = Variable<int>(subscriptionId);
    }
    if (!nullToAbsent || labelIds != null) {
      map['label_ids'] = Variable<String>(labelIds);
    }
    return map;
  }

  CallHistoryCompanion toCompanion(bool nullToAbsent) {
    return CallHistoryCompanion(
      id: Value(id),
      phoneNumber: Value(phoneNumber),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      timestamp: Value(timestamp),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      simDisplayName: simDisplayName == null && nullToAbsent
          ? const Value.absent()
          : Value(simDisplayName),
      callType: Value(callType),
      simSlotIndex: simSlotIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(simSlotIndex),
      carrierName: carrierName == null && nullToAbsent
          ? const Value.absent()
          : Value(carrierName),
      countryIso: countryIso == null && nullToAbsent
          ? const Value.absent()
          : Value(countryIso),
      subscriptionId: subscriptionId == null && nullToAbsent
          ? const Value.absent()
          : Value(subscriptionId),
      labelIds: labelIds == null && nullToAbsent
          ? const Value.absent()
          : Value(labelIds),
    );
  }

  factory CallHistoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CallHistoryData(
      id: serializer.fromJson<String>(json['id']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      name: serializer.fromJson<String?>(json['name']),
      timestamp: serializer.fromJson<String>(json['timestamp']),
      endTime: serializer.fromJson<String?>(json['endTime']),
      duration: serializer.fromJson<int?>(json['duration']),
      simDisplayName: serializer.fromJson<String?>(json['simDisplayName']),
      callType: serializer.fromJson<String>(json['callType']),
      simSlotIndex: serializer.fromJson<int?>(json['simSlotIndex']),
      carrierName: serializer.fromJson<String?>(json['carrierName']),
      countryIso: serializer.fromJson<String?>(json['countryIso']),
      subscriptionId: serializer.fromJson<int?>(json['subscriptionId']),
      labelIds: serializer.fromJson<String?>(json['labelIds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'name': serializer.toJson<String?>(name),
      'timestamp': serializer.toJson<String>(timestamp),
      'endTime': serializer.toJson<String?>(endTime),
      'duration': serializer.toJson<int?>(duration),
      'simDisplayName': serializer.toJson<String?>(simDisplayName),
      'callType': serializer.toJson<String>(callType),
      'simSlotIndex': serializer.toJson<int?>(simSlotIndex),
      'carrierName': serializer.toJson<String?>(carrierName),
      'countryIso': serializer.toJson<String?>(countryIso),
      'subscriptionId': serializer.toJson<int?>(subscriptionId),
      'labelIds': serializer.toJson<String?>(labelIds),
    };
  }

  CallHistoryData copyWith({
    String? id,
    String? phoneNumber,
    Value<String?> name = const Value.absent(),
    String? timestamp,
    Value<String?> endTime = const Value.absent(),
    Value<int?> duration = const Value.absent(),
    Value<String?> simDisplayName = const Value.absent(),
    String? callType,
    Value<int?> simSlotIndex = const Value.absent(),
    Value<String?> carrierName = const Value.absent(),
    Value<String?> countryIso = const Value.absent(),
    Value<int?> subscriptionId = const Value.absent(),
    Value<String?> labelIds = const Value.absent(),
  }) => CallHistoryData(
    id: id ?? this.id,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    name: name.present ? name.value : this.name,
    timestamp: timestamp ?? this.timestamp,
    endTime: endTime.present ? endTime.value : this.endTime,
    duration: duration.present ? duration.value : this.duration,
    simDisplayName: simDisplayName.present
        ? simDisplayName.value
        : this.simDisplayName,
    callType: callType ?? this.callType,
    simSlotIndex: simSlotIndex.present ? simSlotIndex.value : this.simSlotIndex,
    carrierName: carrierName.present ? carrierName.value : this.carrierName,
    countryIso: countryIso.present ? countryIso.value : this.countryIso,
    subscriptionId: subscriptionId.present
        ? subscriptionId.value
        : this.subscriptionId,
    labelIds: labelIds.present ? labelIds.value : this.labelIds,
  );
  CallHistoryData copyWithCompanion(CallHistoryCompanion data) {
    return CallHistoryData(
      id: data.id.present ? data.id.value : this.id,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      name: data.name.present ? data.name.value : this.name,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      duration: data.duration.present ? data.duration.value : this.duration,
      simDisplayName: data.simDisplayName.present
          ? data.simDisplayName.value
          : this.simDisplayName,
      callType: data.callType.present ? data.callType.value : this.callType,
      simSlotIndex: data.simSlotIndex.present
          ? data.simSlotIndex.value
          : this.simSlotIndex,
      carrierName: data.carrierName.present
          ? data.carrierName.value
          : this.carrierName,
      countryIso: data.countryIso.present
          ? data.countryIso.value
          : this.countryIso,
      subscriptionId: data.subscriptionId.present
          ? data.subscriptionId.value
          : this.subscriptionId,
      labelIds: data.labelIds.present ? data.labelIds.value : this.labelIds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CallHistoryData(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('name: $name, ')
          ..write('timestamp: $timestamp, ')
          ..write('endTime: $endTime, ')
          ..write('duration: $duration, ')
          ..write('simDisplayName: $simDisplayName, ')
          ..write('callType: $callType, ')
          ..write('simSlotIndex: $simSlotIndex, ')
          ..write('carrierName: $carrierName, ')
          ..write('countryIso: $countryIso, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('labelIds: $labelIds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    phoneNumber,
    name,
    timestamp,
    endTime,
    duration,
    simDisplayName,
    callType,
    simSlotIndex,
    carrierName,
    countryIso,
    subscriptionId,
    labelIds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CallHistoryData &&
          other.id == this.id &&
          other.phoneNumber == this.phoneNumber &&
          other.name == this.name &&
          other.timestamp == this.timestamp &&
          other.endTime == this.endTime &&
          other.duration == this.duration &&
          other.simDisplayName == this.simDisplayName &&
          other.callType == this.callType &&
          other.simSlotIndex == this.simSlotIndex &&
          other.carrierName == this.carrierName &&
          other.countryIso == this.countryIso &&
          other.subscriptionId == this.subscriptionId &&
          other.labelIds == this.labelIds);
}

class CallHistoryCompanion extends UpdateCompanion<CallHistoryData> {
  final Value<String> id;
  final Value<String> phoneNumber;
  final Value<String?> name;
  final Value<String> timestamp;
  final Value<String?> endTime;
  final Value<int?> duration;
  final Value<String?> simDisplayName;
  final Value<String> callType;
  final Value<int?> simSlotIndex;
  final Value<String?> carrierName;
  final Value<String?> countryIso;
  final Value<int?> subscriptionId;
  final Value<String?> labelIds;
  final Value<int> rowid;
  const CallHistoryCompanion({
    this.id = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.name = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.endTime = const Value.absent(),
    this.duration = const Value.absent(),
    this.simDisplayName = const Value.absent(),
    this.callType = const Value.absent(),
    this.simSlotIndex = const Value.absent(),
    this.carrierName = const Value.absent(),
    this.countryIso = const Value.absent(),
    this.subscriptionId = const Value.absent(),
    this.labelIds = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CallHistoryCompanion.insert({
    required String id,
    required String phoneNumber,
    this.name = const Value.absent(),
    required String timestamp,
    this.endTime = const Value.absent(),
    this.duration = const Value.absent(),
    this.simDisplayName = const Value.absent(),
    required String callType,
    this.simSlotIndex = const Value.absent(),
    this.carrierName = const Value.absent(),
    this.countryIso = const Value.absent(),
    this.subscriptionId = const Value.absent(),
    this.labelIds = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       phoneNumber = Value(phoneNumber),
       timestamp = Value(timestamp),
       callType = Value(callType);
  static Insertable<CallHistoryData> custom({
    Expression<String>? id,
    Expression<String>? phoneNumber,
    Expression<String>? name,
    Expression<String>? timestamp,
    Expression<String>? endTime,
    Expression<int>? duration,
    Expression<String>? simDisplayName,
    Expression<String>? callType,
    Expression<int>? simSlotIndex,
    Expression<String>? carrierName,
    Expression<String>? countryIso,
    Expression<int>? subscriptionId,
    Expression<String>? labelIds,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (name != null) 'name': name,
      if (timestamp != null) 'timestamp': timestamp,
      if (endTime != null) 'end_time': endTime,
      if (duration != null) 'duration': duration,
      if (simDisplayName != null) 'sim_display_name': simDisplayName,
      if (callType != null) 'call_type': callType,
      if (simSlotIndex != null) 'sim_slot_index': simSlotIndex,
      if (carrierName != null) 'carrier_name': carrierName,
      if (countryIso != null) 'country_iso': countryIso,
      if (subscriptionId != null) 'subscription_id': subscriptionId,
      if (labelIds != null) 'label_ids': labelIds,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CallHistoryCompanion copyWith({
    Value<String>? id,
    Value<String>? phoneNumber,
    Value<String?>? name,
    Value<String>? timestamp,
    Value<String?>? endTime,
    Value<int?>? duration,
    Value<String?>? simDisplayName,
    Value<String>? callType,
    Value<int?>? simSlotIndex,
    Value<String?>? carrierName,
    Value<String?>? countryIso,
    Value<int?>? subscriptionId,
    Value<String?>? labelIds,
    Value<int>? rowid,
  }) {
    return CallHistoryCompanion(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      timestamp: timestamp ?? this.timestamp,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
      simDisplayName: simDisplayName ?? this.simDisplayName,
      callType: callType ?? this.callType,
      simSlotIndex: simSlotIndex ?? this.simSlotIndex,
      carrierName: carrierName ?? this.carrierName,
      countryIso: countryIso ?? this.countryIso,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      labelIds: labelIds ?? this.labelIds,
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
    if (timestamp.present) {
      map['timestamp'] = Variable<String>(timestamp.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<String>(endTime.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (simDisplayName.present) {
      map['sim_display_name'] = Variable<String>(simDisplayName.value);
    }
    if (callType.present) {
      map['call_type'] = Variable<String>(callType.value);
    }
    if (simSlotIndex.present) {
      map['sim_slot_index'] = Variable<int>(simSlotIndex.value);
    }
    if (carrierName.present) {
      map['carrier_name'] = Variable<String>(carrierName.value);
    }
    if (countryIso.present) {
      map['country_iso'] = Variable<String>(countryIso.value);
    }
    if (subscriptionId.present) {
      map['subscription_id'] = Variable<int>(subscriptionId.value);
    }
    if (labelIds.present) {
      map['label_ids'] = Variable<String>(labelIds.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CallHistoryCompanion(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('name: $name, ')
          ..write('timestamp: $timestamp, ')
          ..write('endTime: $endTime, ')
          ..write('duration: $duration, ')
          ..write('simDisplayName: $simDisplayName, ')
          ..write('callType: $callType, ')
          ..write('simSlotIndex: $simSlotIndex, ')
          ..write('carrierName: $carrierName, ')
          ..write('countryIso: $countryIso, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('labelIds: $labelIds, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RulesTable extends Rules with TableInfo<$RulesTable, RuleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RulesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _ruleTypeMeta = const VerificationMeta(
    'ruleType',
  );
  @override
  late final GeneratedColumn<String> ruleType = GeneratedColumn<String>(
    'rule_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelIdMeta = const VerificationMeta(
    'labelId',
  );
  @override
  late final GeneratedColumn<String> labelId = GeneratedColumn<String>(
    'label_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    defaultValue: const Constant(5),
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
  static const VerificationMeta _patternMeta = const VerificationMeta(
    'pattern',
  );
  @override
  late final GeneratedColumn<String> pattern = GeneratedColumn<String>(
    'pattern',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
    'avatar',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSubscribedMeta = const VerificationMeta(
    'isSubscribed',
  );
  @override
  late final GeneratedColumn<int> isSubscribed = GeneratedColumn<int>(
    'is_subscribed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    ruleType,
    phoneNumber,
    labelId,
    priority,
    action,
    isEnabled,
    pattern,
    avatar,
    isSubscribed,
    count,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<RuleData> instance, {
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
    if (data.containsKey('rule_type')) {
      context.handle(
        _ruleTypeMeta,
        ruleType.isAcceptableOrUnknown(data['rule_type']!, _ruleTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleTypeMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('label_id')) {
      context.handle(
        _labelIdMeta,
        labelId.isAcceptableOrUnknown(data['label_id']!, _labelIdMeta),
      );
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
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('pattern')) {
      context.handle(
        _patternMeta,
        pattern.isAcceptableOrUnknown(data['pattern']!, _patternMeta),
      );
    }
    if (data.containsKey('avatar')) {
      context.handle(
        _avatarMeta,
        avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta),
      );
    }
    if (data.containsKey('is_subscribed')) {
      context.handle(
        _isSubscribedMeta,
        isSubscribed.isAcceptableOrUnknown(
          data['is_subscribed']!,
          _isSubscribedMeta,
        ),
      );
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RuleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RuleData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      ruleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_type'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      labelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_id'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_enabled'],
      )!,
      pattern: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pattern'],
      ),
      avatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar'],
      ),
      isSubscribed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_subscribed'],
      )!,
      count: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}count'],
      )!,
    );
  }

  @override
  $RulesTable createAlias(String alias) {
    return $RulesTable(attachedDatabase, alias);
  }
}

class RuleData extends DataClass implements Insertable<RuleData> {
  final String id;
  final String name;
  final String ruleType;
  final String? phoneNumber;
  final String? labelId;
  final int priority;
  final String action;
  final int isEnabled;
  final String? pattern;
  final String? avatar;
  final int isSubscribed;
  final int count;
  const RuleData({
    required this.id,
    required this.name,
    required this.ruleType,
    this.phoneNumber,
    this.labelId,
    required this.priority,
    required this.action,
    required this.isEnabled,
    this.pattern,
    this.avatar,
    required this.isSubscribed,
    required this.count,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['rule_type'] = Variable<String>(ruleType);
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || labelId != null) {
      map['label_id'] = Variable<String>(labelId);
    }
    map['priority'] = Variable<int>(priority);
    map['action'] = Variable<String>(action);
    map['is_enabled'] = Variable<int>(isEnabled);
    if (!nullToAbsent || pattern != null) {
      map['pattern'] = Variable<String>(pattern);
    }
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    map['is_subscribed'] = Variable<int>(isSubscribed);
    map['count'] = Variable<int>(count);
    return map;
  }

  RulesCompanion toCompanion(bool nullToAbsent) {
    return RulesCompanion(
      id: Value(id),
      name: Value(name),
      ruleType: Value(ruleType),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      labelId: labelId == null && nullToAbsent
          ? const Value.absent()
          : Value(labelId),
      priority: Value(priority),
      action: Value(action),
      isEnabled: Value(isEnabled),
      pattern: pattern == null && nullToAbsent
          ? const Value.absent()
          : Value(pattern),
      avatar: avatar == null && nullToAbsent
          ? const Value.absent()
          : Value(avatar),
      isSubscribed: Value(isSubscribed),
      count: Value(count),
    );
  }

  factory RuleData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RuleData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      ruleType: serializer.fromJson<String>(json['ruleType']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      labelId: serializer.fromJson<String?>(json['labelId']),
      priority: serializer.fromJson<int>(json['priority']),
      action: serializer.fromJson<String>(json['action']),
      isEnabled: serializer.fromJson<int>(json['isEnabled']),
      pattern: serializer.fromJson<String?>(json['pattern']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      isSubscribed: serializer.fromJson<int>(json['isSubscribed']),
      count: serializer.fromJson<int>(json['count']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'ruleType': serializer.toJson<String>(ruleType),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'labelId': serializer.toJson<String?>(labelId),
      'priority': serializer.toJson<int>(priority),
      'action': serializer.toJson<String>(action),
      'isEnabled': serializer.toJson<int>(isEnabled),
      'pattern': serializer.toJson<String?>(pattern),
      'avatar': serializer.toJson<String?>(avatar),
      'isSubscribed': serializer.toJson<int>(isSubscribed),
      'count': serializer.toJson<int>(count),
    };
  }

  RuleData copyWith({
    String? id,
    String? name,
    String? ruleType,
    Value<String?> phoneNumber = const Value.absent(),
    Value<String?> labelId = const Value.absent(),
    int? priority,
    String? action,
    int? isEnabled,
    Value<String?> pattern = const Value.absent(),
    Value<String?> avatar = const Value.absent(),
    int? isSubscribed,
    int? count,
  }) => RuleData(
    id: id ?? this.id,
    name: name ?? this.name,
    ruleType: ruleType ?? this.ruleType,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    labelId: labelId.present ? labelId.value : this.labelId,
    priority: priority ?? this.priority,
    action: action ?? this.action,
    isEnabled: isEnabled ?? this.isEnabled,
    pattern: pattern.present ? pattern.value : this.pattern,
    avatar: avatar.present ? avatar.value : this.avatar,
    isSubscribed: isSubscribed ?? this.isSubscribed,
    count: count ?? this.count,
  );
  RuleData copyWithCompanion(RulesCompanion data) {
    return RuleData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      ruleType: data.ruleType.present ? data.ruleType.value : this.ruleType,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      labelId: data.labelId.present ? data.labelId.value : this.labelId,
      priority: data.priority.present ? data.priority.value : this.priority,
      action: data.action.present ? data.action.value : this.action,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      pattern: data.pattern.present ? data.pattern.value : this.pattern,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
      isSubscribed: data.isSubscribed.present
          ? data.isSubscribed.value
          : this.isSubscribed,
      count: data.count.present ? data.count.value : this.count,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RuleData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ruleType: $ruleType, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('labelId: $labelId, ')
          ..write('priority: $priority, ')
          ..write('action: $action, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('pattern: $pattern, ')
          ..write('avatar: $avatar, ')
          ..write('isSubscribed: $isSubscribed, ')
          ..write('count: $count')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    ruleType,
    phoneNumber,
    labelId,
    priority,
    action,
    isEnabled,
    pattern,
    avatar,
    isSubscribed,
    count,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RuleData &&
          other.id == this.id &&
          other.name == this.name &&
          other.ruleType == this.ruleType &&
          other.phoneNumber == this.phoneNumber &&
          other.labelId == this.labelId &&
          other.priority == this.priority &&
          other.action == this.action &&
          other.isEnabled == this.isEnabled &&
          other.pattern == this.pattern &&
          other.avatar == this.avatar &&
          other.isSubscribed == this.isSubscribed &&
          other.count == this.count);
}

class RulesCompanion extends UpdateCompanion<RuleData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> ruleType;
  final Value<String?> phoneNumber;
  final Value<String?> labelId;
  final Value<int> priority;
  final Value<String> action;
  final Value<int> isEnabled;
  final Value<String?> pattern;
  final Value<String?> avatar;
  final Value<int> isSubscribed;
  final Value<int> count;
  final Value<int> rowid;
  const RulesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.ruleType = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.labelId = const Value.absent(),
    this.priority = const Value.absent(),
    this.action = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.pattern = const Value.absent(),
    this.avatar = const Value.absent(),
    this.isSubscribed = const Value.absent(),
    this.count = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RulesCompanion.insert({
    required String id,
    required String name,
    required String ruleType,
    this.phoneNumber = const Value.absent(),
    this.labelId = const Value.absent(),
    this.priority = const Value.absent(),
    this.action = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.pattern = const Value.absent(),
    this.avatar = const Value.absent(),
    this.isSubscribed = const Value.absent(),
    this.count = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       ruleType = Value(ruleType);
  static Insertable<RuleData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? ruleType,
    Expression<String>? phoneNumber,
    Expression<String>? labelId,
    Expression<int>? priority,
    Expression<String>? action,
    Expression<int>? isEnabled,
    Expression<String>? pattern,
    Expression<String>? avatar,
    Expression<int>? isSubscribed,
    Expression<int>? count,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (ruleType != null) 'rule_type': ruleType,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (labelId != null) 'label_id': labelId,
      if (priority != null) 'priority': priority,
      if (action != null) 'action': action,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (pattern != null) 'pattern': pattern,
      if (avatar != null) 'avatar': avatar,
      if (isSubscribed != null) 'is_subscribed': isSubscribed,
      if (count != null) 'count': count,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RulesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? ruleType,
    Value<String?>? phoneNumber,
    Value<String?>? labelId,
    Value<int>? priority,
    Value<String>? action,
    Value<int>? isEnabled,
    Value<String?>? pattern,
    Value<String?>? avatar,
    Value<int>? isSubscribed,
    Value<int>? count,
    Value<int>? rowid,
  }) {
    return RulesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      ruleType: ruleType ?? this.ruleType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      labelId: labelId ?? this.labelId,
      priority: priority ?? this.priority,
      action: action ?? this.action,
      isEnabled: isEnabled ?? this.isEnabled,
      pattern: pattern ?? this.pattern,
      avatar: avatar ?? this.avatar,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      count: count ?? this.count,
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
    if (ruleType.present) {
      map['rule_type'] = Variable<String>(ruleType.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (labelId.present) {
      map['label_id'] = Variable<String>(labelId.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<int>(isEnabled.value);
    }
    if (pattern.present) {
      map['pattern'] = Variable<String>(pattern.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (isSubscribed.present) {
      map['is_subscribed'] = Variable<int>(isSubscribed.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RulesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ruleType: $ruleType, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('labelId: $labelId, ')
          ..write('priority: $priority, ')
          ..write('action: $action, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('pattern: $pattern, ')
          ..write('avatar: $avatar, ')
          ..write('isSubscribed: $isSubscribed, ')
          ..write('count: $count, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhoneRulesTable extends PhoneRules
    with TableInfo<$PhoneRulesTable, PhoneRuleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhoneRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _ruleTypeMeta = const VerificationMeta(
    'ruleType',
  );
  @override
  late final GeneratedColumn<String> ruleType = GeneratedColumn<String>(
    'rule_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
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
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelIdMeta = const VerificationMeta(
    'labelId',
  );
  @override
  late final GeneratedColumn<String> labelId = GeneratedColumn<String>(
    'label_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    defaultValue: const Constant(5),
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
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
    'avatar',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subscriptionIdMeta = const VerificationMeta(
    'subscriptionId',
  );
  @override
  late final GeneratedColumn<String> subscriptionId = GeneratedColumn<String>(
    'subscription_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    ruleType,
    phoneNumber,
    labelId,
    priority,
    action,
    isEnabled,
    count,
    avatar,
    subscriptionId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'phone_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<PhoneRuleData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('rule_type')) {
      context.handle(
        _ruleTypeMeta,
        ruleType.isAcceptableOrUnknown(data['rule_type']!, _ruleTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleTypeMeta);
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
    if (data.containsKey('label_id')) {
      context.handle(
        _labelIdMeta,
        labelId.isAcceptableOrUnknown(data['label_id']!, _labelIdMeta),
      );
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
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    }
    if (data.containsKey('avatar')) {
      context.handle(
        _avatarMeta,
        avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta),
      );
    }
    if (data.containsKey('subscription_id')) {
      context.handle(
        _subscriptionIdMeta,
        subscriptionId.isAcceptableOrUnknown(
          data['subscription_id']!,
          _subscriptionIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {phoneNumber};
  @override
  PhoneRuleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhoneRuleData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      ruleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_type'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      labelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_id'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_enabled'],
      )!,
      count: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}count'],
      )!,
      avatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar'],
      ),
      subscriptionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subscription_id'],
      ),
    );
  }

  @override
  $PhoneRulesTable createAlias(String alias) {
    return $PhoneRulesTable(attachedDatabase, alias);
  }
}

class PhoneRuleData extends DataClass implements Insertable<PhoneRuleData> {
  final String? id;
  final String name;
  final String ruleType;
  final String phoneNumber;
  final String? labelId;
  final int priority;
  final String action;
  final int isEnabled;
  final int count;
  final String? avatar;
  final String? subscriptionId;
  const PhoneRuleData({
    this.id,
    required this.name,
    required this.ruleType,
    required this.phoneNumber,
    this.labelId,
    required this.priority,
    required this.action,
    required this.isEnabled,
    required this.count,
    this.avatar,
    this.subscriptionId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    map['name'] = Variable<String>(name);
    map['rule_type'] = Variable<String>(ruleType);
    map['phone_number'] = Variable<String>(phoneNumber);
    if (!nullToAbsent || labelId != null) {
      map['label_id'] = Variable<String>(labelId);
    }
    map['priority'] = Variable<int>(priority);
    map['action'] = Variable<String>(action);
    map['is_enabled'] = Variable<int>(isEnabled);
    map['count'] = Variable<int>(count);
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    if (!nullToAbsent || subscriptionId != null) {
      map['subscription_id'] = Variable<String>(subscriptionId);
    }
    return map;
  }

  PhoneRulesCompanion toCompanion(bool nullToAbsent) {
    return PhoneRulesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: Value(name),
      ruleType: Value(ruleType),
      phoneNumber: Value(phoneNumber),
      labelId: labelId == null && nullToAbsent
          ? const Value.absent()
          : Value(labelId),
      priority: Value(priority),
      action: Value(action),
      isEnabled: Value(isEnabled),
      count: Value(count),
      avatar: avatar == null && nullToAbsent
          ? const Value.absent()
          : Value(avatar),
      subscriptionId: subscriptionId == null && nullToAbsent
          ? const Value.absent()
          : Value(subscriptionId),
    );
  }

  factory PhoneRuleData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhoneRuleData(
      id: serializer.fromJson<String?>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      ruleType: serializer.fromJson<String>(json['ruleType']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      labelId: serializer.fromJson<String?>(json['labelId']),
      priority: serializer.fromJson<int>(json['priority']),
      action: serializer.fromJson<String>(json['action']),
      isEnabled: serializer.fromJson<int>(json['isEnabled']),
      count: serializer.fromJson<int>(json['count']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      subscriptionId: serializer.fromJson<String?>(json['subscriptionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String?>(id),
      'name': serializer.toJson<String>(name),
      'ruleType': serializer.toJson<String>(ruleType),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'labelId': serializer.toJson<String?>(labelId),
      'priority': serializer.toJson<int>(priority),
      'action': serializer.toJson<String>(action),
      'isEnabled': serializer.toJson<int>(isEnabled),
      'count': serializer.toJson<int>(count),
      'avatar': serializer.toJson<String?>(avatar),
      'subscriptionId': serializer.toJson<String?>(subscriptionId),
    };
  }

  PhoneRuleData copyWith({
    Value<String?> id = const Value.absent(),
    String? name,
    String? ruleType,
    String? phoneNumber,
    Value<String?> labelId = const Value.absent(),
    int? priority,
    String? action,
    int? isEnabled,
    int? count,
    Value<String?> avatar = const Value.absent(),
    Value<String?> subscriptionId = const Value.absent(),
  }) => PhoneRuleData(
    id: id.present ? id.value : this.id,
    name: name ?? this.name,
    ruleType: ruleType ?? this.ruleType,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    labelId: labelId.present ? labelId.value : this.labelId,
    priority: priority ?? this.priority,
    action: action ?? this.action,
    isEnabled: isEnabled ?? this.isEnabled,
    count: count ?? this.count,
    avatar: avatar.present ? avatar.value : this.avatar,
    subscriptionId: subscriptionId.present
        ? subscriptionId.value
        : this.subscriptionId,
  );
  PhoneRuleData copyWithCompanion(PhoneRulesCompanion data) {
    return PhoneRuleData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      ruleType: data.ruleType.present ? data.ruleType.value : this.ruleType,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      labelId: data.labelId.present ? data.labelId.value : this.labelId,
      priority: data.priority.present ? data.priority.value : this.priority,
      action: data.action.present ? data.action.value : this.action,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      count: data.count.present ? data.count.value : this.count,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
      subscriptionId: data.subscriptionId.present
          ? data.subscriptionId.value
          : this.subscriptionId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhoneRuleData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ruleType: $ruleType, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('labelId: $labelId, ')
          ..write('priority: $priority, ')
          ..write('action: $action, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('count: $count, ')
          ..write('avatar: $avatar, ')
          ..write('subscriptionId: $subscriptionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    ruleType,
    phoneNumber,
    labelId,
    priority,
    action,
    isEnabled,
    count,
    avatar,
    subscriptionId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhoneRuleData &&
          other.id == this.id &&
          other.name == this.name &&
          other.ruleType == this.ruleType &&
          other.phoneNumber == this.phoneNumber &&
          other.labelId == this.labelId &&
          other.priority == this.priority &&
          other.action == this.action &&
          other.isEnabled == this.isEnabled &&
          other.count == this.count &&
          other.avatar == this.avatar &&
          other.subscriptionId == this.subscriptionId);
}

class PhoneRulesCompanion extends UpdateCompanion<PhoneRuleData> {
  final Value<String?> id;
  final Value<String> name;
  final Value<String> ruleType;
  final Value<String> phoneNumber;
  final Value<String?> labelId;
  final Value<int> priority;
  final Value<String> action;
  final Value<int> isEnabled;
  final Value<int> count;
  final Value<String?> avatar;
  final Value<String?> subscriptionId;
  final Value<int> rowid;
  const PhoneRulesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.ruleType = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.labelId = const Value.absent(),
    this.priority = const Value.absent(),
    this.action = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.count = const Value.absent(),
    this.avatar = const Value.absent(),
    this.subscriptionId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhoneRulesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String ruleType,
    required String phoneNumber,
    this.labelId = const Value.absent(),
    this.priority = const Value.absent(),
    this.action = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.count = const Value.absent(),
    this.avatar = const Value.absent(),
    this.subscriptionId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       ruleType = Value(ruleType),
       phoneNumber = Value(phoneNumber);
  static Insertable<PhoneRuleData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? ruleType,
    Expression<String>? phoneNumber,
    Expression<String>? labelId,
    Expression<int>? priority,
    Expression<String>? action,
    Expression<int>? isEnabled,
    Expression<int>? count,
    Expression<String>? avatar,
    Expression<String>? subscriptionId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (ruleType != null) 'rule_type': ruleType,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (labelId != null) 'label_id': labelId,
      if (priority != null) 'priority': priority,
      if (action != null) 'action': action,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (count != null) 'count': count,
      if (avatar != null) 'avatar': avatar,
      if (subscriptionId != null) 'subscription_id': subscriptionId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhoneRulesCompanion copyWith({
    Value<String?>? id,
    Value<String>? name,
    Value<String>? ruleType,
    Value<String>? phoneNumber,
    Value<String?>? labelId,
    Value<int>? priority,
    Value<String>? action,
    Value<int>? isEnabled,
    Value<int>? count,
    Value<String?>? avatar,
    Value<String?>? subscriptionId,
    Value<int>? rowid,
  }) {
    return PhoneRulesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      ruleType: ruleType ?? this.ruleType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      labelId: labelId ?? this.labelId,
      priority: priority ?? this.priority,
      action: action ?? this.action,
      isEnabled: isEnabled ?? this.isEnabled,
      count: count ?? this.count,
      avatar: avatar ?? this.avatar,
      subscriptionId: subscriptionId ?? this.subscriptionId,
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
    if (ruleType.present) {
      map['rule_type'] = Variable<String>(ruleType.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (labelId.present) {
      map['label_id'] = Variable<String>(labelId.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<int>(isEnabled.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (subscriptionId.present) {
      map['subscription_id'] = Variable<String>(subscriptionId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhoneRulesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ruleType: $ruleType, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('labelId: $labelId, ')
          ..write('priority: $priority, ')
          ..write('action: $action, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('count: $count, ')
          ..write('avatar: $avatar, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RegexRulesTable extends RegexRules
    with TableInfo<$RegexRulesTable, RegexRuleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegexRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _ruleTypeMeta = const VerificationMeta(
    'ruleType',
  );
  @override
  late final GeneratedColumn<String> ruleType = GeneratedColumn<String>(
    'rule_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patternMeta = const VerificationMeta(
    'pattern',
  );
  @override
  late final GeneratedColumn<String> pattern = GeneratedColumn<String>(
    'pattern',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
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
    defaultValue: const Constant(5),
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
  static const VerificationMeta _subscriptionIdMeta = const VerificationMeta(
    'subscriptionId',
  );
  @override
  late final GeneratedColumn<String> subscriptionId = GeneratedColumn<String>(
    'subscription_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    ruleType,
    pattern,
    priority,
    action,
    isEnabled,
    subscriptionId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'regex_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<RegexRuleData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('rule_type')) {
      context.handle(
        _ruleTypeMeta,
        ruleType.isAcceptableOrUnknown(data['rule_type']!, _ruleTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleTypeMeta);
    }
    if (data.containsKey('pattern')) {
      context.handle(
        _patternMeta,
        pattern.isAcceptableOrUnknown(data['pattern']!, _patternMeta),
      );
    } else if (isInserting) {
      context.missing(_patternMeta);
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
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('subscription_id')) {
      context.handle(
        _subscriptionIdMeta,
        subscriptionId.isAcceptableOrUnknown(
          data['subscription_id']!,
          _subscriptionIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pattern};
  @override
  RegexRuleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RegexRuleData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      ruleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_type'],
      )!,
      pattern: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pattern'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_enabled'],
      )!,
      subscriptionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subscription_id'],
      ),
    );
  }

  @override
  $RegexRulesTable createAlias(String alias) {
    return $RegexRulesTable(attachedDatabase, alias);
  }
}

class RegexRuleData extends DataClass implements Insertable<RegexRuleData> {
  final String? id;
  final String name;
  final String ruleType;
  final String pattern;
  final int priority;
  final String action;
  final int isEnabled;
  final String? subscriptionId;
  const RegexRuleData({
    this.id,
    required this.name,
    required this.ruleType,
    required this.pattern,
    required this.priority,
    required this.action,
    required this.isEnabled,
    this.subscriptionId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    map['name'] = Variable<String>(name);
    map['rule_type'] = Variable<String>(ruleType);
    map['pattern'] = Variable<String>(pattern);
    map['priority'] = Variable<int>(priority);
    map['action'] = Variable<String>(action);
    map['is_enabled'] = Variable<int>(isEnabled);
    if (!nullToAbsent || subscriptionId != null) {
      map['subscription_id'] = Variable<String>(subscriptionId);
    }
    return map;
  }

  RegexRulesCompanion toCompanion(bool nullToAbsent) {
    return RegexRulesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: Value(name),
      ruleType: Value(ruleType),
      pattern: Value(pattern),
      priority: Value(priority),
      action: Value(action),
      isEnabled: Value(isEnabled),
      subscriptionId: subscriptionId == null && nullToAbsent
          ? const Value.absent()
          : Value(subscriptionId),
    );
  }

  factory RegexRuleData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RegexRuleData(
      id: serializer.fromJson<String?>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      ruleType: serializer.fromJson<String>(json['ruleType']),
      pattern: serializer.fromJson<String>(json['pattern']),
      priority: serializer.fromJson<int>(json['priority']),
      action: serializer.fromJson<String>(json['action']),
      isEnabled: serializer.fromJson<int>(json['isEnabled']),
      subscriptionId: serializer.fromJson<String?>(json['subscriptionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String?>(id),
      'name': serializer.toJson<String>(name),
      'ruleType': serializer.toJson<String>(ruleType),
      'pattern': serializer.toJson<String>(pattern),
      'priority': serializer.toJson<int>(priority),
      'action': serializer.toJson<String>(action),
      'isEnabled': serializer.toJson<int>(isEnabled),
      'subscriptionId': serializer.toJson<String?>(subscriptionId),
    };
  }

  RegexRuleData copyWith({
    Value<String?> id = const Value.absent(),
    String? name,
    String? ruleType,
    String? pattern,
    int? priority,
    String? action,
    int? isEnabled,
    Value<String?> subscriptionId = const Value.absent(),
  }) => RegexRuleData(
    id: id.present ? id.value : this.id,
    name: name ?? this.name,
    ruleType: ruleType ?? this.ruleType,
    pattern: pattern ?? this.pattern,
    priority: priority ?? this.priority,
    action: action ?? this.action,
    isEnabled: isEnabled ?? this.isEnabled,
    subscriptionId: subscriptionId.present
        ? subscriptionId.value
        : this.subscriptionId,
  );
  RegexRuleData copyWithCompanion(RegexRulesCompanion data) {
    return RegexRuleData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      ruleType: data.ruleType.present ? data.ruleType.value : this.ruleType,
      pattern: data.pattern.present ? data.pattern.value : this.pattern,
      priority: data.priority.present ? data.priority.value : this.priority,
      action: data.action.present ? data.action.value : this.action,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      subscriptionId: data.subscriptionId.present
          ? data.subscriptionId.value
          : this.subscriptionId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RegexRuleData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ruleType: $ruleType, ')
          ..write('pattern: $pattern, ')
          ..write('priority: $priority, ')
          ..write('action: $action, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('subscriptionId: $subscriptionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    ruleType,
    pattern,
    priority,
    action,
    isEnabled,
    subscriptionId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegexRuleData &&
          other.id == this.id &&
          other.name == this.name &&
          other.ruleType == this.ruleType &&
          other.pattern == this.pattern &&
          other.priority == this.priority &&
          other.action == this.action &&
          other.isEnabled == this.isEnabled &&
          other.subscriptionId == this.subscriptionId);
}

class RegexRulesCompanion extends UpdateCompanion<RegexRuleData> {
  final Value<String?> id;
  final Value<String> name;
  final Value<String> ruleType;
  final Value<String> pattern;
  final Value<int> priority;
  final Value<String> action;
  final Value<int> isEnabled;
  final Value<String?> subscriptionId;
  final Value<int> rowid;
  const RegexRulesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.ruleType = const Value.absent(),
    this.pattern = const Value.absent(),
    this.priority = const Value.absent(),
    this.action = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.subscriptionId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RegexRulesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String ruleType,
    required String pattern,
    this.priority = const Value.absent(),
    this.action = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.subscriptionId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       ruleType = Value(ruleType),
       pattern = Value(pattern);
  static Insertable<RegexRuleData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? ruleType,
    Expression<String>? pattern,
    Expression<int>? priority,
    Expression<String>? action,
    Expression<int>? isEnabled,
    Expression<String>? subscriptionId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (ruleType != null) 'rule_type': ruleType,
      if (pattern != null) 'pattern': pattern,
      if (priority != null) 'priority': priority,
      if (action != null) 'action': action,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (subscriptionId != null) 'subscription_id': subscriptionId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RegexRulesCompanion copyWith({
    Value<String?>? id,
    Value<String>? name,
    Value<String>? ruleType,
    Value<String>? pattern,
    Value<int>? priority,
    Value<String>? action,
    Value<int>? isEnabled,
    Value<String?>? subscriptionId,
    Value<int>? rowid,
  }) {
    return RegexRulesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      ruleType: ruleType ?? this.ruleType,
      pattern: pattern ?? this.pattern,
      priority: priority ?? this.priority,
      action: action ?? this.action,
      isEnabled: isEnabled ?? this.isEnabled,
      subscriptionId: subscriptionId ?? this.subscriptionId,
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
    if (ruleType.present) {
      map['rule_type'] = Variable<String>(ruleType.value);
    }
    if (pattern.present) {
      map['pattern'] = Variable<String>(pattern.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<int>(isEnabled.value);
    }
    if (subscriptionId.present) {
      map['subscription_id'] = Variable<String>(subscriptionId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegexRulesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('ruleType: $ruleType, ')
          ..write('pattern: $pattern, ')
          ..write('priority: $priority, ')
          ..write('action: $action, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubscriptionsTable extends Subscriptions
    with TableInfo<$SubscriptionsTable, SubscriptionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubscriptionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tableTypeMeta = const VerificationMeta(
    'tableType',
  );
  @override
  late final GeneratedColumn<String> tableType = GeneratedColumn<String>(
    'table_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<String> lastUpdated = GeneratedColumn<String>(
    'last_updated',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _autoUpdateMeta = const VerificationMeta(
    'autoUpdate',
  );
  @override
  late final GeneratedColumn<int> autoUpdate = GeneratedColumn<int>(
    'auto_update',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _contactGroupMeta = const VerificationMeta(
    'contactGroup',
  );
  @override
  late final GeneratedColumn<String> contactGroup = GeneratedColumn<String>(
    'contact_group',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _keywordFiltersMeta = const VerificationMeta(
    'keywordFilters',
  );
  @override
  late final GeneratedColumn<String> keywordFilters = GeneratedColumn<String>(
    'keyword_filters',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    url,
    tableType,
    isEnabled,
    lastUpdated,
    autoUpdate,
    contactGroup,
    keywordFilters,
    action,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subscriptions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SubscriptionData> instance, {
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
    if (data.containsKey('table_type')) {
      context.handle(
        _tableTypeMeta,
        tableType.isAcceptableOrUnknown(data['table_type']!, _tableTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_tableTypeMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
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
    if (data.containsKey('auto_update')) {
      context.handle(
        _autoUpdateMeta,
        autoUpdate.isAcceptableOrUnknown(data['auto_update']!, _autoUpdateMeta),
      );
    }
    if (data.containsKey('contact_group')) {
      context.handle(
        _contactGroupMeta,
        contactGroup.isAcceptableOrUnknown(
          data['contact_group']!,
          _contactGroupMeta,
        ),
      );
    }
    if (data.containsKey('keyword_filters')) {
      context.handle(
        _keywordFiltersMeta,
        keywordFilters.isAcceptableOrUnknown(
          data['keyword_filters']!,
          _keywordFiltersMeta,
        ),
      );
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubscriptionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubscriptionData(
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
      tableType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}table_type'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_enabled'],
      )!,
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_updated'],
      )!,
      autoUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}auto_update'],
      )!,
      contactGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_group'],
      ),
      keywordFilters: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}keyword_filters'],
      ),
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
    );
  }

  @override
  $SubscriptionsTable createAlias(String alias) {
    return $SubscriptionsTable(attachedDatabase, alias);
  }
}

class SubscriptionData extends DataClass
    implements Insertable<SubscriptionData> {
  final String id;
  final String name;
  final String url;
  final String tableType;
  final int isEnabled;
  final String lastUpdated;
  final int autoUpdate;
  final String? contactGroup;
  final String? keywordFilters;
  final String action;
  const SubscriptionData({
    required this.id,
    required this.name,
    required this.url,
    required this.tableType,
    required this.isEnabled,
    required this.lastUpdated,
    required this.autoUpdate,
    this.contactGroup,
    this.keywordFilters,
    required this.action,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['url'] = Variable<String>(url);
    map['table_type'] = Variable<String>(tableType);
    map['is_enabled'] = Variable<int>(isEnabled);
    map['last_updated'] = Variable<String>(lastUpdated);
    map['auto_update'] = Variable<int>(autoUpdate);
    if (!nullToAbsent || contactGroup != null) {
      map['contact_group'] = Variable<String>(contactGroup);
    }
    if (!nullToAbsent || keywordFilters != null) {
      map['keyword_filters'] = Variable<String>(keywordFilters);
    }
    map['action'] = Variable<String>(action);
    return map;
  }

  SubscriptionsCompanion toCompanion(bool nullToAbsent) {
    return SubscriptionsCompanion(
      id: Value(id),
      name: Value(name),
      url: Value(url),
      tableType: Value(tableType),
      isEnabled: Value(isEnabled),
      lastUpdated: Value(lastUpdated),
      autoUpdate: Value(autoUpdate),
      contactGroup: contactGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(contactGroup),
      keywordFilters: keywordFilters == null && nullToAbsent
          ? const Value.absent()
          : Value(keywordFilters),
      action: Value(action),
    );
  }

  factory SubscriptionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubscriptionData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      url: serializer.fromJson<String>(json['url']),
      tableType: serializer.fromJson<String>(json['tableType']),
      isEnabled: serializer.fromJson<int>(json['isEnabled']),
      lastUpdated: serializer.fromJson<String>(json['lastUpdated']),
      autoUpdate: serializer.fromJson<int>(json['autoUpdate']),
      contactGroup: serializer.fromJson<String?>(json['contactGroup']),
      keywordFilters: serializer.fromJson<String?>(json['keywordFilters']),
      action: serializer.fromJson<String>(json['action']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'url': serializer.toJson<String>(url),
      'tableType': serializer.toJson<String>(tableType),
      'isEnabled': serializer.toJson<int>(isEnabled),
      'lastUpdated': serializer.toJson<String>(lastUpdated),
      'autoUpdate': serializer.toJson<int>(autoUpdate),
      'contactGroup': serializer.toJson<String?>(contactGroup),
      'keywordFilters': serializer.toJson<String?>(keywordFilters),
      'action': serializer.toJson<String>(action),
    };
  }

  SubscriptionData copyWith({
    String? id,
    String? name,
    String? url,
    String? tableType,
    int? isEnabled,
    String? lastUpdated,
    int? autoUpdate,
    Value<String?> contactGroup = const Value.absent(),
    Value<String?> keywordFilters = const Value.absent(),
    String? action,
  }) => SubscriptionData(
    id: id ?? this.id,
    name: name ?? this.name,
    url: url ?? this.url,
    tableType: tableType ?? this.tableType,
    isEnabled: isEnabled ?? this.isEnabled,
    lastUpdated: lastUpdated ?? this.lastUpdated,
    autoUpdate: autoUpdate ?? this.autoUpdate,
    contactGroup: contactGroup.present ? contactGroup.value : this.contactGroup,
    keywordFilters: keywordFilters.present
        ? keywordFilters.value
        : this.keywordFilters,
    action: action ?? this.action,
  );
  SubscriptionData copyWithCompanion(SubscriptionsCompanion data) {
    return SubscriptionData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      url: data.url.present ? data.url.value : this.url,
      tableType: data.tableType.present ? data.tableType.value : this.tableType,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
      autoUpdate: data.autoUpdate.present
          ? data.autoUpdate.value
          : this.autoUpdate,
      contactGroup: data.contactGroup.present
          ? data.contactGroup.value
          : this.contactGroup,
      keywordFilters: data.keywordFilters.present
          ? data.keywordFilters.value
          : this.keywordFilters,
      action: data.action.present ? data.action.value : this.action,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('tableType: $tableType, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('autoUpdate: $autoUpdate, ')
          ..write('contactGroup: $contactGroup, ')
          ..write('keywordFilters: $keywordFilters, ')
          ..write('action: $action')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    url,
    tableType,
    isEnabled,
    lastUpdated,
    autoUpdate,
    contactGroup,
    keywordFilters,
    action,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubscriptionData &&
          other.id == this.id &&
          other.name == this.name &&
          other.url == this.url &&
          other.tableType == this.tableType &&
          other.isEnabled == this.isEnabled &&
          other.lastUpdated == this.lastUpdated &&
          other.autoUpdate == this.autoUpdate &&
          other.contactGroup == this.contactGroup &&
          other.keywordFilters == this.keywordFilters &&
          other.action == this.action);
}

class SubscriptionsCompanion extends UpdateCompanion<SubscriptionData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> url;
  final Value<String> tableType;
  final Value<int> isEnabled;
  final Value<String> lastUpdated;
  final Value<int> autoUpdate;
  final Value<String?> contactGroup;
  final Value<String?> keywordFilters;
  final Value<String> action;
  final Value<int> rowid;
  const SubscriptionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.url = const Value.absent(),
    this.tableType = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.autoUpdate = const Value.absent(),
    this.contactGroup = const Value.absent(),
    this.keywordFilters = const Value.absent(),
    this.action = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubscriptionsCompanion.insert({
    required String id,
    required String name,
    required String url,
    required String tableType,
    this.isEnabled = const Value.absent(),
    required String lastUpdated,
    this.autoUpdate = const Value.absent(),
    this.contactGroup = const Value.absent(),
    this.keywordFilters = const Value.absent(),
    this.action = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       url = Value(url),
       tableType = Value(tableType),
       lastUpdated = Value(lastUpdated);
  static Insertable<SubscriptionData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? url,
    Expression<String>? tableType,
    Expression<int>? isEnabled,
    Expression<String>? lastUpdated,
    Expression<int>? autoUpdate,
    Expression<String>? contactGroup,
    Expression<String>? keywordFilters,
    Expression<String>? action,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (url != null) 'url': url,
      if (tableType != null) 'table_type': tableType,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (autoUpdate != null) 'auto_update': autoUpdate,
      if (contactGroup != null) 'contact_group': contactGroup,
      if (keywordFilters != null) 'keyword_filters': keywordFilters,
      if (action != null) 'action': action,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubscriptionsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? url,
    Value<String>? tableType,
    Value<int>? isEnabled,
    Value<String>? lastUpdated,
    Value<int>? autoUpdate,
    Value<String?>? contactGroup,
    Value<String?>? keywordFilters,
    Value<String>? action,
    Value<int>? rowid,
  }) {
    return SubscriptionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      tableType: tableType ?? this.tableType,
      isEnabled: isEnabled ?? this.isEnabled,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      autoUpdate: autoUpdate ?? this.autoUpdate,
      contactGroup: contactGroup ?? this.contactGroup,
      keywordFilters: keywordFilters ?? this.keywordFilters,
      action: action ?? this.action,
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
    if (tableType.present) {
      map['table_type'] = Variable<String>(tableType.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<int>(isEnabled.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<String>(lastUpdated.value);
    }
    if (autoUpdate.present) {
      map['auto_update'] = Variable<int>(autoUpdate.value);
    }
    if (contactGroup.present) {
      map['contact_group'] = Variable<String>(contactGroup.value);
    }
    if (keywordFilters.present) {
      map['keyword_filters'] = Variable<String>(keywordFilters.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('tableType: $tableType, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('autoUpdate: $autoUpdate, ')
          ..write('contactGroup: $contactGroup, ')
          ..write('keywordFilters: $keywordFilters, ')
          ..write('action: $action, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SmsTable extends Sms with TableInfo<$SmsTable, SmsMessageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactNameMeta = const VerificationMeta(
    'contactName',
  );
  @override
  late final GeneratedColumn<String> contactName = GeneratedColumn<String>(
    'contact_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _messageTypeMeta = const VerificationMeta(
    'messageType',
  );
  @override
  late final GeneratedColumn<String> messageType = GeneratedColumn<String>(
    'message_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<String> timestamp = GeneratedColumn<String>(
    'timestamp',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<int> isRead = GeneratedColumn<int>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _simInfoMeta = const VerificationMeta(
    'simInfo',
  );
  @override
  late final GeneratedColumn<String> simInfo = GeneratedColumn<String>(
    'sim_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isMarkedMeta = const VerificationMeta(
    'isMarked',
  );
  @override
  late final GeneratedColumn<int> isMarked = GeneratedColumn<int>(
    'is_marked',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _labelIdsMeta = const VerificationMeta(
    'labelIds',
  );
  @override
  late final GeneratedColumn<String> labelIds = GeneratedColumn<String>(
    'label_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    phoneNumber,
    contactName,
    messageType,
    content,
    timestamp,
    isRead,
    simInfo,
    isMarked,
    labelIds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sms';
  @override
  VerificationContext validateIntegrity(
    Insertable<SmsMessageData> instance, {
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
    if (data.containsKey('contact_name')) {
      context.handle(
        _contactNameMeta,
        contactName.isAcceptableOrUnknown(
          data['contact_name']!,
          _contactNameMeta,
        ),
      );
    }
    if (data.containsKey('message_type')) {
      context.handle(
        _messageTypeMeta,
        messageType.isAcceptableOrUnknown(
          data['message_type']!,
          _messageTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_messageTypeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('sim_info')) {
      context.handle(
        _simInfoMeta,
        simInfo.isAcceptableOrUnknown(data['sim_info']!, _simInfoMeta),
      );
    }
    if (data.containsKey('is_marked')) {
      context.handle(
        _isMarkedMeta,
        isMarked.isAcceptableOrUnknown(data['is_marked']!, _isMarkedMeta),
      );
    }
    if (data.containsKey('label_ids')) {
      context.handle(
        _labelIdsMeta,
        labelIds.isAcceptableOrUnknown(data['label_ids']!, _labelIdsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SmsMessageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmsMessageData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      contactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_name'],
      ),
      messageType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_type'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timestamp'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_read'],
      )!,
      simInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sim_info'],
      ),
      isMarked: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_marked'],
      )!,
      labelIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_ids'],
      ),
    );
  }

  @override
  $SmsTable createAlias(String alias) {
    return $SmsTable(attachedDatabase, alias);
  }
}

class SmsMessageData extends DataClass implements Insertable<SmsMessageData> {
  final String id;
  final String phoneNumber;
  final String? contactName;
  final String messageType;
  final String content;
  final String timestamp;
  final int isRead;
  final String? simInfo;
  final int isMarked;
  final String? labelIds;
  const SmsMessageData({
    required this.id,
    required this.phoneNumber,
    this.contactName,
    required this.messageType,
    required this.content,
    required this.timestamp,
    required this.isRead,
    this.simInfo,
    required this.isMarked,
    this.labelIds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['phone_number'] = Variable<String>(phoneNumber);
    if (!nullToAbsent || contactName != null) {
      map['contact_name'] = Variable<String>(contactName);
    }
    map['message_type'] = Variable<String>(messageType);
    map['content'] = Variable<String>(content);
    map['timestamp'] = Variable<String>(timestamp);
    map['is_read'] = Variable<int>(isRead);
    if (!nullToAbsent || simInfo != null) {
      map['sim_info'] = Variable<String>(simInfo);
    }
    map['is_marked'] = Variable<int>(isMarked);
    if (!nullToAbsent || labelIds != null) {
      map['label_ids'] = Variable<String>(labelIds);
    }
    return map;
  }

  SmsCompanion toCompanion(bool nullToAbsent) {
    return SmsCompanion(
      id: Value(id),
      phoneNumber: Value(phoneNumber),
      contactName: contactName == null && nullToAbsent
          ? const Value.absent()
          : Value(contactName),
      messageType: Value(messageType),
      content: Value(content),
      timestamp: Value(timestamp),
      isRead: Value(isRead),
      simInfo: simInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(simInfo),
      isMarked: Value(isMarked),
      labelIds: labelIds == null && nullToAbsent
          ? const Value.absent()
          : Value(labelIds),
    );
  }

  factory SmsMessageData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmsMessageData(
      id: serializer.fromJson<String>(json['id']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      contactName: serializer.fromJson<String?>(json['contactName']),
      messageType: serializer.fromJson<String>(json['messageType']),
      content: serializer.fromJson<String>(json['content']),
      timestamp: serializer.fromJson<String>(json['timestamp']),
      isRead: serializer.fromJson<int>(json['isRead']),
      simInfo: serializer.fromJson<String?>(json['simInfo']),
      isMarked: serializer.fromJson<int>(json['isMarked']),
      labelIds: serializer.fromJson<String?>(json['labelIds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'contactName': serializer.toJson<String?>(contactName),
      'messageType': serializer.toJson<String>(messageType),
      'content': serializer.toJson<String>(content),
      'timestamp': serializer.toJson<String>(timestamp),
      'isRead': serializer.toJson<int>(isRead),
      'simInfo': serializer.toJson<String?>(simInfo),
      'isMarked': serializer.toJson<int>(isMarked),
      'labelIds': serializer.toJson<String?>(labelIds),
    };
  }

  SmsMessageData copyWith({
    String? id,
    String? phoneNumber,
    Value<String?> contactName = const Value.absent(),
    String? messageType,
    String? content,
    String? timestamp,
    int? isRead,
    Value<String?> simInfo = const Value.absent(),
    int? isMarked,
    Value<String?> labelIds = const Value.absent(),
  }) => SmsMessageData(
    id: id ?? this.id,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    contactName: contactName.present ? contactName.value : this.contactName,
    messageType: messageType ?? this.messageType,
    content: content ?? this.content,
    timestamp: timestamp ?? this.timestamp,
    isRead: isRead ?? this.isRead,
    simInfo: simInfo.present ? simInfo.value : this.simInfo,
    isMarked: isMarked ?? this.isMarked,
    labelIds: labelIds.present ? labelIds.value : this.labelIds,
  );
  SmsMessageData copyWithCompanion(SmsCompanion data) {
    return SmsMessageData(
      id: data.id.present ? data.id.value : this.id,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      contactName: data.contactName.present
          ? data.contactName.value
          : this.contactName,
      messageType: data.messageType.present
          ? data.messageType.value
          : this.messageType,
      content: data.content.present ? data.content.value : this.content,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      simInfo: data.simInfo.present ? data.simInfo.value : this.simInfo,
      isMarked: data.isMarked.present ? data.isMarked.value : this.isMarked,
      labelIds: data.labelIds.present ? data.labelIds.value : this.labelIds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmsMessageData(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('contactName: $contactName, ')
          ..write('messageType: $messageType, ')
          ..write('content: $content, ')
          ..write('timestamp: $timestamp, ')
          ..write('isRead: $isRead, ')
          ..write('simInfo: $simInfo, ')
          ..write('isMarked: $isMarked, ')
          ..write('labelIds: $labelIds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    phoneNumber,
    contactName,
    messageType,
    content,
    timestamp,
    isRead,
    simInfo,
    isMarked,
    labelIds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmsMessageData &&
          other.id == this.id &&
          other.phoneNumber == this.phoneNumber &&
          other.contactName == this.contactName &&
          other.messageType == this.messageType &&
          other.content == this.content &&
          other.timestamp == this.timestamp &&
          other.isRead == this.isRead &&
          other.simInfo == this.simInfo &&
          other.isMarked == this.isMarked &&
          other.labelIds == this.labelIds);
}

class SmsCompanion extends UpdateCompanion<SmsMessageData> {
  final Value<String> id;
  final Value<String> phoneNumber;
  final Value<String?> contactName;
  final Value<String> messageType;
  final Value<String> content;
  final Value<String> timestamp;
  final Value<int> isRead;
  final Value<String?> simInfo;
  final Value<int> isMarked;
  final Value<String?> labelIds;
  final Value<int> rowid;
  const SmsCompanion({
    this.id = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.contactName = const Value.absent(),
    this.messageType = const Value.absent(),
    this.content = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.isRead = const Value.absent(),
    this.simInfo = const Value.absent(),
    this.isMarked = const Value.absent(),
    this.labelIds = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SmsCompanion.insert({
    required String id,
    required String phoneNumber,
    this.contactName = const Value.absent(),
    required String messageType,
    required String content,
    required String timestamp,
    this.isRead = const Value.absent(),
    this.simInfo = const Value.absent(),
    this.isMarked = const Value.absent(),
    this.labelIds = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       phoneNumber = Value(phoneNumber),
       messageType = Value(messageType),
       content = Value(content),
       timestamp = Value(timestamp);
  static Insertable<SmsMessageData> custom({
    Expression<String>? id,
    Expression<String>? phoneNumber,
    Expression<String>? contactName,
    Expression<String>? messageType,
    Expression<String>? content,
    Expression<String>? timestamp,
    Expression<int>? isRead,
    Expression<String>? simInfo,
    Expression<int>? isMarked,
    Expression<String>? labelIds,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (contactName != null) 'contact_name': contactName,
      if (messageType != null) 'message_type': messageType,
      if (content != null) 'content': content,
      if (timestamp != null) 'timestamp': timestamp,
      if (isRead != null) 'is_read': isRead,
      if (simInfo != null) 'sim_info': simInfo,
      if (isMarked != null) 'is_marked': isMarked,
      if (labelIds != null) 'label_ids': labelIds,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SmsCompanion copyWith({
    Value<String>? id,
    Value<String>? phoneNumber,
    Value<String?>? contactName,
    Value<String>? messageType,
    Value<String>? content,
    Value<String>? timestamp,
    Value<int>? isRead,
    Value<String?>? simInfo,
    Value<int>? isMarked,
    Value<String?>? labelIds,
    Value<int>? rowid,
  }) {
    return SmsCompanion(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      contactName: contactName ?? this.contactName,
      messageType: messageType ?? this.messageType,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      simInfo: simInfo ?? this.simInfo,
      isMarked: isMarked ?? this.isMarked,
      labelIds: labelIds ?? this.labelIds,
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
    if (contactName.present) {
      map['contact_name'] = Variable<String>(contactName.value);
    }
    if (messageType.present) {
      map['message_type'] = Variable<String>(messageType.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<String>(timestamp.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<int>(isRead.value);
    }
    if (simInfo.present) {
      map['sim_info'] = Variable<String>(simInfo.value);
    }
    if (isMarked.present) {
      map['is_marked'] = Variable<int>(isMarked.value);
    }
    if (labelIds.present) {
      map['label_ids'] = Variable<String>(labelIds.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmsCompanion(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('contactName: $contactName, ')
          ..write('messageType: $messageType, ')
          ..write('content: $content, ')
          ..write('timestamp: $timestamp, ')
          ..write('isRead: $isRead, ')
          ..write('simInfo: $simInfo, ')
          ..write('isMarked: $isMarked, ')
          ..write('labelIds: $labelIds, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SmsRulesTable extends SmsRules
    with TableInfo<$SmsRulesTable, SmsRuleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmsRulesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _contentRegexMeta = const VerificationMeta(
    'contentRegex',
  );
  @override
  late final GeneratedColumn<String> contentRegex = GeneratedColumn<String>(
    'content_regex',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderRegexMeta = const VerificationMeta(
    'senderRegex',
  );
  @override
  late final GeneratedColumn<String> senderRegex = GeneratedColumn<String>(
    'sender_regex',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
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
    defaultValue: const Constant(5),
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
  static const VerificationMeta _ruleTypeMeta = const VerificationMeta(
    'ruleType',
  );
  @override
  late final GeneratedColumn<String> ruleType = GeneratedColumn<String>(
    'rule_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    contentRegex,
    senderRegex,
    action,
    priority,
    isEnabled,
    ruleType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sms_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<SmsRuleData> instance, {
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
    if (data.containsKey('content_regex')) {
      context.handle(
        _contentRegexMeta,
        contentRegex.isAcceptableOrUnknown(
          data['content_regex']!,
          _contentRegexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentRegexMeta);
    }
    if (data.containsKey('sender_regex')) {
      context.handle(
        _senderRegexMeta,
        senderRegex.isAcceptableOrUnknown(
          data['sender_regex']!,
          _senderRegexMeta,
        ),
      );
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('rule_type')) {
      context.handle(
        _ruleTypeMeta,
        ruleType.isAcceptableOrUnknown(data['rule_type']!, _ruleTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SmsRuleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmsRuleData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      contentRegex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_regex'],
      )!,
      senderRegex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_regex'],
      ),
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_enabled'],
      )!,
      ruleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_type'],
      )!,
    );
  }

  @override
  $SmsRulesTable createAlias(String alias) {
    return $SmsRulesTable(attachedDatabase, alias);
  }
}

class SmsRuleData extends DataClass implements Insertable<SmsRuleData> {
  final String id;
  final String name;
  final String contentRegex;
  final String? senderRegex;
  final String action;
  final int priority;
  final int isEnabled;
  final String ruleType;
  const SmsRuleData({
    required this.id,
    required this.name,
    required this.contentRegex,
    this.senderRegex,
    required this.action,
    required this.priority,
    required this.isEnabled,
    required this.ruleType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['content_regex'] = Variable<String>(contentRegex);
    if (!nullToAbsent || senderRegex != null) {
      map['sender_regex'] = Variable<String>(senderRegex);
    }
    map['action'] = Variable<String>(action);
    map['priority'] = Variable<int>(priority);
    map['is_enabled'] = Variable<int>(isEnabled);
    map['rule_type'] = Variable<String>(ruleType);
    return map;
  }

  SmsRulesCompanion toCompanion(bool nullToAbsent) {
    return SmsRulesCompanion(
      id: Value(id),
      name: Value(name),
      contentRegex: Value(contentRegex),
      senderRegex: senderRegex == null && nullToAbsent
          ? const Value.absent()
          : Value(senderRegex),
      action: Value(action),
      priority: Value(priority),
      isEnabled: Value(isEnabled),
      ruleType: Value(ruleType),
    );
  }

  factory SmsRuleData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmsRuleData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      contentRegex: serializer.fromJson<String>(json['contentRegex']),
      senderRegex: serializer.fromJson<String?>(json['senderRegex']),
      action: serializer.fromJson<String>(json['action']),
      priority: serializer.fromJson<int>(json['priority']),
      isEnabled: serializer.fromJson<int>(json['isEnabled']),
      ruleType: serializer.fromJson<String>(json['ruleType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'contentRegex': serializer.toJson<String>(contentRegex),
      'senderRegex': serializer.toJson<String?>(senderRegex),
      'action': serializer.toJson<String>(action),
      'priority': serializer.toJson<int>(priority),
      'isEnabled': serializer.toJson<int>(isEnabled),
      'ruleType': serializer.toJson<String>(ruleType),
    };
  }

  SmsRuleData copyWith({
    String? id,
    String? name,
    String? contentRegex,
    Value<String?> senderRegex = const Value.absent(),
    String? action,
    int? priority,
    int? isEnabled,
    String? ruleType,
  }) => SmsRuleData(
    id: id ?? this.id,
    name: name ?? this.name,
    contentRegex: contentRegex ?? this.contentRegex,
    senderRegex: senderRegex.present ? senderRegex.value : this.senderRegex,
    action: action ?? this.action,
    priority: priority ?? this.priority,
    isEnabled: isEnabled ?? this.isEnabled,
    ruleType: ruleType ?? this.ruleType,
  );
  SmsRuleData copyWithCompanion(SmsRulesCompanion data) {
    return SmsRuleData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      contentRegex: data.contentRegex.present
          ? data.contentRegex.value
          : this.contentRegex,
      senderRegex: data.senderRegex.present
          ? data.senderRegex.value
          : this.senderRegex,
      action: data.action.present ? data.action.value : this.action,
      priority: data.priority.present ? data.priority.value : this.priority,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      ruleType: data.ruleType.present ? data.ruleType.value : this.ruleType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmsRuleData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('contentRegex: $contentRegex, ')
          ..write('senderRegex: $senderRegex, ')
          ..write('action: $action, ')
          ..write('priority: $priority, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('ruleType: $ruleType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    contentRegex,
    senderRegex,
    action,
    priority,
    isEnabled,
    ruleType,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmsRuleData &&
          other.id == this.id &&
          other.name == this.name &&
          other.contentRegex == this.contentRegex &&
          other.senderRegex == this.senderRegex &&
          other.action == this.action &&
          other.priority == this.priority &&
          other.isEnabled == this.isEnabled &&
          other.ruleType == this.ruleType);
}

class SmsRulesCompanion extends UpdateCompanion<SmsRuleData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> contentRegex;
  final Value<String?> senderRegex;
  final Value<String> action;
  final Value<int> priority;
  final Value<int> isEnabled;
  final Value<String> ruleType;
  final Value<int> rowid;
  const SmsRulesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.contentRegex = const Value.absent(),
    this.senderRegex = const Value.absent(),
    this.action = const Value.absent(),
    this.priority = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.ruleType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SmsRulesCompanion.insert({
    required String id,
    required String name,
    required String contentRegex,
    this.senderRegex = const Value.absent(),
    required String action,
    this.priority = const Value.absent(),
    this.isEnabled = const Value.absent(),
    required String ruleType,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       contentRegex = Value(contentRegex),
       action = Value(action),
       ruleType = Value(ruleType);
  static Insertable<SmsRuleData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? contentRegex,
    Expression<String>? senderRegex,
    Expression<String>? action,
    Expression<int>? priority,
    Expression<int>? isEnabled,
    Expression<String>? ruleType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (contentRegex != null) 'content_regex': contentRegex,
      if (senderRegex != null) 'sender_regex': senderRegex,
      if (action != null) 'action': action,
      if (priority != null) 'priority': priority,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (ruleType != null) 'rule_type': ruleType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SmsRulesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? contentRegex,
    Value<String?>? senderRegex,
    Value<String>? action,
    Value<int>? priority,
    Value<int>? isEnabled,
    Value<String>? ruleType,
    Value<int>? rowid,
  }) {
    return SmsRulesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      contentRegex: contentRegex ?? this.contentRegex,
      senderRegex: senderRegex ?? this.senderRegex,
      action: action ?? this.action,
      priority: priority ?? this.priority,
      isEnabled: isEnabled ?? this.isEnabled,
      ruleType: ruleType ?? this.ruleType,
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
    if (contentRegex.present) {
      map['content_regex'] = Variable<String>(contentRegex.value);
    }
    if (senderRegex.present) {
      map['sender_regex'] = Variable<String>(senderRegex.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<int>(isEnabled.value);
    }
    if (ruleType.present) {
      map['rule_type'] = Variable<String>(ruleType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmsRulesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('contentRegex: $contentRegex, ')
          ..write('senderRegex: $senderRegex, ')
          ..write('action: $action, ')
          ..write('priority: $priority, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('ruleType: $ruleType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

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

class $LocationsTable extends Locations
    with TableInfo<$LocationsTable, LocationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryNameMeta = const VerificationMeta(
    'countryName',
  );
  @override
  late final GeneratedColumn<String> countryName = GeneratedColumn<String>(
    'country_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _carrierMeta = const VerificationMeta(
    'carrier',
  );
  @override
  late final GeneratedColumn<String> carrier = GeneratedColumn<String>(
    'carrier',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _numberTypeMeta = const VerificationMeta(
    'numberType',
  );
  @override
  late final GeneratedColumn<int> numberType = GeneratedColumn<int>(
    'number_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    phoneNumber,
    region,
    countryName,
    carrier,
    numberType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'locations';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocationData> instance, {
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
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('country_name')) {
      context.handle(
        _countryNameMeta,
        countryName.isAcceptableOrUnknown(
          data['country_name']!,
          _countryNameMeta,
        ),
      );
    }
    if (data.containsKey('carrier')) {
      context.handle(
        _carrierMeta,
        carrier.isAcceptableOrUnknown(data['carrier']!, _carrierMeta),
      );
    }
    if (data.containsKey('number_type')) {
      context.handle(
        _numberTypeMeta,
        numberType.isAcceptableOrUnknown(data['number_type']!, _numberTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_numberTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocationData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      countryName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_name'],
      ),
      carrier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}carrier'],
      ),
      numberType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_type'],
      )!,
    );
  }

  @override
  $LocationsTable createAlias(String alias) {
    return $LocationsTable(attachedDatabase, alias);
  }
}

class LocationData extends DataClass implements Insertable<LocationData> {
  final String id;
  final String phoneNumber;
  final String? region;
  final String? countryName;
  final String? carrier;
  final int numberType;
  const LocationData({
    required this.id,
    required this.phoneNumber,
    this.region,
    this.countryName,
    this.carrier,
    required this.numberType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['phone_number'] = Variable<String>(phoneNumber);
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || countryName != null) {
      map['country_name'] = Variable<String>(countryName);
    }
    if (!nullToAbsent || carrier != null) {
      map['carrier'] = Variable<String>(carrier);
    }
    map['number_type'] = Variable<int>(numberType);
    return map;
  }

  LocationsCompanion toCompanion(bool nullToAbsent) {
    return LocationsCompanion(
      id: Value(id),
      phoneNumber: Value(phoneNumber),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      countryName: countryName == null && nullToAbsent
          ? const Value.absent()
          : Value(countryName),
      carrier: carrier == null && nullToAbsent
          ? const Value.absent()
          : Value(carrier),
      numberType: Value(numberType),
    );
  }

  factory LocationData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationData(
      id: serializer.fromJson<String>(json['id']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      region: serializer.fromJson<String?>(json['region']),
      countryName: serializer.fromJson<String?>(json['countryName']),
      carrier: serializer.fromJson<String?>(json['carrier']),
      numberType: serializer.fromJson<int>(json['numberType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'region': serializer.toJson<String?>(region),
      'countryName': serializer.toJson<String?>(countryName),
      'carrier': serializer.toJson<String?>(carrier),
      'numberType': serializer.toJson<int>(numberType),
    };
  }

  LocationData copyWith({
    String? id,
    String? phoneNumber,
    Value<String?> region = const Value.absent(),
    Value<String?> countryName = const Value.absent(),
    Value<String?> carrier = const Value.absent(),
    int? numberType,
  }) => LocationData(
    id: id ?? this.id,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    region: region.present ? region.value : this.region,
    countryName: countryName.present ? countryName.value : this.countryName,
    carrier: carrier.present ? carrier.value : this.carrier,
    numberType: numberType ?? this.numberType,
  );
  LocationData copyWithCompanion(LocationsCompanion data) {
    return LocationData(
      id: data.id.present ? data.id.value : this.id,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      region: data.region.present ? data.region.value : this.region,
      countryName: data.countryName.present
          ? data.countryName.value
          : this.countryName,
      carrier: data.carrier.present ? data.carrier.value : this.carrier,
      numberType: data.numberType.present
          ? data.numberType.value
          : this.numberType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocationData(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('region: $region, ')
          ..write('countryName: $countryName, ')
          ..write('carrier: $carrier, ')
          ..write('numberType: $numberType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, phoneNumber, region, countryName, carrier, numberType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationData &&
          other.id == this.id &&
          other.phoneNumber == this.phoneNumber &&
          other.region == this.region &&
          other.countryName == this.countryName &&
          other.carrier == this.carrier &&
          other.numberType == this.numberType);
}

class LocationsCompanion extends UpdateCompanion<LocationData> {
  final Value<String> id;
  final Value<String> phoneNumber;
  final Value<String?> region;
  final Value<String?> countryName;
  final Value<String?> carrier;
  final Value<int> numberType;
  final Value<int> rowid;
  const LocationsCompanion({
    this.id = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.region = const Value.absent(),
    this.countryName = const Value.absent(),
    this.carrier = const Value.absent(),
    this.numberType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocationsCompanion.insert({
    required String id,
    required String phoneNumber,
    this.region = const Value.absent(),
    this.countryName = const Value.absent(),
    this.carrier = const Value.absent(),
    required int numberType,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       phoneNumber = Value(phoneNumber),
       numberType = Value(numberType);
  static Insertable<LocationData> custom({
    Expression<String>? id,
    Expression<String>? phoneNumber,
    Expression<String>? region,
    Expression<String>? countryName,
    Expression<String>? carrier,
    Expression<int>? numberType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (region != null) 'region': region,
      if (countryName != null) 'country_name': countryName,
      if (carrier != null) 'carrier': carrier,
      if (numberType != null) 'number_type': numberType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocationsCompanion copyWith({
    Value<String>? id,
    Value<String>? phoneNumber,
    Value<String?>? region,
    Value<String?>? countryName,
    Value<String?>? carrier,
    Value<int>? numberType,
    Value<int>? rowid,
  }) {
    return LocationsCompanion(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      region: region ?? this.region,
      countryName: countryName ?? this.countryName,
      carrier: carrier ?? this.carrier,
      numberType: numberType ?? this.numberType,
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
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (countryName.present) {
      map['country_name'] = Variable<String>(countryName.value);
    }
    if (carrier.present) {
      map['carrier'] = Variable<String>(carrier.value);
    }
    if (numberType.present) {
      map['number_type'] = Variable<int>(numberType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationsCompanion(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('region: $region, ')
          ..write('countryName: $countryName, ')
          ..write('carrier: $carrier, ')
          ..write('numberType: $numberType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PredefinedLabelsTable extends PredefinedLabels
    with TableInfo<$PredefinedLabelsTable, PredefinedLabelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PredefinedLabelsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _labelTextMeta = const VerificationMeta(
    'labelText',
  );
  @override
  late final GeneratedColumn<String> labelText = GeneratedColumn<String>(
    'label_text',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
    'avatar',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, labelText, avatar, icon];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'predefined_labels';
  @override
  VerificationContext validateIntegrity(
    Insertable<PredefinedLabelData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label_text')) {
      context.handle(
        _labelTextMeta,
        labelText.isAcceptableOrUnknown(data['label_text']!, _labelTextMeta),
      );
    } else if (isInserting) {
      context.missing(_labelTextMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(
        _avatarMeta,
        avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta),
      );
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PredefinedLabelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PredefinedLabelData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      labelText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_text'],
      )!,
      avatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar'],
      ),
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
    );
  }

  @override
  $PredefinedLabelsTable createAlias(String alias) {
    return $PredefinedLabelsTable(attachedDatabase, alias);
  }
}

class PredefinedLabelData extends DataClass
    implements Insertable<PredefinedLabelData> {
  final String id;
  final String labelText;
  final String? avatar;
  final String? icon;
  const PredefinedLabelData({
    required this.id,
    required this.labelText,
    this.avatar,
    this.icon,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label_text'] = Variable<String>(labelText);
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    return map;
  }

  PredefinedLabelsCompanion toCompanion(bool nullToAbsent) {
    return PredefinedLabelsCompanion(
      id: Value(id),
      labelText: Value(labelText),
      avatar: avatar == null && nullToAbsent
          ? const Value.absent()
          : Value(avatar),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
    );
  }

  factory PredefinedLabelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PredefinedLabelData(
      id: serializer.fromJson<String>(json['id']),
      labelText: serializer.fromJson<String>(json['labelText']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      icon: serializer.fromJson<String?>(json['icon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'labelText': serializer.toJson<String>(labelText),
      'avatar': serializer.toJson<String?>(avatar),
      'icon': serializer.toJson<String?>(icon),
    };
  }

  PredefinedLabelData copyWith({
    String? id,
    String? labelText,
    Value<String?> avatar = const Value.absent(),
    Value<String?> icon = const Value.absent(),
  }) => PredefinedLabelData(
    id: id ?? this.id,
    labelText: labelText ?? this.labelText,
    avatar: avatar.present ? avatar.value : this.avatar,
    icon: icon.present ? icon.value : this.icon,
  );
  PredefinedLabelData copyWithCompanion(PredefinedLabelsCompanion data) {
    return PredefinedLabelData(
      id: data.id.present ? data.id.value : this.id,
      labelText: data.labelText.present ? data.labelText.value : this.labelText,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
      icon: data.icon.present ? data.icon.value : this.icon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PredefinedLabelData(')
          ..write('id: $id, ')
          ..write('labelText: $labelText, ')
          ..write('avatar: $avatar, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, labelText, avatar, icon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PredefinedLabelData &&
          other.id == this.id &&
          other.labelText == this.labelText &&
          other.avatar == this.avatar &&
          other.icon == this.icon);
}

class PredefinedLabelsCompanion extends UpdateCompanion<PredefinedLabelData> {
  final Value<String> id;
  final Value<String> labelText;
  final Value<String?> avatar;
  final Value<String?> icon;
  final Value<int> rowid;
  const PredefinedLabelsCompanion({
    this.id = const Value.absent(),
    this.labelText = const Value.absent(),
    this.avatar = const Value.absent(),
    this.icon = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PredefinedLabelsCompanion.insert({
    required String id,
    required String labelText,
    this.avatar = const Value.absent(),
    this.icon = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       labelText = Value(labelText);
  static Insertable<PredefinedLabelData> custom({
    Expression<String>? id,
    Expression<String>? labelText,
    Expression<String>? avatar,
    Expression<String>? icon,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (labelText != null) 'label_text': labelText,
      if (avatar != null) 'avatar': avatar,
      if (icon != null) 'icon': icon,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PredefinedLabelsCompanion copyWith({
    Value<String>? id,
    Value<String>? labelText,
    Value<String?>? avatar,
    Value<String?>? icon,
    Value<int>? rowid,
  }) {
    return PredefinedLabelsCompanion(
      id: id ?? this.id,
      labelText: labelText ?? this.labelText,
      avatar: avatar ?? this.avatar,
      icon: icon ?? this.icon,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (labelText.present) {
      map['label_text'] = Variable<String>(labelText.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PredefinedLabelsCompanion(')
          ..write('id: $id, ')
          ..write('labelText: $labelText, ')
          ..write('avatar: $avatar, ')
          ..write('icon: $icon, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LabelPhonesTable extends LabelPhones
    with TableInfo<$LabelPhonesTable, LabelPhoneData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LabelPhonesTable(this.attachedDatabase, [this._alias]);
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelIdMeta = const VerificationMeta(
    'labelId',
  );
  @override
  late final GeneratedColumn<String> labelId = GeneratedColumn<String>(
    'label_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
    'avatar',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _ruleTypeMeta = const VerificationMeta(
    'ruleType',
  );
  @override
  late final GeneratedColumn<String> ruleType = GeneratedColumn<String>(
    'rule_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('label'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    icon,
    phoneNumber,
    labelId,
    avatar,
    priority,
    action,
    isEnabled,
    ruleType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'label_phones';
  @override
  VerificationContext validateIntegrity(
    Insertable<LabelPhoneData> instance, {
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
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
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
    if (data.containsKey('label_id')) {
      context.handle(
        _labelIdMeta,
        labelId.isAcceptableOrUnknown(data['label_id']!, _labelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_labelIdMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(
        _avatarMeta,
        avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta),
      );
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
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('rule_type')) {
      context.handle(
        _ruleTypeMeta,
        ruleType.isAcceptableOrUnknown(data['rule_type']!, _ruleTypeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LabelPhoneData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LabelPhoneData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      labelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_id'],
      )!,
      avatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_enabled'],
      )!,
      ruleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_type'],
      )!,
    );
  }

  @override
  $LabelPhonesTable createAlias(String alias) {
    return $LabelPhonesTable(attachedDatabase, alias);
  }
}

class LabelPhoneData extends DataClass implements Insertable<LabelPhoneData> {
  final String id;
  final String? name;
  final String? icon;
  final String phoneNumber;
  final String labelId;
  final String? avatar;
  final int priority;
  final String action;
  final int isEnabled;
  final String ruleType;
  const LabelPhoneData({
    required this.id,
    this.name,
    this.icon,
    required this.phoneNumber,
    required this.labelId,
    this.avatar,
    required this.priority,
    required this.action,
    required this.isEnabled,
    required this.ruleType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    map['phone_number'] = Variable<String>(phoneNumber);
    map['label_id'] = Variable<String>(labelId);
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    map['priority'] = Variable<int>(priority);
    map['action'] = Variable<String>(action);
    map['is_enabled'] = Variable<int>(isEnabled);
    map['rule_type'] = Variable<String>(ruleType);
    return map;
  }

  LabelPhonesCompanion toCompanion(bool nullToAbsent) {
    return LabelPhonesCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      phoneNumber: Value(phoneNumber),
      labelId: Value(labelId),
      avatar: avatar == null && nullToAbsent
          ? const Value.absent()
          : Value(avatar),
      priority: Value(priority),
      action: Value(action),
      isEnabled: Value(isEnabled),
      ruleType: Value(ruleType),
    );
  }

  factory LabelPhoneData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LabelPhoneData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      icon: serializer.fromJson<String?>(json['icon']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      labelId: serializer.fromJson<String>(json['labelId']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      priority: serializer.fromJson<int>(json['priority']),
      action: serializer.fromJson<String>(json['action']),
      isEnabled: serializer.fromJson<int>(json['isEnabled']),
      ruleType: serializer.fromJson<String>(json['ruleType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'icon': serializer.toJson<String?>(icon),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'labelId': serializer.toJson<String>(labelId),
      'avatar': serializer.toJson<String?>(avatar),
      'priority': serializer.toJson<int>(priority),
      'action': serializer.toJson<String>(action),
      'isEnabled': serializer.toJson<int>(isEnabled),
      'ruleType': serializer.toJson<String>(ruleType),
    };
  }

  LabelPhoneData copyWith({
    String? id,
    Value<String?> name = const Value.absent(),
    Value<String?> icon = const Value.absent(),
    String? phoneNumber,
    String? labelId,
    Value<String?> avatar = const Value.absent(),
    int? priority,
    String? action,
    int? isEnabled,
    String? ruleType,
  }) => LabelPhoneData(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    icon: icon.present ? icon.value : this.icon,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    labelId: labelId ?? this.labelId,
    avatar: avatar.present ? avatar.value : this.avatar,
    priority: priority ?? this.priority,
    action: action ?? this.action,
    isEnabled: isEnabled ?? this.isEnabled,
    ruleType: ruleType ?? this.ruleType,
  );
  LabelPhoneData copyWithCompanion(LabelPhonesCompanion data) {
    return LabelPhoneData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      labelId: data.labelId.present ? data.labelId.value : this.labelId,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
      priority: data.priority.present ? data.priority.value : this.priority,
      action: data.action.present ? data.action.value : this.action,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      ruleType: data.ruleType.present ? data.ruleType.value : this.ruleType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LabelPhoneData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('labelId: $labelId, ')
          ..write('avatar: $avatar, ')
          ..write('priority: $priority, ')
          ..write('action: $action, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('ruleType: $ruleType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    icon,
    phoneNumber,
    labelId,
    avatar,
    priority,
    action,
    isEnabled,
    ruleType,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LabelPhoneData &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.phoneNumber == this.phoneNumber &&
          other.labelId == this.labelId &&
          other.avatar == this.avatar &&
          other.priority == this.priority &&
          other.action == this.action &&
          other.isEnabled == this.isEnabled &&
          other.ruleType == this.ruleType);
}

class LabelPhonesCompanion extends UpdateCompanion<LabelPhoneData> {
  final Value<String> id;
  final Value<String?> name;
  final Value<String?> icon;
  final Value<String> phoneNumber;
  final Value<String> labelId;
  final Value<String?> avatar;
  final Value<int> priority;
  final Value<String> action;
  final Value<int> isEnabled;
  final Value<String> ruleType;
  final Value<int> rowid;
  const LabelPhonesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.labelId = const Value.absent(),
    this.avatar = const Value.absent(),
    this.priority = const Value.absent(),
    this.action = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.ruleType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LabelPhonesCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    required String phoneNumber,
    required String labelId,
    this.avatar = const Value.absent(),
    this.priority = const Value.absent(),
    this.action = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.ruleType = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       phoneNumber = Value(phoneNumber),
       labelId = Value(labelId);
  static Insertable<LabelPhoneData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<String>? phoneNumber,
    Expression<String>? labelId,
    Expression<String>? avatar,
    Expression<int>? priority,
    Expression<String>? action,
    Expression<int>? isEnabled,
    Expression<String>? ruleType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (labelId != null) 'label_id': labelId,
      if (avatar != null) 'avatar': avatar,
      if (priority != null) 'priority': priority,
      if (action != null) 'action': action,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (ruleType != null) 'rule_type': ruleType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LabelPhonesCompanion copyWith({
    Value<String>? id,
    Value<String?>? name,
    Value<String?>? icon,
    Value<String>? phoneNumber,
    Value<String>? labelId,
    Value<String?>? avatar,
    Value<int>? priority,
    Value<String>? action,
    Value<int>? isEnabled,
    Value<String>? ruleType,
    Value<int>? rowid,
  }) {
    return LabelPhonesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      labelId: labelId ?? this.labelId,
      avatar: avatar ?? this.avatar,
      priority: priority ?? this.priority,
      action: action ?? this.action,
      isEnabled: isEnabled ?? this.isEnabled,
      ruleType: ruleType ?? this.ruleType,
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
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (labelId.present) {
      map['label_id'] = Variable<String>(labelId.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<int>(isEnabled.value);
    }
    if (ruleType.present) {
      map['rule_type'] = Variable<String>(ruleType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LabelPhonesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('labelId: $labelId, ')
          ..write('avatar: $avatar, ')
          ..write('priority: $priority, ')
          ..write('action: $action, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('ruleType: $ruleType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SimSlotRulesTable extends SimSlotRules
    with TableInfo<$SimSlotRulesTable, SimSlotRuleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SimSlotRulesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _simSlotIndexMeta = const VerificationMeta(
    'simSlotIndex',
  );
  @override
  late final GeneratedColumn<int> simSlotIndex = GeneratedColumn<int>(
    'sim_slot_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelIdMeta = const VerificationMeta(
    'labelId',
  );
  @override
  late final GeneratedColumn<String> labelId = GeneratedColumn<String>(
    'label_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
    'avatar',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleTypeMeta = const VerificationMeta(
    'ruleType',
  );
  @override
  late final GeneratedColumn<String> ruleType = GeneratedColumn<String>(
    'rule_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('simSlot'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    priority,
    action,
    isEnabled,
    phoneNumber,
    simSlotIndex,
    labelId,
    avatar,
    ruleType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sim_slot_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<SimSlotRuleData> instance, {
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
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
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
    if (data.containsKey('sim_slot_index')) {
      context.handle(
        _simSlotIndexMeta,
        simSlotIndex.isAcceptableOrUnknown(
          data['sim_slot_index']!,
          _simSlotIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_simSlotIndexMeta);
    }
    if (data.containsKey('label_id')) {
      context.handle(
        _labelIdMeta,
        labelId.isAcceptableOrUnknown(data['label_id']!, _labelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_labelIdMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(
        _avatarMeta,
        avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta),
      );
    }
    if (data.containsKey('rule_type')) {
      context.handle(
        _ruleTypeMeta,
        ruleType.isAcceptableOrUnknown(data['rule_type']!, _ruleTypeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SimSlotRuleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SimSlotRuleData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_enabled'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      simSlotIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sim_slot_index'],
      )!,
      labelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_id'],
      )!,
      avatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar'],
      ),
      ruleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_type'],
      )!,
    );
  }

  @override
  $SimSlotRulesTable createAlias(String alias) {
    return $SimSlotRulesTable(attachedDatabase, alias);
  }
}

class SimSlotRuleData extends DataClass implements Insertable<SimSlotRuleData> {
  final String id;
  final String name;
  final int priority;
  final String action;
  final int isEnabled;
  final String phoneNumber;
  final int simSlotIndex;
  final String labelId;
  final String? avatar;
  final String ruleType;
  const SimSlotRuleData({
    required this.id,
    required this.name,
    required this.priority,
    required this.action,
    required this.isEnabled,
    required this.phoneNumber,
    required this.simSlotIndex,
    required this.labelId,
    this.avatar,
    required this.ruleType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['priority'] = Variable<int>(priority);
    map['action'] = Variable<String>(action);
    map['is_enabled'] = Variable<int>(isEnabled);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['sim_slot_index'] = Variable<int>(simSlotIndex);
    map['label_id'] = Variable<String>(labelId);
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    map['rule_type'] = Variable<String>(ruleType);
    return map;
  }

  SimSlotRulesCompanion toCompanion(bool nullToAbsent) {
    return SimSlotRulesCompanion(
      id: Value(id),
      name: Value(name),
      priority: Value(priority),
      action: Value(action),
      isEnabled: Value(isEnabled),
      phoneNumber: Value(phoneNumber),
      simSlotIndex: Value(simSlotIndex),
      labelId: Value(labelId),
      avatar: avatar == null && nullToAbsent
          ? const Value.absent()
          : Value(avatar),
      ruleType: Value(ruleType),
    );
  }

  factory SimSlotRuleData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SimSlotRuleData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      priority: serializer.fromJson<int>(json['priority']),
      action: serializer.fromJson<String>(json['action']),
      isEnabled: serializer.fromJson<int>(json['isEnabled']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      simSlotIndex: serializer.fromJson<int>(json['simSlotIndex']),
      labelId: serializer.fromJson<String>(json['labelId']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      ruleType: serializer.fromJson<String>(json['ruleType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'priority': serializer.toJson<int>(priority),
      'action': serializer.toJson<String>(action),
      'isEnabled': serializer.toJson<int>(isEnabled),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'simSlotIndex': serializer.toJson<int>(simSlotIndex),
      'labelId': serializer.toJson<String>(labelId),
      'avatar': serializer.toJson<String?>(avatar),
      'ruleType': serializer.toJson<String>(ruleType),
    };
  }

  SimSlotRuleData copyWith({
    String? id,
    String? name,
    int? priority,
    String? action,
    int? isEnabled,
    String? phoneNumber,
    int? simSlotIndex,
    String? labelId,
    Value<String?> avatar = const Value.absent(),
    String? ruleType,
  }) => SimSlotRuleData(
    id: id ?? this.id,
    name: name ?? this.name,
    priority: priority ?? this.priority,
    action: action ?? this.action,
    isEnabled: isEnabled ?? this.isEnabled,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    simSlotIndex: simSlotIndex ?? this.simSlotIndex,
    labelId: labelId ?? this.labelId,
    avatar: avatar.present ? avatar.value : this.avatar,
    ruleType: ruleType ?? this.ruleType,
  );
  SimSlotRuleData copyWithCompanion(SimSlotRulesCompanion data) {
    return SimSlotRuleData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      priority: data.priority.present ? data.priority.value : this.priority,
      action: data.action.present ? data.action.value : this.action,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      simSlotIndex: data.simSlotIndex.present
          ? data.simSlotIndex.value
          : this.simSlotIndex,
      labelId: data.labelId.present ? data.labelId.value : this.labelId,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
      ruleType: data.ruleType.present ? data.ruleType.value : this.ruleType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SimSlotRuleData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('priority: $priority, ')
          ..write('action: $action, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('simSlotIndex: $simSlotIndex, ')
          ..write('labelId: $labelId, ')
          ..write('avatar: $avatar, ')
          ..write('ruleType: $ruleType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    priority,
    action,
    isEnabled,
    phoneNumber,
    simSlotIndex,
    labelId,
    avatar,
    ruleType,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SimSlotRuleData &&
          other.id == this.id &&
          other.name == this.name &&
          other.priority == this.priority &&
          other.action == this.action &&
          other.isEnabled == this.isEnabled &&
          other.phoneNumber == this.phoneNumber &&
          other.simSlotIndex == this.simSlotIndex &&
          other.labelId == this.labelId &&
          other.avatar == this.avatar &&
          other.ruleType == this.ruleType);
}

class SimSlotRulesCompanion extends UpdateCompanion<SimSlotRuleData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> priority;
  final Value<String> action;
  final Value<int> isEnabled;
  final Value<String> phoneNumber;
  final Value<int> simSlotIndex;
  final Value<String> labelId;
  final Value<String?> avatar;
  final Value<String> ruleType;
  final Value<int> rowid;
  const SimSlotRulesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.priority = const Value.absent(),
    this.action = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.simSlotIndex = const Value.absent(),
    this.labelId = const Value.absent(),
    this.avatar = const Value.absent(),
    this.ruleType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SimSlotRulesCompanion.insert({
    required String id,
    required String name,
    required int priority,
    required String action,
    this.isEnabled = const Value.absent(),
    required String phoneNumber,
    required int simSlotIndex,
    required String labelId,
    this.avatar = const Value.absent(),
    this.ruleType = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       priority = Value(priority),
       action = Value(action),
       phoneNumber = Value(phoneNumber),
       simSlotIndex = Value(simSlotIndex),
       labelId = Value(labelId);
  static Insertable<SimSlotRuleData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? priority,
    Expression<String>? action,
    Expression<int>? isEnabled,
    Expression<String>? phoneNumber,
    Expression<int>? simSlotIndex,
    Expression<String>? labelId,
    Expression<String>? avatar,
    Expression<String>? ruleType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (priority != null) 'priority': priority,
      if (action != null) 'action': action,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (simSlotIndex != null) 'sim_slot_index': simSlotIndex,
      if (labelId != null) 'label_id': labelId,
      if (avatar != null) 'avatar': avatar,
      if (ruleType != null) 'rule_type': ruleType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SimSlotRulesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? priority,
    Value<String>? action,
    Value<int>? isEnabled,
    Value<String>? phoneNumber,
    Value<int>? simSlotIndex,
    Value<String>? labelId,
    Value<String?>? avatar,
    Value<String>? ruleType,
    Value<int>? rowid,
  }) {
    return SimSlotRulesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      priority: priority ?? this.priority,
      action: action ?? this.action,
      isEnabled: isEnabled ?? this.isEnabled,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      simSlotIndex: simSlotIndex ?? this.simSlotIndex,
      labelId: labelId ?? this.labelId,
      avatar: avatar ?? this.avatar,
      ruleType: ruleType ?? this.ruleType,
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
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<int>(isEnabled.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (simSlotIndex.present) {
      map['sim_slot_index'] = Variable<int>(simSlotIndex.value);
    }
    if (labelId.present) {
      map['label_id'] = Variable<String>(labelId.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (ruleType.present) {
      map['rule_type'] = Variable<String>(ruleType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SimSlotRulesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('priority: $priority, ')
          ..write('action: $action, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('simSlotIndex: $simSlotIndex, ')
          ..write('labelId: $labelId, ')
          ..write('avatar: $avatar, ')
          ..write('ruleType: $ruleType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LabelMarkStatisticsTable extends LabelMarkStatistics
    with TableInfo<$LabelMarkStatisticsTable, LabelMarkStatisticData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LabelMarkStatisticsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelIdMeta = const VerificationMeta(
    'labelId',
  );
  @override
  late final GeneratedColumn<String> labelId = GeneratedColumn<String>(
    'label_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _markedAtMeta = const VerificationMeta(
    'markedAt',
  );
  @override
  late final GeneratedColumn<String> markedAt = GeneratedColumn<String>(
    'marked_at',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCountedMeta = const VerificationMeta(
    'isCounted',
  );
  @override
  late final GeneratedColumn<int> isCounted = GeneratedColumn<int>(
    'is_counted',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    phoneNumber,
    labelId,
    markedAt,
    isCounted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'label_mark_statistics';
  @override
  VerificationContext validateIntegrity(
    Insertable<LabelMarkStatisticData> instance, {
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
    if (data.containsKey('label_id')) {
      context.handle(
        _labelIdMeta,
        labelId.isAcceptableOrUnknown(data['label_id']!, _labelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_labelIdMeta);
    }
    if (data.containsKey('marked_at')) {
      context.handle(
        _markedAtMeta,
        markedAt.isAcceptableOrUnknown(data['marked_at']!, _markedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_markedAtMeta);
    }
    if (data.containsKey('is_counted')) {
      context.handle(
        _isCountedMeta,
        isCounted.isAcceptableOrUnknown(data['is_counted']!, _isCountedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LabelMarkStatisticData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LabelMarkStatisticData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      labelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_id'],
      )!,
      markedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marked_at'],
      )!,
      isCounted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_counted'],
      )!,
    );
  }

  @override
  $LabelMarkStatisticsTable createAlias(String alias) {
    return $LabelMarkStatisticsTable(attachedDatabase, alias);
  }
}

class LabelMarkStatisticData extends DataClass
    implements Insertable<LabelMarkStatisticData> {
  final String id;
  final String phoneNumber;
  final String labelId;
  final String markedAt;
  final int isCounted;
  const LabelMarkStatisticData({
    required this.id,
    required this.phoneNumber,
    required this.labelId,
    required this.markedAt,
    required this.isCounted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['label_id'] = Variable<String>(labelId);
    map['marked_at'] = Variable<String>(markedAt);
    map['is_counted'] = Variable<int>(isCounted);
    return map;
  }

  LabelMarkStatisticsCompanion toCompanion(bool nullToAbsent) {
    return LabelMarkStatisticsCompanion(
      id: Value(id),
      phoneNumber: Value(phoneNumber),
      labelId: Value(labelId),
      markedAt: Value(markedAt),
      isCounted: Value(isCounted),
    );
  }

  factory LabelMarkStatisticData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LabelMarkStatisticData(
      id: serializer.fromJson<String>(json['id']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      labelId: serializer.fromJson<String>(json['labelId']),
      markedAt: serializer.fromJson<String>(json['markedAt']),
      isCounted: serializer.fromJson<int>(json['isCounted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'labelId': serializer.toJson<String>(labelId),
      'markedAt': serializer.toJson<String>(markedAt),
      'isCounted': serializer.toJson<int>(isCounted),
    };
  }

  LabelMarkStatisticData copyWith({
    String? id,
    String? phoneNumber,
    String? labelId,
    String? markedAt,
    int? isCounted,
  }) => LabelMarkStatisticData(
    id: id ?? this.id,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    labelId: labelId ?? this.labelId,
    markedAt: markedAt ?? this.markedAt,
    isCounted: isCounted ?? this.isCounted,
  );
  LabelMarkStatisticData copyWithCompanion(LabelMarkStatisticsCompanion data) {
    return LabelMarkStatisticData(
      id: data.id.present ? data.id.value : this.id,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      labelId: data.labelId.present ? data.labelId.value : this.labelId,
      markedAt: data.markedAt.present ? data.markedAt.value : this.markedAt,
      isCounted: data.isCounted.present ? data.isCounted.value : this.isCounted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LabelMarkStatisticData(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('labelId: $labelId, ')
          ..write('markedAt: $markedAt, ')
          ..write('isCounted: $isCounted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, phoneNumber, labelId, markedAt, isCounted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LabelMarkStatisticData &&
          other.id == this.id &&
          other.phoneNumber == this.phoneNumber &&
          other.labelId == this.labelId &&
          other.markedAt == this.markedAt &&
          other.isCounted == this.isCounted);
}

class LabelMarkStatisticsCompanion
    extends UpdateCompanion<LabelMarkStatisticData> {
  final Value<String> id;
  final Value<String> phoneNumber;
  final Value<String> labelId;
  final Value<String> markedAt;
  final Value<int> isCounted;
  final Value<int> rowid;
  const LabelMarkStatisticsCompanion({
    this.id = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.labelId = const Value.absent(),
    this.markedAt = const Value.absent(),
    this.isCounted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LabelMarkStatisticsCompanion.insert({
    required String id,
    required String phoneNumber,
    required String labelId,
    required String markedAt,
    this.isCounted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       phoneNumber = Value(phoneNumber),
       labelId = Value(labelId),
       markedAt = Value(markedAt);
  static Insertable<LabelMarkStatisticData> custom({
    Expression<String>? id,
    Expression<String>? phoneNumber,
    Expression<String>? labelId,
    Expression<String>? markedAt,
    Expression<int>? isCounted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (labelId != null) 'label_id': labelId,
      if (markedAt != null) 'marked_at': markedAt,
      if (isCounted != null) 'is_counted': isCounted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LabelMarkStatisticsCompanion copyWith({
    Value<String>? id,
    Value<String>? phoneNumber,
    Value<String>? labelId,
    Value<String>? markedAt,
    Value<int>? isCounted,
    Value<int>? rowid,
  }) {
    return LabelMarkStatisticsCompanion(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      labelId: labelId ?? this.labelId,
      markedAt: markedAt ?? this.markedAt,
      isCounted: isCounted ?? this.isCounted,
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
    if (labelId.present) {
      map['label_id'] = Variable<String>(labelId.value);
    }
    if (markedAt.present) {
      map['marked_at'] = Variable<String>(markedAt.value);
    }
    if (isCounted.present) {
      map['is_counted'] = Variable<int>(isCounted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LabelMarkStatisticsCompanion(')
          ..write('id: $id, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('labelId: $labelId, ')
          ..write('markedAt: $markedAt, ')
          ..write('isCounted: $isCounted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserMarkCountTable extends UserMarkCount
    with TableInfo<$UserMarkCountTable, UserMarkCountData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserMarkCountTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _totalCountMeta = const VerificationMeta(
    'totalCount',
  );
  @override
  late final GeneratedColumn<int> totalCount = GeneratedColumn<int>(
    'total_count',
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
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, totalCount, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_mark_count';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserMarkCountData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('total_count')) {
      context.handle(
        _totalCountMeta,
        totalCount.isAcceptableOrUnknown(data['total_count']!, _totalCountMeta),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserMarkCountData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserMarkCountData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      totalCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_count'],
      )!,
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_updated'],
      )!,
    );
  }

  @override
  $UserMarkCountTable createAlias(String alias) {
    return $UserMarkCountTable(attachedDatabase, alias);
  }
}

class UserMarkCountData extends DataClass
    implements Insertable<UserMarkCountData> {
  final String id;
  final int totalCount;
  final String lastUpdated;
  const UserMarkCountData({
    required this.id,
    required this.totalCount,
    required this.lastUpdated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['total_count'] = Variable<int>(totalCount);
    map['last_updated'] = Variable<String>(lastUpdated);
    return map;
  }

  UserMarkCountCompanion toCompanion(bool nullToAbsent) {
    return UserMarkCountCompanion(
      id: Value(id),
      totalCount: Value(totalCount),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory UserMarkCountData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserMarkCountData(
      id: serializer.fromJson<String>(json['id']),
      totalCount: serializer.fromJson<int>(json['totalCount']),
      lastUpdated: serializer.fromJson<String>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'totalCount': serializer.toJson<int>(totalCount),
      'lastUpdated': serializer.toJson<String>(lastUpdated),
    };
  }

  UserMarkCountData copyWith({
    String? id,
    int? totalCount,
    String? lastUpdated,
  }) => UserMarkCountData(
    id: id ?? this.id,
    totalCount: totalCount ?? this.totalCount,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
  UserMarkCountData copyWithCompanion(UserMarkCountCompanion data) {
    return UserMarkCountData(
      id: data.id.present ? data.id.value : this.id,
      totalCount: data.totalCount.present
          ? data.totalCount.value
          : this.totalCount,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserMarkCountData(')
          ..write('id: $id, ')
          ..write('totalCount: $totalCount, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, totalCount, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserMarkCountData &&
          other.id == this.id &&
          other.totalCount == this.totalCount &&
          other.lastUpdated == this.lastUpdated);
}

class UserMarkCountCompanion extends UpdateCompanion<UserMarkCountData> {
  final Value<String> id;
  final Value<int> totalCount;
  final Value<String> lastUpdated;
  final Value<int> rowid;
  const UserMarkCountCompanion({
    this.id = const Value.absent(),
    this.totalCount = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserMarkCountCompanion.insert({
    required String id,
    this.totalCount = const Value.absent(),
    required String lastUpdated,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       lastUpdated = Value(lastUpdated);
  static Insertable<UserMarkCountData> custom({
    Expression<String>? id,
    Expression<int>? totalCount,
    Expression<String>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalCount != null) 'total_count': totalCount,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserMarkCountCompanion copyWith({
    Value<String>? id,
    Value<int>? totalCount,
    Value<String>? lastUpdated,
    Value<int>? rowid,
  }) {
    return UserMarkCountCompanion(
      id: id ?? this.id,
      totalCount: totalCount ?? this.totalCount,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (totalCount.present) {
      map['total_count'] = Variable<int>(totalCount.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<String>(lastUpdated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserMarkCountCompanion(')
          ..write('id: $id, ')
          ..write('totalCount: $totalCount, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $CallHistoryTable callHistory = $CallHistoryTable(this);
  late final $RulesTable rules = $RulesTable(this);
  late final $PhoneRulesTable phoneRules = $PhoneRulesTable(this);
  late final $RegexRulesTable regexRules = $RegexRulesTable(this);
  late final $SubscriptionsTable subscriptions = $SubscriptionsTable(this);
  late final $SmsTable sms = $SmsTable(this);
  late final $SmsRulesTable smsRules = $SmsRulesTable(this);
  late final $PluginsTable plugins = $PluginsTable(this);
  late final $LocationsTable locations = $LocationsTable(this);
  late final $PredefinedLabelsTable predefinedLabels = $PredefinedLabelsTable(
    this,
  );
  late final $LabelPhonesTable labelPhones = $LabelPhonesTable(this);
  late final $SimSlotRulesTable simSlotRules = $SimSlotRulesTable(this);
  late final $LabelMarkStatisticsTable labelMarkStatistics =
      $LabelMarkStatisticsTable(this);
  late final $UserMarkCountTable userMarkCount = $UserMarkCountTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    contacts,
    callHistory,
    rules,
    phoneRules,
    regexRules,
    subscriptions,
    sms,
    smsRules,
    plugins,
    locations,
    predefinedLabels,
    labelPhones,
    simSlotRules,
    labelMarkStatistics,
    userMarkCount,
  ];
}

typedef $$ContactsTableCreateCompanionBuilder =
    ContactsCompanion Function({
      required String id,
      required String phoneNumber,
      required String name,
      Value<String?> avatar,
      Value<String?> url,
      Value<String?> note,
      Value<String?> labelIds,
      Value<int> isFavorite,
      required String lastUpdated,
      Value<int> rowid,
    });
typedef $$ContactsTableUpdateCompanionBuilder =
    ContactsCompanion Function({
      Value<String> id,
      Value<String> phoneNumber,
      Value<String> name,
      Value<String?> avatar,
      Value<String?> url,
      Value<String?> note,
      Value<String?> labelIds,
      Value<int> isFavorite,
      Value<String> lastUpdated,
      Value<int> rowid,
    });

class $$ContactsTableFilterComposer
    extends Composer<_$LocalDatabase, $ContactsTable> {
  $$ContactsTableFilterComposer({
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

  ColumnFilters<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelIds => $composableBuilder(
    column: $table.labelIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ContactsTableOrderingComposer
    extends Composer<_$LocalDatabase, $ContactsTable> {
  $$ContactsTableOrderingComposer({
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

  ColumnOrderings<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelIds => $composableBuilder(
    column: $table.labelIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContactsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $ContactsTable> {
  $$ContactsTableAnnotationComposer({
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

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get labelIds =>
      $composableBuilder(column: $table.labelIds, builder: (column) => column);

  GeneratedColumn<int> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );
}

class $$ContactsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $ContactsTable,
          ContactData,
          $$ContactsTableFilterComposer,
          $$ContactsTableOrderingComposer,
          $$ContactsTableAnnotationComposer,
          $$ContactsTableCreateCompanionBuilder,
          $$ContactsTableUpdateCompanionBuilder,
          (
            ContactData,
            BaseReferences<_$LocalDatabase, $ContactsTable, ContactData>,
          ),
          ContactData,
          PrefetchHooks Function()
        > {
  $$ContactsTableTableManager(_$LocalDatabase db, $ContactsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> avatar = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> labelIds = const Value.absent(),
                Value<int> isFavorite = const Value.absent(),
                Value<String> lastUpdated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContactsCompanion(
                id: id,
                phoneNumber: phoneNumber,
                name: name,
                avatar: avatar,
                url: url,
                note: note,
                labelIds: labelIds,
                isFavorite: isFavorite,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String phoneNumber,
                required String name,
                Value<String?> avatar = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> labelIds = const Value.absent(),
                Value<int> isFavorite = const Value.absent(),
                required String lastUpdated,
                Value<int> rowid = const Value.absent(),
              }) => ContactsCompanion.insert(
                id: id,
                phoneNumber: phoneNumber,
                name: name,
                avatar: avatar,
                url: url,
                note: note,
                labelIds: labelIds,
                isFavorite: isFavorite,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ContactsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $ContactsTable,
      ContactData,
      $$ContactsTableFilterComposer,
      $$ContactsTableOrderingComposer,
      $$ContactsTableAnnotationComposer,
      $$ContactsTableCreateCompanionBuilder,
      $$ContactsTableUpdateCompanionBuilder,
      (
        ContactData,
        BaseReferences<_$LocalDatabase, $ContactsTable, ContactData>,
      ),
      ContactData,
      PrefetchHooks Function()
    >;
typedef $$CallHistoryTableCreateCompanionBuilder =
    CallHistoryCompanion Function({
      required String id,
      required String phoneNumber,
      Value<String?> name,
      required String timestamp,
      Value<String?> endTime,
      Value<int?> duration,
      Value<String?> simDisplayName,
      required String callType,
      Value<int?> simSlotIndex,
      Value<String?> carrierName,
      Value<String?> countryIso,
      Value<int?> subscriptionId,
      Value<String?> labelIds,
      Value<int> rowid,
    });
typedef $$CallHistoryTableUpdateCompanionBuilder =
    CallHistoryCompanion Function({
      Value<String> id,
      Value<String> phoneNumber,
      Value<String?> name,
      Value<String> timestamp,
      Value<String?> endTime,
      Value<int?> duration,
      Value<String?> simDisplayName,
      Value<String> callType,
      Value<int?> simSlotIndex,
      Value<String?> carrierName,
      Value<String?> countryIso,
      Value<int?> subscriptionId,
      Value<String?> labelIds,
      Value<int> rowid,
    });

class $$CallHistoryTableFilterComposer
    extends Composer<_$LocalDatabase, $CallHistoryTable> {
  $$CallHistoryTableFilterComposer({
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

  ColumnFilters<String> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get simDisplayName => $composableBuilder(
    column: $table.simDisplayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get callType => $composableBuilder(
    column: $table.callType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get simSlotIndex => $composableBuilder(
    column: $table.simSlotIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get carrierName => $composableBuilder(
    column: $table.carrierName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryIso => $composableBuilder(
    column: $table.countryIso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelIds => $composableBuilder(
    column: $table.labelIds,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CallHistoryTableOrderingComposer
    extends Composer<_$LocalDatabase, $CallHistoryTable> {
  $$CallHistoryTableOrderingComposer({
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

  ColumnOrderings<String> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get simDisplayName => $composableBuilder(
    column: $table.simDisplayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get callType => $composableBuilder(
    column: $table.callType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get simSlotIndex => $composableBuilder(
    column: $table.simSlotIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get carrierName => $composableBuilder(
    column: $table.carrierName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryIso => $composableBuilder(
    column: $table.countryIso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelIds => $composableBuilder(
    column: $table.labelIds,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CallHistoryTableAnnotationComposer
    extends Composer<_$LocalDatabase, $CallHistoryTable> {
  $$CallHistoryTableAnnotationComposer({
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

  GeneratedColumn<String> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get simDisplayName => $composableBuilder(
    column: $table.simDisplayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get callType =>
      $composableBuilder(column: $table.callType, builder: (column) => column);

  GeneratedColumn<int> get simSlotIndex => $composableBuilder(
    column: $table.simSlotIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get carrierName => $composableBuilder(
    column: $table.carrierName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get countryIso => $composableBuilder(
    column: $table.countryIso,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get labelIds =>
      $composableBuilder(column: $table.labelIds, builder: (column) => column);
}

class $$CallHistoryTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $CallHistoryTable,
          CallHistoryData,
          $$CallHistoryTableFilterComposer,
          $$CallHistoryTableOrderingComposer,
          $$CallHistoryTableAnnotationComposer,
          $$CallHistoryTableCreateCompanionBuilder,
          $$CallHistoryTableUpdateCompanionBuilder,
          (
            CallHistoryData,
            BaseReferences<_$LocalDatabase, $CallHistoryTable, CallHistoryData>,
          ),
          CallHistoryData,
          PrefetchHooks Function()
        > {
  $$CallHistoryTableTableManager(_$LocalDatabase db, $CallHistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CallHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CallHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CallHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String> timestamp = const Value.absent(),
                Value<String?> endTime = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                Value<String?> simDisplayName = const Value.absent(),
                Value<String> callType = const Value.absent(),
                Value<int?> simSlotIndex = const Value.absent(),
                Value<String?> carrierName = const Value.absent(),
                Value<String?> countryIso = const Value.absent(),
                Value<int?> subscriptionId = const Value.absent(),
                Value<String?> labelIds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CallHistoryCompanion(
                id: id,
                phoneNumber: phoneNumber,
                name: name,
                timestamp: timestamp,
                endTime: endTime,
                duration: duration,
                simDisplayName: simDisplayName,
                callType: callType,
                simSlotIndex: simSlotIndex,
                carrierName: carrierName,
                countryIso: countryIso,
                subscriptionId: subscriptionId,
                labelIds: labelIds,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String phoneNumber,
                Value<String?> name = const Value.absent(),
                required String timestamp,
                Value<String?> endTime = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                Value<String?> simDisplayName = const Value.absent(),
                required String callType,
                Value<int?> simSlotIndex = const Value.absent(),
                Value<String?> carrierName = const Value.absent(),
                Value<String?> countryIso = const Value.absent(),
                Value<int?> subscriptionId = const Value.absent(),
                Value<String?> labelIds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CallHistoryCompanion.insert(
                id: id,
                phoneNumber: phoneNumber,
                name: name,
                timestamp: timestamp,
                endTime: endTime,
                duration: duration,
                simDisplayName: simDisplayName,
                callType: callType,
                simSlotIndex: simSlotIndex,
                carrierName: carrierName,
                countryIso: countryIso,
                subscriptionId: subscriptionId,
                labelIds: labelIds,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CallHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $CallHistoryTable,
      CallHistoryData,
      $$CallHistoryTableFilterComposer,
      $$CallHistoryTableOrderingComposer,
      $$CallHistoryTableAnnotationComposer,
      $$CallHistoryTableCreateCompanionBuilder,
      $$CallHistoryTableUpdateCompanionBuilder,
      (
        CallHistoryData,
        BaseReferences<_$LocalDatabase, $CallHistoryTable, CallHistoryData>,
      ),
      CallHistoryData,
      PrefetchHooks Function()
    >;
typedef $$RulesTableCreateCompanionBuilder =
    RulesCompanion Function({
      required String id,
      required String name,
      required String ruleType,
      Value<String?> phoneNumber,
      Value<String?> labelId,
      Value<int> priority,
      Value<String> action,
      Value<int> isEnabled,
      Value<String?> pattern,
      Value<String?> avatar,
      Value<int> isSubscribed,
      Value<int> count,
      Value<int> rowid,
    });
typedef $$RulesTableUpdateCompanionBuilder =
    RulesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> ruleType,
      Value<String?> phoneNumber,
      Value<String?> labelId,
      Value<int> priority,
      Value<String> action,
      Value<int> isEnabled,
      Value<String?> pattern,
      Value<String?> avatar,
      Value<int> isSubscribed,
      Value<int> count,
      Value<int> rowid,
    });

class $$RulesTableFilterComposer
    extends Composer<_$LocalDatabase, $RulesTable> {
  $$RulesTableFilterComposer({
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

  ColumnFilters<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelId => $composableBuilder(
    column: $table.labelId,
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

  ColumnFilters<int> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pattern => $composableBuilder(
    column: $table.pattern,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isSubscribed => $composableBuilder(
    column: $table.isSubscribed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RulesTableOrderingComposer
    extends Composer<_$LocalDatabase, $RulesTable> {
  $$RulesTableOrderingComposer({
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

  ColumnOrderings<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelId => $composableBuilder(
    column: $table.labelId,
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

  ColumnOrderings<int> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pattern => $composableBuilder(
    column: $table.pattern,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isSubscribed => $composableBuilder(
    column: $table.isSubscribed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RulesTableAnnotationComposer
    extends Composer<_$LocalDatabase, $RulesTable> {
  $$RulesTableAnnotationComposer({
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

  GeneratedColumn<String> get ruleType =>
      $composableBuilder(column: $table.ruleType, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get labelId =>
      $composableBuilder(column: $table.labelId, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<int> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get pattern =>
      $composableBuilder(column: $table.pattern, builder: (column) => column);

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);

  GeneratedColumn<int> get isSubscribed => $composableBuilder(
    column: $table.isSubscribed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);
}

class $$RulesTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $RulesTable,
          RuleData,
          $$RulesTableFilterComposer,
          $$RulesTableOrderingComposer,
          $$RulesTableAnnotationComposer,
          $$RulesTableCreateCompanionBuilder,
          $$RulesTableUpdateCompanionBuilder,
          (RuleData, BaseReferences<_$LocalDatabase, $RulesTable, RuleData>),
          RuleData,
          PrefetchHooks Function()
        > {
  $$RulesTableTableManager(_$LocalDatabase db, $RulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> ruleType = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String?> labelId = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<int> isEnabled = const Value.absent(),
                Value<String?> pattern = const Value.absent(),
                Value<String?> avatar = const Value.absent(),
                Value<int> isSubscribed = const Value.absent(),
                Value<int> count = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RulesCompanion(
                id: id,
                name: name,
                ruleType: ruleType,
                phoneNumber: phoneNumber,
                labelId: labelId,
                priority: priority,
                action: action,
                isEnabled: isEnabled,
                pattern: pattern,
                avatar: avatar,
                isSubscribed: isSubscribed,
                count: count,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String ruleType,
                Value<String?> phoneNumber = const Value.absent(),
                Value<String?> labelId = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<int> isEnabled = const Value.absent(),
                Value<String?> pattern = const Value.absent(),
                Value<String?> avatar = const Value.absent(),
                Value<int> isSubscribed = const Value.absent(),
                Value<int> count = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RulesCompanion.insert(
                id: id,
                name: name,
                ruleType: ruleType,
                phoneNumber: phoneNumber,
                labelId: labelId,
                priority: priority,
                action: action,
                isEnabled: isEnabled,
                pattern: pattern,
                avatar: avatar,
                isSubscribed: isSubscribed,
                count: count,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RulesTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $RulesTable,
      RuleData,
      $$RulesTableFilterComposer,
      $$RulesTableOrderingComposer,
      $$RulesTableAnnotationComposer,
      $$RulesTableCreateCompanionBuilder,
      $$RulesTableUpdateCompanionBuilder,
      (RuleData, BaseReferences<_$LocalDatabase, $RulesTable, RuleData>),
      RuleData,
      PrefetchHooks Function()
    >;
typedef $$PhoneRulesTableCreateCompanionBuilder =
    PhoneRulesCompanion Function({
      Value<String?> id,
      required String name,
      required String ruleType,
      required String phoneNumber,
      Value<String?> labelId,
      Value<int> priority,
      Value<String> action,
      Value<int> isEnabled,
      Value<int> count,
      Value<String?> avatar,
      Value<String?> subscriptionId,
      Value<int> rowid,
    });
typedef $$PhoneRulesTableUpdateCompanionBuilder =
    PhoneRulesCompanion Function({
      Value<String?> id,
      Value<String> name,
      Value<String> ruleType,
      Value<String> phoneNumber,
      Value<String?> labelId,
      Value<int> priority,
      Value<String> action,
      Value<int> isEnabled,
      Value<int> count,
      Value<String?> avatar,
      Value<String?> subscriptionId,
      Value<int> rowid,
    });

class $$PhoneRulesTableFilterComposer
    extends Composer<_$LocalDatabase, $PhoneRulesTable> {
  $$PhoneRulesTableFilterComposer({
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

  ColumnFilters<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelId => $composableBuilder(
    column: $table.labelId,
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

  ColumnFilters<int> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PhoneRulesTableOrderingComposer
    extends Composer<_$LocalDatabase, $PhoneRulesTable> {
  $$PhoneRulesTableOrderingComposer({
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

  ColumnOrderings<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelId => $composableBuilder(
    column: $table.labelId,
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

  ColumnOrderings<int> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PhoneRulesTableAnnotationComposer
    extends Composer<_$LocalDatabase, $PhoneRulesTable> {
  $$PhoneRulesTableAnnotationComposer({
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

  GeneratedColumn<String> get ruleType =>
      $composableBuilder(column: $table.ruleType, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get labelId =>
      $composableBuilder(column: $table.labelId, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<int> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);

  GeneratedColumn<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => column,
  );
}

class $$PhoneRulesTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $PhoneRulesTable,
          PhoneRuleData,
          $$PhoneRulesTableFilterComposer,
          $$PhoneRulesTableOrderingComposer,
          $$PhoneRulesTableAnnotationComposer,
          $$PhoneRulesTableCreateCompanionBuilder,
          $$PhoneRulesTableUpdateCompanionBuilder,
          (
            PhoneRuleData,
            BaseReferences<_$LocalDatabase, $PhoneRulesTable, PhoneRuleData>,
          ),
          PhoneRuleData,
          PrefetchHooks Function()
        > {
  $$PhoneRulesTableTableManager(_$LocalDatabase db, $PhoneRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhoneRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhoneRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhoneRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String?> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> ruleType = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String?> labelId = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<int> isEnabled = const Value.absent(),
                Value<int> count = const Value.absent(),
                Value<String?> avatar = const Value.absent(),
                Value<String?> subscriptionId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhoneRulesCompanion(
                id: id,
                name: name,
                ruleType: ruleType,
                phoneNumber: phoneNumber,
                labelId: labelId,
                priority: priority,
                action: action,
                isEnabled: isEnabled,
                count: count,
                avatar: avatar,
                subscriptionId: subscriptionId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String?> id = const Value.absent(),
                required String name,
                required String ruleType,
                required String phoneNumber,
                Value<String?> labelId = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<int> isEnabled = const Value.absent(),
                Value<int> count = const Value.absent(),
                Value<String?> avatar = const Value.absent(),
                Value<String?> subscriptionId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhoneRulesCompanion.insert(
                id: id,
                name: name,
                ruleType: ruleType,
                phoneNumber: phoneNumber,
                labelId: labelId,
                priority: priority,
                action: action,
                isEnabled: isEnabled,
                count: count,
                avatar: avatar,
                subscriptionId: subscriptionId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PhoneRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $PhoneRulesTable,
      PhoneRuleData,
      $$PhoneRulesTableFilterComposer,
      $$PhoneRulesTableOrderingComposer,
      $$PhoneRulesTableAnnotationComposer,
      $$PhoneRulesTableCreateCompanionBuilder,
      $$PhoneRulesTableUpdateCompanionBuilder,
      (
        PhoneRuleData,
        BaseReferences<_$LocalDatabase, $PhoneRulesTable, PhoneRuleData>,
      ),
      PhoneRuleData,
      PrefetchHooks Function()
    >;
typedef $$RegexRulesTableCreateCompanionBuilder =
    RegexRulesCompanion Function({
      Value<String?> id,
      required String name,
      required String ruleType,
      required String pattern,
      Value<int> priority,
      Value<String> action,
      Value<int> isEnabled,
      Value<String?> subscriptionId,
      Value<int> rowid,
    });
typedef $$RegexRulesTableUpdateCompanionBuilder =
    RegexRulesCompanion Function({
      Value<String?> id,
      Value<String> name,
      Value<String> ruleType,
      Value<String> pattern,
      Value<int> priority,
      Value<String> action,
      Value<int> isEnabled,
      Value<String?> subscriptionId,
      Value<int> rowid,
    });

class $$RegexRulesTableFilterComposer
    extends Composer<_$LocalDatabase, $RegexRulesTable> {
  $$RegexRulesTableFilterComposer({
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

  ColumnFilters<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pattern => $composableBuilder(
    column: $table.pattern,
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

  ColumnFilters<int> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RegexRulesTableOrderingComposer
    extends Composer<_$LocalDatabase, $RegexRulesTable> {
  $$RegexRulesTableOrderingComposer({
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

  ColumnOrderings<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pattern => $composableBuilder(
    column: $table.pattern,
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

  ColumnOrderings<int> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RegexRulesTableAnnotationComposer
    extends Composer<_$LocalDatabase, $RegexRulesTable> {
  $$RegexRulesTableAnnotationComposer({
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

  GeneratedColumn<String> get ruleType =>
      $composableBuilder(column: $table.ruleType, builder: (column) => column);

  GeneratedColumn<String> get pattern =>
      $composableBuilder(column: $table.pattern, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<int> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get subscriptionId => $composableBuilder(
    column: $table.subscriptionId,
    builder: (column) => column,
  );
}

class $$RegexRulesTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $RegexRulesTable,
          RegexRuleData,
          $$RegexRulesTableFilterComposer,
          $$RegexRulesTableOrderingComposer,
          $$RegexRulesTableAnnotationComposer,
          $$RegexRulesTableCreateCompanionBuilder,
          $$RegexRulesTableUpdateCompanionBuilder,
          (
            RegexRuleData,
            BaseReferences<_$LocalDatabase, $RegexRulesTable, RegexRuleData>,
          ),
          RegexRuleData,
          PrefetchHooks Function()
        > {
  $$RegexRulesTableTableManager(_$LocalDatabase db, $RegexRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RegexRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RegexRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RegexRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String?> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> ruleType = const Value.absent(),
                Value<String> pattern = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<int> isEnabled = const Value.absent(),
                Value<String?> subscriptionId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RegexRulesCompanion(
                id: id,
                name: name,
                ruleType: ruleType,
                pattern: pattern,
                priority: priority,
                action: action,
                isEnabled: isEnabled,
                subscriptionId: subscriptionId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String?> id = const Value.absent(),
                required String name,
                required String ruleType,
                required String pattern,
                Value<int> priority = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<int> isEnabled = const Value.absent(),
                Value<String?> subscriptionId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RegexRulesCompanion.insert(
                id: id,
                name: name,
                ruleType: ruleType,
                pattern: pattern,
                priority: priority,
                action: action,
                isEnabled: isEnabled,
                subscriptionId: subscriptionId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RegexRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $RegexRulesTable,
      RegexRuleData,
      $$RegexRulesTableFilterComposer,
      $$RegexRulesTableOrderingComposer,
      $$RegexRulesTableAnnotationComposer,
      $$RegexRulesTableCreateCompanionBuilder,
      $$RegexRulesTableUpdateCompanionBuilder,
      (
        RegexRuleData,
        BaseReferences<_$LocalDatabase, $RegexRulesTable, RegexRuleData>,
      ),
      RegexRuleData,
      PrefetchHooks Function()
    >;
typedef $$SubscriptionsTableCreateCompanionBuilder =
    SubscriptionsCompanion Function({
      required String id,
      required String name,
      required String url,
      required String tableType,
      Value<int> isEnabled,
      required String lastUpdated,
      Value<int> autoUpdate,
      Value<String?> contactGroup,
      Value<String?> keywordFilters,
      Value<String> action,
      Value<int> rowid,
    });
typedef $$SubscriptionsTableUpdateCompanionBuilder =
    SubscriptionsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> url,
      Value<String> tableType,
      Value<int> isEnabled,
      Value<String> lastUpdated,
      Value<int> autoUpdate,
      Value<String?> contactGroup,
      Value<String?> keywordFilters,
      Value<String> action,
      Value<int> rowid,
    });

class $$SubscriptionsTableFilterComposer
    extends Composer<_$LocalDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableFilterComposer({
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

  ColumnFilters<String> get tableType => $composableBuilder(
    column: $table.tableType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get autoUpdate => $composableBuilder(
    column: $table.autoUpdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactGroup => $composableBuilder(
    column: $table.contactGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keywordFilters => $composableBuilder(
    column: $table.keywordFilters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SubscriptionsTableOrderingComposer
    extends Composer<_$LocalDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableOrderingComposer({
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

  ColumnOrderings<String> get tableType => $composableBuilder(
    column: $table.tableType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get autoUpdate => $composableBuilder(
    column: $table.autoUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactGroup => $composableBuilder(
    column: $table.contactGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keywordFilters => $composableBuilder(
    column: $table.keywordFilters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubscriptionsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableAnnotationComposer({
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

  GeneratedColumn<String> get tableType =>
      $composableBuilder(column: $table.tableType, builder: (column) => column);

  GeneratedColumn<int> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );

  GeneratedColumn<int> get autoUpdate => $composableBuilder(
    column: $table.autoUpdate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactGroup => $composableBuilder(
    column: $table.contactGroup,
    builder: (column) => column,
  );

  GeneratedColumn<String> get keywordFilters => $composableBuilder(
    column: $table.keywordFilters,
    builder: (column) => column,
  );

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);
}

class $$SubscriptionsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $SubscriptionsTable,
          SubscriptionData,
          $$SubscriptionsTableFilterComposer,
          $$SubscriptionsTableOrderingComposer,
          $$SubscriptionsTableAnnotationComposer,
          $$SubscriptionsTableCreateCompanionBuilder,
          $$SubscriptionsTableUpdateCompanionBuilder,
          (
            SubscriptionData,
            BaseReferences<
              _$LocalDatabase,
              $SubscriptionsTable,
              SubscriptionData
            >,
          ),
          SubscriptionData,
          PrefetchHooks Function()
        > {
  $$SubscriptionsTableTableManager(
    _$LocalDatabase db,
    $SubscriptionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubscriptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubscriptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubscriptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String> tableType = const Value.absent(),
                Value<int> isEnabled = const Value.absent(),
                Value<String> lastUpdated = const Value.absent(),
                Value<int> autoUpdate = const Value.absent(),
                Value<String?> contactGroup = const Value.absent(),
                Value<String?> keywordFilters = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubscriptionsCompanion(
                id: id,
                name: name,
                url: url,
                tableType: tableType,
                isEnabled: isEnabled,
                lastUpdated: lastUpdated,
                autoUpdate: autoUpdate,
                contactGroup: contactGroup,
                keywordFilters: keywordFilters,
                action: action,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String url,
                required String tableType,
                Value<int> isEnabled = const Value.absent(),
                required String lastUpdated,
                Value<int> autoUpdate = const Value.absent(),
                Value<String?> contactGroup = const Value.absent(),
                Value<String?> keywordFilters = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubscriptionsCompanion.insert(
                id: id,
                name: name,
                url: url,
                tableType: tableType,
                isEnabled: isEnabled,
                lastUpdated: lastUpdated,
                autoUpdate: autoUpdate,
                contactGroup: contactGroup,
                keywordFilters: keywordFilters,
                action: action,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SubscriptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $SubscriptionsTable,
      SubscriptionData,
      $$SubscriptionsTableFilterComposer,
      $$SubscriptionsTableOrderingComposer,
      $$SubscriptionsTableAnnotationComposer,
      $$SubscriptionsTableCreateCompanionBuilder,
      $$SubscriptionsTableUpdateCompanionBuilder,
      (
        SubscriptionData,
        BaseReferences<_$LocalDatabase, $SubscriptionsTable, SubscriptionData>,
      ),
      SubscriptionData,
      PrefetchHooks Function()
    >;
typedef $$SmsTableCreateCompanionBuilder =
    SmsCompanion Function({
      required String id,
      required String phoneNumber,
      Value<String?> contactName,
      required String messageType,
      required String content,
      required String timestamp,
      Value<int> isRead,
      Value<String?> simInfo,
      Value<int> isMarked,
      Value<String?> labelIds,
      Value<int> rowid,
    });
typedef $$SmsTableUpdateCompanionBuilder =
    SmsCompanion Function({
      Value<String> id,
      Value<String> phoneNumber,
      Value<String?> contactName,
      Value<String> messageType,
      Value<String> content,
      Value<String> timestamp,
      Value<int> isRead,
      Value<String?> simInfo,
      Value<int> isMarked,
      Value<String?> labelIds,
      Value<int> rowid,
    });

class $$SmsTableFilterComposer extends Composer<_$LocalDatabase, $SmsTable> {
  $$SmsTableFilterComposer({
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

  ColumnFilters<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get simInfo => $composableBuilder(
    column: $table.simInfo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isMarked => $composableBuilder(
    column: $table.isMarked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelIds => $composableBuilder(
    column: $table.labelIds,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SmsTableOrderingComposer extends Composer<_$LocalDatabase, $SmsTable> {
  $$SmsTableOrderingComposer({
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

  ColumnOrderings<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get simInfo => $composableBuilder(
    column: $table.simInfo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isMarked => $composableBuilder(
    column: $table.isMarked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelIds => $composableBuilder(
    column: $table.labelIds,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SmsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $SmsTable> {
  $$SmsTableAnnotationComposer({
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

  GeneratedColumn<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<String> get simInfo =>
      $composableBuilder(column: $table.simInfo, builder: (column) => column);

  GeneratedColumn<int> get isMarked =>
      $composableBuilder(column: $table.isMarked, builder: (column) => column);

  GeneratedColumn<String> get labelIds =>
      $composableBuilder(column: $table.labelIds, builder: (column) => column);
}

class $$SmsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $SmsTable,
          SmsMessageData,
          $$SmsTableFilterComposer,
          $$SmsTableOrderingComposer,
          $$SmsTableAnnotationComposer,
          $$SmsTableCreateCompanionBuilder,
          $$SmsTableUpdateCompanionBuilder,
          (
            SmsMessageData,
            BaseReferences<_$LocalDatabase, $SmsTable, SmsMessageData>,
          ),
          SmsMessageData,
          PrefetchHooks Function()
        > {
  $$SmsTableTableManager(_$LocalDatabase db, $SmsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SmsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SmsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SmsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String?> contactName = const Value.absent(),
                Value<String> messageType = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> timestamp = const Value.absent(),
                Value<int> isRead = const Value.absent(),
                Value<String?> simInfo = const Value.absent(),
                Value<int> isMarked = const Value.absent(),
                Value<String?> labelIds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SmsCompanion(
                id: id,
                phoneNumber: phoneNumber,
                contactName: contactName,
                messageType: messageType,
                content: content,
                timestamp: timestamp,
                isRead: isRead,
                simInfo: simInfo,
                isMarked: isMarked,
                labelIds: labelIds,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String phoneNumber,
                Value<String?> contactName = const Value.absent(),
                required String messageType,
                required String content,
                required String timestamp,
                Value<int> isRead = const Value.absent(),
                Value<String?> simInfo = const Value.absent(),
                Value<int> isMarked = const Value.absent(),
                Value<String?> labelIds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SmsCompanion.insert(
                id: id,
                phoneNumber: phoneNumber,
                contactName: contactName,
                messageType: messageType,
                content: content,
                timestamp: timestamp,
                isRead: isRead,
                simInfo: simInfo,
                isMarked: isMarked,
                labelIds: labelIds,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SmsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $SmsTable,
      SmsMessageData,
      $$SmsTableFilterComposer,
      $$SmsTableOrderingComposer,
      $$SmsTableAnnotationComposer,
      $$SmsTableCreateCompanionBuilder,
      $$SmsTableUpdateCompanionBuilder,
      (
        SmsMessageData,
        BaseReferences<_$LocalDatabase, $SmsTable, SmsMessageData>,
      ),
      SmsMessageData,
      PrefetchHooks Function()
    >;
typedef $$SmsRulesTableCreateCompanionBuilder =
    SmsRulesCompanion Function({
      required String id,
      required String name,
      required String contentRegex,
      Value<String?> senderRegex,
      required String action,
      Value<int> priority,
      Value<int> isEnabled,
      required String ruleType,
      Value<int> rowid,
    });
typedef $$SmsRulesTableUpdateCompanionBuilder =
    SmsRulesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> contentRegex,
      Value<String?> senderRegex,
      Value<String> action,
      Value<int> priority,
      Value<int> isEnabled,
      Value<String> ruleType,
      Value<int> rowid,
    });

class $$SmsRulesTableFilterComposer
    extends Composer<_$LocalDatabase, $SmsRulesTable> {
  $$SmsRulesTableFilterComposer({
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

  ColumnFilters<String> get contentRegex => $composableBuilder(
    column: $table.contentRegex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderRegex => $composableBuilder(
    column: $table.senderRegex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SmsRulesTableOrderingComposer
    extends Composer<_$LocalDatabase, $SmsRulesTable> {
  $$SmsRulesTableOrderingComposer({
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

  ColumnOrderings<String> get contentRegex => $composableBuilder(
    column: $table.contentRegex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderRegex => $composableBuilder(
    column: $table.senderRegex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SmsRulesTableAnnotationComposer
    extends Composer<_$LocalDatabase, $SmsRulesTable> {
  $$SmsRulesTableAnnotationComposer({
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

  GeneratedColumn<String> get contentRegex => $composableBuilder(
    column: $table.contentRegex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get senderRegex => $composableBuilder(
    column: $table.senderRegex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<int> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get ruleType =>
      $composableBuilder(column: $table.ruleType, builder: (column) => column);
}

class $$SmsRulesTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $SmsRulesTable,
          SmsRuleData,
          $$SmsRulesTableFilterComposer,
          $$SmsRulesTableOrderingComposer,
          $$SmsRulesTableAnnotationComposer,
          $$SmsRulesTableCreateCompanionBuilder,
          $$SmsRulesTableUpdateCompanionBuilder,
          (
            SmsRuleData,
            BaseReferences<_$LocalDatabase, $SmsRulesTable, SmsRuleData>,
          ),
          SmsRuleData,
          PrefetchHooks Function()
        > {
  $$SmsRulesTableTableManager(_$LocalDatabase db, $SmsRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SmsRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SmsRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SmsRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> contentRegex = const Value.absent(),
                Value<String?> senderRegex = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int> isEnabled = const Value.absent(),
                Value<String> ruleType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SmsRulesCompanion(
                id: id,
                name: name,
                contentRegex: contentRegex,
                senderRegex: senderRegex,
                action: action,
                priority: priority,
                isEnabled: isEnabled,
                ruleType: ruleType,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String contentRegex,
                Value<String?> senderRegex = const Value.absent(),
                required String action,
                Value<int> priority = const Value.absent(),
                Value<int> isEnabled = const Value.absent(),
                required String ruleType,
                Value<int> rowid = const Value.absent(),
              }) => SmsRulesCompanion.insert(
                id: id,
                name: name,
                contentRegex: contentRegex,
                senderRegex: senderRegex,
                action: action,
                priority: priority,
                isEnabled: isEnabled,
                ruleType: ruleType,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SmsRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $SmsRulesTable,
      SmsRuleData,
      $$SmsRulesTableFilterComposer,
      $$SmsRulesTableOrderingComposer,
      $$SmsRulesTableAnnotationComposer,
      $$SmsRulesTableCreateCompanionBuilder,
      $$SmsRulesTableUpdateCompanionBuilder,
      (
        SmsRuleData,
        BaseReferences<_$LocalDatabase, $SmsRulesTable, SmsRuleData>,
      ),
      SmsRuleData,
      PrefetchHooks Function()
    >;
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
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
typedef $$LocationsTableCreateCompanionBuilder =
    LocationsCompanion Function({
      required String id,
      required String phoneNumber,
      Value<String?> region,
      Value<String?> countryName,
      Value<String?> carrier,
      required int numberType,
      Value<int> rowid,
    });
typedef $$LocationsTableUpdateCompanionBuilder =
    LocationsCompanion Function({
      Value<String> id,
      Value<String> phoneNumber,
      Value<String?> region,
      Value<String?> countryName,
      Value<String?> carrier,
      Value<int> numberType,
      Value<int> rowid,
    });

class $$LocationsTableFilterComposer
    extends Composer<_$LocalDatabase, $LocationsTable> {
  $$LocationsTableFilterComposer({
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

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryName => $composableBuilder(
    column: $table.countryName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get carrier => $composableBuilder(
    column: $table.carrier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberType => $composableBuilder(
    column: $table.numberType,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocationsTableOrderingComposer
    extends Composer<_$LocalDatabase, $LocationsTable> {
  $$LocationsTableOrderingComposer({
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

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryName => $composableBuilder(
    column: $table.countryName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get carrier => $composableBuilder(
    column: $table.carrier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberType => $composableBuilder(
    column: $table.numberType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocationsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $LocationsTable> {
  $$LocationsTableAnnotationComposer({
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

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get countryName => $composableBuilder(
    column: $table.countryName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get carrier =>
      $composableBuilder(column: $table.carrier, builder: (column) => column);

  GeneratedColumn<int> get numberType => $composableBuilder(
    column: $table.numberType,
    builder: (column) => column,
  );
}

class $$LocationsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $LocationsTable,
          LocationData,
          $$LocationsTableFilterComposer,
          $$LocationsTableOrderingComposer,
          $$LocationsTableAnnotationComposer,
          $$LocationsTableCreateCompanionBuilder,
          $$LocationsTableUpdateCompanionBuilder,
          (
            LocationData,
            BaseReferences<_$LocalDatabase, $LocationsTable, LocationData>,
          ),
          LocationData,
          PrefetchHooks Function()
        > {
  $$LocationsTableTableManager(_$LocalDatabase db, $LocationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> countryName = const Value.absent(),
                Value<String?> carrier = const Value.absent(),
                Value<int> numberType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocationsCompanion(
                id: id,
                phoneNumber: phoneNumber,
                region: region,
                countryName: countryName,
                carrier: carrier,
                numberType: numberType,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String phoneNumber,
                Value<String?> region = const Value.absent(),
                Value<String?> countryName = const Value.absent(),
                Value<String?> carrier = const Value.absent(),
                required int numberType,
                Value<int> rowid = const Value.absent(),
              }) => LocationsCompanion.insert(
                id: id,
                phoneNumber: phoneNumber,
                region: region,
                countryName: countryName,
                carrier: carrier,
                numberType: numberType,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $LocationsTable,
      LocationData,
      $$LocationsTableFilterComposer,
      $$LocationsTableOrderingComposer,
      $$LocationsTableAnnotationComposer,
      $$LocationsTableCreateCompanionBuilder,
      $$LocationsTableUpdateCompanionBuilder,
      (
        LocationData,
        BaseReferences<_$LocalDatabase, $LocationsTable, LocationData>,
      ),
      LocationData,
      PrefetchHooks Function()
    >;
typedef $$PredefinedLabelsTableCreateCompanionBuilder =
    PredefinedLabelsCompanion Function({
      required String id,
      required String labelText,
      Value<String?> avatar,
      Value<String?> icon,
      Value<int> rowid,
    });
typedef $$PredefinedLabelsTableUpdateCompanionBuilder =
    PredefinedLabelsCompanion Function({
      Value<String> id,
      Value<String> labelText,
      Value<String?> avatar,
      Value<String?> icon,
      Value<int> rowid,
    });

class $$PredefinedLabelsTableFilterComposer
    extends Composer<_$LocalDatabase, $PredefinedLabelsTable> {
  $$PredefinedLabelsTableFilterComposer({
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

  ColumnFilters<String> get labelText => $composableBuilder(
    column: $table.labelText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PredefinedLabelsTableOrderingComposer
    extends Composer<_$LocalDatabase, $PredefinedLabelsTable> {
  $$PredefinedLabelsTableOrderingComposer({
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

  ColumnOrderings<String> get labelText => $composableBuilder(
    column: $table.labelText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PredefinedLabelsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $PredefinedLabelsTable> {
  $$PredefinedLabelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get labelText =>
      $composableBuilder(column: $table.labelText, builder: (column) => column);

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);
}

class $$PredefinedLabelsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $PredefinedLabelsTable,
          PredefinedLabelData,
          $$PredefinedLabelsTableFilterComposer,
          $$PredefinedLabelsTableOrderingComposer,
          $$PredefinedLabelsTableAnnotationComposer,
          $$PredefinedLabelsTableCreateCompanionBuilder,
          $$PredefinedLabelsTableUpdateCompanionBuilder,
          (
            PredefinedLabelData,
            BaseReferences<
              _$LocalDatabase,
              $PredefinedLabelsTable,
              PredefinedLabelData
            >,
          ),
          PredefinedLabelData,
          PrefetchHooks Function()
        > {
  $$PredefinedLabelsTableTableManager(
    _$LocalDatabase db,
    $PredefinedLabelsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PredefinedLabelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PredefinedLabelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PredefinedLabelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> labelText = const Value.absent(),
                Value<String?> avatar = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PredefinedLabelsCompanion(
                id: id,
                labelText: labelText,
                avatar: avatar,
                icon: icon,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String labelText,
                Value<String?> avatar = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PredefinedLabelsCompanion.insert(
                id: id,
                labelText: labelText,
                avatar: avatar,
                icon: icon,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PredefinedLabelsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $PredefinedLabelsTable,
      PredefinedLabelData,
      $$PredefinedLabelsTableFilterComposer,
      $$PredefinedLabelsTableOrderingComposer,
      $$PredefinedLabelsTableAnnotationComposer,
      $$PredefinedLabelsTableCreateCompanionBuilder,
      $$PredefinedLabelsTableUpdateCompanionBuilder,
      (
        PredefinedLabelData,
        BaseReferences<
          _$LocalDatabase,
          $PredefinedLabelsTable,
          PredefinedLabelData
        >,
      ),
      PredefinedLabelData,
      PrefetchHooks Function()
    >;
typedef $$LabelPhonesTableCreateCompanionBuilder =
    LabelPhonesCompanion Function({
      required String id,
      Value<String?> name,
      Value<String?> icon,
      required String phoneNumber,
      required String labelId,
      Value<String?> avatar,
      Value<int> priority,
      Value<String> action,
      Value<int> isEnabled,
      Value<String> ruleType,
      Value<int> rowid,
    });
typedef $$LabelPhonesTableUpdateCompanionBuilder =
    LabelPhonesCompanion Function({
      Value<String> id,
      Value<String?> name,
      Value<String?> icon,
      Value<String> phoneNumber,
      Value<String> labelId,
      Value<String?> avatar,
      Value<int> priority,
      Value<String> action,
      Value<int> isEnabled,
      Value<String> ruleType,
      Value<int> rowid,
    });

class $$LabelPhonesTableFilterComposer
    extends Composer<_$LocalDatabase, $LabelPhonesTable> {
  $$LabelPhonesTableFilterComposer({
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

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelId => $composableBuilder(
    column: $table.labelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatar => $composableBuilder(
    column: $table.avatar,
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

  ColumnFilters<int> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LabelPhonesTableOrderingComposer
    extends Composer<_$LocalDatabase, $LabelPhonesTable> {
  $$LabelPhonesTableOrderingComposer({
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

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelId => $composableBuilder(
    column: $table.labelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatar => $composableBuilder(
    column: $table.avatar,
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

  ColumnOrderings<int> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LabelPhonesTableAnnotationComposer
    extends Composer<_$LocalDatabase, $LabelPhonesTable> {
  $$LabelPhonesTableAnnotationComposer({
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

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get labelId =>
      $composableBuilder(column: $table.labelId, builder: (column) => column);

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<int> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get ruleType =>
      $composableBuilder(column: $table.ruleType, builder: (column) => column);
}

class $$LabelPhonesTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $LabelPhonesTable,
          LabelPhoneData,
          $$LabelPhonesTableFilterComposer,
          $$LabelPhonesTableOrderingComposer,
          $$LabelPhonesTableAnnotationComposer,
          $$LabelPhonesTableCreateCompanionBuilder,
          $$LabelPhonesTableUpdateCompanionBuilder,
          (
            LabelPhoneData,
            BaseReferences<_$LocalDatabase, $LabelPhonesTable, LabelPhoneData>,
          ),
          LabelPhoneData,
          PrefetchHooks Function()
        > {
  $$LabelPhonesTableTableManager(_$LocalDatabase db, $LabelPhonesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LabelPhonesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LabelPhonesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LabelPhonesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String> labelId = const Value.absent(),
                Value<String?> avatar = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<int> isEnabled = const Value.absent(),
                Value<String> ruleType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LabelPhonesCompanion(
                id: id,
                name: name,
                icon: icon,
                phoneNumber: phoneNumber,
                labelId: labelId,
                avatar: avatar,
                priority: priority,
                action: action,
                isEnabled: isEnabled,
                ruleType: ruleType,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> name = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                required String phoneNumber,
                required String labelId,
                Value<String?> avatar = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<int> isEnabled = const Value.absent(),
                Value<String> ruleType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LabelPhonesCompanion.insert(
                id: id,
                name: name,
                icon: icon,
                phoneNumber: phoneNumber,
                labelId: labelId,
                avatar: avatar,
                priority: priority,
                action: action,
                isEnabled: isEnabled,
                ruleType: ruleType,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LabelPhonesTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $LabelPhonesTable,
      LabelPhoneData,
      $$LabelPhonesTableFilterComposer,
      $$LabelPhonesTableOrderingComposer,
      $$LabelPhonesTableAnnotationComposer,
      $$LabelPhonesTableCreateCompanionBuilder,
      $$LabelPhonesTableUpdateCompanionBuilder,
      (
        LabelPhoneData,
        BaseReferences<_$LocalDatabase, $LabelPhonesTable, LabelPhoneData>,
      ),
      LabelPhoneData,
      PrefetchHooks Function()
    >;
typedef $$SimSlotRulesTableCreateCompanionBuilder =
    SimSlotRulesCompanion Function({
      required String id,
      required String name,
      required int priority,
      required String action,
      Value<int> isEnabled,
      required String phoneNumber,
      required int simSlotIndex,
      required String labelId,
      Value<String?> avatar,
      Value<String> ruleType,
      Value<int> rowid,
    });
typedef $$SimSlotRulesTableUpdateCompanionBuilder =
    SimSlotRulesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> priority,
      Value<String> action,
      Value<int> isEnabled,
      Value<String> phoneNumber,
      Value<int> simSlotIndex,
      Value<String> labelId,
      Value<String?> avatar,
      Value<String> ruleType,
      Value<int> rowid,
    });

class $$SimSlotRulesTableFilterComposer
    extends Composer<_$LocalDatabase, $SimSlotRulesTable> {
  $$SimSlotRulesTableFilterComposer({
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

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get simSlotIndex => $composableBuilder(
    column: $table.simSlotIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelId => $composableBuilder(
    column: $table.labelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SimSlotRulesTableOrderingComposer
    extends Composer<_$LocalDatabase, $SimSlotRulesTable> {
  $$SimSlotRulesTableOrderingComposer({
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

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get simSlotIndex => $composableBuilder(
    column: $table.simSlotIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelId => $composableBuilder(
    column: $table.labelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SimSlotRulesTableAnnotationComposer
    extends Composer<_$LocalDatabase, $SimSlotRulesTable> {
  $$SimSlotRulesTableAnnotationComposer({
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

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<int> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get simSlotIndex => $composableBuilder(
    column: $table.simSlotIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get labelId =>
      $composableBuilder(column: $table.labelId, builder: (column) => column);

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);

  GeneratedColumn<String> get ruleType =>
      $composableBuilder(column: $table.ruleType, builder: (column) => column);
}

class $$SimSlotRulesTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $SimSlotRulesTable,
          SimSlotRuleData,
          $$SimSlotRulesTableFilterComposer,
          $$SimSlotRulesTableOrderingComposer,
          $$SimSlotRulesTableAnnotationComposer,
          $$SimSlotRulesTableCreateCompanionBuilder,
          $$SimSlotRulesTableUpdateCompanionBuilder,
          (
            SimSlotRuleData,
            BaseReferences<
              _$LocalDatabase,
              $SimSlotRulesTable,
              SimSlotRuleData
            >,
          ),
          SimSlotRuleData,
          PrefetchHooks Function()
        > {
  $$SimSlotRulesTableTableManager(_$LocalDatabase db, $SimSlotRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SimSlotRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SimSlotRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SimSlotRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<int> isEnabled = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<int> simSlotIndex = const Value.absent(),
                Value<String> labelId = const Value.absent(),
                Value<String?> avatar = const Value.absent(),
                Value<String> ruleType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SimSlotRulesCompanion(
                id: id,
                name: name,
                priority: priority,
                action: action,
                isEnabled: isEnabled,
                phoneNumber: phoneNumber,
                simSlotIndex: simSlotIndex,
                labelId: labelId,
                avatar: avatar,
                ruleType: ruleType,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int priority,
                required String action,
                Value<int> isEnabled = const Value.absent(),
                required String phoneNumber,
                required int simSlotIndex,
                required String labelId,
                Value<String?> avatar = const Value.absent(),
                Value<String> ruleType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SimSlotRulesCompanion.insert(
                id: id,
                name: name,
                priority: priority,
                action: action,
                isEnabled: isEnabled,
                phoneNumber: phoneNumber,
                simSlotIndex: simSlotIndex,
                labelId: labelId,
                avatar: avatar,
                ruleType: ruleType,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SimSlotRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $SimSlotRulesTable,
      SimSlotRuleData,
      $$SimSlotRulesTableFilterComposer,
      $$SimSlotRulesTableOrderingComposer,
      $$SimSlotRulesTableAnnotationComposer,
      $$SimSlotRulesTableCreateCompanionBuilder,
      $$SimSlotRulesTableUpdateCompanionBuilder,
      (
        SimSlotRuleData,
        BaseReferences<_$LocalDatabase, $SimSlotRulesTable, SimSlotRuleData>,
      ),
      SimSlotRuleData,
      PrefetchHooks Function()
    >;
typedef $$LabelMarkStatisticsTableCreateCompanionBuilder =
    LabelMarkStatisticsCompanion Function({
      required String id,
      required String phoneNumber,
      required String labelId,
      required String markedAt,
      Value<int> isCounted,
      Value<int> rowid,
    });
typedef $$LabelMarkStatisticsTableUpdateCompanionBuilder =
    LabelMarkStatisticsCompanion Function({
      Value<String> id,
      Value<String> phoneNumber,
      Value<String> labelId,
      Value<String> markedAt,
      Value<int> isCounted,
      Value<int> rowid,
    });

class $$LabelMarkStatisticsTableFilterComposer
    extends Composer<_$LocalDatabase, $LabelMarkStatisticsTable> {
  $$LabelMarkStatisticsTableFilterComposer({
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

  ColumnFilters<String> get labelId => $composableBuilder(
    column: $table.labelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get markedAt => $composableBuilder(
    column: $table.markedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isCounted => $composableBuilder(
    column: $table.isCounted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LabelMarkStatisticsTableOrderingComposer
    extends Composer<_$LocalDatabase, $LabelMarkStatisticsTable> {
  $$LabelMarkStatisticsTableOrderingComposer({
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

  ColumnOrderings<String> get labelId => $composableBuilder(
    column: $table.labelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get markedAt => $composableBuilder(
    column: $table.markedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isCounted => $composableBuilder(
    column: $table.isCounted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LabelMarkStatisticsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $LabelMarkStatisticsTable> {
  $$LabelMarkStatisticsTableAnnotationComposer({
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

  GeneratedColumn<String> get labelId =>
      $composableBuilder(column: $table.labelId, builder: (column) => column);

  GeneratedColumn<String> get markedAt =>
      $composableBuilder(column: $table.markedAt, builder: (column) => column);

  GeneratedColumn<int> get isCounted =>
      $composableBuilder(column: $table.isCounted, builder: (column) => column);
}

class $$LabelMarkStatisticsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $LabelMarkStatisticsTable,
          LabelMarkStatisticData,
          $$LabelMarkStatisticsTableFilterComposer,
          $$LabelMarkStatisticsTableOrderingComposer,
          $$LabelMarkStatisticsTableAnnotationComposer,
          $$LabelMarkStatisticsTableCreateCompanionBuilder,
          $$LabelMarkStatisticsTableUpdateCompanionBuilder,
          (
            LabelMarkStatisticData,
            BaseReferences<
              _$LocalDatabase,
              $LabelMarkStatisticsTable,
              LabelMarkStatisticData
            >,
          ),
          LabelMarkStatisticData,
          PrefetchHooks Function()
        > {
  $$LabelMarkStatisticsTableTableManager(
    _$LocalDatabase db,
    $LabelMarkStatisticsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LabelMarkStatisticsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LabelMarkStatisticsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LabelMarkStatisticsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String> labelId = const Value.absent(),
                Value<String> markedAt = const Value.absent(),
                Value<int> isCounted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LabelMarkStatisticsCompanion(
                id: id,
                phoneNumber: phoneNumber,
                labelId: labelId,
                markedAt: markedAt,
                isCounted: isCounted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String phoneNumber,
                required String labelId,
                required String markedAt,
                Value<int> isCounted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LabelMarkStatisticsCompanion.insert(
                id: id,
                phoneNumber: phoneNumber,
                labelId: labelId,
                markedAt: markedAt,
                isCounted: isCounted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LabelMarkStatisticsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $LabelMarkStatisticsTable,
      LabelMarkStatisticData,
      $$LabelMarkStatisticsTableFilterComposer,
      $$LabelMarkStatisticsTableOrderingComposer,
      $$LabelMarkStatisticsTableAnnotationComposer,
      $$LabelMarkStatisticsTableCreateCompanionBuilder,
      $$LabelMarkStatisticsTableUpdateCompanionBuilder,
      (
        LabelMarkStatisticData,
        BaseReferences<
          _$LocalDatabase,
          $LabelMarkStatisticsTable,
          LabelMarkStatisticData
        >,
      ),
      LabelMarkStatisticData,
      PrefetchHooks Function()
    >;
typedef $$UserMarkCountTableCreateCompanionBuilder =
    UserMarkCountCompanion Function({
      required String id,
      Value<int> totalCount,
      required String lastUpdated,
      Value<int> rowid,
    });
typedef $$UserMarkCountTableUpdateCompanionBuilder =
    UserMarkCountCompanion Function({
      Value<String> id,
      Value<int> totalCount,
      Value<String> lastUpdated,
      Value<int> rowid,
    });

class $$UserMarkCountTableFilterComposer
    extends Composer<_$LocalDatabase, $UserMarkCountTable> {
  $$UserMarkCountTableFilterComposer({
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

  ColumnFilters<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserMarkCountTableOrderingComposer
    extends Composer<_$LocalDatabase, $UserMarkCountTable> {
  $$UserMarkCountTableOrderingComposer({
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

  ColumnOrderings<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserMarkCountTableAnnotationComposer
    extends Composer<_$LocalDatabase, $UserMarkCountTable> {
  $$UserMarkCountTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );
}

class $$UserMarkCountTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $UserMarkCountTable,
          UserMarkCountData,
          $$UserMarkCountTableFilterComposer,
          $$UserMarkCountTableOrderingComposer,
          $$UserMarkCountTableAnnotationComposer,
          $$UserMarkCountTableCreateCompanionBuilder,
          $$UserMarkCountTableUpdateCompanionBuilder,
          (
            UserMarkCountData,
            BaseReferences<
              _$LocalDatabase,
              $UserMarkCountTable,
              UserMarkCountData
            >,
          ),
          UserMarkCountData,
          PrefetchHooks Function()
        > {
  $$UserMarkCountTableTableManager(
    _$LocalDatabase db,
    $UserMarkCountTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserMarkCountTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserMarkCountTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserMarkCountTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> totalCount = const Value.absent(),
                Value<String> lastUpdated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserMarkCountCompanion(
                id: id,
                totalCount: totalCount,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int> totalCount = const Value.absent(),
                required String lastUpdated,
                Value<int> rowid = const Value.absent(),
              }) => UserMarkCountCompanion.insert(
                id: id,
                totalCount: totalCount,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserMarkCountTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $UserMarkCountTable,
      UserMarkCountData,
      $$UserMarkCountTableFilterComposer,
      $$UserMarkCountTableOrderingComposer,
      $$UserMarkCountTableAnnotationComposer,
      $$UserMarkCountTableCreateCompanionBuilder,
      $$UserMarkCountTableUpdateCompanionBuilder,
      (
        UserMarkCountData,
        BaseReferences<_$LocalDatabase, $UserMarkCountTable, UserMarkCountData>,
      ),
      UserMarkCountData,
      PrefetchHooks Function()
    >;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db, _db.contacts);
  $$CallHistoryTableTableManager get callHistory =>
      $$CallHistoryTableTableManager(_db, _db.callHistory);
  $$RulesTableTableManager get rules =>
      $$RulesTableTableManager(_db, _db.rules);
  $$PhoneRulesTableTableManager get phoneRules =>
      $$PhoneRulesTableTableManager(_db, _db.phoneRules);
  $$RegexRulesTableTableManager get regexRules =>
      $$RegexRulesTableTableManager(_db, _db.regexRules);
  $$SubscriptionsTableTableManager get subscriptions =>
      $$SubscriptionsTableTableManager(_db, _db.subscriptions);
  $$SmsTableTableManager get sms => $$SmsTableTableManager(_db, _db.sms);
  $$SmsRulesTableTableManager get smsRules =>
      $$SmsRulesTableTableManager(_db, _db.smsRules);
  $$PluginsTableTableManager get plugins =>
      $$PluginsTableTableManager(_db, _db.plugins);
  $$LocationsTableTableManager get locations =>
      $$LocationsTableTableManager(_db, _db.locations);
  $$PredefinedLabelsTableTableManager get predefinedLabels =>
      $$PredefinedLabelsTableTableManager(_db, _db.predefinedLabels);
  $$LabelPhonesTableTableManager get labelPhones =>
      $$LabelPhonesTableTableManager(_db, _db.labelPhones);
  $$SimSlotRulesTableTableManager get simSlotRules =>
      $$SimSlotRulesTableTableManager(_db, _db.simSlotRules);
  $$LabelMarkStatisticsTableTableManager get labelMarkStatistics =>
      $$LabelMarkStatisticsTableTableManager(_db, _db.labelMarkStatistics);
  $$UserMarkCountTableTableManager get userMarkCount =>
      $$UserMarkCountTableTableManager(_db, _db.userMarkCount);
}
