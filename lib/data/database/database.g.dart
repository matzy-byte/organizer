// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
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
  @override
  List<GeneratedColumn> get $columns => [id, name, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
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
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final String? description;
  const Category({required this.id, required this.name, this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
    };
  }

  Category copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $TopicsTable extends Topics with TableInfo<$TopicsTable, Topic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
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
  @override
  List<GeneratedColumn> get $columns => [id, categoryId, name, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topics';
  @override
  VerificationContext validateIntegrity(
    Insertable<Topic> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Topic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Topic(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $TopicsTable createAlias(String alias) {
    return $TopicsTable(attachedDatabase, alias);
  }
}

class Topic extends DataClass implements Insertable<Topic> {
  final int id;
  final int categoryId;
  final String name;
  final String? description;
  const Topic({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  TopicsCompanion toCompanion(bool nullToAbsent) {
    return TopicsCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Topic.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Topic(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
    };
  }

  Topic copyWith({
    int? id,
    int? categoryId,
    String? name,
    Value<String?> description = const Value.absent(),
  }) => Topic(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
  );
  Topic copyWithCompanion(TopicsCompanion data) {
    return Topic(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Topic(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, categoryId, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Topic &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.name == this.name &&
          other.description == this.description);
}

class TopicsCompanion extends UpdateCompanion<Topic> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<String> name;
  final Value<String?> description;
  const TopicsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  TopicsCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required String name,
    this.description = const Value.absent(),
  }) : categoryId = Value(categoryId),
       name = Value(name);
  static Insertable<Topic> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? name,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    });
  }

  TopicsCompanion copyWith({
    Value<int>? id,
    Value<int>? categoryId,
    Value<String>? name,
    Value<String?>? description,
  }) {
    return TopicsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, color];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
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
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final String color;
  const User({required this.id, required this.name, required this.color});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['color'] = Variable<String>(color);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      color: Value(color),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String>(color),
    };
  }

  User copyWith({int? id, String? name, String? color}) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    color: color ?? this.color,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> color;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String color,
  }) : name = Value(name),
       color = Value(color);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? color,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? color,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

class $TransactionLabelsTable extends TransactionLabels
    with TableInfo<$TransactionLabelsTable, TransactionLabel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionLabelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, color];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_labels';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionLabel> instance, {
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
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionLabel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionLabel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      )!,
    );
  }

  @override
  $TransactionLabelsTable createAlias(String alias) {
    return $TransactionLabelsTable(attachedDatabase, alias);
  }
}

class TransactionLabel extends DataClass
    implements Insertable<TransactionLabel> {
  final int id;
  final String name;
  final String color;
  const TransactionLabel({
    required this.id,
    required this.name,
    required this.color,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['color'] = Variable<String>(color);
    return map;
  }

  TransactionLabelsCompanion toCompanion(bool nullToAbsent) {
    return TransactionLabelsCompanion(
      id: Value(id),
      name: Value(name),
      color: Value(color),
    );
  }

  factory TransactionLabel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionLabel(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String>(color),
    };
  }

  TransactionLabel copyWith({int? id, String? name, String? color}) =>
      TransactionLabel(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
      );
  TransactionLabel copyWithCompanion(TransactionLabelsCompanion data) {
    return TransactionLabel(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionLabel(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionLabel &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color);
}

class TransactionLabelsCompanion extends UpdateCompanion<TransactionLabel> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> color;
  const TransactionLabelsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
  });
  TransactionLabelsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String color,
  }) : name = Value(name),
       color = Value(color);
  static Insertable<TransactionLabel> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? color,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
    });
  }

  TransactionLabelsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? color,
  }) {
    return TransactionLabelsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionLabelsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

class $FilesTable extends Files with TableInfo<$FilesTable, File> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, path];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'files';
  @override
  VerificationContext validateIntegrity(
    Insertable<File> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  File map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return File(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      path: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path'],
      )!,
    );
  }

  @override
  $FilesTable createAlias(String alias) {
    return $FilesTable(attachedDatabase, alias);
  }
}

class File extends DataClass implements Insertable<File> {
  final int id;
  final String path;
  const File({required this.id, required this.path});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['path'] = Variable<String>(path);
    return map;
  }

  FilesCompanion toCompanion(bool nullToAbsent) {
    return FilesCompanion(id: Value(id), path: Value(path));
  }

  factory File.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return File(
      id: serializer.fromJson<int>(json['id']),
      path: serializer.fromJson<String>(json['path']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'path': serializer.toJson<String>(path),
    };
  }

  File copyWith({int? id, String? path}) =>
      File(id: id ?? this.id, path: path ?? this.path);
  File copyWithCompanion(FilesCompanion data) {
    return File(
      id: data.id.present ? data.id.value : this.id,
      path: data.path.present ? data.path.value : this.path,
    );
  }

  @override
  String toString() {
    return (StringBuffer('File(')
          ..write('id: $id, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, path);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is File && other.id == this.id && other.path == this.path);
}

class FilesCompanion extends UpdateCompanion<File> {
  final Value<int> id;
  final Value<String> path;
  const FilesCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
  });
  FilesCompanion.insert({this.id = const Value.absent(), required String path})
    : path = Value(path);
  static Insertable<File> custom({
    Expression<int>? id,
    Expression<String>? path,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (path != null) 'path': path,
    });
  }

  FilesCompanion copyWith({Value<int>? id, Value<String>? path}) {
    return FilesCompanion(id: id ?? this.id, path: path ?? this.path);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FilesCompanion(')
          ..write('id: $id, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }
}

class $VarTransactionsTable extends VarTransactions
    with TableInfo<$VarTransactionsTable, VarTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VarTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<int> topicId = GeneratedColumn<int>(
    'topic_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topics (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int> value = GeneratedColumn<int>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userRefIdMeta = const VerificationMeta(
    'userRefId',
  );
  @override
  late final GeneratedColumn<int> userRefId = GeneratedColumn<int>(
    'user_ref_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _compensationsMeta = const VerificationMeta(
    'compensations',
  );
  @override
  late final GeneratedColumn<String> compensations = GeneratedColumn<String>(
    'compensations',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transactionLabelIdMeta =
      const VerificationMeta('transactionLabelId');
  @override
  late final GeneratedColumn<int> transactionLabelId = GeneratedColumn<int>(
    'transaction_label_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES transaction_labels (id) ON DELETE SET NULL',
    ),
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
  static const VerificationMeta _fixRefIdMeta = const VerificationMeta(
    'fixRefId',
  );
  @override
  late final GeneratedColumn<int> fixRefId = GeneratedColumn<int>(
    'fix_ref_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _varRefIdMeta = const VerificationMeta(
    'varRefId',
  );
  @override
  late final GeneratedColumn<int> varRefId = GeneratedColumn<int>(
    'var_ref_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES var_transactions (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _fileRefIdMeta = const VerificationMeta(
    'fileRefId',
  );
  @override
  late final GeneratedColumn<int> fileRefId = GeneratedColumn<int>(
    'file_ref_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES files (id) ON DELETE SET NULL',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    topicId,
    date,
    value,
    userRefId,
    compensations,
    transactionLabelId,
    description,
    fixRefId,
    varRefId,
    fileRefId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'var_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<VarTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('user_ref_id')) {
      context.handle(
        _userRefIdMeta,
        userRefId.isAcceptableOrUnknown(data['user_ref_id']!, _userRefIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userRefIdMeta);
    }
    if (data.containsKey('compensations')) {
      context.handle(
        _compensationsMeta,
        compensations.isAcceptableOrUnknown(
          data['compensations']!,
          _compensationsMeta,
        ),
      );
    }
    if (data.containsKey('transaction_label_id')) {
      context.handle(
        _transactionLabelIdMeta,
        transactionLabelId.isAcceptableOrUnknown(
          data['transaction_label_id']!,
          _transactionLabelIdMeta,
        ),
      );
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
    if (data.containsKey('fix_ref_id')) {
      context.handle(
        _fixRefIdMeta,
        fixRefId.isAcceptableOrUnknown(data['fix_ref_id']!, _fixRefIdMeta),
      );
    }
    if (data.containsKey('var_ref_id')) {
      context.handle(
        _varRefIdMeta,
        varRefId.isAcceptableOrUnknown(data['var_ref_id']!, _varRefIdMeta),
      );
    }
    if (data.containsKey('file_ref_id')) {
      context.handle(
        _fileRefIdMeta,
        fileRefId.isAcceptableOrUnknown(data['file_ref_id']!, _fileRefIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VarTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VarTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}topic_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}value'],
      )!,
      userRefId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_ref_id'],
      )!,
      compensations: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}compensations'],
      ),
      transactionLabelId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_label_id'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      fixRefId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fix_ref_id'],
      ),
      varRefId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}var_ref_id'],
      ),
      fileRefId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_ref_id'],
      ),
    );
  }

  @override
  $VarTransactionsTable createAlias(String alias) {
    return $VarTransactionsTable(attachedDatabase, alias);
  }
}

class VarTransaction extends DataClass implements Insertable<VarTransaction> {
  final int id;
  final int topicId;
  final DateTime date;
  final int value;
  final int userRefId;
  final String? compensations;
  final int? transactionLabelId;
  final String? description;
  final int? fixRefId;
  final int? varRefId;
  final int? fileRefId;
  const VarTransaction({
    required this.id,
    required this.topicId,
    required this.date,
    required this.value,
    required this.userRefId,
    this.compensations,
    this.transactionLabelId,
    this.description,
    this.fixRefId,
    this.varRefId,
    this.fileRefId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['topic_id'] = Variable<int>(topicId);
    map['date'] = Variable<DateTime>(date);
    map['value'] = Variable<int>(value);
    map['user_ref_id'] = Variable<int>(userRefId);
    if (!nullToAbsent || compensations != null) {
      map['compensations'] = Variable<String>(compensations);
    }
    if (!nullToAbsent || transactionLabelId != null) {
      map['transaction_label_id'] = Variable<int>(transactionLabelId);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || fixRefId != null) {
      map['fix_ref_id'] = Variable<int>(fixRefId);
    }
    if (!nullToAbsent || varRefId != null) {
      map['var_ref_id'] = Variable<int>(varRefId);
    }
    if (!nullToAbsent || fileRefId != null) {
      map['file_ref_id'] = Variable<int>(fileRefId);
    }
    return map;
  }

  VarTransactionsCompanion toCompanion(bool nullToAbsent) {
    return VarTransactionsCompanion(
      id: Value(id),
      topicId: Value(topicId),
      date: Value(date),
      value: Value(value),
      userRefId: Value(userRefId),
      compensations: compensations == null && nullToAbsent
          ? const Value.absent()
          : Value(compensations),
      transactionLabelId: transactionLabelId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionLabelId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      fixRefId: fixRefId == null && nullToAbsent
          ? const Value.absent()
          : Value(fixRefId),
      varRefId: varRefId == null && nullToAbsent
          ? const Value.absent()
          : Value(varRefId),
      fileRefId: fileRefId == null && nullToAbsent
          ? const Value.absent()
          : Value(fileRefId),
    );
  }

  factory VarTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VarTransaction(
      id: serializer.fromJson<int>(json['id']),
      topicId: serializer.fromJson<int>(json['topicId']),
      date: serializer.fromJson<DateTime>(json['date']),
      value: serializer.fromJson<int>(json['value']),
      userRefId: serializer.fromJson<int>(json['userRefId']),
      compensations: serializer.fromJson<String?>(json['compensations']),
      transactionLabelId: serializer.fromJson<int?>(json['transactionLabelId']),
      description: serializer.fromJson<String?>(json['description']),
      fixRefId: serializer.fromJson<int?>(json['fixRefId']),
      varRefId: serializer.fromJson<int?>(json['varRefId']),
      fileRefId: serializer.fromJson<int?>(json['fileRefId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'topicId': serializer.toJson<int>(topicId),
      'date': serializer.toJson<DateTime>(date),
      'value': serializer.toJson<int>(value),
      'userRefId': serializer.toJson<int>(userRefId),
      'compensations': serializer.toJson<String?>(compensations),
      'transactionLabelId': serializer.toJson<int?>(transactionLabelId),
      'description': serializer.toJson<String?>(description),
      'fixRefId': serializer.toJson<int?>(fixRefId),
      'varRefId': serializer.toJson<int?>(varRefId),
      'fileRefId': serializer.toJson<int?>(fileRefId),
    };
  }

  VarTransaction copyWith({
    int? id,
    int? topicId,
    DateTime? date,
    int? value,
    int? userRefId,
    Value<String?> compensations = const Value.absent(),
    Value<int?> transactionLabelId = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<int?> fixRefId = const Value.absent(),
    Value<int?> varRefId = const Value.absent(),
    Value<int?> fileRefId = const Value.absent(),
  }) => VarTransaction(
    id: id ?? this.id,
    topicId: topicId ?? this.topicId,
    date: date ?? this.date,
    value: value ?? this.value,
    userRefId: userRefId ?? this.userRefId,
    compensations: compensations.present
        ? compensations.value
        : this.compensations,
    transactionLabelId: transactionLabelId.present
        ? transactionLabelId.value
        : this.transactionLabelId,
    description: description.present ? description.value : this.description,
    fixRefId: fixRefId.present ? fixRefId.value : this.fixRefId,
    varRefId: varRefId.present ? varRefId.value : this.varRefId,
    fileRefId: fileRefId.present ? fileRefId.value : this.fileRefId,
  );
  VarTransaction copyWithCompanion(VarTransactionsCompanion data) {
    return VarTransaction(
      id: data.id.present ? data.id.value : this.id,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      date: data.date.present ? data.date.value : this.date,
      value: data.value.present ? data.value.value : this.value,
      userRefId: data.userRefId.present ? data.userRefId.value : this.userRefId,
      compensations: data.compensations.present
          ? data.compensations.value
          : this.compensations,
      transactionLabelId: data.transactionLabelId.present
          ? data.transactionLabelId.value
          : this.transactionLabelId,
      description: data.description.present
          ? data.description.value
          : this.description,
      fixRefId: data.fixRefId.present ? data.fixRefId.value : this.fixRefId,
      varRefId: data.varRefId.present ? data.varRefId.value : this.varRefId,
      fileRefId: data.fileRefId.present ? data.fileRefId.value : this.fileRefId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VarTransaction(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('date: $date, ')
          ..write('value: $value, ')
          ..write('userRefId: $userRefId, ')
          ..write('compensations: $compensations, ')
          ..write('transactionLabelId: $transactionLabelId, ')
          ..write('description: $description, ')
          ..write('fixRefId: $fixRefId, ')
          ..write('varRefId: $varRefId, ')
          ..write('fileRefId: $fileRefId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    topicId,
    date,
    value,
    userRefId,
    compensations,
    transactionLabelId,
    description,
    fixRefId,
    varRefId,
    fileRefId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VarTransaction &&
          other.id == this.id &&
          other.topicId == this.topicId &&
          other.date == this.date &&
          other.value == this.value &&
          other.userRefId == this.userRefId &&
          other.compensations == this.compensations &&
          other.transactionLabelId == this.transactionLabelId &&
          other.description == this.description &&
          other.fixRefId == this.fixRefId &&
          other.varRefId == this.varRefId &&
          other.fileRefId == this.fileRefId);
}

class VarTransactionsCompanion extends UpdateCompanion<VarTransaction> {
  final Value<int> id;
  final Value<int> topicId;
  final Value<DateTime> date;
  final Value<int> value;
  final Value<int> userRefId;
  final Value<String?> compensations;
  final Value<int?> transactionLabelId;
  final Value<String?> description;
  final Value<int?> fixRefId;
  final Value<int?> varRefId;
  final Value<int?> fileRefId;
  const VarTransactionsCompanion({
    this.id = const Value.absent(),
    this.topicId = const Value.absent(),
    this.date = const Value.absent(),
    this.value = const Value.absent(),
    this.userRefId = const Value.absent(),
    this.compensations = const Value.absent(),
    this.transactionLabelId = const Value.absent(),
    this.description = const Value.absent(),
    this.fixRefId = const Value.absent(),
    this.varRefId = const Value.absent(),
    this.fileRefId = const Value.absent(),
  });
  VarTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int topicId,
    required DateTime date,
    required int value,
    required int userRefId,
    this.compensations = const Value.absent(),
    this.transactionLabelId = const Value.absent(),
    this.description = const Value.absent(),
    this.fixRefId = const Value.absent(),
    this.varRefId = const Value.absent(),
    this.fileRefId = const Value.absent(),
  }) : topicId = Value(topicId),
       date = Value(date),
       value = Value(value),
       userRefId = Value(userRefId);
  static Insertable<VarTransaction> custom({
    Expression<int>? id,
    Expression<int>? topicId,
    Expression<DateTime>? date,
    Expression<int>? value,
    Expression<int>? userRefId,
    Expression<String>? compensations,
    Expression<int>? transactionLabelId,
    Expression<String>? description,
    Expression<int>? fixRefId,
    Expression<int>? varRefId,
    Expression<int>? fileRefId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (topicId != null) 'topic_id': topicId,
      if (date != null) 'date': date,
      if (value != null) 'value': value,
      if (userRefId != null) 'user_ref_id': userRefId,
      if (compensations != null) 'compensations': compensations,
      if (transactionLabelId != null)
        'transaction_label_id': transactionLabelId,
      if (description != null) 'description': description,
      if (fixRefId != null) 'fix_ref_id': fixRefId,
      if (varRefId != null) 'var_ref_id': varRefId,
      if (fileRefId != null) 'file_ref_id': fileRefId,
    });
  }

  VarTransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? topicId,
    Value<DateTime>? date,
    Value<int>? value,
    Value<int>? userRefId,
    Value<String?>? compensations,
    Value<int?>? transactionLabelId,
    Value<String?>? description,
    Value<int?>? fixRefId,
    Value<int?>? varRefId,
    Value<int?>? fileRefId,
  }) {
    return VarTransactionsCompanion(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      date: date ?? this.date,
      value: value ?? this.value,
      userRefId: userRefId ?? this.userRefId,
      compensations: compensations ?? this.compensations,
      transactionLabelId: transactionLabelId ?? this.transactionLabelId,
      description: description ?? this.description,
      fixRefId: fixRefId ?? this.fixRefId,
      varRefId: varRefId ?? this.varRefId,
      fileRefId: fileRefId ?? this.fileRefId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<int>(topicId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    if (userRefId.present) {
      map['user_ref_id'] = Variable<int>(userRefId.value);
    }
    if (compensations.present) {
      map['compensations'] = Variable<String>(compensations.value);
    }
    if (transactionLabelId.present) {
      map['transaction_label_id'] = Variable<int>(transactionLabelId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (fixRefId.present) {
      map['fix_ref_id'] = Variable<int>(fixRefId.value);
    }
    if (varRefId.present) {
      map['var_ref_id'] = Variable<int>(varRefId.value);
    }
    if (fileRefId.present) {
      map['file_ref_id'] = Variable<int>(fileRefId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VarTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('date: $date, ')
          ..write('value: $value, ')
          ..write('userRefId: $userRefId, ')
          ..write('compensations: $compensations, ')
          ..write('transactionLabelId: $transactionLabelId, ')
          ..write('description: $description, ')
          ..write('fixRefId: $fixRefId, ')
          ..write('varRefId: $varRefId, ')
          ..write('fileRefId: $fileRefId')
          ..write(')'))
        .toString();
  }
}

class $FixTransactionsTable extends FixTransactions
    with TableInfo<$FixTransactionsTable, FixTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FixTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<int> topicId = GeneratedColumn<int>(
    'topic_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topics (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Status, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Status>($FixTransactionsTable.$converterstatus);
  static const VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<DateTime> start = GeneratedColumn<DateTime>(
    'start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMeta = const VerificationMeta('end');
  @override
  late final GeneratedColumn<DateTime> end = GeneratedColumn<DateTime>(
    'end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalCountMeta = const VerificationMeta(
    'intervalCount',
  );
  @override
  late final GeneratedColumn<int> intervalCount = GeneratedColumn<int>(
    'interval_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<IntervalUnit, String>
  intervalUnit = GeneratedColumn<String>(
    'interval_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<IntervalUnit>($FixTransactionsTable.$converterintervalUnit);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int> value = GeneratedColumn<int>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userRefIdMeta = const VerificationMeta(
    'userRefId',
  );
  @override
  late final GeneratedColumn<int> userRefId = GeneratedColumn<int>(
    'user_ref_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _compensationsMeta = const VerificationMeta(
    'compensations',
  );
  @override
  late final GeneratedColumn<String> compensations = GeneratedColumn<String>(
    'compensations',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transactionLabelIdMeta =
      const VerificationMeta('transactionLabelId');
  @override
  late final GeneratedColumn<int> transactionLabelId = GeneratedColumn<int>(
    'transaction_label_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES transaction_labels (id) ON DELETE SET NULL',
    ),
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
  static const VerificationMeta _latestDateMeta = const VerificationMeta(
    'latestDate',
  );
  @override
  late final GeneratedColumn<DateTime> latestDate = GeneratedColumn<DateTime>(
    'latest_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _varRefIdMeta = const VerificationMeta(
    'varRefId',
  );
  @override
  late final GeneratedColumn<int> varRefId = GeneratedColumn<int>(
    'var_ref_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES var_transactions (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _fileRefIdMeta = const VerificationMeta(
    'fileRefId',
  );
  @override
  late final GeneratedColumn<int> fileRefId = GeneratedColumn<int>(
    'file_ref_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES files (id) ON DELETE SET NULL',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    topicId,
    status,
    start,
    end,
    intervalCount,
    intervalUnit,
    value,
    userRefId,
    compensations,
    transactionLabelId,
    description,
    latestDate,
    varRefId,
    fileRefId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fix_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<FixTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('start')) {
      context.handle(
        _startMeta,
        start.isAcceptableOrUnknown(data['start']!, _startMeta),
      );
    } else if (isInserting) {
      context.missing(_startMeta);
    }
    if (data.containsKey('end')) {
      context.handle(
        _endMeta,
        end.isAcceptableOrUnknown(data['end']!, _endMeta),
      );
    } else if (isInserting) {
      context.missing(_endMeta);
    }
    if (data.containsKey('interval_count')) {
      context.handle(
        _intervalCountMeta,
        intervalCount.isAcceptableOrUnknown(
          data['interval_count']!,
          _intervalCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_intervalCountMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('user_ref_id')) {
      context.handle(
        _userRefIdMeta,
        userRefId.isAcceptableOrUnknown(data['user_ref_id']!, _userRefIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userRefIdMeta);
    }
    if (data.containsKey('compensations')) {
      context.handle(
        _compensationsMeta,
        compensations.isAcceptableOrUnknown(
          data['compensations']!,
          _compensationsMeta,
        ),
      );
    }
    if (data.containsKey('transaction_label_id')) {
      context.handle(
        _transactionLabelIdMeta,
        transactionLabelId.isAcceptableOrUnknown(
          data['transaction_label_id']!,
          _transactionLabelIdMeta,
        ),
      );
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
    if (data.containsKey('latest_date')) {
      context.handle(
        _latestDateMeta,
        latestDate.isAcceptableOrUnknown(data['latest_date']!, _latestDateMeta),
      );
    }
    if (data.containsKey('var_ref_id')) {
      context.handle(
        _varRefIdMeta,
        varRefId.isAcceptableOrUnknown(data['var_ref_id']!, _varRefIdMeta),
      );
    }
    if (data.containsKey('file_ref_id')) {
      context.handle(
        _fileRefIdMeta,
        fileRefId.isAcceptableOrUnknown(data['file_ref_id']!, _fileRefIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FixTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FixTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}topic_id'],
      )!,
      status: $FixTransactionsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      start: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start'],
      )!,
      end: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end'],
      )!,
      intervalCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_count'],
      )!,
      intervalUnit: $FixTransactionsTable.$converterintervalUnit.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}interval_unit'],
        )!,
      ),
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}value'],
      )!,
      userRefId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_ref_id'],
      )!,
      compensations: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}compensations'],
      ),
      transactionLabelId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_label_id'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      latestDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}latest_date'],
      ),
      varRefId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}var_ref_id'],
      ),
      fileRefId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_ref_id'],
      ),
    );
  }

  @override
  $FixTransactionsTable createAlias(String alias) {
    return $FixTransactionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Status, String, String> $converterstatus =
      const EnumNameConverter<Status>(Status.values);
  static JsonTypeConverter2<IntervalUnit, String, String>
  $converterintervalUnit = const EnumNameConverter<IntervalUnit>(
    IntervalUnit.values,
  );
}

class FixTransaction extends DataClass implements Insertable<FixTransaction> {
  final int id;
  final int topicId;
  final Status status;
  final DateTime start;
  final DateTime end;
  final int intervalCount;
  final IntervalUnit intervalUnit;
  final int value;
  final int userRefId;
  final String? compensations;
  final int? transactionLabelId;
  final String? description;
  final DateTime? latestDate;
  final int? varRefId;
  final int? fileRefId;
  const FixTransaction({
    required this.id,
    required this.topicId,
    required this.status,
    required this.start,
    required this.end,
    required this.intervalCount,
    required this.intervalUnit,
    required this.value,
    required this.userRefId,
    this.compensations,
    this.transactionLabelId,
    this.description,
    this.latestDate,
    this.varRefId,
    this.fileRefId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['topic_id'] = Variable<int>(topicId);
    {
      map['status'] = Variable<String>(
        $FixTransactionsTable.$converterstatus.toSql(status),
      );
    }
    map['start'] = Variable<DateTime>(start);
    map['end'] = Variable<DateTime>(end);
    map['interval_count'] = Variable<int>(intervalCount);
    {
      map['interval_unit'] = Variable<String>(
        $FixTransactionsTable.$converterintervalUnit.toSql(intervalUnit),
      );
    }
    map['value'] = Variable<int>(value);
    map['user_ref_id'] = Variable<int>(userRefId);
    if (!nullToAbsent || compensations != null) {
      map['compensations'] = Variable<String>(compensations);
    }
    if (!nullToAbsent || transactionLabelId != null) {
      map['transaction_label_id'] = Variable<int>(transactionLabelId);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || latestDate != null) {
      map['latest_date'] = Variable<DateTime>(latestDate);
    }
    if (!nullToAbsent || varRefId != null) {
      map['var_ref_id'] = Variable<int>(varRefId);
    }
    if (!nullToAbsent || fileRefId != null) {
      map['file_ref_id'] = Variable<int>(fileRefId);
    }
    return map;
  }

  FixTransactionsCompanion toCompanion(bool nullToAbsent) {
    return FixTransactionsCompanion(
      id: Value(id),
      topicId: Value(topicId),
      status: Value(status),
      start: Value(start),
      end: Value(end),
      intervalCount: Value(intervalCount),
      intervalUnit: Value(intervalUnit),
      value: Value(value),
      userRefId: Value(userRefId),
      compensations: compensations == null && nullToAbsent
          ? const Value.absent()
          : Value(compensations),
      transactionLabelId: transactionLabelId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionLabelId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      latestDate: latestDate == null && nullToAbsent
          ? const Value.absent()
          : Value(latestDate),
      varRefId: varRefId == null && nullToAbsent
          ? const Value.absent()
          : Value(varRefId),
      fileRefId: fileRefId == null && nullToAbsent
          ? const Value.absent()
          : Value(fileRefId),
    );
  }

  factory FixTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FixTransaction(
      id: serializer.fromJson<int>(json['id']),
      topicId: serializer.fromJson<int>(json['topicId']),
      status: $FixTransactionsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      start: serializer.fromJson<DateTime>(json['start']),
      end: serializer.fromJson<DateTime>(json['end']),
      intervalCount: serializer.fromJson<int>(json['intervalCount']),
      intervalUnit: $FixTransactionsTable.$converterintervalUnit.fromJson(
        serializer.fromJson<String>(json['intervalUnit']),
      ),
      value: serializer.fromJson<int>(json['value']),
      userRefId: serializer.fromJson<int>(json['userRefId']),
      compensations: serializer.fromJson<String?>(json['compensations']),
      transactionLabelId: serializer.fromJson<int?>(json['transactionLabelId']),
      description: serializer.fromJson<String?>(json['description']),
      latestDate: serializer.fromJson<DateTime?>(json['latestDate']),
      varRefId: serializer.fromJson<int?>(json['varRefId']),
      fileRefId: serializer.fromJson<int?>(json['fileRefId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'topicId': serializer.toJson<int>(topicId),
      'status': serializer.toJson<String>(
        $FixTransactionsTable.$converterstatus.toJson(status),
      ),
      'start': serializer.toJson<DateTime>(start),
      'end': serializer.toJson<DateTime>(end),
      'intervalCount': serializer.toJson<int>(intervalCount),
      'intervalUnit': serializer.toJson<String>(
        $FixTransactionsTable.$converterintervalUnit.toJson(intervalUnit),
      ),
      'value': serializer.toJson<int>(value),
      'userRefId': serializer.toJson<int>(userRefId),
      'compensations': serializer.toJson<String?>(compensations),
      'transactionLabelId': serializer.toJson<int?>(transactionLabelId),
      'description': serializer.toJson<String?>(description),
      'latestDate': serializer.toJson<DateTime?>(latestDate),
      'varRefId': serializer.toJson<int?>(varRefId),
      'fileRefId': serializer.toJson<int?>(fileRefId),
    };
  }

  FixTransaction copyWith({
    int? id,
    int? topicId,
    Status? status,
    DateTime? start,
    DateTime? end,
    int? intervalCount,
    IntervalUnit? intervalUnit,
    int? value,
    int? userRefId,
    Value<String?> compensations = const Value.absent(),
    Value<int?> transactionLabelId = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<DateTime?> latestDate = const Value.absent(),
    Value<int?> varRefId = const Value.absent(),
    Value<int?> fileRefId = const Value.absent(),
  }) => FixTransaction(
    id: id ?? this.id,
    topicId: topicId ?? this.topicId,
    status: status ?? this.status,
    start: start ?? this.start,
    end: end ?? this.end,
    intervalCount: intervalCount ?? this.intervalCount,
    intervalUnit: intervalUnit ?? this.intervalUnit,
    value: value ?? this.value,
    userRefId: userRefId ?? this.userRefId,
    compensations: compensations.present
        ? compensations.value
        : this.compensations,
    transactionLabelId: transactionLabelId.present
        ? transactionLabelId.value
        : this.transactionLabelId,
    description: description.present ? description.value : this.description,
    latestDate: latestDate.present ? latestDate.value : this.latestDate,
    varRefId: varRefId.present ? varRefId.value : this.varRefId,
    fileRefId: fileRefId.present ? fileRefId.value : this.fileRefId,
  );
  FixTransaction copyWithCompanion(FixTransactionsCompanion data) {
    return FixTransaction(
      id: data.id.present ? data.id.value : this.id,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      status: data.status.present ? data.status.value : this.status,
      start: data.start.present ? data.start.value : this.start,
      end: data.end.present ? data.end.value : this.end,
      intervalCount: data.intervalCount.present
          ? data.intervalCount.value
          : this.intervalCount,
      intervalUnit: data.intervalUnit.present
          ? data.intervalUnit.value
          : this.intervalUnit,
      value: data.value.present ? data.value.value : this.value,
      userRefId: data.userRefId.present ? data.userRefId.value : this.userRefId,
      compensations: data.compensations.present
          ? data.compensations.value
          : this.compensations,
      transactionLabelId: data.transactionLabelId.present
          ? data.transactionLabelId.value
          : this.transactionLabelId,
      description: data.description.present
          ? data.description.value
          : this.description,
      latestDate: data.latestDate.present
          ? data.latestDate.value
          : this.latestDate,
      varRefId: data.varRefId.present ? data.varRefId.value : this.varRefId,
      fileRefId: data.fileRefId.present ? data.fileRefId.value : this.fileRefId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FixTransaction(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('status: $status, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('intervalCount: $intervalCount, ')
          ..write('intervalUnit: $intervalUnit, ')
          ..write('value: $value, ')
          ..write('userRefId: $userRefId, ')
          ..write('compensations: $compensations, ')
          ..write('transactionLabelId: $transactionLabelId, ')
          ..write('description: $description, ')
          ..write('latestDate: $latestDate, ')
          ..write('varRefId: $varRefId, ')
          ..write('fileRefId: $fileRefId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    topicId,
    status,
    start,
    end,
    intervalCount,
    intervalUnit,
    value,
    userRefId,
    compensations,
    transactionLabelId,
    description,
    latestDate,
    varRefId,
    fileRefId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FixTransaction &&
          other.id == this.id &&
          other.topicId == this.topicId &&
          other.status == this.status &&
          other.start == this.start &&
          other.end == this.end &&
          other.intervalCount == this.intervalCount &&
          other.intervalUnit == this.intervalUnit &&
          other.value == this.value &&
          other.userRefId == this.userRefId &&
          other.compensations == this.compensations &&
          other.transactionLabelId == this.transactionLabelId &&
          other.description == this.description &&
          other.latestDate == this.latestDate &&
          other.varRefId == this.varRefId &&
          other.fileRefId == this.fileRefId);
}

class FixTransactionsCompanion extends UpdateCompanion<FixTransaction> {
  final Value<int> id;
  final Value<int> topicId;
  final Value<Status> status;
  final Value<DateTime> start;
  final Value<DateTime> end;
  final Value<int> intervalCount;
  final Value<IntervalUnit> intervalUnit;
  final Value<int> value;
  final Value<int> userRefId;
  final Value<String?> compensations;
  final Value<int?> transactionLabelId;
  final Value<String?> description;
  final Value<DateTime?> latestDate;
  final Value<int?> varRefId;
  final Value<int?> fileRefId;
  const FixTransactionsCompanion({
    this.id = const Value.absent(),
    this.topicId = const Value.absent(),
    this.status = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.intervalCount = const Value.absent(),
    this.intervalUnit = const Value.absent(),
    this.value = const Value.absent(),
    this.userRefId = const Value.absent(),
    this.compensations = const Value.absent(),
    this.transactionLabelId = const Value.absent(),
    this.description = const Value.absent(),
    this.latestDate = const Value.absent(),
    this.varRefId = const Value.absent(),
    this.fileRefId = const Value.absent(),
  });
  FixTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int topicId,
    required Status status,
    required DateTime start,
    required DateTime end,
    required int intervalCount,
    required IntervalUnit intervalUnit,
    required int value,
    required int userRefId,
    this.compensations = const Value.absent(),
    this.transactionLabelId = const Value.absent(),
    this.description = const Value.absent(),
    this.latestDate = const Value.absent(),
    this.varRefId = const Value.absent(),
    this.fileRefId = const Value.absent(),
  }) : topicId = Value(topicId),
       status = Value(status),
       start = Value(start),
       end = Value(end),
       intervalCount = Value(intervalCount),
       intervalUnit = Value(intervalUnit),
       value = Value(value),
       userRefId = Value(userRefId);
  static Insertable<FixTransaction> custom({
    Expression<int>? id,
    Expression<int>? topicId,
    Expression<String>? status,
    Expression<DateTime>? start,
    Expression<DateTime>? end,
    Expression<int>? intervalCount,
    Expression<String>? intervalUnit,
    Expression<int>? value,
    Expression<int>? userRefId,
    Expression<String>? compensations,
    Expression<int>? transactionLabelId,
    Expression<String>? description,
    Expression<DateTime>? latestDate,
    Expression<int>? varRefId,
    Expression<int>? fileRefId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (topicId != null) 'topic_id': topicId,
      if (status != null) 'status': status,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
      if (intervalCount != null) 'interval_count': intervalCount,
      if (intervalUnit != null) 'interval_unit': intervalUnit,
      if (value != null) 'value': value,
      if (userRefId != null) 'user_ref_id': userRefId,
      if (compensations != null) 'compensations': compensations,
      if (transactionLabelId != null)
        'transaction_label_id': transactionLabelId,
      if (description != null) 'description': description,
      if (latestDate != null) 'latest_date': latestDate,
      if (varRefId != null) 'var_ref_id': varRefId,
      if (fileRefId != null) 'file_ref_id': fileRefId,
    });
  }

  FixTransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? topicId,
    Value<Status>? status,
    Value<DateTime>? start,
    Value<DateTime>? end,
    Value<int>? intervalCount,
    Value<IntervalUnit>? intervalUnit,
    Value<int>? value,
    Value<int>? userRefId,
    Value<String?>? compensations,
    Value<int?>? transactionLabelId,
    Value<String?>? description,
    Value<DateTime?>? latestDate,
    Value<int?>? varRefId,
    Value<int?>? fileRefId,
  }) {
    return FixTransactionsCompanion(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      status: status ?? this.status,
      start: start ?? this.start,
      end: end ?? this.end,
      intervalCount: intervalCount ?? this.intervalCount,
      intervalUnit: intervalUnit ?? this.intervalUnit,
      value: value ?? this.value,
      userRefId: userRefId ?? this.userRefId,
      compensations: compensations ?? this.compensations,
      transactionLabelId: transactionLabelId ?? this.transactionLabelId,
      description: description ?? this.description,
      latestDate: latestDate ?? this.latestDate,
      varRefId: varRefId ?? this.varRefId,
      fileRefId: fileRefId ?? this.fileRefId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<int>(topicId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $FixTransactionsTable.$converterstatus.toSql(status.value),
      );
    }
    if (start.present) {
      map['start'] = Variable<DateTime>(start.value);
    }
    if (end.present) {
      map['end'] = Variable<DateTime>(end.value);
    }
    if (intervalCount.present) {
      map['interval_count'] = Variable<int>(intervalCount.value);
    }
    if (intervalUnit.present) {
      map['interval_unit'] = Variable<String>(
        $FixTransactionsTable.$converterintervalUnit.toSql(intervalUnit.value),
      );
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    if (userRefId.present) {
      map['user_ref_id'] = Variable<int>(userRefId.value);
    }
    if (compensations.present) {
      map['compensations'] = Variable<String>(compensations.value);
    }
    if (transactionLabelId.present) {
      map['transaction_label_id'] = Variable<int>(transactionLabelId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (latestDate.present) {
      map['latest_date'] = Variable<DateTime>(latestDate.value);
    }
    if (varRefId.present) {
      map['var_ref_id'] = Variable<int>(varRefId.value);
    }
    if (fileRefId.present) {
      map['file_ref_id'] = Variable<int>(fileRefId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FixTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('status: $status, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('intervalCount: $intervalCount, ')
          ..write('intervalUnit: $intervalUnit, ')
          ..write('value: $value, ')
          ..write('userRefId: $userRefId, ')
          ..write('compensations: $compensations, ')
          ..write('transactionLabelId: $transactionLabelId, ')
          ..write('description: $description, ')
          ..write('latestDate: $latestDate, ')
          ..write('varRefId: $varRefId, ')
          ..write('fileRefId: $fileRefId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $TopicsTable topics = $TopicsTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $TransactionLabelsTable transactionLabels =
      $TransactionLabelsTable(this);
  late final $FilesTable files = $FilesTable(this);
  late final $VarTransactionsTable varTransactions = $VarTransactionsTable(
    this,
  );
  late final $FixTransactionsTable fixTransactions = $FixTransactionsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categories,
    topics,
    users,
    transactionLabels,
    files,
    varTransactions,
    fixTransactions,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('topics', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'topics',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('var_transactions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'transaction_labels',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('var_transactions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'var_transactions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('var_transactions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'files',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('var_transactions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'topics',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fix_transactions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'transaction_labels',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fix_transactions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'var_transactions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fix_transactions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'files',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fix_transactions', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
    });

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TopicsTable, List<Topic>> _topicsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.topics,
    aliasName: $_aliasNameGenerator(db.categories.id, db.topics.categoryId),
  );

  $$TopicsTableProcessedTableManager get topicsRefs {
    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_topicsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> topicsRefs(
    Expression<bool> Function($$TopicsTableFilterComposer f) f,
  ) {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> topicsRefs<T extends Object>(
    Expression<T> Function($$TopicsTableAnnotationComposer a) f,
  ) {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({bool topicsRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                description: description,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({topicsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (topicsRefs) db.topics],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (topicsRefs)
                    await $_getPrefetchedData<
                      Category,
                      $CategoriesTable,
                      Topic
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._topicsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(db, table, p0).topicsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({bool topicsRefs})
    >;
typedef $$TopicsTableCreateCompanionBuilder =
    TopicsCompanion Function({
      Value<int> id,
      required int categoryId,
      required String name,
      Value<String?> description,
    });
typedef $$TopicsTableUpdateCompanionBuilder =
    TopicsCompanion Function({
      Value<int> id,
      Value<int> categoryId,
      Value<String> name,
      Value<String?> description,
    });

final class $$TopicsTableReferences
    extends BaseReferences<_$AppDatabase, $TopicsTable, Topic> {
  $$TopicsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(db.topics.categoryId, db.categories.id),
      );

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$VarTransactionsTable, List<VarTransaction>>
  _varTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.varTransactions,
    aliasName: $_aliasNameGenerator(db.topics.id, db.varTransactions.topicId),
  );

  $$VarTransactionsTableProcessedTableManager get varTransactionsRefs {
    final manager = $$VarTransactionsTableTableManager(
      $_db,
      $_db.varTransactions,
    ).filter((f) => f.topicId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _varTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FixTransactionsTable, List<FixTransaction>>
  _fixTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fixTransactions,
    aliasName: $_aliasNameGenerator(db.topics.id, db.fixTransactions.topicId),
  );

  $$FixTransactionsTableProcessedTableManager get fixTransactionsRefs {
    final manager = $$FixTransactionsTableTableManager(
      $_db,
      $_db.fixTransactions,
    ).filter((f) => f.topicId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _fixTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TopicsTableFilterComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> varTransactionsRefs(
    Expression<bool> Function($$VarTransactionsTableFilterComposer f) f,
  ) {
    final $$VarTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.varTransactions,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VarTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.varTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fixTransactionsRefs(
    Expression<bool> Function($$FixTransactionsTableFilterComposer f) f,
  ) {
    final $$FixTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixTransactions,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.fixTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TopicsTableOrderingComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TopicsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> varTransactionsRefs<T extends Object>(
    Expression<T> Function($$VarTransactionsTableAnnotationComposer a) f,
  ) {
    final $$VarTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.varTransactions,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VarTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.varTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fixTransactionsRefs<T extends Object>(
    Expression<T> Function($$FixTransactionsTableAnnotationComposer a) f,
  ) {
    final $$FixTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixTransactions,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.fixTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TopicsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TopicsTable,
          Topic,
          $$TopicsTableFilterComposer,
          $$TopicsTableOrderingComposer,
          $$TopicsTableAnnotationComposer,
          $$TopicsTableCreateCompanionBuilder,
          $$TopicsTableUpdateCompanionBuilder,
          (Topic, $$TopicsTableReferences),
          Topic,
          PrefetchHooks Function({
            bool categoryId,
            bool varTransactionsRefs,
            bool fixTransactionsRefs,
          })
        > {
  $$TopicsTableTableManager(_$AppDatabase db, $TopicsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TopicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TopicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TopicsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
              }) => TopicsCompanion(
                id: id,
                categoryId: categoryId,
                name: name,
                description: description,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoryId,
                required String name,
                Value<String?> description = const Value.absent(),
              }) => TopicsCompanion.insert(
                id: id,
                categoryId: categoryId,
                name: name,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TopicsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                varTransactionsRefs = false,
                fixTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (varTransactionsRefs) db.varTransactions,
                    if (fixTransactionsRefs) db.fixTransactions,
                  ],
                  addJoins:
                      <
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
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable: $$TopicsTableReferences
                                        ._categoryIdTable(db),
                                    referencedColumn: $$TopicsTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (varTransactionsRefs)
                        await $_getPrefetchedData<
                          Topic,
                          $TopicsTable,
                          VarTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$TopicsTableReferences
                              ._varTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TopicsTableReferences(
                                db,
                                table,
                                p0,
                              ).varTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.topicId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fixTransactionsRefs)
                        await $_getPrefetchedData<
                          Topic,
                          $TopicsTable,
                          FixTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$TopicsTableReferences
                              ._fixTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TopicsTableReferences(
                                db,
                                table,
                                p0,
                              ).fixTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.topicId == item.id,
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

typedef $$TopicsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TopicsTable,
      Topic,
      $$TopicsTableFilterComposer,
      $$TopicsTableOrderingComposer,
      $$TopicsTableAnnotationComposer,
      $$TopicsTableCreateCompanionBuilder,
      $$TopicsTableUpdateCompanionBuilder,
      (Topic, $$TopicsTableReferences),
      Topic,
      PrefetchHooks Function({
        bool categoryId,
        bool varTransactionsRefs,
        bool fixTransactionsRefs,
      })
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String name,
      required String color,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> color,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VarTransactionsTable, List<VarTransaction>>
  _varTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.varTransactions,
    aliasName: $_aliasNameGenerator(db.users.id, db.varTransactions.userRefId),
  );

  $$VarTransactionsTableProcessedTableManager get varTransactionsRefs {
    final manager = $$VarTransactionsTableTableManager(
      $_db,
      $_db.varTransactions,
    ).filter((f) => f.userRefId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _varTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FixTransactionsTable, List<FixTransaction>>
  _fixTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fixTransactions,
    aliasName: $_aliasNameGenerator(db.users.id, db.fixTransactions.userRefId),
  );

  $$FixTransactionsTableProcessedTableManager get fixTransactionsRefs {
    final manager = $$FixTransactionsTableTableManager(
      $_db,
      $_db.fixTransactions,
    ).filter((f) => f.userRefId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _fixTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> varTransactionsRefs(
    Expression<bool> Function($$VarTransactionsTableFilterComposer f) f,
  ) {
    final $$VarTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.varTransactions,
      getReferencedColumn: (t) => t.userRefId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VarTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.varTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fixTransactionsRefs(
    Expression<bool> Function($$FixTransactionsTableFilterComposer f) f,
  ) {
    final $$FixTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixTransactions,
      getReferencedColumn: (t) => t.userRefId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.fixTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  Expression<T> varTransactionsRefs<T extends Object>(
    Expression<T> Function($$VarTransactionsTableAnnotationComposer a) f,
  ) {
    final $$VarTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.varTransactions,
      getReferencedColumn: (t) => t.userRefId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VarTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.varTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fixTransactionsRefs<T extends Object>(
    Expression<T> Function($$FixTransactionsTableAnnotationComposer a) f,
  ) {
    final $$FixTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixTransactions,
      getReferencedColumn: (t) => t.userRefId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.fixTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({
            bool varTransactionsRefs,
            bool fixTransactionsRefs,
          })
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> color = const Value.absent(),
              }) => UsersCompanion(id: id, name: name, color: color),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String color,
              }) => UsersCompanion.insert(id: id, name: name, color: color),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({varTransactionsRefs = false, fixTransactionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (varTransactionsRefs) db.varTransactions,
                    if (fixTransactionsRefs) db.fixTransactions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (varTransactionsRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          VarTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._varTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).varTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userRefId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fixTransactionsRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          FixTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._fixTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).fixTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userRefId == item.id,
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

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({
        bool varTransactionsRefs,
        bool fixTransactionsRefs,
      })
    >;
typedef $$TransactionLabelsTableCreateCompanionBuilder =
    TransactionLabelsCompanion Function({
      Value<int> id,
      required String name,
      required String color,
    });
typedef $$TransactionLabelsTableUpdateCompanionBuilder =
    TransactionLabelsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> color,
    });

final class $$TransactionLabelsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TransactionLabelsTable,
          TransactionLabel
        > {
  $$TransactionLabelsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$VarTransactionsTable, List<VarTransaction>>
  _varTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.varTransactions,
    aliasName: $_aliasNameGenerator(
      db.transactionLabels.id,
      db.varTransactions.transactionLabelId,
    ),
  );

  $$VarTransactionsTableProcessedTableManager get varTransactionsRefs {
    final manager =
        $$VarTransactionsTableTableManager($_db, $_db.varTransactions).filter(
          (f) => f.transactionLabelId.id.sqlEquals($_itemColumn<int>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _varTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FixTransactionsTable, List<FixTransaction>>
  _fixTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fixTransactions,
    aliasName: $_aliasNameGenerator(
      db.transactionLabels.id,
      db.fixTransactions.transactionLabelId,
    ),
  );

  $$FixTransactionsTableProcessedTableManager get fixTransactionsRefs {
    final manager =
        $$FixTransactionsTableTableManager($_db, $_db.fixTransactions).filter(
          (f) => f.transactionLabelId.id.sqlEquals($_itemColumn<int>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _fixTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TransactionLabelsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionLabelsTable> {
  $$TransactionLabelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> varTransactionsRefs(
    Expression<bool> Function($$VarTransactionsTableFilterComposer f) f,
  ) {
    final $$VarTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.varTransactions,
      getReferencedColumn: (t) => t.transactionLabelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VarTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.varTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fixTransactionsRefs(
    Expression<bool> Function($$FixTransactionsTableFilterComposer f) f,
  ) {
    final $$FixTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixTransactions,
      getReferencedColumn: (t) => t.transactionLabelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.fixTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransactionLabelsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionLabelsTable> {
  $$TransactionLabelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionLabelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionLabelsTable> {
  $$TransactionLabelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  Expression<T> varTransactionsRefs<T extends Object>(
    Expression<T> Function($$VarTransactionsTableAnnotationComposer a) f,
  ) {
    final $$VarTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.varTransactions,
      getReferencedColumn: (t) => t.transactionLabelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VarTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.varTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fixTransactionsRefs<T extends Object>(
    Expression<T> Function($$FixTransactionsTableAnnotationComposer a) f,
  ) {
    final $$FixTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixTransactions,
      getReferencedColumn: (t) => t.transactionLabelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.fixTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransactionLabelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionLabelsTable,
          TransactionLabel,
          $$TransactionLabelsTableFilterComposer,
          $$TransactionLabelsTableOrderingComposer,
          $$TransactionLabelsTableAnnotationComposer,
          $$TransactionLabelsTableCreateCompanionBuilder,
          $$TransactionLabelsTableUpdateCompanionBuilder,
          (TransactionLabel, $$TransactionLabelsTableReferences),
          TransactionLabel,
          PrefetchHooks Function({
            bool varTransactionsRefs,
            bool fixTransactionsRefs,
          })
        > {
  $$TransactionLabelsTableTableManager(
    _$AppDatabase db,
    $TransactionLabelsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionLabelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionLabelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionLabelsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> color = const Value.absent(),
              }) =>
                  TransactionLabelsCompanion(id: id, name: name, color: color),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String color,
              }) => TransactionLabelsCompanion.insert(
                id: id,
                name: name,
                color: color,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransactionLabelsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({varTransactionsRefs = false, fixTransactionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (varTransactionsRefs) db.varTransactions,
                    if (fixTransactionsRefs) db.fixTransactions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (varTransactionsRefs)
                        await $_getPrefetchedData<
                          TransactionLabel,
                          $TransactionLabelsTable,
                          VarTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$TransactionLabelsTableReferences
                              ._varTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TransactionLabelsTableReferences(
                                db,
                                table,
                                p0,
                              ).varTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.transactionLabelId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fixTransactionsRefs)
                        await $_getPrefetchedData<
                          TransactionLabel,
                          $TransactionLabelsTable,
                          FixTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$TransactionLabelsTableReferences
                              ._fixTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TransactionLabelsTableReferences(
                                db,
                                table,
                                p0,
                              ).fixTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.transactionLabelId == item.id,
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

typedef $$TransactionLabelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionLabelsTable,
      TransactionLabel,
      $$TransactionLabelsTableFilterComposer,
      $$TransactionLabelsTableOrderingComposer,
      $$TransactionLabelsTableAnnotationComposer,
      $$TransactionLabelsTableCreateCompanionBuilder,
      $$TransactionLabelsTableUpdateCompanionBuilder,
      (TransactionLabel, $$TransactionLabelsTableReferences),
      TransactionLabel,
      PrefetchHooks Function({
        bool varTransactionsRefs,
        bool fixTransactionsRefs,
      })
    >;
typedef $$FilesTableCreateCompanionBuilder =
    FilesCompanion Function({Value<int> id, required String path});
typedef $$FilesTableUpdateCompanionBuilder =
    FilesCompanion Function({Value<int> id, Value<String> path});

final class $$FilesTableReferences
    extends BaseReferences<_$AppDatabase, $FilesTable, File> {
  $$FilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VarTransactionsTable, List<VarTransaction>>
  _varTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.varTransactions,
    aliasName: $_aliasNameGenerator(db.files.id, db.varTransactions.fileRefId),
  );

  $$VarTransactionsTableProcessedTableManager get varTransactionsRefs {
    final manager = $$VarTransactionsTableTableManager(
      $_db,
      $_db.varTransactions,
    ).filter((f) => f.fileRefId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _varTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FixTransactionsTable, List<FixTransaction>>
  _fixTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fixTransactions,
    aliasName: $_aliasNameGenerator(db.files.id, db.fixTransactions.fileRefId),
  );

  $$FixTransactionsTableProcessedTableManager get fixTransactionsRefs {
    final manager = $$FixTransactionsTableTableManager(
      $_db,
      $_db.fixTransactions,
    ).filter((f) => f.fileRefId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _fixTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FilesTableFilterComposer extends Composer<_$AppDatabase, $FilesTable> {
  $$FilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> varTransactionsRefs(
    Expression<bool> Function($$VarTransactionsTableFilterComposer f) f,
  ) {
    final $$VarTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.varTransactions,
      getReferencedColumn: (t) => t.fileRefId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VarTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.varTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fixTransactionsRefs(
    Expression<bool> Function($$FixTransactionsTableFilterComposer f) f,
  ) {
    final $$FixTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixTransactions,
      getReferencedColumn: (t) => t.fileRefId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.fixTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FilesTableOrderingComposer
    extends Composer<_$AppDatabase, $FilesTable> {
  $$FilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FilesTable> {
  $$FilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  Expression<T> varTransactionsRefs<T extends Object>(
    Expression<T> Function($$VarTransactionsTableAnnotationComposer a) f,
  ) {
    final $$VarTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.varTransactions,
      getReferencedColumn: (t) => t.fileRefId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VarTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.varTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fixTransactionsRefs<T extends Object>(
    Expression<T> Function($$FixTransactionsTableAnnotationComposer a) f,
  ) {
    final $$FixTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixTransactions,
      getReferencedColumn: (t) => t.fileRefId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.fixTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FilesTable,
          File,
          $$FilesTableFilterComposer,
          $$FilesTableOrderingComposer,
          $$FilesTableAnnotationComposer,
          $$FilesTableCreateCompanionBuilder,
          $$FilesTableUpdateCompanionBuilder,
          (File, $$FilesTableReferences),
          File,
          PrefetchHooks Function({
            bool varTransactionsRefs,
            bool fixTransactionsRefs,
          })
        > {
  $$FilesTableTableManager(_$AppDatabase db, $FilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> path = const Value.absent(),
              }) => FilesCompanion(id: id, path: path),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String path}) =>
                  FilesCompanion.insert(id: id, path: path),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$FilesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({varTransactionsRefs = false, fixTransactionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (varTransactionsRefs) db.varTransactions,
                    if (fixTransactionsRefs) db.fixTransactions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (varTransactionsRefs)
                        await $_getPrefetchedData<
                          File,
                          $FilesTable,
                          VarTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$FilesTableReferences
                              ._varTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FilesTableReferences(
                                db,
                                table,
                                p0,
                              ).varTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fileRefId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fixTransactionsRefs)
                        await $_getPrefetchedData<
                          File,
                          $FilesTable,
                          FixTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$FilesTableReferences
                              ._fixTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FilesTableReferences(
                                db,
                                table,
                                p0,
                              ).fixTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fileRefId == item.id,
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

typedef $$FilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FilesTable,
      File,
      $$FilesTableFilterComposer,
      $$FilesTableOrderingComposer,
      $$FilesTableAnnotationComposer,
      $$FilesTableCreateCompanionBuilder,
      $$FilesTableUpdateCompanionBuilder,
      (File, $$FilesTableReferences),
      File,
      PrefetchHooks Function({
        bool varTransactionsRefs,
        bool fixTransactionsRefs,
      })
    >;
typedef $$VarTransactionsTableCreateCompanionBuilder =
    VarTransactionsCompanion Function({
      Value<int> id,
      required int topicId,
      required DateTime date,
      required int value,
      required int userRefId,
      Value<String?> compensations,
      Value<int?> transactionLabelId,
      Value<String?> description,
      Value<int?> fixRefId,
      Value<int?> varRefId,
      Value<int?> fileRefId,
    });
typedef $$VarTransactionsTableUpdateCompanionBuilder =
    VarTransactionsCompanion Function({
      Value<int> id,
      Value<int> topicId,
      Value<DateTime> date,
      Value<int> value,
      Value<int> userRefId,
      Value<String?> compensations,
      Value<int?> transactionLabelId,
      Value<String?> description,
      Value<int?> fixRefId,
      Value<int?> varRefId,
      Value<int?> fileRefId,
    });

final class $$VarTransactionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $VarTransactionsTable, VarTransaction> {
  $$VarTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TopicsTable _topicIdTable(_$AppDatabase db) => db.topics.createAlias(
    $_aliasNameGenerator(db.varTransactions.topicId, db.topics.id),
  );

  $$TopicsTableProcessedTableManager get topicId {
    final $_column = $_itemColumn<int>('topic_id')!;

    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _userRefIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.varTransactions.userRefId, db.users.id),
  );

  $$UsersTableProcessedTableManager get userRefId {
    final $_column = $_itemColumn<int>('user_ref_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userRefIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TransactionLabelsTable _transactionLabelIdTable(_$AppDatabase db) =>
      db.transactionLabels.createAlias(
        $_aliasNameGenerator(
          db.varTransactions.transactionLabelId,
          db.transactionLabels.id,
        ),
      );

  $$TransactionLabelsTableProcessedTableManager? get transactionLabelId {
    final $_column = $_itemColumn<int>('transaction_label_id');
    if ($_column == null) return null;
    final manager = $$TransactionLabelsTableTableManager(
      $_db,
      $_db.transactionLabels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transactionLabelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VarTransactionsTable _varRefIdTable(_$AppDatabase db) =>
      db.varTransactions.createAlias(
        $_aliasNameGenerator(
          db.varTransactions.varRefId,
          db.varTransactions.id,
        ),
      );

  $$VarTransactionsTableProcessedTableManager? get varRefId {
    final $_column = $_itemColumn<int>('var_ref_id');
    if ($_column == null) return null;
    final manager = $$VarTransactionsTableTableManager(
      $_db,
      $_db.varTransactions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_varRefIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FilesTable _fileRefIdTable(_$AppDatabase db) => db.files.createAlias(
    $_aliasNameGenerator(db.varTransactions.fileRefId, db.files.id),
  );

  $$FilesTableProcessedTableManager? get fileRefId {
    final $_column = $_itemColumn<int>('file_ref_id');
    if ($_column == null) return null;
    final manager = $$FilesTableTableManager(
      $_db,
      $_db.files,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fileRefIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FixTransactionsTable, List<FixTransaction>>
  _fixTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fixTransactions,
    aliasName: $_aliasNameGenerator(
      db.varTransactions.id,
      db.fixTransactions.varRefId,
    ),
  );

  $$FixTransactionsTableProcessedTableManager get fixTransactionsRefs {
    final manager = $$FixTransactionsTableTableManager(
      $_db,
      $_db.fixTransactions,
    ).filter((f) => f.varRefId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _fixTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VarTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $VarTransactionsTable> {
  $$VarTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get compensations => $composableBuilder(
    column: $table.compensations,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fixRefId => $composableBuilder(
    column: $table.fixRefId,
    builder: (column) => ColumnFilters(column),
  );

  $$TopicsTableFilterComposer get topicId {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get userRefId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userRefId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TransactionLabelsTableFilterComposer get transactionLabelId {
    final $$TransactionLabelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionLabelId,
      referencedTable: $db.transactionLabels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionLabelsTableFilterComposer(
            $db: $db,
            $table: $db.transactionLabels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VarTransactionsTableFilterComposer get varRefId {
    final $$VarTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.varRefId,
      referencedTable: $db.varTransactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VarTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.varTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FilesTableFilterComposer get fileRefId {
    final $$FilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileRefId,
      referencedTable: $db.files,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesTableFilterComposer(
            $db: $db,
            $table: $db.files,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> fixTransactionsRefs(
    Expression<bool> Function($$FixTransactionsTableFilterComposer f) f,
  ) {
    final $$FixTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixTransactions,
      getReferencedColumn: (t) => t.varRefId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.fixTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VarTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $VarTransactionsTable> {
  $$VarTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get compensations => $composableBuilder(
    column: $table.compensations,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fixRefId => $composableBuilder(
    column: $table.fixRefId,
    builder: (column) => ColumnOrderings(column),
  );

  $$TopicsTableOrderingComposer get topicId {
    final $$TopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get userRefId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userRefId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TransactionLabelsTableOrderingComposer get transactionLabelId {
    final $$TransactionLabelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionLabelId,
      referencedTable: $db.transactionLabels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionLabelsTableOrderingComposer(
            $db: $db,
            $table: $db.transactionLabels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VarTransactionsTableOrderingComposer get varRefId {
    final $$VarTransactionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.varRefId,
      referencedTable: $db.varTransactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VarTransactionsTableOrderingComposer(
            $db: $db,
            $table: $db.varTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FilesTableOrderingComposer get fileRefId {
    final $$FilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileRefId,
      referencedTable: $db.files,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesTableOrderingComposer(
            $db: $db,
            $table: $db.files,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VarTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VarTransactionsTable> {
  $$VarTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get compensations => $composableBuilder(
    column: $table.compensations,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fixRefId =>
      $composableBuilder(column: $table.fixRefId, builder: (column) => column);

  $$TopicsTableAnnotationComposer get topicId {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get userRefId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userRefId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TransactionLabelsTableAnnotationComposer get transactionLabelId {
    final $$TransactionLabelsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.transactionLabelId,
          referencedTable: $db.transactionLabels,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionLabelsTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionLabels,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$VarTransactionsTableAnnotationComposer get varRefId {
    final $$VarTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.varRefId,
      referencedTable: $db.varTransactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VarTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.varTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FilesTableAnnotationComposer get fileRefId {
    final $$FilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileRefId,
      referencedTable: $db.files,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesTableAnnotationComposer(
            $db: $db,
            $table: $db.files,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> fixTransactionsRefs<T extends Object>(
    Expression<T> Function($$FixTransactionsTableAnnotationComposer a) f,
  ) {
    final $$FixTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixTransactions,
      getReferencedColumn: (t) => t.varRefId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.fixTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VarTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VarTransactionsTable,
          VarTransaction,
          $$VarTransactionsTableFilterComposer,
          $$VarTransactionsTableOrderingComposer,
          $$VarTransactionsTableAnnotationComposer,
          $$VarTransactionsTableCreateCompanionBuilder,
          $$VarTransactionsTableUpdateCompanionBuilder,
          (VarTransaction, $$VarTransactionsTableReferences),
          VarTransaction,
          PrefetchHooks Function({
            bool topicId,
            bool userRefId,
            bool transactionLabelId,
            bool varRefId,
            bool fileRefId,
            bool fixTransactionsRefs,
          })
        > {
  $$VarTransactionsTableTableManager(
    _$AppDatabase db,
    $VarTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VarTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VarTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VarTransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> topicId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> value = const Value.absent(),
                Value<int> userRefId = const Value.absent(),
                Value<String?> compensations = const Value.absent(),
                Value<int?> transactionLabelId = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int?> fixRefId = const Value.absent(),
                Value<int?> varRefId = const Value.absent(),
                Value<int?> fileRefId = const Value.absent(),
              }) => VarTransactionsCompanion(
                id: id,
                topicId: topicId,
                date: date,
                value: value,
                userRefId: userRefId,
                compensations: compensations,
                transactionLabelId: transactionLabelId,
                description: description,
                fixRefId: fixRefId,
                varRefId: varRefId,
                fileRefId: fileRefId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int topicId,
                required DateTime date,
                required int value,
                required int userRefId,
                Value<String?> compensations = const Value.absent(),
                Value<int?> transactionLabelId = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int?> fixRefId = const Value.absent(),
                Value<int?> varRefId = const Value.absent(),
                Value<int?> fileRefId = const Value.absent(),
              }) => VarTransactionsCompanion.insert(
                id: id,
                topicId: topicId,
                date: date,
                value: value,
                userRefId: userRefId,
                compensations: compensations,
                transactionLabelId: transactionLabelId,
                description: description,
                fixRefId: fixRefId,
                varRefId: varRefId,
                fileRefId: fileRefId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VarTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                topicId = false,
                userRefId = false,
                transactionLabelId = false,
                varRefId = false,
                fileRefId = false,
                fixTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (fixTransactionsRefs) db.fixTransactions,
                  ],
                  addJoins:
                      <
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
                        if (topicId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.topicId,
                                    referencedTable:
                                        $$VarTransactionsTableReferences
                                            ._topicIdTable(db),
                                    referencedColumn:
                                        $$VarTransactionsTableReferences
                                            ._topicIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (userRefId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userRefId,
                                    referencedTable:
                                        $$VarTransactionsTableReferences
                                            ._userRefIdTable(db),
                                    referencedColumn:
                                        $$VarTransactionsTableReferences
                                            ._userRefIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (transactionLabelId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.transactionLabelId,
                                    referencedTable:
                                        $$VarTransactionsTableReferences
                                            ._transactionLabelIdTable(db),
                                    referencedColumn:
                                        $$VarTransactionsTableReferences
                                            ._transactionLabelIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (varRefId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.varRefId,
                                    referencedTable:
                                        $$VarTransactionsTableReferences
                                            ._varRefIdTable(db),
                                    referencedColumn:
                                        $$VarTransactionsTableReferences
                                            ._varRefIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (fileRefId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.fileRefId,
                                    referencedTable:
                                        $$VarTransactionsTableReferences
                                            ._fileRefIdTable(db),
                                    referencedColumn:
                                        $$VarTransactionsTableReferences
                                            ._fileRefIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (fixTransactionsRefs)
                        await $_getPrefetchedData<
                          VarTransaction,
                          $VarTransactionsTable,
                          FixTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$VarTransactionsTableReferences
                              ._fixTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VarTransactionsTableReferences(
                                db,
                                table,
                                p0,
                              ).fixTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.varRefId == item.id,
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

typedef $$VarTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VarTransactionsTable,
      VarTransaction,
      $$VarTransactionsTableFilterComposer,
      $$VarTransactionsTableOrderingComposer,
      $$VarTransactionsTableAnnotationComposer,
      $$VarTransactionsTableCreateCompanionBuilder,
      $$VarTransactionsTableUpdateCompanionBuilder,
      (VarTransaction, $$VarTransactionsTableReferences),
      VarTransaction,
      PrefetchHooks Function({
        bool topicId,
        bool userRefId,
        bool transactionLabelId,
        bool varRefId,
        bool fileRefId,
        bool fixTransactionsRefs,
      })
    >;
typedef $$FixTransactionsTableCreateCompanionBuilder =
    FixTransactionsCompanion Function({
      Value<int> id,
      required int topicId,
      required Status status,
      required DateTime start,
      required DateTime end,
      required int intervalCount,
      required IntervalUnit intervalUnit,
      required int value,
      required int userRefId,
      Value<String?> compensations,
      Value<int?> transactionLabelId,
      Value<String?> description,
      Value<DateTime?> latestDate,
      Value<int?> varRefId,
      Value<int?> fileRefId,
    });
typedef $$FixTransactionsTableUpdateCompanionBuilder =
    FixTransactionsCompanion Function({
      Value<int> id,
      Value<int> topicId,
      Value<Status> status,
      Value<DateTime> start,
      Value<DateTime> end,
      Value<int> intervalCount,
      Value<IntervalUnit> intervalUnit,
      Value<int> value,
      Value<int> userRefId,
      Value<String?> compensations,
      Value<int?> transactionLabelId,
      Value<String?> description,
      Value<DateTime?> latestDate,
      Value<int?> varRefId,
      Value<int?> fileRefId,
    });

final class $$FixTransactionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $FixTransactionsTable, FixTransaction> {
  $$FixTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TopicsTable _topicIdTable(_$AppDatabase db) => db.topics.createAlias(
    $_aliasNameGenerator(db.fixTransactions.topicId, db.topics.id),
  );

  $$TopicsTableProcessedTableManager get topicId {
    final $_column = $_itemColumn<int>('topic_id')!;

    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _userRefIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.fixTransactions.userRefId, db.users.id),
  );

  $$UsersTableProcessedTableManager get userRefId {
    final $_column = $_itemColumn<int>('user_ref_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userRefIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TransactionLabelsTable _transactionLabelIdTable(_$AppDatabase db) =>
      db.transactionLabels.createAlias(
        $_aliasNameGenerator(
          db.fixTransactions.transactionLabelId,
          db.transactionLabels.id,
        ),
      );

  $$TransactionLabelsTableProcessedTableManager? get transactionLabelId {
    final $_column = $_itemColumn<int>('transaction_label_id');
    if ($_column == null) return null;
    final manager = $$TransactionLabelsTableTableManager(
      $_db,
      $_db.transactionLabels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transactionLabelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VarTransactionsTable _varRefIdTable(_$AppDatabase db) =>
      db.varTransactions.createAlias(
        $_aliasNameGenerator(
          db.fixTransactions.varRefId,
          db.varTransactions.id,
        ),
      );

  $$VarTransactionsTableProcessedTableManager? get varRefId {
    final $_column = $_itemColumn<int>('var_ref_id');
    if ($_column == null) return null;
    final manager = $$VarTransactionsTableTableManager(
      $_db,
      $_db.varTransactions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_varRefIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FilesTable _fileRefIdTable(_$AppDatabase db) => db.files.createAlias(
    $_aliasNameGenerator(db.fixTransactions.fileRefId, db.files.id),
  );

  $$FilesTableProcessedTableManager? get fileRefId {
    final $_column = $_itemColumn<int>('file_ref_id');
    if ($_column == null) return null;
    final manager = $$FilesTableTableManager(
      $_db,
      $_db.files,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fileRefIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FixTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $FixTransactionsTable> {
  $$FixTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Status, Status, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalCount => $composableBuilder(
    column: $table.intervalCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<IntervalUnit, IntervalUnit, String>
  get intervalUnit => $composableBuilder(
    column: $table.intervalUnit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get compensations => $composableBuilder(
    column: $table.compensations,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get latestDate => $composableBuilder(
    column: $table.latestDate,
    builder: (column) => ColumnFilters(column),
  );

  $$TopicsTableFilterComposer get topicId {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get userRefId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userRefId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TransactionLabelsTableFilterComposer get transactionLabelId {
    final $$TransactionLabelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionLabelId,
      referencedTable: $db.transactionLabels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionLabelsTableFilterComposer(
            $db: $db,
            $table: $db.transactionLabels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VarTransactionsTableFilterComposer get varRefId {
    final $$VarTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.varRefId,
      referencedTable: $db.varTransactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VarTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.varTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FilesTableFilterComposer get fileRefId {
    final $$FilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileRefId,
      referencedTable: $db.files,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesTableFilterComposer(
            $db: $db,
            $table: $db.files,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FixTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FixTransactionsTable> {
  $$FixTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalCount => $composableBuilder(
    column: $table.intervalCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intervalUnit => $composableBuilder(
    column: $table.intervalUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get compensations => $composableBuilder(
    column: $table.compensations,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get latestDate => $composableBuilder(
    column: $table.latestDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$TopicsTableOrderingComposer get topicId {
    final $$TopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get userRefId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userRefId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TransactionLabelsTableOrderingComposer get transactionLabelId {
    final $$TransactionLabelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionLabelId,
      referencedTable: $db.transactionLabels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionLabelsTableOrderingComposer(
            $db: $db,
            $table: $db.transactionLabels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VarTransactionsTableOrderingComposer get varRefId {
    final $$VarTransactionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.varRefId,
      referencedTable: $db.varTransactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VarTransactionsTableOrderingComposer(
            $db: $db,
            $table: $db.varTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FilesTableOrderingComposer get fileRefId {
    final $$FilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileRefId,
      referencedTable: $db.files,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesTableOrderingComposer(
            $db: $db,
            $table: $db.files,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FixTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FixTransactionsTable> {
  $$FixTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Status, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get start =>
      $composableBuilder(column: $table.start, builder: (column) => column);

  GeneratedColumn<DateTime> get end =>
      $composableBuilder(column: $table.end, builder: (column) => column);

  GeneratedColumn<int> get intervalCount => $composableBuilder(
    column: $table.intervalCount,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<IntervalUnit, String> get intervalUnit =>
      $composableBuilder(
        column: $table.intervalUnit,
        builder: (column) => column,
      );

  GeneratedColumn<int> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get compensations => $composableBuilder(
    column: $table.compensations,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get latestDate => $composableBuilder(
    column: $table.latestDate,
    builder: (column) => column,
  );

  $$TopicsTableAnnotationComposer get topicId {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get userRefId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userRefId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TransactionLabelsTableAnnotationComposer get transactionLabelId {
    final $$TransactionLabelsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.transactionLabelId,
          referencedTable: $db.transactionLabels,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionLabelsTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionLabels,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$VarTransactionsTableAnnotationComposer get varRefId {
    final $$VarTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.varRefId,
      referencedTable: $db.varTransactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VarTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.varTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FilesTableAnnotationComposer get fileRefId {
    final $$FilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileRefId,
      referencedTable: $db.files,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesTableAnnotationComposer(
            $db: $db,
            $table: $db.files,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FixTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FixTransactionsTable,
          FixTransaction,
          $$FixTransactionsTableFilterComposer,
          $$FixTransactionsTableOrderingComposer,
          $$FixTransactionsTableAnnotationComposer,
          $$FixTransactionsTableCreateCompanionBuilder,
          $$FixTransactionsTableUpdateCompanionBuilder,
          (FixTransaction, $$FixTransactionsTableReferences),
          FixTransaction,
          PrefetchHooks Function({
            bool topicId,
            bool userRefId,
            bool transactionLabelId,
            bool varRefId,
            bool fileRefId,
          })
        > {
  $$FixTransactionsTableTableManager(
    _$AppDatabase db,
    $FixTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FixTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FixTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FixTransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> topicId = const Value.absent(),
                Value<Status> status = const Value.absent(),
                Value<DateTime> start = const Value.absent(),
                Value<DateTime> end = const Value.absent(),
                Value<int> intervalCount = const Value.absent(),
                Value<IntervalUnit> intervalUnit = const Value.absent(),
                Value<int> value = const Value.absent(),
                Value<int> userRefId = const Value.absent(),
                Value<String?> compensations = const Value.absent(),
                Value<int?> transactionLabelId = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime?> latestDate = const Value.absent(),
                Value<int?> varRefId = const Value.absent(),
                Value<int?> fileRefId = const Value.absent(),
              }) => FixTransactionsCompanion(
                id: id,
                topicId: topicId,
                status: status,
                start: start,
                end: end,
                intervalCount: intervalCount,
                intervalUnit: intervalUnit,
                value: value,
                userRefId: userRefId,
                compensations: compensations,
                transactionLabelId: transactionLabelId,
                description: description,
                latestDate: latestDate,
                varRefId: varRefId,
                fileRefId: fileRefId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int topicId,
                required Status status,
                required DateTime start,
                required DateTime end,
                required int intervalCount,
                required IntervalUnit intervalUnit,
                required int value,
                required int userRefId,
                Value<String?> compensations = const Value.absent(),
                Value<int?> transactionLabelId = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime?> latestDate = const Value.absent(),
                Value<int?> varRefId = const Value.absent(),
                Value<int?> fileRefId = const Value.absent(),
              }) => FixTransactionsCompanion.insert(
                id: id,
                topicId: topicId,
                status: status,
                start: start,
                end: end,
                intervalCount: intervalCount,
                intervalUnit: intervalUnit,
                value: value,
                userRefId: userRefId,
                compensations: compensations,
                transactionLabelId: transactionLabelId,
                description: description,
                latestDate: latestDate,
                varRefId: varRefId,
                fileRefId: fileRefId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FixTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                topicId = false,
                userRefId = false,
                transactionLabelId = false,
                varRefId = false,
                fileRefId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
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
                        if (topicId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.topicId,
                                    referencedTable:
                                        $$FixTransactionsTableReferences
                                            ._topicIdTable(db),
                                    referencedColumn:
                                        $$FixTransactionsTableReferences
                                            ._topicIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (userRefId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userRefId,
                                    referencedTable:
                                        $$FixTransactionsTableReferences
                                            ._userRefIdTable(db),
                                    referencedColumn:
                                        $$FixTransactionsTableReferences
                                            ._userRefIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (transactionLabelId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.transactionLabelId,
                                    referencedTable:
                                        $$FixTransactionsTableReferences
                                            ._transactionLabelIdTable(db),
                                    referencedColumn:
                                        $$FixTransactionsTableReferences
                                            ._transactionLabelIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (varRefId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.varRefId,
                                    referencedTable:
                                        $$FixTransactionsTableReferences
                                            ._varRefIdTable(db),
                                    referencedColumn:
                                        $$FixTransactionsTableReferences
                                            ._varRefIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (fileRefId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.fileRefId,
                                    referencedTable:
                                        $$FixTransactionsTableReferences
                                            ._fileRefIdTable(db),
                                    referencedColumn:
                                        $$FixTransactionsTableReferences
                                            ._fileRefIdTable(db)
                                            .id,
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

typedef $$FixTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FixTransactionsTable,
      FixTransaction,
      $$FixTransactionsTableFilterComposer,
      $$FixTransactionsTableOrderingComposer,
      $$FixTransactionsTableAnnotationComposer,
      $$FixTransactionsTableCreateCompanionBuilder,
      $$FixTransactionsTableUpdateCompanionBuilder,
      (FixTransaction, $$FixTransactionsTableReferences),
      FixTransaction,
      PrefetchHooks Function({
        bool topicId,
        bool userRefId,
        bool transactionLabelId,
        bool varRefId,
        bool fileRefId,
      })
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$TopicsTableTableManager get topics =>
      $$TopicsTableTableManager(_db, _db.topics);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$TransactionLabelsTableTableManager get transactionLabels =>
      $$TransactionLabelsTableTableManager(_db, _db.transactionLabels);
  $$FilesTableTableManager get files =>
      $$FilesTableTableManager(_db, _db.files);
  $$VarTransactionsTableTableManager get varTransactions =>
      $$VarTransactionsTableTableManager(_db, _db.varTransactions);
  $$FixTransactionsTableTableManager get fixTransactions =>
      $$FixTransactionsTableTableManager(_db, _db.fixTransactions);
}
