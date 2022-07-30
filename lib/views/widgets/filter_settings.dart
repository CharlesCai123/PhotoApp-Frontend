import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_family_story/models/providers/filter_providers.dart';

import 'button_menu/photo_page.dart';

/// Generated Temp Filter for Settings
late Filter tempFilter;
late ChangeNotifierProvider<Filter> tempFilterProvider;

/// Filter Overall Settings Profile
class FilterSettingsPage extends ConsumerStatefulWidget {
  final Filter? _routeArg;

  const FilterSettingsPage(this._routeArg, {Key? key}) : super(key: key);

  @override
  FilterSettingsPageState createState() => FilterSettingsPageState(_routeArg);
}

class FilterSettingsPageState extends ConsumerState<FilterSettingsPage>
    with TickerProviderStateMixin {
  final Filter? _routeArg;

  FilterSettingsPageState(this._routeArg);

  @override
  void initState() {
    super.initState();

    if (_routeArg != null) {
      tempFilter = _routeArg!.deepCopy();
    } else {
      var name = "Filter" + filterCnt.toString();
      tempFilter = Filter(name);
    }
    tempFilterProvider = ChangeNotifierProvider((ref) => tempFilter);
  }

  @override
  Widget build(BuildContext context) {
    final _filters = ref.watch(filtersProvider);
    final _tempFilter = ref.watch(tempFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Settings"),
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text(
                  "Confirmation",
                  textAlign: TextAlign.center,
                ),
                titleTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
                //actionsOverflowButtonSpacing: 20,
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  SizedBox(
                    width: 70,
                    height: 35,
                    //padding: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text(
                        "No",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 35,
                    //padding: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/home/filter");
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
                content: const Text(
                  "Are you going to give up present settings?",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: FilterSettingsBoard(_routeArg),
          ),
          const Expanded(
            flex: 6,
            child: PhotoPage(),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 100,
              width: 200,
              child: ElevatedButton(
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  if (_routeArg != null) {
                    var index = _filters.filters.indexOf(_routeArg!);
                    _filters.filters[index] = _tempFilter;
                  } else {
                    _filters.filters.add(tempFilter);
                    filterCnt++;
                  }
                  Navigator.pushNamed(context, "/home/filter");
                },
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Filter Settings Sole Board
class FilterSettingsBoard extends ConsumerStatefulWidget {
  final Filter? _originFilter;

  const FilterSettingsBoard(this._originFilter, {Key? key}) : super(key: key);

  @override
  FilterSettingsBoardState createState() =>
      FilterSettingsBoardState(_originFilter);
}

class FilterSettingsBoardState extends ConsumerState<FilterSettingsBoard>
    with TickerProviderStateMixin {
  final Filter? _originFilter;

  FilterSettingsBoardState(this._originFilter);

  late List<ListTile> _filterGroupWidget;

  bool isEditable = false;

  int filterGroupOrder = 1;

  @override
  void initState() {
    super.initState();
    final _tempFilter = ref.read(tempFilterProvider);

    _filterGroupWidget = [];

    for (int i = 0; i < _tempFilter.filterGroup.length; i++) {
      var filterGrpUI =
          FilterGroupUI(_tempFilter.filterGroup[i], _filterGroupWidget);
      ListTile temp = ListTile(
        title: filterGrpUI,
        key: ValueKey(_tempFilter.filterGroup[i]),
      );
      _filterGroupWidget.add(temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _filters = ref.watch(filtersProvider);
    final _tempFilter = ref.watch(tempFilterProvider);

    final TextEditingController _textController =
        TextEditingController(text: _tempFilter.filterName);

    return SingleChildScrollView(
      controller: ScrollController(),
      child: ExpansionTile(
        initiallyExpanded: true,
        backgroundColor: const Color.fromRGBO(145, 174, 242, 1),
        children: _filterGroupWidget,
        title: Container(
          color: const Color.fromRGBO(145, 174, 242, 1),
          child: ListTile(
            title: !isEditable
                ? Container(
                    alignment: Alignment.center,
                    child: Text(
                      _tempFilter.filterName,
                      style: const TextStyle(fontSize: 16),
                    ),
                  )
                : TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Please Input the Photo Filter Name",
                      labelText: "Filter Name",
                      labelStyle: const TextStyle(color: Colors.blue),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: _textController.clear),
                    ),
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      setState(
                        () => {
                          isEditable = false,
                          _tempFilter.filterName = value,
                        },
                      );
                    },
                  ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 40,
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(
                        () => {
                          isEditable ^= true,
                          _textController.text = _tempFilter.filterName,
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(
                        () {
                          var groupName =
                              "Filter Group" + (filterGroupOrder++).toString();
                          var newFilterGroup = FilterGroup(groupName);
                          _tempFilter.addFilterGroup(newFilterGroup);
                          if (_tempFilter.filterGroup.length == 1) {
                            newFilterGroup.logicOperator = null;
                          }

                          ListTile temp = ListTile(
                            title: FilterGroupUI(
                                newFilterGroup, _filterGroupWidget),
                            key: ValueKey(newFilterGroup),
                          );
                          _filterGroupWidget.add(temp);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: IconButton(
                    onPressed: () => {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text(
                            "Confirmation",
                            textAlign: TextAlign.center,
                          ),
                          titleTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20),
                          //actionsOverflowButtonSpacing: 20,
                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                          actions: [
                            SizedBox(
                              width: 70,
                              height: 35,
                              //padding: EdgeInsets.only(bottom: 10),
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text(
                                  "No",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 70,
                              height: 35,
                              //padding: EdgeInsets.only(bottom: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  _filters.filters.removeWhere(
                                      (element) => element == _originFilter);
                                  Navigator.pushNamed(context, "/home/filter");
                                },
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                          content: const Text(
                            "Do you want to delete the filter?",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Filter Group UI Page
class FilterGroupUI extends ConsumerStatefulWidget {
  final List<ListTile> _filterGroupWidget;
  final FilterGroup _filterGroup;

  const FilterGroupUI(this._filterGroup, this._filterGroupWidget, {Key? key})
      : super(key: key);

  @override
  FilterGroupUIState createState() =>
      FilterGroupUIState(_filterGroup, _filterGroupWidget);
}

class FilterGroupUIState extends ConsumerState<FilterGroupUI>
    with TickerProviderStateMixin {
  final FilterGroup _filterGroup;
  final List<ListTile> _filterGroupWidget;
  late ChangeNotifierProvider<FilterGroup> _filterGrpProvider;

  bool? _logicValue;

  FilterGroupUIState(this._filterGroup, this._filterGroupWidget);

  bool isEditable = false;
  late List<ListTile> _filterRuleWidget;

  @override
  void initState() {
    super.initState();
    _filterGrpProvider = ChangeNotifierProvider((ref) => _filterGroup);

    _filterRuleWidget = [];
    for (int i = 0; i < _filterGroup.filterRule.length; i++) {
      var filterRuleUI = FilterRuleUI(
          _filterGroup, _filterGroup.filterRule[i], _filterRuleWidget);
      ListTile temp = ListTile(
        title: filterRuleUI,
        key: ValueKey(_filterGroup.filterRule[i]),
      );
      _filterRuleWidget.add(temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _tempFilter = ref.watch(tempFilterProvider);
    var _ = ref.watch(_filterGrpProvider);

    _logicValue = _filterGroup.logicOperator;

    final TextEditingController _textController =
        TextEditingController(text: _filterGroup.filterGroupName);

    return Card(
      color: const Color.fromRGBO(153, 238, 255, 1),
      child: ExpansionTile(
        backgroundColor: const Color.fromRGBO(153, 238, 255, 1),
        children: _filterRuleWidget,
        leading: _logicValue == null
            ? const SizedBox(
                width: 53,
              )
            : Card(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _logicValue,
                    items: const [
                      DropdownMenuItem(
                        child: Text("And"),
                        value: true,
                      ),
                      DropdownMenuItem(
                        child: Text("Or"),
                        value: false,
                      )
                    ],
                    onChanged: (bool? value) {
                      setState(() {
                        _filterGroup.logicOperator = value;
                      });
                    },
                  ),
                ),
              ),
        title: ListTile(
          title: Container(
            child: !isEditable
                ? Container(
                    alignment: Alignment.center,
                    child: Text(
                      _filterGroup.filterGroupName,
                      style: const TextStyle(fontSize: 18),
                    ),
                  )
                : TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Please Input the Filter Group Name",
                      labelText: "Filter Group Name",
                      labelStyle: const TextStyle(color: Colors.blue),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: _textController.clear),
                    ),
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      setState(
                        () => {
                          isEditable = false,
                          _filterGroup.filterGroupName = value,
                        },
                      );
                    },
                  ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 40,
                child: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(
                      () => {
                        isEditable ^= true,
                        _textController.text = _filterGroup.filterGroupName,
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(
                      () {
                        var newFilterRule = FilterRule();
                        var filterRuleUI = FilterRuleUI(
                            _filterGroup, newFilterRule, _filterRuleWidget);
                        ListTile temp = ListTile(
                          title: filterRuleUI,
                          key: ValueKey(newFilterRule),
                        );
                        _filterRuleWidget.add(temp);
                        _filterGroup.addFilterRule(newFilterRule);
                        // _filterGroup.filterRule.add(newFilterRule);
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text(
                          "Confirmation",
                          textAlign: TextAlign.center,
                        ),
                        titleTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                        //actionsOverflowButtonSpacing: 20,
                        actionsAlignment: MainAxisAlignment.spaceEvenly,
                        actions: [
                          SizedBox(
                            width: 70,
                            height: 35,
                            //padding: EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text(
                                "No",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            height: 35,
                            //padding: EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(
                                  () {
                                    _tempFilter.removeFilterGroup(_filterGroup);
                                    _filterGroupWidget.removeWhere((element) =>
                                        element.key == ValueKey(_filterGroup));
                                  },
                                );
                                Navigator.pop(context, true);
                              },
                              child: const Text(
                                "Yes",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                        content: const Text(
                          "Do you want to delete the filter group?",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterRuleUI extends ConsumerStatefulWidget {
  final List<ListTile> _filterRuleWidget;
  final FilterRule _filterRule;
  final FilterGroup _filterGroup;

  const FilterRuleUI(
      this._filterGroup, this._filterRule, this._filterRuleWidget,
      {Key? key})
      : super(key: key);

  @override
  FilterRuleUIState createState() =>
      FilterRuleUIState(_filterGroup, _filterRule, _filterRuleWidget);
}

class FilterRuleUIState extends ConsumerState<FilterRuleUI> {
  final FilterGroup _filterGroup;
  final FilterRule _filterRule;
  final List<ListTile> _filterRuleWidget;
  late ChangeNotifierProvider<FilterGroup> _filterGrpProvider;

  FilterRuleUIState(
      this._filterGroup, this._filterRule, this._filterRuleWidget);

  @override
  void initState() {
    super.initState();
    _filterGrpProvider = ChangeNotifierProvider((ref) => _filterGroup);
  }

  @override
  Widget build(BuildContext context) {
    var _ = ref.watch(_filterGrpProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
      child: Card(
        color: const Color.fromRGBO(68, 204, 255, 1),
        child: ListTile(
          leading: _filterRule.logicOperator == null
              ? Container(
                  width: 61,
                )
              : Card(
                  //color: const Color.fromRGBO(68, 204, 255, 1),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _filterRule.logicOperator,
                      items: const [
                        DropdownMenuItem(
                          child: Text(
                            "And",
                            textAlign: TextAlign.center,
                          ),
                          value: true,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "Or",
                            textAlign: TextAlign.center,
                          ),
                          value: false,
                        ),
                      ],
                      onChanged: (bool? value) {
                        setState(
                          () {
                            _filterRule.logicOperator = value!;
                          },
                        );
                      },
                    ),
                  ),
                ),
          title: Row(
            children: [
              Expanded(
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _filterRule.subject,
                        items: const [
                          DropdownMenuItem(
                            child: Text("People"),
                            value: Subjects.people,
                          ),
                          DropdownMenuItem(
                            child: Text("Source"),
                            value: Subjects.source,
                          ),
                          DropdownMenuItem(
                            child: Text("Create Time"),
                            value: Subjects.createTime,
                          )
                        ],
                        onChanged: (Subjects? value) {
                          setState(
                            () {
                              _filterRule.subject = value!;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _filterRule.predicate,
                        items: const [
                          DropdownMenuItem(
                            child: Text("Contains"),
                            value: Predicates.contains,
                          ),
                          DropdownMenuItem(
                            child: Text("In"),
                            value: Predicates.in_,
                          ),
                          DropdownMenuItem(
                            child: Text("Before"),
                            value: Predicates.before,
                          ),
                        ],
                        onChanged: (Predicates? value) {
                          setState(
                            () {
                              _filterRule.predicate = value!;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _filterRule.object,
                        items: const [
                          DropdownMenuItem(
                            child: Text("Person"),
                            value: Objects.person,
                          ),
                          DropdownMenuItem(
                            child: Text("Place"),
                            value: Objects.place,
                          ),
                          DropdownMenuItem(
                            child: Text("Time Line"),
                            value: Objects.timeLine,
                          ),
                          DropdownMenuItem(
                            child: Text("Value"),
                            value: Objects.value,
                          ),
                        ],
                        onChanged: (Objects? value) {
                          setState(
                            () {
                              _filterRule.object = value!;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(
                () {
                  _filterGroup.removeFilterRule(_filterRule);
                  _filterRuleWidget.removeWhere(
                      (element) => element.key == ValueKey(_filterRule));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
