import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_family_story/models/providers/settings_provider.dart';

/// Unit Number returned by Restful
int unitNum = 1;

class StorageUnitConfigPage extends ConsumerStatefulWidget {
  const StorageUnitConfigPage({Key? key}) : super(key: key);

  @override
  StorageUnitConfigPageState createState() => StorageUnitConfigPageState();
}

class StorageUnitConfigPageState extends ConsumerState<StorageUnitConfigPage>
    with TickerProviderStateMixin {
  List<Widget> models = [];

  @override
  void initState() {
    for (int i = 0; i < unitNum; i++) {
      if (i == 0) {
        models.add(
          const StorageUnitConfigModel(
            key: Key("storage1"),
          ),
        );
      } else {
        models.add(
          const StorageUnitConfigModel(
            key: Key("storage2"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Storage Unit Config')),
      body: Scrollbar(
        child: Container(
          //padding: EdgeInsets.only(top: 20),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: models,
          ),
        ),
      ),
    );
  }
}

/// Unit Model
class StorageUnitConfigModel extends ConsumerStatefulWidget {
  const StorageUnitConfigModel({Key? key}) : super(key: key);

  @override
  StorageUnitConfigModelState createState() => StorageUnitConfigModelState();
}

class StorageUnitConfigModelState extends ConsumerState<StorageUnitConfigModel>
    with TickerProviderStateMixin {
  final int _width = 450;
  final int _height = 400;

  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    final _settingsProvider = ref.watch(settingsProvider);

    final TextEditingController _textController =
        TextEditingController(text: _settingsProvider.storageLaptopName);

    return Container(
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: !isEditable
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      _settingsProvider.storageLaptopName,
                                      style: const TextStyle(fontSize: 16),
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
                                      hintText: "Please Input Your Laptop Name",
                                      labelText: "Laptop Name",
                                      labelStyle:
                                          const TextStyle(color: Colors.blue),
                                      suffixIcon: IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: _textController.clear),
                                    ),
                                    //initialValue: _laptopName,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (value) {
                                      setState(
                                        () => {
                                          isEditable = false,
                                          _settingsProvider.storageLaptopName =
                                              value,
                                        },
                                      );
                                    },
                                  ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              setState(
                                () => {
                                  isEditable ^= true,
                                  _textController.text =
                                      _settingsProvider.storageLaptopName,
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: const ListTile(
                                title: Text("Status :"),
                                leading: Icon(Icons.computer),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(right: 15),
                              child: const Text(
                                "Active",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 26,
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: const ListTile(
                                title: Text("Last Refresh Time :"),
                                leading: Icon(Icons.refresh),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 23,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(right: 15),
                              child: const Text(
                                "6 minutes ago",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: const ListTile(
                                title: Text("Disk Usage :"),
                                leading: Icon(Icons.album_rounded),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(right: 15),
                              child: const Text(
                                "6 GB Used / 100 GB Available",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.only(left: 25),
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 7,
                                    child: Text(
                                      "Resize   Photos",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.info,
                                          color: Colors.blue,
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
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Switch(
                                      value: _settingsProvider.isResizePhotosOn,
                                      onChanged: (_) => {
                                        _settingsProvider
                                            .resizePhotosChanged(_),
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "50%",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.info,
                                          color: Colors.blue,
                                        ),
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
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.only(left: 25),
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 7,
                                    child: Text(
                                      "Resize   Videos",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.info,
                                          color: Colors.blue,
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
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Switch(
                                      value: _settingsProvider.isResizeVideosOn,
                                      onChanged: (_) => {
                                        _settingsProvider
                                            .resizeVideosChanged(_),
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "50%",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.info,
                                          color: Colors.blue,
                                        ),
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
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.only(left: 25),
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 19,
                                    child: Text(
                                      "Encrypt   Videos",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 25,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.info,
                                          color: Colors.blue,
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
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Switch(
                                      value: _settingsProvider.isEncryptVideoOn,
                                      onChanged: (_) => {
                                        _settingsProvider
                                            .encryptVideoChanged(_),
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "50%",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
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
                        ],
                      ),
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
