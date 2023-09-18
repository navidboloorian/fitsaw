import 'package:fitsaw/features/settings/domain/domain.dart';
import 'package:fitsaw/shared/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

class SettingsRealm {
  late final Realm _realm;

  SettingsRealm(Ref ref) {
    _realm = ref.read(realmProvider);
  }

  void update(SettingsInfo settings) {
    _realm.write(() => _realm.add(settings, update: true));
  }

  SettingsInfo get() {
    if (_realm.all<SettingsInfo>().isEmpty) {
      update(SettingsInfo('settings', 'lb'));
    }

    return _realm.all<SettingsInfo>()[0];
  }
}

final settingsProvider = Provider<SettingsRealm>((ref) => SettingsRealm(ref));
