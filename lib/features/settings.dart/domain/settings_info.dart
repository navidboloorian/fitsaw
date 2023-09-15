import 'package:realm/realm.dart';

part 'settings_info.g.dart';

@RealmModel()
class _SettingsInfo {
  @PrimaryKey()
  late final String key;

  late final String weightUnit;
}
