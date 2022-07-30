import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timelines/timelines.dart';

// Photo set number
int unitNum = 2;
const List photo1 = [
  "https://image.shutterstock.com/image-photo/laughing-fun-young-happy-parents-600w-1938829744.jpg",
  "https://image.shutterstock.com/image-photo/portrait-three-nice-attractive-lovely-600w-1478632532.jpg",
  "https://image.shutterstock.com/image-photo/asian-chinese-mother-caucasian-father-600w-1547727188.jpg",
  "https://image.shutterstock.com/image-photo/portrait-family-walking-along-coastal-600w-208005658.jpg",
];

const List photo2 = [
  "https://image.shutterstock.com/image-photo/smiling-father-mother-son-pet-600w-1853535634.jpg",
  "https://image.shutterstock.com/image-photo/portrait-happy-family-laying-down-600w-357705146.jpg",
  "https://image.shutterstock.com/image-photo/happy-family-enjoying-sunset-summer-600w-1023017290.jpg",
  "https://image.shutterstock.com/image-photo/portrait-lovely-adult-guy-woman-600w-1498856759.jpg",
];

class PhotoPage extends ConsumerStatefulWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  PhotoPageState createState() => PhotoPageState();
}

class PhotoPageState extends ConsumerState<PhotoPage>
    with TickerProviderStateMixin {
  List<Widget> photos = [];

  @override
  void initState() {
    for (int i = 0; i < unitNum; i++) {
      if (i == 0) {
        photos.add(
          const PhotoPageUnit(photo1, "2022"),
        );
      } else {
        photos.add(
          const PhotoPageUnit(photo2, "2021"),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        //padding: EdgeInsets.only(left: 20),
        height: 50.0,
        width: 50.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => SimpleDialog(
                  titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: [
                      ListTile(
                        onTap: () {
                          print("hello");
                        },
                        title: const Center(
                          child: Text("Add Private"),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          print("hello");
                        },
                        title: const Center(
                          child: Text("View Private"),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          print("hello");
                        },
                        title: const Center(
                          child: Text("Select"),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          print("hello");
                        },
                        title: const Center(
                          child: Text("View Selected"),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          print("hello");
                        },
                        title: const Center(
                          child: Text("Add Metadata"),
                        ),
                      ),
                    ],
                  ).toList(),
                ),
              );
            },
          ),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: photos,
      ),
    );
  }
}

class PhotoPageUnit extends ConsumerStatefulWidget {
  const PhotoPageUnit(this._photoList, this._year, {Key? key})
      : super(key: key);
  final List _photoList;
  final String _year;

  @override
  PhotoPageUnitState createState() =>
      PhotoPageUnitState(this._photoList, this._year);
}

class PhotoPageUnitState extends ConsumerState<PhotoPageUnit>
    with TickerProviderStateMixin {
  final List _photoList;
  final String _year;

  PhotoPageUnitState(this._photoList, this._year);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 15,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
            children: List.generate(
              _photoList.length,
              (index) => Container(
                padding: const EdgeInsets.all(20),
                child: Image.network(
                  _photoList[index],
                  // width: 300,
                  // height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: TimelineNode(
            indicator: Card(
              margin: EdgeInsets.zero,
              child: Text(_year),
            ),
            startConnector: DashedLineConnector(),
            endConnector: SolidLineConnector(),
          ),
        ),
      ],
    );
  }
}
