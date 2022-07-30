import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_family_story/models/providers/settings_provider.dart';

class BackupSettingsPage extends ConsumerStatefulWidget {
  const BackupSettingsPage({Key? key}) : super(key: key);

  @override
  BackupSettingsPageState createState() => BackupSettingsPageState();
}

class BackupSettingsPageState extends ConsumerState<BackupSettingsPage>
    with TickerProviderStateMixin {
  final int _width = 500;
  final int _height = 750;

  bool _isEditable = false;

  @override
  Widget build(BuildContext context) {
    final _settingsProvider = ref.watch(settingsProvider);
    final TextEditingController _textController =
        TextEditingController(text: _settingsProvider.srcDirName);

    return Scaffold(
      appBar: AppBar(title: const Text('Backup Settings')),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: Scrollbar(
            child: ListView(
          children: [
            SizedBox(
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
                                child: const Text(
                                  "Backup On/Off",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Switch(
                                value: _settingsProvider.isBackupOn,
                                onChanged: (_) => {
                                  _settingsProvider.backupChanged(_),
                                },
                              ),
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
                                        flex: 19,
                                        child: Text(
                                          "Upload on un-metered WiFi only",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 10,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
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
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Switch(
                                    value: _settingsProvider.isUploadWiFiOn,
                                    onChanged: (_) => {
                                      _settingsProvider.uploadWiFiChanged(_),
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: !_isEditable
                                        ? Container(
                                            //alignment: Alignment.center,
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              _settingsProvider.srcDirName,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          )
                                        : TextFormField(
                                            controller: _textController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText:
                                                  "Please Input the Source Directory Name",
                                              labelText:
                                                  "Source Directory Name",
                                              labelStyle: const TextStyle(
                                                  color: Colors.blue),
                                              suffixIcon: IconButton(
                                                  icon: const Icon(Icons.close),
                                                  onPressed:
                                                      _textController.clear),
                                            ),
                                            //initialValue: _laptopName,
                                            textInputAction:
                                                TextInputAction.done,
                                            onFieldSubmitted: (value) {
                                              setState(
                                                () => {
                                                  _isEditable = false,
                                                  _settingsProvider.srcDirName =
                                                      value,
                                                },
                                              );
                                            },
                                          ),
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
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  setState(
                                    () => {
                                      _isEditable ^= true,
                                      _textController.text =
                                          _settingsProvider.srcDirName,
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: const Text(
                                  "Upload Filter",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Switch(
                                value: _settingsProvider.isUploadFilterOn,
                                onChanged: (_) => {
                                  _settingsProvider.uploadFilterChanged(_),
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 200,
                            width: 450,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                color: Color.fromRGBO(171, 191, 237, 1),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Inclusive",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Tooltip(
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
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 100),
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Photo Library",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Exclusive",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Tooltip(
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
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 100),
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Not Photos with John",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 100),
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Not Photos taken in Boston",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    const Text(
                                      "Free up Device Space",
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
                            ],
                          ),
                          SizedBox(
                            height: 200,
                            width: 450,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                color: Color.fromRGBO(153, 238, 255, 1),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: const Text(
                                      "Photos 6 months and Older 10GB",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    child: const Text(
                                      "Photos 1 year and Older 8GB",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    child: const Text(
                                      "Photos 2 years and Older 4GB",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
