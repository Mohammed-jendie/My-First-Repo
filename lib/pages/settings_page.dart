import 'package:calculator/data/notifiers.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: const Color.fromARGB(206, 255, 153, 0),
        actions: [
          PopupMenuButton(
            popUpAnimationStyle: AnimationStyle(
              curve: FlippedCurve(Curves.slowMiddle),
            ),
            shadowColor: Colors.orange,
            elevation: 2,
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    child: Text('Bmi Calculator'),
                    onTap: () {
                      Navigator.pushNamed(context, 'Bmi');
                    },
                  ),
                  PopupMenuItem(
                    child: Text('About'),
                    onTap: () {
                      Navigator.pushNamed(context, 'About');
                    },
                  ),
                ],
          ),
        ],
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: isDarkModeNotifier,
            builder: (context, isDarkmode, child) {
              return SwitchListTile(
                title: Text('Enable Light mode'),
                value: !isDarkModeNotifier.value,
                onChanged: (value) {
                  setState(() {
                    isDarkModeNotifier.value = !isDarkModeNotifier.value;
                  }
                  );
                  
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
