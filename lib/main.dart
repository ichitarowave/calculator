import 'package:flutter/material.dart';
import 'buildbutton.dart';
void main() => runApp(const MyApp());
///　↓　class
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      theme:  ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home:  const MyHomePage(title: 'Calculator'),
    );
  }
}
/// ↑ class
///class
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() =>  _MyHomePageState();
}

///widgetからclassに
class BuildButton extends StatelessWidget {
  const BuildButton({
    required this.onPressed,
    required Key key,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build (String buttonText) {
    return Expanded(
      child: OutlinedButton(

          child: Text(buttonText,
            style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold
            ),
          ),
          onPressed: onPressed, =>
          onPressed(buttonText),
    ),
    );
  }
}
///ここまで





///class
class _MyHomePageState extends State<MyHomePage> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
/// ボタンを押したらどんな反応をさせるかの設計
  buttonPressed(String buttonText){
///　　もしクリアボタン押したら画面には0を出力
    if(buttonText == "CLEAR"){
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
///　　　そうじゃなくてもし、＋、ー、/、X,ボタンを押したらnum1にdouble.parseを代入する。画面上は０のまま。
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "X"){
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
      ///クリアじゃなく演算子でもなく　.ボタンでさらに.ボタン押されたらすでに含まれていると出力
    } else if(buttonText == "."){
      if(_output.contains(".")){
        print("Already conatains a decimals");
        return;
      } else {
        _output = _output + buttonText;
      }

    } else if (buttonText == "="){

      num2 = double.parse(output);

      if(operand == "+"){
        _output = (num1 + num2).toString();
      }
      if(operand == "-"){
        _output = (num1 - num2).toString();
      }
      if(operand == "X"){
        _output = (num1 * num2).toString();
      }
      if(operand == "/"){
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";

    } else {
///ここで数字ボタンと画面表示の連結
      _output = _output + buttonText;

    }

    print(_output);

    setState(() {

      output = double.parse(_output).toStringAsFixed(2);

    });

  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar:  AppBar(
          title: Text(widget.title),
        ),
        body:  Container(
            child:  Column(
              children: <Widget>[
                 Container(
                    alignment: Alignment.centerRight,
                    padding:  const EdgeInsets.symmetric(
                        vertical: 36.0,
                        horizontal: 12.0
                    ),
                    child:  Text(output, style:  const TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,

                    ))),
                 const Expanded(
                  child:  Divider(),
                ),


                 Column(children: [
                   Row(children: [
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("/")
                  ]),

                   Row(children: [
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("X")
                  ]),

                   Row(children: [
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("-")
                  ]),

                   Row(children: [
                    buildButton("."),
                    buildButton("0"),
                    buildButton("00"),
                    buildButton("+")
                  ]),

                   Row(children: [
                    buildButton("CLEAR"),
                    buildButton("="),
                  ])
                ])
              ],
            )));
  }
}