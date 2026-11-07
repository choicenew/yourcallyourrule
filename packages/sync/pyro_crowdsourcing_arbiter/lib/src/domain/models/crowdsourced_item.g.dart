// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crowdsourced_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetCrowdsourcedItemCollection on Isar {
  IsarCollection<CrowdsourcedItem> get crowdsourcedItems => this.collection();
}

const CrowdsourcedItemSchema = CollectionSchema(
  name: r'CrowdsourcedItem',
  id: 9049544321409203189,
  properties: {
    r'compositeKey': PropertySchema(
      id: 0,
      name: r'compositeKey',
      type: IsarType.string,
    ),
    r'confidence': PropertySchema(
      id: 1,
      name: r'confidence',
      type: IsarType.double,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'domain': PropertySchema(
      id: 3,
      name: r'domain',
      type: IsarType.string,
    ),
    r'entityKey': PropertySchema(
      id: 4,
      name: r'entityKey',
      type: IsarType.string,
    ),
    r'opposeVotes': PropertySchema(
      id: 5,
      name: r'opposeVotes',
      type: IsarType.long,
    ),
    r'payloadJson': PropertySchema(
      id: 6,
      name: r'payloadJson',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 7,
      name: r'status',
      type: IsarType.string,
    ),
    r'supportVotes': PropertySchema(
      id: 8,
      name: r'supportVotes',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 9,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'verifiedOwnerCount': PropertySchema(
      id: 10,
      name: r'verifiedOwnerCount',
      type: IsarType.long,
    )
  },
  estimateSize: _crowdsourcedItemEstimateSize,
  serialize: _crowdsourcedItemSerialize,
  deserialize: _crowdsourcedItemDeserialize,
  deserializeProp: _crowdsourcedItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'compositeKey': IndexSchema(
      id: -66619599277560115,
      name: r'compositeKey',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'compositeKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'domain': IndexSchema(
      id: 1163864941618423784,
      name: r'domain',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'domain',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'entityKey': IndexSchema(
      id: -9036825346649120373,
      name: r'entityKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'entityKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'status': IndexSchema(
      id: -107785170620420283,
      name: r'status',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'status',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _crowdsourcedItemGetId,
  getLinks: _crowdsourcedItemGetLinks,
  attach: _crowdsourcedItemAttach,
  version: '3.4.1',
);

int _crowdsourcedItemEstimateSize(
  CrowdsourcedItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.compositeKey.length * 3;
  bytesCount += 3 + object.domain.length * 3;
  bytesCount += 3 + object.entityKey.length * 3;
  bytesCount += 3 + object.payloadJson.length * 3;
  bytesCount += 3 + object.status.length * 3;
  return bytesCount;
}

void _crowdsourcedItemSerialize(
  CrowdsourcedItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.compositeKey);
  writer.writeDouble(offsets[1], object.confidence);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.domain);
  writer.writeString(offsets[4], object.entityKey);
  writer.writeLong(offsets[5], object.opposeVotes);
  writer.writeString(offsets[6], object.payloadJson);
  writer.writeString(offsets[7], object.status);
  writer.writeLong(offsets[8], object.supportVotes);
  writer.writeDateTime(offsets[9], object.updatedAt);
  writer.writeLong(offsets[10], object.verifiedOwnerCount);
}

CrowdsourcedItem _crowdsourcedItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CrowdsourcedItem();
  object.compositeKey = reader.readString(offsets[0]);
  object.confidence = reader.readDouble(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.domain = reader.readString(offsets[3]);
  object.entityKey = reader.readString(offsets[4]);
  object.id = id;
  object.opposeVotes = reader.readLong(offsets[5]);
  object.payloadJson = reader.readString(offsets[6]);
  object.status = reader.readString(offsets[7]);
  object.supportVotes = reader.readLong(offsets[8]);
  object.updatedAt = reader.readDateTime(offsets[9]);
  object.verifiedOwnerCount = reader.readLong(offsets[10]);
  return object;
}

P _crowdsourcedItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _crowdsourcedItemGetId(CrowdsourcedItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _crowdsourcedItemGetLinks(CrowdsourcedItem object) {
  return [];
}

void _crowdsourcedItemAttach(
    IsarCollection<dynamic> col, Id id, CrowdsourcedItem object) {
  object.id = id;
}

extension CrowdsourcedItemByIndex on IsarCollection<CrowdsourcedItem> {
  Future<CrowdsourcedItem?> getByCompositeKey(String compositeKey) {
    return getByIndex(r'compositeKey', [compositeKey]);
  }

  CrowdsourcedItem? getByCompositeKeySync(String compositeKey) {
    return getByIndexSync(r'compositeKey', [compositeKey]);
  }

  Future<bool> deleteByCompositeKey(String compositeKey) {
    return deleteByIndex(r'compositeKey', [compositeKey]);
  }

  bool deleteByCompositeKeySync(String compositeKey) {
    return deleteByIndexSync(r'compositeKey', [compositeKey]);
  }

  Future<List<CrowdsourcedItem?>> getAllByCompositeKey(
      List<String> compositeKeyValues) {
    final values = compositeKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'compositeKey', values);
  }

  List<CrowdsourcedItem?> getAllByCompositeKeySync(
      List<String> compositeKeyValues) {
    final values = compositeKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'compositeKey', values);
  }

  Future<int> deleteAllByCompositeKey(List<String> compositeKeyValues) {
    final values = compositeKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'compositeKey', values);
  }

  int deleteAllByCompositeKeySync(List<String> compositeKeyValues) {
    final values = compositeKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'compositeKey', values);
  }

  Future<Id> putByCompositeKey(CrowdsourcedItem object) {
    return putByIndex(r'compositeKey', object);
  }

  Id putByCompositeKeySync(CrowdsourcedItem object, {bool saveLinks = true}) {
    return putByIndexSync(r'compositeKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByCompositeKey(List<CrowdsourcedItem> objects) {
    return putAllByIndex(r'compositeKey', objects);
  }

  List<Id> putAllByCompositeKeySync(List<CrowdsourcedItem> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'compositeKey', objects, saveLinks: saveLinks);
  }
}

extension CrowdsourcedItemQueryWhereSort
    on QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QWhere> {
  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CrowdsourcedItemQueryWhere
    on QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QWhereClause> {
  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterWhereClause>
      compositeKeyEqualTo(String compositeKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'compositeKey',
        value: [compositeKey],
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterWhereClause>
      compositeKeyNotEqualTo(String compositeKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'compositeKey',
              lower: [],
              upper: [compositeKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'compositeKey',
              lower: [compositeKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'compositeKey',
              lower: [compositeKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'compositeKey',
              lower: [],
              upper: [compositeKey],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterWhereClause>
      domainEqualTo(String domain) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'domain',
        value: [domain],
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterWhereClause>
      domainNotEqualTo(String domain) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'domain',
              lower: [],
              upper: [domain],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'domain',
              lower: [domain],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'domain',
              lower: [domain],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'domain',
              lower: [],
              upper: [domain],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterWhereClause>
      entityKeyEqualTo(String entityKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'entityKey',
        value: [entityKey],
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterWhereClause>
      entityKeyNotEqualTo(String entityKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entityKey',
              lower: [],
              upper: [entityKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entityKey',
              lower: [entityKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entityKey',
              lower: [entityKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entityKey',
              lower: [],
              upper: [entityKey],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterWhereClause>
      statusEqualTo(String status) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'status',
        value: [status],
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterWhereClause>
      statusNotEqualTo(String status) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [],
              upper: [status],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [status],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [status],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [],
              upper: [status],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CrowdsourcedItemQueryFilter
    on QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QFilterCondition> {
  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      compositeKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'compositeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      compositeKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'compositeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      compositeKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'compositeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      compositeKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'compositeKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      compositeKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'compositeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      compositeKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'compositeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      compositeKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'compositeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      compositeKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'compositeKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      compositeKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'compositeKey',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      compositeKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'compositeKey',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      confidenceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'confidence',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      confidenceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'confidence',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      confidenceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'confidence',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      confidenceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'confidence',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      domainEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'domain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      domainGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'domain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      domainLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'domain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      domainBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'domain',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      domainStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'domain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      domainEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'domain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      domainContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'domain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      domainMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'domain',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      domainIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'domain',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      domainIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'domain',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      entityKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entityKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      entityKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entityKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      entityKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entityKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      entityKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entityKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      entityKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'entityKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      entityKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'entityKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      entityKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entityKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      entityKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entityKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      entityKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entityKey',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      entityKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entityKey',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      opposeVotesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'opposeVotes',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      opposeVotesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'opposeVotes',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      opposeVotesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'opposeVotes',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      opposeVotesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'opposeVotes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      payloadJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      payloadJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'payloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      payloadJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'payloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      payloadJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'payloadJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      payloadJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'payloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      payloadJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'payloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      payloadJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'payloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      payloadJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'payloadJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      payloadJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payloadJson',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      payloadJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'payloadJson',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      supportVotesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supportVotes',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      supportVotesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'supportVotes',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      supportVotesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'supportVotes',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      supportVotesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'supportVotes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      verifiedOwnerCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verifiedOwnerCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      verifiedOwnerCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'verifiedOwnerCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      verifiedOwnerCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'verifiedOwnerCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterFilterCondition>
      verifiedOwnerCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'verifiedOwnerCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CrowdsourcedItemQueryObject
    on QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QFilterCondition> {}

extension CrowdsourcedItemQueryLinks
    on QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QFilterCondition> {}

extension CrowdsourcedItemQuerySortBy
    on QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QSortBy> {
  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByCompositeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compositeKey', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByCompositeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compositeKey', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByDomain() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domain', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByDomainDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domain', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByEntityKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityKey', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByEntityKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityKey', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByOpposeVotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'opposeVotes', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByOpposeVotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'opposeVotes', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByPayloadJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payloadJson', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByPayloadJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payloadJson', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortBySupportVotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportVotes', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortBySupportVotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportVotes', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByVerifiedOwnerCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifiedOwnerCount', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      sortByVerifiedOwnerCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifiedOwnerCount', Sort.desc);
    });
  }
}

extension CrowdsourcedItemQuerySortThenBy
    on QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QSortThenBy> {
  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByCompositeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compositeKey', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByCompositeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compositeKey', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByDomain() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domain', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByDomainDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domain', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByEntityKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityKey', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByEntityKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityKey', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByOpposeVotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'opposeVotes', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByOpposeVotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'opposeVotes', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByPayloadJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payloadJson', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByPayloadJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payloadJson', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenBySupportVotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportVotes', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenBySupportVotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportVotes', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByVerifiedOwnerCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifiedOwnerCount', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QAfterSortBy>
      thenByVerifiedOwnerCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifiedOwnerCount', Sort.desc);
    });
  }
}

extension CrowdsourcedItemQueryWhereDistinct
    on QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QDistinct> {
  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QDistinct>
      distinctByCompositeKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'compositeKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QDistinct>
      distinctByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'confidence');
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QDistinct> distinctByDomain(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'domain', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QDistinct>
      distinctByEntityKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entityKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QDistinct>
      distinctByOpposeVotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'opposeVotes');
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QDistinct>
      distinctByPayloadJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'payloadJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QDistinct>
      distinctBySupportVotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supportVotes');
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QDistinct>
      distinctByVerifiedOwnerCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verifiedOwnerCount');
    });
  }
}

extension CrowdsourcedItemQueryProperty
    on QueryBuilder<CrowdsourcedItem, CrowdsourcedItem, QQueryProperty> {
  QueryBuilder<CrowdsourcedItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CrowdsourcedItem, String, QQueryOperations>
      compositeKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'compositeKey');
    });
  }

  QueryBuilder<CrowdsourcedItem, double, QQueryOperations>
      confidenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'confidence');
    });
  }

  QueryBuilder<CrowdsourcedItem, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CrowdsourcedItem, String, QQueryOperations> domainProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'domain');
    });
  }

  QueryBuilder<CrowdsourcedItem, String, QQueryOperations> entityKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entityKey');
    });
  }

  QueryBuilder<CrowdsourcedItem, int, QQueryOperations> opposeVotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'opposeVotes');
    });
  }

  QueryBuilder<CrowdsourcedItem, String, QQueryOperations>
      payloadJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payloadJson');
    });
  }

  QueryBuilder<CrowdsourcedItem, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<CrowdsourcedItem, int, QQueryOperations> supportVotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supportVotes');
    });
  }

  QueryBuilder<CrowdsourcedItem, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<CrowdsourcedItem, int, QQueryOperations>
      verifiedOwnerCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verifiedOwnerCount');
    });
  }
}
