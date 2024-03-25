// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_info.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class SettingsInfo extends _SettingsInfo
    with RealmEntity, RealmObjectBase, RealmObject {
  SettingsInfo(
    String key,
    String weightUnit,
  ) {
    RealmObjectBase.set(this, 'key', key);
    RealmObjectBase.set(this, 'weightUnit', weightUnit);
  }

  SettingsInfo._();

  @override
  String get key => RealmObjectBase.get<String>(this, 'key') as String;
  @override
  set key(String value) => throw RealmUnsupportedSetError();

  @override
  String get weightUnit =>
      RealmObjectBase.get<String>(this, 'weightUnit') as String;
  @override
  set weightUnit(String value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<SettingsInfo>> get changes =>
      RealmObjectBase.getChanges<SettingsInfo>(this);

  @override
  SettingsInfo freeze() => RealmObjectBase.freezeObject<SettingsInfo>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(SettingsInfo._);
    return const SchemaObject(
        ObjectType.realmObject, SettingsInfo, 'SettingsInfo', [
      SchemaProperty('key', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('weightUnit', RealmPropertyType.string),
    ]);
  }
}
