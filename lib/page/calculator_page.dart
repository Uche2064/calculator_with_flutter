import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _digitOnScreen = "";

  // cette methode permet de mettre à jour les valeurs sur l'ecran
  // de la calculatrice
  void _addDigitToScreen(String text) {
    setState(() {
      _digitOnScreen += text;
    });
  }

  void _function(String digit) {
    if(digit == "C") {
      _digitOnScreen = "";
      _addDigitToScreen(_digitOnScreen);
    } else if(digit == "=") {
      Parser p = Parser();
      Expression exp = p.parse(_digitOnScreen);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      _digitOnScreen = "";
      _addDigitToScreen("$result");
    } else {
      _addDigitToScreen(digit);
    }
  }
// cette methode retourne un Elevated button pour chaque chiffre
  Widget _onCharClick(String digit, {color = Colors.white10}) {

    return ElevatedButton(
        onPressed: () {
          _function(digit);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.all(25),
          shape: CircleBorder()
        ),
        child: Text(
          "$digit",
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
          ),
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            // container d'affichage des opérations
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(20),
                width: 500,
                color: Colors.white,
                child: Text(
                    "$_digitOnScreen",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                    ),
                )
              ),
            ),
            // container d'affichage du tableau
            Expanded(
              flex: 2,
               child: Container(
                 color: Colors.white10,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         _onCharClick("C"),
                         _onCharClick("+"),
                         _onCharClick("%"),
                         _onCharClick("/", color: Colors.orange),
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         _onCharClick("7"),
                         _onCharClick("8"),
                         _onCharClick("9"),
                         _onCharClick("*", color: Colors.orange),
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         _onCharClick("4"),
                         _onCharClick("5"),
                         _onCharClick("6"),
                         _onCharClick("-", color: Colors.orange),
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         _onCharClick("1"),
                         _onCharClick("2"),
                         _onCharClick("3"),
                         _onCharClick("+", color: Colors.orange),
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         _onCharClick("0"),
                         _onCharClick("."),
                         _onCharClick("=", color: Colors.orange),
                       ],
                     ),
                   ],
                 ),
               ),
            ),
          ],
        ),
      )
    );
  }
}
