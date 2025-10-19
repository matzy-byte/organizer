// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'var_transaction_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVarTransactionIsarCollection on Isar {
  IsarCollection<VarTransactionIsar> get varTransactionIsars =>
      this.collection();
}

const VarTransactionIsarSchema = CollectionSchema(
  name: r'VarTransactionIsar',
  id: -5677839320296670666,
  properties: {
    r'compensations': PropertySchema(
      id: 0,
      name: r'compensations',
      type: IsarType.string,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 3,
      name: r'type',
      type: IsarType.byte,
      enumMap: _VarTransactionIsartypeEnumValueMap,
    ),
    r'value': PropertySchema(
      id: 4,
      name: r'value',
      type: IsarType.long,
    )
  },
  estimateSize: _varTransactionIsarEstimateSize,
  serialize: _varTransactionIsarSerialize,
  deserialize: _varTransactionIsarDeserialize,
  deserializeProp: _varTransactionIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'topic': LinkSchema(
      id: 7655627648224622878,
      name: r'topic',
      target: r'TopicIsar',
      single: true,
    ),
    r'fixReference': LinkSchema(
      id: 2276115580417625812,
      name: r'fixReference',
      target: r'FixTransactionIsar',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _varTransactionIsarGetId,
  getLinks: _varTransactionIsarGetLinks,
  attach: _varTransactionIsarAttach,
  version: '3.1.0+1',
);

int _varTransactionIsarEstimateSize(
  VarTransactionIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.compensations;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _varTransactionIsarSerialize(
  VarTransactionIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.compensations);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeString(offsets[2], object.description);
  writer.writeByte(offsets[3], object.type.index);
  writer.writeLong(offsets[4], object.value);
}

VarTransactionIsar _varTransactionIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VarTransactionIsar();
  object.compensations = reader.readStringOrNull(offsets[0]);
  object.date = reader.readDateTime(offsets[1]);
  object.description = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.type =
      _VarTransactionIsartypeValueEnumMap[reader.readByteOrNull(offsets[3])] ??
          Polarity.negative;
  object.value = reader.readLong(offsets[4]);
  return object;
}

P _varTransactionIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (_VarTransactionIsartypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          Polarity.negative) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _VarTransactionIsartypeEnumValueMap = {
  'negative': 0,
  'positive': 1,
};
const _VarTransactionIsartypeValueEnumMap = {
  0: Polarity.negative,
  1: Polarity.positive,
};

Id _varTransactionIsarGetId(VarTransactionIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _varTransactionIsarGetLinks(
    VarTransactionIsar object) {
  return [object.topic, object.fixReference];
}

void _varTransactionIsarAttach(
    IsarCollection<dynamic> col, Id id, VarTransactionIsar object) {
  object.id = id;
  object.topic.attach(col, col.isar.collection<TopicIsar>(), r'topic', id);
  object.fixReference.attach(
      col, col.isar.collection<FixTransactionIsar>(), r'fixReference', id);
}

extension VarTransactionIsarQueryWhereSort
    on QueryBuilder<VarTransactionIsar, VarTransactionIsar, QWhere> {
  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VarTransactionIsarQueryWhere
    on QueryBuilder<VarTransactionIsar, VarTransactionIsar, QWhereClause> {
  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterWhereClause>
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

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterWhereClause>
      idBetween(
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
}

extension VarTransactionIsarQueryFilter
    on QueryBuilder<VarTransactionIsar, VarTransactionIsar, QFilterCondition> {
  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      compensationsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'compensations',
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      compensationsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'compensations',
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      compensationsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'compensations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      compensationsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'compensations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      compensationsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'compensations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      compensationsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'compensations',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      compensationsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'compensations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      compensationsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'compensations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      compensationsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'compensations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      compensationsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'compensations',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      compensationsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'compensations',
        value: '',
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      compensationsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'compensations',
        value: '',
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      typeEqualTo(Polarity value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      typeGreaterThan(
    Polarity value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      typeLessThan(
    Polarity value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      typeBetween(
    Polarity lower,
    Polarity upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      valueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      valueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      valueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
      ));
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      valueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VarTransactionIsarQueryObject
    on QueryBuilder<VarTransactionIsar, VarTransactionIsar, QFilterCondition> {}

extension VarTransactionIsarQueryLinks
    on QueryBuilder<VarTransactionIsar, VarTransactionIsar, QFilterCondition> {
  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      topic(FilterQuery<TopicIsar> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'topic');
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      topicIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'topic', 0, true, 0, true);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      fixReference(FilterQuery<FixTransactionIsar> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'fixReference');
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterFilterCondition>
      fixReferenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'fixReference', 0, true, 0, true);
    });
  }
}

extension VarTransactionIsarQuerySortBy
    on QueryBuilder<VarTransactionIsar, VarTransactionIsar, QSortBy> {
  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      sortByCompensations() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compensations', Sort.asc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      sortByCompensationsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compensations', Sort.desc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      sortByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      sortByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension VarTransactionIsarQuerySortThenBy
    on QueryBuilder<VarTransactionIsar, VarTransactionIsar, QSortThenBy> {
  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      thenByCompensations() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compensations', Sort.asc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      thenByCompensationsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compensations', Sort.desc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      thenByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QAfterSortBy>
      thenByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension VarTransactionIsarQueryWhereDistinct
    on QueryBuilder<VarTransactionIsar, VarTransactionIsar, QDistinct> {
  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QDistinct>
      distinctByCompensations({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'compensations',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QDistinct>
      distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QDistinct>
      distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<VarTransactionIsar, VarTransactionIsar, QDistinct>
      distinctByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'value');
    });
  }
}

extension VarTransactionIsarQueryProperty
    on QueryBuilder<VarTransactionIsar, VarTransactionIsar, QQueryProperty> {
  QueryBuilder<VarTransactionIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<VarTransactionIsar, String?, QQueryOperations>
      compensationsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'compensations');
    });
  }

  QueryBuilder<VarTransactionIsar, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<VarTransactionIsar, String?, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<VarTransactionIsar, Polarity, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<VarTransactionIsar, int, QQueryOperations> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'value');
    });
  }
}
