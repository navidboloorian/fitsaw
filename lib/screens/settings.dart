import 'package:fitsaw/features/settings/domain/domain.dart';
import 'package:fitsaw/features/settings/services/services.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum WeightUnit { kg, lb }

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  WeightUnit? _weightUnit = WeightUnit.lb;

  void _parseSettings() {
    final settings = ref.read(settingsProvider).get();

    switch (settings.weightUnit) {
      case 'kg':
        setState(() {
          _weightUnit = WeightUnit.kg;
        });
        break;
      case 'lb':
      default:
        setState(() {
          _weightUnit = WeightUnit.lb;
        });
        break;
    }
  }

  void _updateSettings() {
    ref.read(settingsProvider).update(
          SettingsInfo(
            'settings',
            _weightUnit.toString().split('.')[1],
          ),
        );

    Navigator.pop(context, true);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Palette.fitsawGreen,
        duration: Duration(milliseconds: 500),
        content: Text(
          'Settings Updated!',
          style: TextStyle(color: Palette.darkText),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _parseSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [CheckButton(_updateSettings)],
      ),
      body: ListView(
        children: [
          CustomContainer(
            child: Row(
              children: [
                const Text('Unit of Weight: '),
                Flexible(
                  child: RadioListTile<WeightUnit>(
                    title: const Text('kgs'),
                    contentPadding: EdgeInsets.zero,
                    fillColor: MaterialStateColor.resolveWith(
                      (states) => Palette.fitsawGreen,
                    ),
                    value: WeightUnit.kg,
                    groupValue: _weightUnit,
                    onChanged: (WeightUnit? value) {
                      setState(() {
                        _weightUnit = value;
                      });
                    },
                  ),
                ),
                Flexible(
                  child: RadioListTile<WeightUnit>(
                    title: const Text('lbs'),
                    contentPadding: EdgeInsets.zero,
                    fillColor: MaterialStateColor.resolveWith(
                      (states) => Palette.fitsawGreen,
                    ),
                    value: WeightUnit.lb,
                    groupValue: _weightUnit,
                    onChanged: (WeightUnit? value) {
                      setState(() {
                        _weightUnit = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
