// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fix_transaction_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFixTransactionIsarCollection on Isar {
  IsarCollection<FixTransactionIsar> get fixTransactionIsars =>
      this.collection();
}

const FixTransactionIsarSchema = CollectionSchema(
  name: r'FixTransactionIsar',
  id: -3665471538458201247,
  properties: {
    r'compensation': PropertySchema(
      id: 0,
      name: r'compensation',
      type: IsarType.byte,
      enumMap: _FixTransactionIsarcompensationEnumValueMap,
    ),
    r'description': PropertySchema(
      id: 1,
      name: r'description',
      type: IsarType.string,
    ),
    r'end': PropertySchema(
      id: 2,
      name: r'end',
      type: IsarType.dateTime,
    ),
    r'intervalCount': PropertySchema(
      id: 3,
      name: r'intervalCount',
      type: IsarType.long,
    ),
    r'intervalUnit': PropertySchema(
      id: 4,
      name: r'intervalUnit',
      type: IsarType.byte,
      enumMap: _FixTransactionIsarintervalUnitEnumValueMap,
    ),
    r'start': PropertySchema(
      id: 5,
      name: r'start',
      type: IsarType.dateTime,
    ),
    r'status': PropertySchema(
      id: 6,
      name: r'status',
      type: IsarType.byte,
      enumMap: _FixTransactionIsarstatusEnumValueMap,
    ),
    r'type': PropertySchema(
      id: 7,
      name: r'type',
      type: IsarType.byte,
      enumMap: _FixTransactionIsartypeEnumValueMap,
    ),
    r'value': PropertySchema(
      id: 8,
      name: r'value',
      type: IsarType.long,
    )
  },
  estimateSize: _fixTransactionIsarEstimateSize,
  serialize: _fixTransactionIsarSerialize,
  deserialize: _fixTransactionIsarDeserialize,
  deserializeProp: _fixTransactionIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'topic': LinkSchema(
      id: 325062957457514571,
      name: r'topic',
      target: r'TopicIsar',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _fixTransactionIsarGetId,
  getLinks: _fixTransactionIsarGetLinks,
  attach: _fixTransactionIsarAttach,
  version: '3.1.0+1',
);

int _fixTransactionIsarEstimateSize(
  FixTransactionIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _fixTransactionIsarSerialize(
  FixTransactionIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.compensation.index);
  writer.writeString(offsets[1], object.description);
  writer.writeDateTime(offsets[2], object.end);
  writer.writeLong(offsets[3], object.intervalCount);
  writer.writeByte(offsets[4], object.intervalUnit.index);
  writer.writeDateTime(offsets[5], object.start);
  writer.writeByte(offsets[6], object.status.index);
  writer.writeByte(offsets[7], object.type.index);
  writer.writeLong(offsets[8], object.value);
}

FixTransactionIsar _fixTransactionIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FixTransactionIsar();
  object.compensation = _FixTransactionIsarcompensationValueEnumMap[
          reader.readByteOrNull(offsets[0])] ??
      Compensation.none;
  object.description = reader.readStringOrNull(offsets[1]);
  object.end = reader.readDateTime(offsets[2]);
  object.id = id;
  object.intervalCount = reader.readLong(offsets[3]);
  object.intervalUnit = _FixTransactionIsarintervalUnitValueEnumMap[
          reader.readByteOrNull(offsets[4])] ??
      IntervalUnit.day;
  object.start = reader.readDateTime(offsets[5]);
  object.status = _FixTransactionIsarstatusValueEnumMap[
          reader.readByteOrNull(offsets[6])] ??
      Status.active;
  object.type =
      _FixTransactionIsartypeValueEnumMap[reader.readByteOrNull(offsets[7])] ??
          Polarity.negative;
  object.value = reader.readLong(offsets[8]);
  return object;
}

P _fixTransactionIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_FixTransactionIsarcompensationValueEnumMap[
              reader.readByteOrNull(offset)] ??
          Compensation.none) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (_FixTransactionIsarintervalUnitValueEnumMap[
              reader.readByteOrNull(offset)] ??
          IntervalUnit.day) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (_FixTransactionIsarstatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          Status.active) as P;
    case 7:
      return (_FixTransactionIsartypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          Polarity.negative) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FixTransactionIsarcompensationEnumValueMap = {
  'none': 0,
  'living': 1,
  'groceries': 2,
  'transportation': 3,
};
const _FixTransactionIsarcompensationValueEnumMap = {
  0: Compensation.none,
  1: Compensation.living,
  2: Compensation.groceries,
  3: Compensation.transportation,
};
const _FixTransactionIsarintervalUnitEnumValueMap = {
  'day': 0,
  'week': 1,
  'month': 2,
  'year': 3,
  'decade': 4,
};
const _FixTransactionIsarintervalUnitValueEnumMap = {
  0: IntervalUnit.day,
  1: IntervalUnit.week,
  2: IntervalUnit.month,
  3: IntervalUnit.year,
  4: IntervalUnit.decade,
};
const _FixTransactionIsarstatusEnumValueMap = {
  'active': 0,
  'inactive': 1,
};
const _FixTransactionIsarstatusValueEnumMap = {
  0: Status.active,
  1: Status.inactive,
};
const _FixTransactionIsartypeEnumValueMap = {
  'negative': 0,
  'positive': 1,
};
const _FixTransactionIsartypeValueEnumMap = {
  0: Polarity.negative,
  1: Polarity.positive,
};

Id _fixTransactionIsarGetId(FixTransactionIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _fixTransactionIsarGetLinks(
    FixTransactionIsar object) {
  return [object.topic];
}

void _fixTransactionIsarAttach(
    IsarCollection<dynamic> col, Id id, FixTransactionIsar object) {
  object.id = id;
  object.topic.attach(col, col.isar.collection<TopicIsar>(), r'topic', id);
}

extension FixTransactionIsarQueryWhereSort
    on QueryBuilder<FixTransactionIsar, FixTransactionIsar, QWhere> {
  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FixTransactionIsarQueryWhere
    on QueryBuilder<FixTransactionIsar, FixTransactionIsar, QWhereClause> {
  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterWhereClause>
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

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterWhereClause>
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

extension FixTransactionIsarQueryFilter
    on QueryBuilder<FixTransactionIsar, FixTransactionIsar, QFilterCondition> {
  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      compensationEqualTo(Compensation value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'compensation',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      compensationGreaterThan(
    Compensation value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'compensation',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      compensationLessThan(
    Compensation value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'compensation',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      compensationBetween(
    Compensation lower,
    Compensation upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'compensation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      endEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'end',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      endGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'end',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      endLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'end',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      endBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'end',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      intervalCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'intervalCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      intervalCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'intervalCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      intervalCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'intervalCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      intervalCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'intervalCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      intervalUnitEqualTo(IntervalUnit value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'intervalUnit',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      intervalUnitGreaterThan(
    IntervalUnit value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'intervalUnit',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      intervalUnitLessThan(
    IntervalUnit value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'intervalUnit',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      intervalUnitBetween(
    IntervalUnit lower,
    IntervalUnit upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'intervalUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      startEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'start',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      startGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'start',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      startLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'start',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      startBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'start',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      statusEqualTo(Status value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      statusGreaterThan(
    Status value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      statusLessThan(
    Status value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      statusBetween(
    Status lower,
    Status upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      typeEqualTo(Polarity value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      valueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
      ));
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
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

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
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

extension FixTransactionIsarQueryObject
    on QueryBuilder<FixTransactionIsar, FixTransactionIsar, QFilterCondition> {}

extension FixTransactionIsarQueryLinks
    on QueryBuilder<FixTransactionIsar, FixTransactionIsar, QFilterCondition> {
  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      topic(FilterQuery<TopicIsar> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'topic');
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterFilterCondition>
      topicIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'topic', 0, true, 0, true);
    });
  }
}

extension FixTransactionIsarQuerySortBy
    on QueryBuilder<FixTransactionIsar, FixTransactionIsar, QSortBy> {
  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByCompensation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compensation', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByCompensationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compensation', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'end', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'end', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByIntervalCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalCount', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByIntervalCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalCount', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByIntervalUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalUnit', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByIntervalUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalUnit', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      sortByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension FixTransactionIsarQuerySortThenBy
    on QueryBuilder<FixTransactionIsar, FixTransactionIsar, QSortThenBy> {
  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByCompensation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compensation', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByCompensationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'compensation', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'end', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'end', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByIntervalCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalCount', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByIntervalCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalCount', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByIntervalUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalUnit', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByIntervalUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalUnit', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QAfterSortBy>
      thenByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension FixTransactionIsarQueryWhereDistinct
    on QueryBuilder<FixTransactionIsar, FixTransactionIsar, QDistinct> {
  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QDistinct>
      distinctByCompensation() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'compensation');
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QDistinct>
      distinctByEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'end');
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QDistinct>
      distinctByIntervalCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'intervalCount');
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QDistinct>
      distinctByIntervalUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'intervalUnit');
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QDistinct>
      distinctByStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'start');
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QDistinct>
      distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QDistinct>
      distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<FixTransactionIsar, FixTransactionIsar, QDistinct>
      distinctByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'value');
    });
  }
}

extension FixTransactionIsarQueryProperty
    on QueryBuilder<FixTransactionIsar, FixTransactionIsar, QQueryProperty> {
  QueryBuilder<FixTransactionIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FixTransactionIsar, Compensation, QQueryOperations>
      compensationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'compensation');
    });
  }

  QueryBuilder<FixTransactionIsar, String?, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<FixTransactionIsar, DateTime, QQueryOperations> endProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'end');
    });
  }

  QueryBuilder<FixTransactionIsar, int, QQueryOperations>
      intervalCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'intervalCount');
    });
  }

  QueryBuilder<FixTransactionIsar, IntervalUnit, QQueryOperations>
      intervalUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'intervalUnit');
    });
  }

  QueryBuilder<FixTransactionIsar, DateTime, QQueryOperations> startProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'start');
    });
  }

  QueryBuilder<FixTransactionIsar, Status, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<FixTransactionIsar, Polarity, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<FixTransactionIsar, int, QQueryOperations> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'value');
    });
  }
}
