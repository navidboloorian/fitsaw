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
    Routine? routine,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'elapsedTime', elapsedTime);
    RealmObjectBase.set(this, 'routine', routine);
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
  Routine? get routine =>
      RealmObjectBase.get<Routine>(this, 'routine') as Routine?;
  @override
  set routine(covariant Routine? value) => throw RealmUnsupportedSetError();

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
      SchemaProperty('routine', RealmPropertyType.object,
          optional: true, linkTarget: 'Routine'),
    ]);
  }
}
