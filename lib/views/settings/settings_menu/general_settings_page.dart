import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_family_story/models/providers/settings_provider.dart';

class GeneralSettingsPage extends ConsumerStatefulWidget {
  const GeneralSettingsPage({Key? key}) : super(key: key);

  @override
  GeneralSettingsPageState createState() => GeneralSettingsPageState();
}

class GeneralSettingsPageState extends ConsumerState<GeneralSettingsPage>
    with TickerProviderStateMixin {
  final int _width = 500;
  final int _height = 150;

  @override
  Widget build(BuildContext context) {
    final _settingsProvider = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('General Settings')),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                const Text(
                                  "Enable Cache",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Tooltip(
                                  preferBelow: false,
                                  waitDuration: const Duration(seconds: 1),
                                  message: "50% size",
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.info,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            //padding: const EdgeInsets.only(right: 30),
                            child: Switch(
                              value: _settingsProvider.isEnableCacheOn,
                              onChanged: (_) => {
                                _settingsProvider.cacheChanged(_),
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 10,
                                    child: Text(
                                      "Max Cache Size",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      //padding: EdgeInsets.only(right: 20),
                                      child: Tooltip(
                                        preferBelow: false,
                                        waitDuration:
                                            const Duration(seconds: 1),
                                        message: "50% size",
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.info,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              //alignment: Alignment.center,
                              //padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 60,
                                    child: Slider(
                                      min: 0,
                                      max: 1000,
                                      divisions: 100,
                                      //label: _sliderValue.round().toString(),
                                      value: _settingsProvider.sliderValue,
                                      onChanged: (v) {
                                        setState(
                                          () {
                                            _settingsProvider.sliderValue = v;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 11,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        _settingsProvider.sliderValue
                                            .round()
                                            .toString(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 10,
                                    child: Text(
                                      " MB",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: const [
                                Text(
                                  "Current Cache Size",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 10),
                            child: const Text(
                              "200 MB",
                              style: TextStyle(fontSize: 16),
                            ),
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
      ),
    );
  }
}
