import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_family_story/models/providers/settings_provider.dart';

/// Unit Number returned by Restful
int unitNum = 1;

class ComputeUnitConfigPage extends ConsumerStatefulWidget {
  const ComputeUnitConfigPage({Key? key}) : super(key: key);

  @override
  ComputeUnitConfigPageState createState() => ComputeUnitConfigPageState();
}

class ComputeUnitConfigPageState extends ConsumerState<ComputeUnitConfigPage>
    with TickerProviderStateMixin {
  List<Widget> models = [];

  @override
  void initState() {
    for (int i = 0; i < unitNum; i++) {
      models.add(const ComputeUnitConfigModel());
    }
  }

  @override
  Widget build(BuildContext context) {
    print(models);
    return Scaffold(
      appBar: AppBar(title: const Text('Compute Unit Config')),
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
class ComputeUnitConfigModel extends ConsumerStatefulWidget {
  const ComputeUnitConfigModel({Key? key}) : super(key: key);

  @override
  ComputeUnitConfigModelState createState() => ComputeUnitConfigModelState();
}

class ComputeUnitConfigModelState extends ConsumerState<ComputeUnitConfigModel>
    with TickerProviderStateMixin {
  final int _width = 450;
  final int _height = 200;

  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    final _settingsProvider = ref.watch(settingsProvider);
    final TextEditingController _textController =
        TextEditingController(text: _settingsProvider.computeLaptopName);

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
                                      _settingsProvider.computeLaptopName,
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
                                          _settingsProvider.computeLaptopName =
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
                                      _settingsProvider.computeLaptopName,
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
                          const Expanded(
                            child: ListTile(
                              title: Text("Status :"),
                              leading: Icon(Icons.computer),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              //padding: EdgeInsets.only(right: 80),
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
                          const Expanded(
                            child: ListTile(
                              title: Text("Last Refresh Time :"),
                              leading: Icon(Icons.refresh),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              //padding: EdgeInsets.only(right: 80),
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
                          const Expanded(
                            child: ListTile(
                              title: Text("CPU Usage :"),
                              leading: Icon(Icons.memory_rounded),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              //padding: EdgeInsets.only(right: 80),
                              child: const Text(
                                "20% / 100 GB Available",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
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
