import 'exam1.dart';

void main() {

  var info = studentInfo();
  print(info[2]); 

  print(circleArea(7));
  print(circleArea(20));
  print(circleArea(0));
  print(circleArea(-10));

  try {
    print(parseAndAddOne("1")); 
    print(parseAndAddOne(null)); 
    print(parseAndAddOne("a")); 
  } catch (e) {
    print(e); 
  }
}

