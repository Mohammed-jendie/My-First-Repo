import 'dart:async';
import 'dart:math';
import 'package:calculator/data/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:calculator/button_values.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = ""; // 0-9
  String operand = ""; // + - * / ^
  String number2 = ""; // 0-9
  bool pageview2 = true;

  bool showLottie = false;
  @override
  void initState() {
    super.initState();
    checkFirstLaunch();
  }

  Future<void> checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance(); // (1)
    final hasLaunchedBefore =
        prefs.getBool('has_launched_before') ?? false; // (2)

    if (!hasLaunchedBefore) {
      // (3)
      await prefs.setBool('has_launched_before', true); // (4)
      setState(() => showLottie = true); // (5)
      Timer(const Duration(seconds: 5), () {
        // (6)
        setState(() => showLottie = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.all(10),
          child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover),
        ),

        title: Text('Calculator'),
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
          //* Output-----------------------------------------------------------------------------------
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(16),
                child: Text(
                  "$number1$operand$number2".isEmpty
                      ? "0"
                      : pageview2
                      ? "$number1$operand$number2"
                      : "$operand$number1",
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          Divider(
            color: isDarkModeNotifier.value ? Colors.white12 : Colors.black,
            thickness: 3,
          ),

          //* buttons------------------------------------------------------------------------------
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView(
                  children: [
                    Expanded(
                      child: Wrap(
                        children:
                            Btn.buttonValues
                                .map(
                                  (value) => SizedBox(
                                    width:
                                        value == Btn.n0
                                            ? screenSize.width / 2
                                            : screenSize.width / 4,
                                    height: (screenSize.width / 5) - 4,
                                    child: buildButton(value),
                                  ),
                                )
                                .toList(),
                      ),
                    ),

                    Expanded(
                      child: Wrap(
                        children:
                            Btn.buttonValues1
                                .map(
                                  (value) => SizedBox(
                                    width: screenSize.width / 3,
                                    height: (screenSize.width / 4) - 6,
                                    child: buildButton(value),
                                  ),
                                )
                                .toList(),
                                
                      ),
                    ),
                  ],
                ),
                if (showLottie)
                  Lottie.asset("assets/lottie/Swipe Gesture Left.json"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(context,value),
  
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: Colors.white24),
        ),

        child: InkWell(
          onTap: () => onTapBtn(value),
          child: Center(
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }

  //############################################

  void onTapBtn(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clr) {
      clearAll();
      return;
    }

    if (value == Btn.per && number1.isEmpty) {
      return;
    }

    if (value == Btn.per) {
      convertToPercentage();
      return;
    }

    if (value == Btn.calculate) {
      calculate();
      return;
    }
    appendValue(value);
  }

  //------------------------------Calculate function (1)-------------------------------------------
  void calculate() {
    if (number1.isEmpty) return;
    if (operand.isEmpty) return;
    if (number2.isEmpty) return;

    double num1 = double.parse(number1);
    double num2 = double.parse(number2);

    num result = 0.0;

    switch (operand) {
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;
      case Btn.power:
        result = pow(num1, num2);
        break;
      default:
    }
    setState(() {
      number1 = '$result';
      if (number1.endsWith('.0')) {
        number1 = number1.substring(0, number1.length - 2);
      }

      operand = "";
      number2 = "";
    });
  }

  //------------------------------------convertToPercentage function--------------------------------------
  void convertToPercentage() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      //calculate before conversion
      calculate();
    }
    if (operand.isNotEmpty) {
      // 78- then user press on %
      return;
    }

    final number = double.parse(number1);
    setState(() {
      number1 = "${number / 100}";
      operand = "";
      number2 = "";
    });
  }

  //-------------------------------clear function -------------------------------------------
  void clearAll() {
    number1 = "";
    operand = "";
    number2 = "";
    setState(() {});
  }

  //----------------------------- delete funtion ------------------------------------------
  void delete() {
    if (number2.isNotEmpty) {
      // 234 ==> 23
      number2 = number2.substring(0, number2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }
    setState(() {});
  }

  //----------------------------------Append_Function(2)------------------------------------
  // void AppendValue(String value) {
  //   // operend   number1
  //   // sin         5
  //   if (value ==
  //           [
  //             Btn.sin,
  //             Btn.cos,
  //             Btn.tan,
  //             Btn.sqrt,
  //             Btn.positive,
  //             Btn.polytheism,
  //             Btn.ln,
  //             Btn.log,
  //             Btn.ex,
  //           ].contains(value) &&
  //       number1.isEmpty) {
  //     pageview2 = false;
  //     operand += value;
  //   }
  //   if (operand.isNotEmpty && value != Btn.dot) {
  //     number1 += value;
  //   }
  // }

  //---------------------------------Append_Function(1)------------------------------------
  void appendValue(String value) {
    // number1  operand  number2
    // 554         +       234
    if (value == Btn.add && number1.isEmpty) {
      return;
    }
    if (value == Btn.power && number1.isEmpty) {
      return;
    }
    if (value == Btn.subtract && number1.isEmpty) {
      number1 = '-';
      setState(() {});
      return;
    }
    if (value == Btn.multiply && number1.isEmpty) {
      return;
    }
    if (value == Btn.divide && number1.isEmpty) {
      return;
    }
    if (value != Btn.dot && int.tryParse(value) == null) {
      //operand pressed
      if (operand.isNotEmpty && number2.isNotEmpty) {
        calculate();
      }
      if (number1 != Btn.subtract) {
        operand = value;
      }
    }
    //assign value to number1 variable
    else if (number1.isEmpty || operand.isEmpty) {
      // "2313" "+"  ""
      if (value == Btn.dot && number1.contains(Btn.dot)) return; // number1==1.2
      if (value == Btn.dot && (number1.isEmpty)) {
        value = "0.";
      } // number1="" or number1= 0 then user press . ==> show (0.)
      number1 += value;
    }
    //assign value to number2 variable
    else if (number2.isEmpty || operand.isNotEmpty) {
      // "2313" "+"  ""
      if (value == Btn.dot && number2.contains(Btn.dot)) return; // number1==1.2
      if (value == Btn.dot && (number2.isEmpty)) {
        value = "0.";
      } // number1="" or number1= 0 then user press . ==> show (0.)
      number2 += value;
    }

    setState(() {});
  }
  //######################################################################

  Color getBtnColor(BuildContext context , value) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return [Btn.del, Btn.clr].contains(value)
        ? Colors.blueGrey
        : [
          Btn.per,
          Btn.multiply,
          Btn.divide,
          Btn.subtract,
          Btn.add,
          Btn.calculate,
        ].contains(value)
        ? const Color.fromARGB(221, 255, 153, 0)
        : isDarkMode
        ? Colors.black
        : Colors.grey;
  }
}
