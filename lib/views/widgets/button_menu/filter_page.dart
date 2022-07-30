import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_family_story/models/providers/filter_providers.dart';

class FilterPage extends ConsumerStatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  FilterPageState createState() => FilterPageState();
}

class FilterPageState extends ConsumerState<FilterPage>
    with TickerProviderStateMixin {
  final List<FilterItem> _filters = [];

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    var _filterProvider = ref.watch(filtersProvider);

    for (int i = 0; i < _filterProvider.filters.length; i++) {
      _filters.add(FilterItem(_filterProvider.filters[i]));
    }

    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 15),
            alignment: Alignment.center,
            child: SizedBox(
              height: 50,
              width: 120,
              child: ElevatedButton(
                child: const Text(
                  "Filter",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/filter/filter_settings',
                      arguments: null);
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
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
            child: const Text(
              "Saved Filters",
              style: TextStyle(fontSize: 20),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            children: _filters,
            /*[
              FilterItem(imageList[0], "Jason"),
              FilterItem(imageList[1], "Big Mountains"),
              FilterItem(imageList[2], "Cats"),
              FilterItem(imageList[3], "In California"),
              FilterItem(imageList[4], "Anna Laughing"),
              FilterItem(imageList[5], "Sunset"),
            ],*/
          ),
        ],
      ),
    );
  }
}

class FilterItem extends ConsumerStatefulWidget {
  Filter _filter;

  FilterItem(this._filter);

  @override
  FilterItemState createState() => FilterItemState(_filter);
}

class FilterItemState extends ConsumerState<FilterItem>
    with TickerProviderStateMixin {
  Filter _filter;

  FilterItemState(this._filter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: () => {
          Navigator.pushNamed(
            context,
            "/filter/filter_settings",
            arguments: _filter,
          ),
        },
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Image.network(
                  _filter.photoUrl,
                  height: 400,
                  width: 400,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Container(
                //margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  _filter.filterName,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
