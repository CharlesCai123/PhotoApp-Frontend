import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_family_story/models/providers/settings_provider.dart';

/// Unit Number returned by Restful
int unitNum = 1;

class EncryptionSettingsPage extends ConsumerStatefulWidget {
  const EncryptionSettingsPage({Key? key}) : super(key: key);

  @override
  EncryptionSettingsPageState createState() => EncryptionSettingsPageState();
}

class EncryptionSettingsPageState extends ConsumerState<EncryptionSettingsPage>
    with TickerProviderStateMixin {
  List<Widget> models = [];

  @override
  void initState() {
    for (int i = 0; i < unitNum; i++) {
      models.add(const EncryptionSettingsModel());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Encryption Settings')),
      body: Scrollbar(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: ListView(
            children: models,
          ),
        ),
      ),
    );
  }
}

/// Unit Model
class EncryptionSettingsModel extends ConsumerStatefulWidget {
  const EncryptionSettingsModel({Key? key}) : super(key: key);

  @override
  EncryptionSettingsModelState createState() => EncryptionSettingsModelState();
}

class EncryptionSettingsModelState
    extends ConsumerState<EncryptionSettingsModel>
    with TickerProviderStateMixin {
  final int _width = 400;
  final int _height = 100;

  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    final _settingsProvider = ref.watch(settingsProvider);

    return Container(
      //padding: const EdgeInsets.only(left: 200),
      child: SizedBox(
        width: _width.toDouble(),
        height: _height.toDouble(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: _width.toDouble(),
              height: _height.toDouble(),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(225, 255, 194, 1),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 50),
                          child: const Text(
                            "Encryption Enabled",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Switch(
                          value: _settingsProvider.isEncryptionEnabled,
                          onChanged: (_) => {
                            _settingsProvider.encryptionChanged(_),
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
