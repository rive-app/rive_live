// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animations_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAnimationDataCollection on Isar {
  IsarCollection<AnimationData> get animationDatas => this.collection();
}

const AnimationDataSchema = CollectionSchema(
  name: r'AnimationData',
  id: -7284646695725293840,
  properties: {
    r'artboard': PropertySchema(
      id: 0,
      name: r'artboard',
      type: IsarType.string,
    ),
    r'hashCode': PropertySchema(
      id: 1,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'path': PropertySchema(
      id: 2,
      name: r'path',
      type: IsarType.string,
    ),
    r'stateMachine': PropertySchema(
      id: 3,
      name: r'stateMachine',
      type: IsarType.string,
    ),
    r'trigger': PropertySchema(
      id: 4,
      name: r'trigger',
      type: IsarType.string,
    )
  },
  estimateSize: _animationDataEstimateSize,
  serialize: _animationDataSerialize,
  deserialize: _animationDataDeserialize,
  deserializeProp: _animationDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _animationDataGetId,
  getLinks: _animationDataGetLinks,
  attach: _animationDataAttach,
  version: '3.1.0+1',
);

int _animationDataEstimateSize(
  AnimationData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.artboard;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.path;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.stateMachine;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.trigger;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _animationDataSerialize(
  AnimationData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.artboard);
  writer.writeLong(offsets[1], object.hashCode);
  writer.writeString(offsets[2], object.path);
  writer.writeString(offsets[3], object.stateMachine);
  writer.writeString(offsets[4], object.trigger);
}

AnimationData _animationDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AnimationData();
  object.artboard = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.path = reader.readStringOrNull(offsets[2]);
  object.stateMachine = reader.readStringOrNull(offsets[3]);
  object.trigger = reader.readStringOrNull(offsets[4]);
  return object;
}

P _animationDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _animationDataGetId(AnimationData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _animationDataGetLinks(AnimationData object) {
  return [];
}

void _animationDataAttach(
    IsarCollection<dynamic> col, Id id, AnimationData object) {
  object.id = id;
}

extension AnimationDataQueryWhereSort
    on QueryBuilder<AnimationData, AnimationData, QWhere> {
  QueryBuilder<AnimationData, AnimationData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AnimationDataQueryWhere
    on QueryBuilder<AnimationData, AnimationData, QWhereClause> {
  QueryBuilder<AnimationData, AnimationData, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<AnimationData, AnimationData, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterWhereClause> idBetween(
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

extension AnimationDataQueryFilter
    on QueryBuilder<AnimationData, AnimationData, QFilterCondition> {
  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      artboardIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'artboard',
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      artboardIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'artboard',
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      artboardEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artboard',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      artboardGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'artboard',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      artboardLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'artboard',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      artboardBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'artboard',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      artboardStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'artboard',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      artboardEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'artboard',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      artboardContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'artboard',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      artboardMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'artboard',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      artboardIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artboard',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      artboardIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'artboard',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
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

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition> idBetween(
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

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      pathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'path',
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      pathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'path',
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition> pathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      pathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      pathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition> pathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      pathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      pathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      pathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition> pathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      pathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      pathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      stateMachineIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stateMachine',
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      stateMachineIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stateMachine',
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      stateMachineEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stateMachine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      stateMachineGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stateMachine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      stateMachineLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stateMachine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      stateMachineBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stateMachine',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      stateMachineStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stateMachine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      stateMachineEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stateMachine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      stateMachineContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stateMachine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      stateMachineMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stateMachine',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      stateMachineIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stateMachine',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      stateMachineIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stateMachine',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      triggerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trigger',
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      triggerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trigger',
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      triggerEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trigger',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      triggerGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trigger',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      triggerLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trigger',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      triggerBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trigger',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      triggerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'trigger',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      triggerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'trigger',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      triggerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trigger',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      triggerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trigger',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      triggerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trigger',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterFilterCondition>
      triggerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trigger',
        value: '',
      ));
    });
  }
}

extension AnimationDataQueryObject
    on QueryBuilder<AnimationData, AnimationData, QFilterCondition> {}

extension AnimationDataQueryLinks
    on QueryBuilder<AnimationData, AnimationData, QFilterCondition> {}

extension AnimationDataQuerySortBy
    on QueryBuilder<AnimationData, AnimationData, QSortBy> {
  QueryBuilder<AnimationData, AnimationData, QAfterSortBy> sortByArtboard() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artboard', Sort.asc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy>
      sortByArtboardDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artboard', Sort.desc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy> sortByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy> sortByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy>
      sortByStateMachine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stateMachine', Sort.asc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy>
      sortByStateMachineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stateMachine', Sort.desc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy> sortByTrigger() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trigger', Sort.asc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy> sortByTriggerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trigger', Sort.desc);
    });
  }
}

extension AnimationDataQuerySortThenBy
    on QueryBuilder<AnimationData, AnimationData, QSortThenBy> {
  QueryBuilder<AnimationData, AnimationData, QAfterSortBy> thenByArtboard() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artboard', Sort.asc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy>
      thenByArtboardDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artboard', Sort.desc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy> thenByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy> thenByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy>
      thenByStateMachine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stateMachine', Sort.asc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy>
      thenByStateMachineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stateMachine', Sort.desc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy> thenByTrigger() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trigger', Sort.asc);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QAfterSortBy> thenByTriggerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trigger', Sort.desc);
    });
  }
}

extension AnimationDataQueryWhereDistinct
    on QueryBuilder<AnimationData, AnimationData, QDistinct> {
  QueryBuilder<AnimationData, AnimationData, QDistinct> distinctByArtboard(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'artboard', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<AnimationData, AnimationData, QDistinct> distinctByPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'path', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QDistinct> distinctByStateMachine(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stateMachine', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimationData, AnimationData, QDistinct> distinctByTrigger(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trigger', caseSensitive: caseSensitive);
    });
  }
}

extension AnimationDataQueryProperty
    on QueryBuilder<AnimationData, AnimationData, QQueryProperty> {
  QueryBuilder<AnimationData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AnimationData, String?, QQueryOperations> artboardProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artboard');
    });
  }

  QueryBuilder<AnimationData, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<AnimationData, String?, QQueryOperations> pathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'path');
    });
  }

  QueryBuilder<AnimationData, String?, QQueryOperations>
      stateMachineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stateMachine');
    });
  }

  QueryBuilder<AnimationData, String?, QQueryOperations> triggerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trigger');
    });
  }
}
