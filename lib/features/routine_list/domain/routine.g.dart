// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Routine extends $Routine with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Routine(
    ObjectId id,
    String name, {
    String? description,
    double? rating = 0,
    int? downloads = 0,
    Iterable<RoutineExerciseWrapper> exercises = const [],
    Iterable<String> tags = const [],
    Iterable<ObjectId> reviewers = const [],
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Routine>({
        'rating': 0,
        'downloads': 0,
      });
    }
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'rating', rating);
    RealmObjectBase.set(this, 'downloads', downloads);
    RealmObjectBase.set<RealmList<RoutineExerciseWrapper>>(
        this, 'exercises', RealmList<RoutineExerciseWrapper>(exercises));
    RealmObjectBase.set<RealmList<String>>(
        this, 'tags', RealmList<String>(tags));
    RealmObjectBase.set<RealmList<ObjectId>>(
        this, 'reviewers', RealmList<ObjectId>(reviewers));
  }

  Routine._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => throw RealmUnsupportedSetError();

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
  double? get rating => RealmObjectBase.get<double>(this, 'rating') as double?;
  @override
  set rating(double? value) => throw RealmUnsupportedSetError();

  @override
  int? get downloads => RealmObjectBase.get<int>(this, 'downloads') as int?;
  @override
  set downloads(int? value) => throw RealmUnsupportedSetError();

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
  RealmList<ObjectId> get reviewers =>
      RealmObjectBase.get<ObjectId>(this, 'reviewers') as RealmList<ObjectId>;
  @override
  set reviewers(covariant RealmList<ObjectId> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Routine>> get changes =>
      RealmObjectBase.getChanges<Routine>(this);

  @override
  Routine freeze() => RealmObjectBase.freezeObject<Routine>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Routine._);
    return const SchemaObject(ObjectType.realmObject, Routine, 'Routine', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('rating', RealmPropertyType.double, optional: true),
      SchemaProperty('downloads', RealmPropertyType.int, optional: true),
      SchemaProperty('exercises', RealmPropertyType.object,
          linkTarget: 'RoutineExerciseWrapper',
          collectionType: RealmCollectionType.list),
      SchemaProperty('tags', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('reviewers', RealmPropertyType.objectid,
          collectionType: RealmCollectionType.list),
    ]);
  }
}

// ignore_for_file: type=lint
class RoutineExerciseWrapper extends $RoutineExerciseWrapper
    with RealmEntity, RealmObjectBase, RealmObject {
  RoutineExerciseWrapper({
    Exercise? exercise,
    HistoryExercise? historyExercise,
    int? rest,
    int? sets,
    Iterable<int> reps = const [],
    Iterable<int> times = const [],
    Iterable<int> weights = const [],
  }) {
    RealmObjectBase.set(this, 'exercise', exercise);
    RealmObjectBase.set(this, 'historyExercise', historyExercise);
    RealmObjectBase.set(this, 'rest', rest);
    RealmObjectBase.set(this, 'sets', sets);
    RealmObjectBase.set<RealmList<int>>(this, 'reps', RealmList<int>(reps));
    RealmObjectBase.set<RealmList<int>>(this, 'times', RealmList<int>(times));
    RealmObjectBase.set<RealmList<int>>(
        this, 'weights', RealmList<int>(weights));
  }

  RoutineExerciseWrapper._();

  @override
  Exercise? get exercise =>
      RealmObjectBase.get<Exercise>(this, 'exercise') as Exercise?;
  @override
  set exercise(covariant Exercise? value) => throw RealmUnsupportedSetError();

  @override
  HistoryExercise? get historyExercise =>
      RealmObjectBase.get<HistoryExercise>(this, 'historyExercise')
          as HistoryExercise?;
  @override
  set historyExercise(covariant HistoryExercise? value) =>
      throw RealmUnsupportedSetError();

  @override
  int? get rest => RealmObjectBase.get<int>(this, 'rest') as int?;
  @override
  set rest(int? value) => throw RealmUnsupportedSetError();

  @override
  int? get sets => RealmObjectBase.get<int>(this, 'sets') as int?;
  @override
  set sets(int? value) => throw RealmUnsupportedSetError();

  @override
  RealmList<int> get reps =>
      RealmObjectBase.get<int>(this, 'reps') as RealmList<int>;
  @override
  set reps(covariant RealmList<int> value) => throw RealmUnsupportedSetError();

  @override
  RealmList<int> get times =>
      RealmObjectBase.get<int>(this, 'times') as RealmList<int>;
  @override
  set times(covariant RealmList<int> value) => throw RealmUnsupportedSetError();

  @override
  RealmList<int> get weights =>
      RealmObjectBase.get<int>(this, 'weights') as RealmList<int>;
  @override
  set weights(covariant RealmList<int> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<RoutineExerciseWrapper>> get changes =>
      RealmObjectBase.getChanges<RoutineExerciseWrapper>(this);

  @override
  RoutineExerciseWrapper freeze() =>
      RealmObjectBase.freezeObject<RoutineExerciseWrapper>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RoutineExerciseWrapper._);
    return const SchemaObject(ObjectType.realmObject, RoutineExerciseWrapper,
        'RoutineExerciseWrapper', [
      SchemaProperty('exercise', RealmPropertyType.object,
          optional: true, linkTarget: 'Exercise'),
      SchemaProperty('historyExercise', RealmPropertyType.object,
          optional: true, linkTarget: 'HistoryExercise'),
      SchemaProperty('rest', RealmPropertyType.int, optional: true),
      SchemaProperty('sets', RealmPropertyType.int, optional: true),
      SchemaProperty('reps', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
      SchemaProperty('times', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
      SchemaProperty('weights', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
    ]);
  }
}
