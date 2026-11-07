// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crowdsourced_vote.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetCrowdsourcedVoteCollection on Isar {
  IsarCollection<CrowdsourcedVote> get crowdsourcedVotes => this.collection();
}

const CrowdsourcedVoteSchema = CollectionSchema(
  name: r'CrowdsourcedVote',
  id: -555390180124665791,
  properties: {
    r'compositeKey': PropertySchema(
      id: 0,
      name: r'compositeKey',
      type: IsarType.string,
    ),
    r'deviceId': PropertySchema(
      id: 1,
      name: r'deviceId',
      type: IsarType.string,
    ),
    r'voteTime': PropertySchema(
      id: 2,
      name: r'voteTime',
      type: IsarType.dateTime,
    ),
    r'voteType': PropertySchema(
      id: 3,
      name: r'voteType',
      type: IsarType.string,
    )
  },
  estimateSize: _crowdsourcedVoteEstimateSize,
  serialize: _crowdsourcedVoteSerialize,
  deserialize: _crowdsourcedVoteDeserialize,
  deserializeProp: _crowdsourcedVoteDeserializeProp,
  idName: r'id',
  indexes: {
    r'compositeKey': IndexSchema(
      id: -66619599277560115,
      name: r'compositeKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'compositeKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'deviceId': IndexSchema(
      id: 4442814072367132509,
      name: r'deviceId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'deviceId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _crowdsourcedVoteGetId,
  getLinks: _crowdsourcedVoteGetLinks,
  attach: _crowdsourcedVoteAttach,
  version: '3.4.1',
);

int _crowdsourcedVoteEstimateSize(
  CrowdsourcedVote object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.compositeKey.length * 3;
  bytesCount += 3 + object.deviceId.length * 3;
  bytesCount += 3 + object.voteType.length * 3;
  return bytesCount;
}

void _crowdsourcedVoteSerialize(
  CrowdsourcedVote object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.compositeKey);
  writer.writeString(offsets[1], object.deviceId);
  writer.writeDateTime(offsets[2], object.voteTime);
  writer.writeString(offsets[3], object.voteType);
}

CrowdsourcedVote _crowdsourcedVoteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CrowdsourcedVote();
  object.compositeKey = reader.readString(offsets[0]);
  object.deviceId = reader.readString(offsets[1]);
  object.id = id;
  object.voteTime = reader.readDateTime(offsets[2]);
  object.voteType = reader.readString(offsets[3]);
  return object;
}

P _crowdsourcedVoteDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _crowdsourcedVoteGetId(CrowdsourcedVote object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _crowdsourcedVoteGetLinks(CrowdsourcedVote object) {
  return [];
}

void _crowdsourcedVoteAttach(
    IsarCollection<dynamic> col, Id id, CrowdsourcedVote object) {
  object.id = id;
}

extension CrowdsourcedVoteQueryWhereSort
    on QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QWhere> {
  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CrowdsourcedVoteQueryWhere
    on QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QWhereClause> {
  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterWhereClause>
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

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterWhereClause> idBetween(
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

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterWhereClause>
      compositeKeyEqualTo(String compositeKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'compositeKey',
        value: [compositeKey],
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterWhereClause>
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

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterWhereClause>
      deviceIdEqualTo(String deviceId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'deviceId',
        value: [deviceId],
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterWhereClause>
      deviceIdNotEqualTo(String deviceId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deviceId',
              lower: [],
              upper: [deviceId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deviceId',
              lower: [deviceId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deviceId',
              lower: [deviceId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deviceId',
              lower: [],
              upper: [deviceId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CrowdsourcedVoteQueryFilter
    on QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QFilterCondition> {
  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
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

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
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

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
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

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
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

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
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

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
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

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      compositeKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'compositeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      compositeKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'compositeKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      compositeKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'compositeKey',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      compositeKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'compositeKey',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      deviceIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      deviceIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      deviceIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      deviceIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deviceId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      deviceIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      deviceIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      deviceIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      deviceIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deviceId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      deviceIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceId',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      deviceIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deviceId',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
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

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
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

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
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

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      voteTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voteTime',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      voteTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'voteTime',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      voteTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'voteTime',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      voteTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'voteTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      voteTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voteType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      voteTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'voteType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      voteTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'voteType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      voteTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'voteType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      voteTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'voteType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      voteTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'voteType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      voteTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'voteType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      voteTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'voteType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      voteTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voteType',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterFilterCondition>
      voteTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'voteType',
        value: '',
      ));
    });
  }
}

extension CrowdsourcedVoteQueryObject
    on QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QFilterCondition> {}

extension CrowdsourcedVoteQueryLinks
    on QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QFilterCondition> {}

extension CrowdsourcedVoteQuerySortBy
    on QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QSortBy> {
  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      sortByCompositeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compositeKey', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      sortByCompositeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compositeKey', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      sortByDeviceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceId', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      sortByDeviceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceId', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      sortByVoteTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteTime', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      sortByVoteTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteTime', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      sortByVoteType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteType', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      sortByVoteTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteType', Sort.desc);
    });
  }
}

extension CrowdsourcedVoteQuerySortThenBy
    on QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QSortThenBy> {
  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      thenByCompositeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compositeKey', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      thenByCompositeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compositeKey', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      thenByDeviceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceId', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      thenByDeviceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceId', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      thenByVoteTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteTime', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      thenByVoteTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteTime', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      thenByVoteType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteType', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QAfterSortBy>
      thenByVoteTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteType', Sort.desc);
    });
  }
}

extension CrowdsourcedVoteQueryWhereDistinct
    on QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QDistinct> {
  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QDistinct>
      distinctByCompositeKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'compositeKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QDistinct>
      distinctByDeviceId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deviceId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QDistinct>
      distinctByVoteTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'voteTime');
    });
  }

  QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QDistinct>
      distinctByVoteType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'voteType', caseSensitive: caseSensitive);
    });
  }
}

extension CrowdsourcedVoteQueryProperty
    on QueryBuilder<CrowdsourcedVote, CrowdsourcedVote, QQueryProperty> {
  QueryBuilder<CrowdsourcedVote, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CrowdsourcedVote, String, QQueryOperations>
      compositeKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'compositeKey');
    });
  }

  QueryBuilder<CrowdsourcedVote, String, QQueryOperations> deviceIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deviceId');
    });
  }

  QueryBuilder<CrowdsourcedVote, DateTime, QQueryOperations>
      voteTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'voteTime');
    });
  }

  QueryBuilder<CrowdsourcedVote, String, QQueryOperations> voteTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'voteType');
    });
  }
}
