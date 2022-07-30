import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_family_story/models/providers/settings_provider.dart';

class PrivacySettingsPage extends ConsumerStatefulWidget {
  const PrivacySettingsPage({Key? key}) : super(key: key);

  @override
  PrivacySettingsPageState createState() => PrivacySettingsPageState();
}

class PrivacySettingsPageState extends ConsumerState<PrivacySettingsPage>
    with TickerProviderStateMixin {
  final int _width = 500;
  final int _height = 150;

  @override
  Widget build(BuildContext context) {
    final _settingsProvider = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Settings')),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
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
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color.fromRGBO(225, 255, 194, 1)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RowUnit(
                          "Enable Private Photos/Albums",
                          _settingsProvider.isPrivatePhotoEnabled,
                          _settingsProvider.photoEnabledChanged),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Change Passcode",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      RowUnit("Use Face ID", _settingsProvider.isUseFaceIdOn,
                          _settingsProvider.useFaceIDChanged),
                      RowUnit(
                          "Prevent Sharing Private Photos/Videos",
                          _settingsProvider.isPhotoSharingPrevented,
                          _settingsProvider.photoSharingPreventChanged),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RowUnit extends ConsumerStatefulWidget {
  //const RowUnit({Key? key}) : super(key: key);
  RowUnit(this._name, this._isCheck, this._func);

  final String _name;
  final bool _isCheck;
  final Function _func;

  @override
  RowUnitState createState() => RowUnitState(_name, _isCheck, _func);
}

class RowUnitState extends ConsumerState<RowUnit>
    with TickerProviderStateMixin {
  RowUnitState(this._name, this._isCheck, this.switchFunc);

  final String _name;
  bool _isCheck;
  Function switchFunc;

  void _switchChanged(isCheck) {
    _isCheck = isCheck;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            _name,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Switch(
          value: _isCheck,
          onChanged: (_) => {
            setState(() => {_switchChanged(_)}),
            switchFunc(_),
          },
        ),
      ],
    );
  }
}
