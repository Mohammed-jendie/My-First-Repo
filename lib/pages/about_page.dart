import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
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
                    child: Text('Settings'),
                    onTap: () {
                      Navigator.pushNamed(context, 'Settings');
                    },
                  ),
                ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 60),
            Image.asset('assets/images/bg.jpg'),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {},
              child: Text(
                'version 1.0.0',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: Colors.orange,
                  fontSize: 20,
                  color: Colors.orange,
                ),
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Calculator.playstore@gamil.com ',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: Colors.orange,
                  fontSize: 20,
                  color: Colors.orange,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'www.calculatorjendie.com',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                decorationColor: Colors.orange,
                fontSize: 20,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Report an issue',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                decorationColor: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
                color: const Color.fromARGB(255, 255, 254, 254),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Privacy & Policy',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                decorationColor: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
                color: const Color.fromARGB(255, 255, 254, 254),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
