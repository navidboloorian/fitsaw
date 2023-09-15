import 'package:fitsaw/features/settings.dart/services/services.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum WeightUnit { kg, lb }

class SettingsForm extends ConsumerStatefulWidget {
  const SettingsForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsFormState();
}

class _SettingsFormState extends ConsumerState<SettingsForm> {
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

  @override
  void initState() {
    super.initState();

    _parseSettings();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
    );
  }
}
