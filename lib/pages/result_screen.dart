import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.result});
  final double result;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 60),

          Text("              Your Result", style: TextStyle(fontSize: 30)),
          SizedBox(height: 30),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromARGB(255, 93, 93, 93),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    classifyBmi(widget.result),
                    style: TextStyle(
                      color:
                          (widget.result < 18 || widget.result >= 30)
                              ? Colors.red
                              : Colors.green,
                      fontSize: 35,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    widget.result.round().toString(),
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(height: 60),
                  Text(advice(widget.result), style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed("Bmi");
              },
              style: ElevatedButton.styleFrom(fixedSize: Size(350, 20)),
              child: Text(
                "Re-Calculate",
                style: TextStyle(fontSize: 20, color: Colors.amber),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//?--------------------------------------  Classify Function -------------------------------------------------
String classifyBmi(double bmi) {
  if (bmi < 18.5) {
    return "UnderWeight";
  } else if (bmi < 25) {
    return "Normal weight";
  } else if (bmi < 30) {
    return "Overweight";
  } else
    // ignore: curly_braces_in_flow_control_structures
    return "Obese";
}

//?------------------------------------------ Advice Function --------------------------------------------
String advice(double bmi) {
  if (bmi < 18.5) {
    return "You should eat more :) ";
  } else if (bmi < 25) {
    return "Good job";
  } else if (bmi < 30) {
    return "Hmm i think you should eat less and do some exercises";
  } else
    // ignore: curly_braces_in_flow_control_structures
    return "You should to follow a hard system";
}
