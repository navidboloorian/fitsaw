// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fitsaw_user.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class FitsawUser extends _FitsawUser
    with RealmEntity, RealmObjectBase, RealmObject {
  FitsawUser(
    ObjectId id, {
    String? email,
    String? password,
    String? displayName,
    String? profilePictureURL,
    double? reputation,
    int? totalDownloads,
    Iterable<Routine> routines = const [],
    Iterable<Exercise> exercises = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'password', password);
    RealmObjectBase.set(this, 'displayName', displayName);
    RealmObjectBase.set(this, 'profilePictureURL', profilePictureURL);
    RealmObjectBase.set(this, 'reputation', reputation);
    RealmObjectBase.set(this, 'totalDownloads', totalDownloads);
    RealmObjectBase.set<RealmList<Routine>>(
        this, 'routines', RealmList<Routine>(routines));
    RealmObjectBase.set<RealmList<Exercise>>(
        this, 'exercises', RealmList<Exercise>(exercises));
  }

  FitsawUser._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  RealmList<Routine> get routines =>
      RealmObjectBase.get<Routine>(this, 'routines') as RealmList<Routine>;
  @override
  set routines(covariant RealmList<Routine> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<Exercise> get exercises =>
      RealmObjectBase.get<Exercise>(this, 'exercises') as RealmList<Exercise>;
  @override
  set exercises(covariant RealmList<Exercise> value) =>
      throw RealmUnsupportedSetError();

  @override
  String? get email => RealmObjectBase.get<String>(this, 'email') as String?;
  @override
  set email(String? value) => throw RealmUnsupportedSetError();

  @override
  String? get password =>
      RealmObjectBase.get<String>(this, 'password') as String?;
  @override
  set password(String? value) => throw RealmUnsupportedSetError();

  @override
  String? get displayName =>
      RealmObjectBase.get<String>(this, 'displayName') as String?;
  @override
  set displayName(String? value) => throw RealmUnsupportedSetError();

  @override
  String? get profilePictureURL =>
      RealmObjectBase.get<String>(this, 'profilePictureURL') as String?;
  @override
  set profilePictureURL(String? value) => throw RealmUnsupportedSetError();

  @override
  double? get reputation =>
      RealmObjectBase.get<double>(this, 'reputation') as double?;
  @override
  set reputation(double? value) => throw RealmUnsupportedSetError();

  @override
  int? get totalDownloads =>
      RealmObjectBase.get<int>(this, 'totalDownloads') as int?;
  @override
  set totalDownloads(int? value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<FitsawUser>> get changes =>
      RealmObjectBase.getChanges<FitsawUser>(this);

  @override
  FitsawUser freeze() => RealmObjectBase.freezeObject<FitsawUser>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(FitsawUser._);
    return const SchemaObject(
        ObjectType.realmObject, FitsawUser, 'FitsawUser', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('routines', RealmPropertyType.object,
          linkTarget: 'Routine', collectionType: RealmCollectionType.list),
      SchemaProperty('exercises', RealmPropertyType.object,
          linkTarget: 'Exercise', collectionType: RealmCollectionType.list),
      SchemaProperty('email', RealmPropertyType.string, optional: true),
      SchemaProperty('password', RealmPropertyType.string, optional: true),
      SchemaProperty('displayName', RealmPropertyType.string, optional: true),
      SchemaProperty('profilePictureURL', RealmPropertyType.string,
          optional: true),
      SchemaProperty('reputation', RealmPropertyType.double, optional: true),
      SchemaProperty('totalDownloads', RealmPropertyType.int, optional: true),
    ]);
  }
}
