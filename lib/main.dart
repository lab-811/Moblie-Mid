import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculatorApp(),
    );
  }
}

class SimpleCalculatorApp extends StatefulWidget {
  @override
  _SimpleCalculatorAppState createState() => _SimpleCalculatorAppState();
}



class _SimpleCalculatorAppState extends State<SimpleCalculatorApp> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
    setState(() {

      switch(buttonText){
        case "C":
          equation = "0";
          result = "0";
          break;
        case "±":
          equation = "-" + equation;
          break;
        case "=":
          expression = equation;
          expression = expression.replaceAll('×', '*');
          expression = expression.replaceAll('÷', '/');

          try{
            Parser p = Parser();
            Expression exp = p.parse(expression);

            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          }catch(e){
            result = "Error";
          }
          break;
        default:
          if(equation == "0"){
            equation = buttonText;
          }else {
            equation = equation + buttonText;
          }

      }

    });
  }

  Widget buildButton(String buttonText, double buttonHeight, int buttonColor, {double buttonWidth = 0.0}){
    return  Container(

      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: Color(buttonColor),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.black,
              width: 1,
              style: BorderStyle.solid
          ),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF303030),
      body: Column(
        children: <Widget>[

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 300, 40, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize, color: Colors.white),
            ),
          ),

          Container(

            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 40, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize,color: Colors.white),
            ),
          ),
          Expanded(

            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("C", 1, 0xFF424242),
                          buildButton("±", 1, 0xFF424242),
                          buildButton("%", 1, 0xFF424242),
                          // buildButton("÷", 1, Colors.redAccent),

                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("7", 1, 0xFF616161),
                          buildButton("8", 1, 0xFF616161),
                          buildButton("9", 1, 0xFF616161),
                          // buildButton("X", 1, Colors.black54),

                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("4", 1, 0xFF616161),
                          buildButton("5", 1, 0xFF616161),
                          buildButton("6", 1, 0xFF616161),
                          // buildButton("-", 1, Colors.black54),

                        ]
                    ),


                    TableRow(
                        children: [
                          buildButton("1", 1, 0xFF616161),
                          buildButton("2", 1, 0xFF616161),
                          buildButton("3", 1, 0xFF616161),
                          // buildButton("+", 1, Colors.black54),

                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("0", 1, 0xFF616161),
                          buildButton(".", 1, 0xFF616161),
                          buildButton("", 1, 0xFF616161),


                        ]
                    ),


                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("÷", 1, 0xFFFF8F00),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("×", 1, 0xFFFF8F00),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, 0xFFFF8F00),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, 0xFFFF8F00),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 1, 0xFFFF8F00),
                        ]
                    ),

                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}