// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class History extends _History with RealmEntity, RealmObjectBase, RealmObject {
  History(
    int date, {
    Iterable<RoutineSummary> summaries = const [],
  }) {
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set<RealmList<RoutineSummary>>(
        this, 'summaries', RealmList<RoutineSummary>(summaries));
  }

  History._();

  @override
  int get date => RealmObjectBase.get<int>(this, 'date') as int;
  @override
  set date(int value) => throw RealmUnsupportedSetError();

  @override
  RealmList<RoutineSummary> get summaries =>
      RealmObjectBase.get<RoutineSummary>(this, 'summaries')
          as RealmList<RoutineSummary>;
  @override
  set summaries(covariant RealmList<RoutineSummary> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<History>> get changes =>
      RealmObjectBase.getChanges<History>(this);

  @override
  History freeze() => RealmObjectBase.freezeObject<History>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(History._);
    return const SchemaObject(ObjectType.realmObject, History, 'History', [
      SchemaProperty('date', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('summaries', RealmPropertyType.object,
          linkTarget: 'RoutineSummary',
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class RoutineSummary extends _RoutineSummary
    with RealmEntity, RealmObjectBase, RealmObject {
  RoutineSummary(
    ObjectId id, {
    String? elapsedTime,
    HistoryRoutine? historyRoutine,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'elapsedTime', elapsedTime);
    RealmObjectBase.set(this, 'historyRoutine', historyRoutine);
  }

  RoutineSummary._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String? get elapsedTime =>
      RealmObjectBase.get<String>(this, 'elapsedTime') as String?;
  @override
  set elapsedTime(String? value) => throw RealmUnsupportedSetError();

  @override
  HistoryRoutine? get historyRoutine =>
      RealmObjectBase.get<HistoryRoutine>(this, 'historyRoutine')
          as HistoryRoutine?;
  @override
  set historyRoutine(covariant HistoryRoutine? value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<RoutineSummary>> get changes =>
      RealmObjectBase.getChanges<RoutineSummary>(this);

  @override
  RoutineSummary freeze() => RealmObjectBase.freezeObject<RoutineSummary>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RoutineSummary._);
    return const SchemaObject(
        ObjectType.realmObject, RoutineSummary, 'RoutineSummary', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('elapsedTime', RealmPropertyType.string, optional: true),
      SchemaProperty('historyRoutine', RealmPropertyType.object,
          optional: true, linkTarget: 'HistoryRoutine'),
    ]);
  }
}

class HistoryRoutine extends _HistoryRoutine
    with RealmEntity, RealmObjectBase, RealmObject {
  HistoryRoutine(
    String name, {
    String? description,
    Iterable<RoutineExerciseWrapper> exercises = const [],
    Iterable<String> tags = const [],
  }) {
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set<RealmList<RoutineExerciseWrapper>>(
        this, 'exercises', RealmList<RoutineExerciseWrapper>(exercises));
    RealmObjectBase.set<RealmList<String>>(
        this, 'tags', RealmList<String>(tags));
  }

  HistoryRoutine._();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => throw RealmUnsupportedSetError();

  @override
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) => throw RealmUnsupportedSetError();

  @override
  RealmList<RoutineExerciseWrapper> get exercises =>
      RealmObjectBase.get<RoutineExerciseWrapper>(this, 'exercises')
          as RealmList<RoutineExerciseWrapper>;
  @override
  set exercises(covariant RealmList<RoutineExerciseWrapper> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<String> get tags =>
      RealmObjectBase.get<String>(this, 'tags') as RealmList<String>;
  @override
  set tags(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<HistoryRoutine>> get changes =>
      RealmObjectBase.getChanges<HistoryRoutine>(this);

  @override
  HistoryRoutine freeze() => RealmObjectBase.freezeObject<HistoryRoutine>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(HistoryRoutine._);
    return const SchemaObject(
        ObjectType.realmObject, HistoryRoutine, 'HistoryRoutine', [
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('exercises', RealmPropertyType.object,
          linkTarget: 'RoutineExerciseWrapper',
          collectionType: RealmCollectionType.list),
      SchemaProperty('tags', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class HistoryExercise extends $HistoryExercise
    with RealmEntity, RealmObjectBase, RealmObject {
  HistoryExercise(
    String name,
    bool isTimed,
    bool isWeighted, {
    String? description,
    Iterable<String> tags = const [],
  }) {
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'isTimed', isTimed);
    RealmObjectBase.set(this, 'isWeighted', isWeighted);
    RealmObjectBase.set<RealmList<String>>(
        this, 'tags', RealmList<String>(tags));
  }

  HistoryExercise._();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => throw RealmUnsupportedSetError();

  @override
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) => throw RealmUnsupportedSetError();

  @override
  bool get isTimed => RealmObjectBase.get<bool>(this, 'isTimed') as bool;
  @override
  set isTimed(bool value) => throw RealmUnsupportedSetError();

  @override
  bool get isWeighted => RealmObjectBase.get<bool>(this, 'isWeighted') as bool;
  @override
  set isWeighted(bool value) => throw RealmUnsupportedSetError();

  @override
  RealmList<String> get tags =>
      RealmObjectBase.get<String>(this, 'tags') as RealmList<String>;
  @override
  set tags(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<HistoryExercise>> get changes =>
      RealmObjectBase.getChanges<HistoryExercise>(this);

  @override
  HistoryExercise freeze() =>
      RealmObjectBase.freezeObject<HistoryExercise>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(HistoryExercise._);
    return const SchemaObject(
        ObjectType.realmObject, HistoryExercise, 'HistoryExercise', [
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('isTimed', RealmPropertyType.bool),
      SchemaProperty('isWeighted', RealmPropertyType.bool),
      SchemaProperty('tags', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
    ]);
  }
}
