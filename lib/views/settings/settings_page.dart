import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends ConsumerState<SettingsPage>
    with TickerProviderStateMixin {
  final int _barWidth = 300;
  final int _barHeight = 40;
  late final TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: _barWidth.toDouble(),
                height: _barHeight.toDouble(),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/storage_unit_config',
                    );
                  },
                  child: const Text("Storage Unit Config"),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(width: 1, color: Color(0xffCAD0DB))),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: _barWidth.toDouble(),
                height: _barHeight.toDouble(),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/compute_unit_config',
                      );
                    },
                    child: const Text("Compute Unit Config")),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: _barWidth.toDouble(),
                height: _barHeight.toDouble(),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/backup_settings',
                    );
                  },
                  child: const Text("Backup Settings"),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(width: 1, color: Color(0xffCAD0DB))),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: _barWidth.toDouble(),
                height: _barHeight.toDouble(),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/encryption_settings',
                      );
                    },
                    child: const Text("Encryption Settings")),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: _barWidth.toDouble(),
                height: _barHeight.toDouble(),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/general_settings',
                      );
                    },
                    child: const Text("General Settings")),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: _barWidth.toDouble(),
                height: _barHeight.toDouble(),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/privacy_settings',
                      );
                    },
                    child: const Text("Privacy Settings")),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: _barWidth.toDouble(),
                height: _barHeight.toDouble(),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/notification_settings',
                      );
                    },
                    child: const Text("Notification Settings")),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
