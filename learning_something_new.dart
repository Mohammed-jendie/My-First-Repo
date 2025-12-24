
import 'dart:math';
void main() {
  //--------------------------------Learining Map method----------------------------------------
  num result = pow(3, 2);
  print(result);
  //? Ex1:
  List mobile = ["Note 30", "Hot50", "Note 13", "Hot 40 pro"];

  var numberLength = mobile.map((value) => value.length);
  // ignore: avoid_print
  print(numberLength);

  //? Ex2:
  var mymobile = mobile.map((e) {
    if (e == "Note 30") {
      return 'yes';
    }
    return 'No';
  });
  // ignore: avoid_print
  print(mymobile); // (yes, No, No, No)

  String string1 = "Hello";
  String string2 = "World";
  String weclome = string2 += string1;

  // ignore: avoid_print
  print(weclome);

  //---------------------------------tryparse_method----------------------------------
  int A = 15;
  var value = "oop";
  if (A > 10 && int.tryParse(value) == null) {
    // tryparse try to convert value to a int number
    // if it sucsses return this number else return null and null == null && 15>10 ==> true
    // ignore: avoid_print
    print("done");
  }
}

//-------------------------------------- async library -----------------------------------------------
//هي مجموعة من الأدوات والوظائف التي تدعم البرمجة غير المتزامنة (Timers,streams,futures)
