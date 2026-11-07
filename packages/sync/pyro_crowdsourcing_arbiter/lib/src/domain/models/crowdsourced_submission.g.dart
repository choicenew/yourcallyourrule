// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crowdsourced_submission.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetCrowdsourcedSubmissionCollection on Isar {
  IsarCollection<CrowdsourcedSubmission> get crowdsourcedSubmissions =>
      this.collection();
}

const CrowdsourcedSubmissionSchema = CollectionSchema(
  name: r'CrowdsourcedSubmission',
  id: 4566550394100184039,
  properties: {
    r'domain': PropertySchema(
      id: 0,
      name: r'domain',
      type: IsarType.string,
    ),
    r'entityKey': PropertySchema(
      id: 1,
      name: r'entityKey',
      type: IsarType.string,
    ),
    r'proposerDeviceId': PropertySchema(
      id: 2,
      name: r'proposerDeviceId',
      type: IsarType.string,
    ),
    r'submissionTime': PropertySchema(
      id: 3,
      name: r'submissionTime',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _crowdsourcedSubmissionEstimateSize,
  serialize: _crowdsourcedSubmissionSerialize,
  deserialize: _crowdsourcedSubmissionDeserialize,
  deserializeProp: _crowdsourcedSubmissionDeserializeProp,
  idName: r'id',
  indexes: {
    r'proposerDeviceId': IndexSchema(
      id: 6168781830413289419,
      name: r'proposerDeviceId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'proposerDeviceId',
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
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _crowdsourcedSubmissionGetId,
  getLinks: _crowdsourcedSubmissionGetLinks,
  attach: _crowdsourcedSubmissionAttach,
  version: '3.4.1',
);

int _crowdsourcedSubmissionEstimateSize(
  CrowdsourcedSubmission object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.domain.length * 3;
  bytesCount += 3 + object.entityKey.length * 3;
  bytesCount += 3 + object.proposerDeviceId.length * 3;
  return bytesCount;
}

void _crowdsourcedSubmissionSerialize(
  CrowdsourcedSubmission object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.domain);
  writer.writeString(offsets[1], object.entityKey);
  writer.writeString(offsets[2], object.proposerDeviceId);
  writer.writeDateTime(offsets[3], object.submissionTime);
}

CrowdsourcedSubmission _crowdsourcedSubmissionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CrowdsourcedSubmission();
  object.domain = reader.readString(offsets[0]);
  object.entityKey = reader.readString(offsets[1]);
  object.id = id;
  object.proposerDeviceId = reader.readString(offsets[2]);
  object.submissionTime = reader.readDateTime(offsets[3]);
  return object;
}

P _crowdsourcedSubmissionDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _crowdsourcedSubmissionGetId(CrowdsourcedSubmission object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _crowdsourcedSubmissionGetLinks(
    CrowdsourcedSubmission object) {
  return [];
}

void _crowdsourcedSubmissionAttach(
    IsarCollection<dynamic> col, Id id, CrowdsourcedSubmission object) {
  object.id = id;
}

extension CrowdsourcedSubmissionQueryWhereSort
    on QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QWhere> {
  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CrowdsourcedSubmissionQueryWhere on QueryBuilder<
    CrowdsourcedSubmission, CrowdsourcedSubmission, QWhereClause> {
  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterWhereClause> idBetween(
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterWhereClause> proposerDeviceIdEqualTo(String proposerDeviceId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'proposerDeviceId',
        value: [proposerDeviceId],
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterWhereClause> proposerDeviceIdNotEqualTo(String proposerDeviceId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'proposerDeviceId',
              lower: [],
              upper: [proposerDeviceId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'proposerDeviceId',
              lower: [proposerDeviceId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'proposerDeviceId',
              lower: [proposerDeviceId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'proposerDeviceId',
              lower: [],
              upper: [proposerDeviceId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterWhereClause> domainEqualTo(String domain) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'domain',
        value: [domain],
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterWhereClause> domainNotEqualTo(String domain) {
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterWhereClause> entityKeyEqualTo(String entityKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'entityKey',
        value: [entityKey],
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterWhereClause> entityKeyNotEqualTo(String entityKey) {
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
}

extension CrowdsourcedSubmissionQueryFilter on QueryBuilder<
    CrowdsourcedSubmission, CrowdsourcedSubmission, QFilterCondition> {
  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> domainEqualTo(
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> domainGreaterThan(
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> domainLessThan(
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> domainBetween(
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> domainStartsWith(
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> domainEndsWith(
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
          QAfterFilterCondition>
      domainContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'domain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
          QAfterFilterCondition>
      domainMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'domain',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> domainIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'domain',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> domainIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'domain',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> entityKeyEqualTo(
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> entityKeyGreaterThan(
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> entityKeyLessThan(
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> entityKeyBetween(
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> entityKeyStartsWith(
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> entityKeyEndsWith(
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
          QAfterFilterCondition>
      entityKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entityKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
          QAfterFilterCondition>
      entityKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entityKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> entityKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entityKey',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> entityKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entityKey',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> proposerDeviceIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proposerDeviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> proposerDeviceIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proposerDeviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> proposerDeviceIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proposerDeviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> proposerDeviceIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proposerDeviceId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> proposerDeviceIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'proposerDeviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> proposerDeviceIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'proposerDeviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
          QAfterFilterCondition>
      proposerDeviceIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'proposerDeviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
          QAfterFilterCondition>
      proposerDeviceIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'proposerDeviceId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> proposerDeviceIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proposerDeviceId',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> proposerDeviceIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'proposerDeviceId',
        value: '',
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> submissionTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'submissionTime',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> submissionTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'submissionTime',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> submissionTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'submissionTime',
        value: value,
      ));
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission,
      QAfterFilterCondition> submissionTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'submissionTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CrowdsourcedSubmissionQueryObject on QueryBuilder<
    CrowdsourcedSubmission, CrowdsourcedSubmission, QFilterCondition> {}

extension CrowdsourcedSubmissionQueryLinks on QueryBuilder<
    CrowdsourcedSubmission, CrowdsourcedSubmission, QFilterCondition> {}

extension CrowdsourcedSubmissionQuerySortBy
    on QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QSortBy> {
  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      sortByDomain() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domain', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      sortByDomainDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domain', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      sortByEntityKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityKey', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      sortByEntityKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityKey', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      sortByProposerDeviceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proposerDeviceId', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      sortByProposerDeviceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proposerDeviceId', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      sortBySubmissionTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'submissionTime', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      sortBySubmissionTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'submissionTime', Sort.desc);
    });
  }
}

extension CrowdsourcedSubmissionQuerySortThenBy on QueryBuilder<
    CrowdsourcedSubmission, CrowdsourcedSubmission, QSortThenBy> {
  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      thenByDomain() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domain', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      thenByDomainDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'domain', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      thenByEntityKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityKey', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      thenByEntityKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityKey', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      thenByProposerDeviceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proposerDeviceId', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      thenByProposerDeviceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proposerDeviceId', Sort.desc);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      thenBySubmissionTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'submissionTime', Sort.asc);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QAfterSortBy>
      thenBySubmissionTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'submissionTime', Sort.desc);
    });
  }
}

extension CrowdsourcedSubmissionQueryWhereDistinct
    on QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QDistinct> {
  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QDistinct>
      distinctByDomain({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'domain', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QDistinct>
      distinctByEntityKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entityKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QDistinct>
      distinctByProposerDeviceId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proposerDeviceId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CrowdsourcedSubmission, CrowdsourcedSubmission, QDistinct>
      distinctBySubmissionTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'submissionTime');
    });
  }
}

extension CrowdsourcedSubmissionQueryProperty on QueryBuilder<
    CrowdsourcedSubmission, CrowdsourcedSubmission, QQueryProperty> {
  QueryBuilder<CrowdsourcedSubmission, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CrowdsourcedSubmission, String, QQueryOperations>
      domainProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'domain');
    });
  }

  QueryBuilder<CrowdsourcedSubmission, String, QQueryOperations>
      entityKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entityKey');
    });
  }

  QueryBuilder<CrowdsourcedSubmission, String, QQueryOperations>
      proposerDeviceIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proposerDeviceId');
    });
  }

  QueryBuilder<CrowdsourcedSubmission, DateTime, QQueryOperations>
      submissionTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'submissionTime');
    });
  }
}
