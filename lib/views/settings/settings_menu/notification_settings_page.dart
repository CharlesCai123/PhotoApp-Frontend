import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_family_story/models/providers/settings_provider.dart';

/// Unit Number returned by Restful
int unitNum = 1;

class NotificationSettingsPage extends ConsumerStatefulWidget {
  const NotificationSettingsPage({Key? key}) : super(key: key);

  @override
  NotificationSettingsPageState createState() =>
      NotificationSettingsPageState();
}

class NotificationSettingsPageState
    extends ConsumerState<NotificationSettingsPage>
    with TickerProviderStateMixin {
  final int _width = 500;
  final int _height = 400;

  @override
  Widget build(BuildContext context) {
    final _settingsProvider = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Settings')),
      body: Scrollbar(
        child: Center(
          child: SizedBox(
            width: _width.toDouble(),
            height: _height.toDouble(),
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color.fromRGBO(225, 255, 194, 1)),
              child: ListView(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(""),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            SizedBox(
                              child: Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                "Text",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                "App",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      "Backup/Storage",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  NotificationUnit(
                      "Backup Errors",
                      _settingsProvider.backupErrors,
                      _settingsProvider.itemCheckChanged),
                  NotificationUnit(
                      "Backup Warnings",
                      _settingsProvider.backupWarnings,
                      _settingsProvider.itemCheckChanged),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      "Compute",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  NotificationUnit(
                      "Compute Errors",
                      _settingsProvider.computeErrors,
                      _settingsProvider.itemCheckChanged),
                  NotificationUnit(
                      "Compute Warnings",
                      _settingsProvider.computeWarnings,
                      _settingsProvider.itemCheckChanged),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      "Story",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  NotificationUnit(
                      "New Story Created",
                      _settingsProvider.newStory,
                      _settingsProvider.itemCheckChanged),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Notification Unit
class NotificationUnit extends ConsumerStatefulWidget {
  //const NotificationUnit({Key? key}) : super(key: key);

  final String _textName;
  final NotificationItem _item;
  final Function _func;

  NotificationUnit(this._textName, this._item, this._func);

  @override
  NotificationUnitState createState() =>
      NotificationUnitState(_textName, _item, _func);
}

class NotificationUnitState extends ConsumerState<NotificationUnit>
    with TickerProviderStateMixin {
  final String _textName;
  final NotificationItem _item;
  final Function _func;

  NotificationUnitState(this._textName, this._item, this._func);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 80),
            alignment: Alignment.centerLeft,
            child: Text(
              _textName,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Checkbox(
                activeColor: Colors.blue,
                checkColor: Colors.white,
                value: _item.isEmailCheck,
                onChanged: (bool? value) {
                  //_func(_item, "Email", value);
                  setState(
                    () {
                      _item.isEmailCheck = value!;
                    },
                  );
                },
              ),
              Checkbox(
                activeColor: Colors.blue,
                checkColor: Colors.white,
                value: _item.isTextCheck,
                onChanged: (bool? value) {
                  //_func(_item, "Text", value);
                  setState(
                    () {
                      _item.isTextCheck = value!;
                    },
                  );
                },
              ),
              Checkbox(
                activeColor: Colors.blue,
                checkColor: Colors.white,
                value: _item.isAppCheck,
                onChanged: (bool? value) {
                  //_func(_item, "App", value);
                  setState(
                    () {
                      _item.isAppCheck = value!;
                    },
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
