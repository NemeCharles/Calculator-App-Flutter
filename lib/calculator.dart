import 'package:calculator_app/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> buttons = [
    'C', '( )', '%', '/',
    '7', '8', '9', 'x',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '+/-', '0', '.', '='
  ];
  String question = '';
  String answer = '';
  String subAnswer = '';
  int bracketNum = 0;
  bool containsDecimal = false;
  bool isSolved = false;

  // Input function
  void onTap(String btnText) {
    if(btnText == 'C') {
      containsDecimal = false;
      question = '';
      answer = '';
      subAnswer = '';
      bracketNum = 0;
      isSolved = false;
    } else if(btnText == '+/-') {
      if(question.startsWith('(-')) {
        question = question.substring(2);
        bracketNum -= 1;
      } else if (isSolved) {
        question = answer;
        question = '(-' + question;
        bracketNum += 1;
        isSolved = false;
      } else {
        question = '(-' + question;
        bracketNum += 1;
      }
    } else if(btnText == '( )') {
      if(question.isEmpty) {
        bracketNum += 1;
        question = question + '(';
      } else if(question.endsWith('(-') || question.endsWith('(+')) {
        question = question + '(';
        bracketNum += 1;
      } else if(!question.endsWith('(')&& bracketNum != 0) {
        question = question + ')';
        bracketNum -= 1;
        calc();
      } else if(question.endsWith('+') || question.endsWith('-') || question.endsWith('/') || question.endsWith('x')) {
        question = question + '(';
        bracketNum += 1;
      }  else if(isSolved) {
        question = answer;
        question = question + 'x' + '(';
        bracketNum += 1;
        isSolved = false;
      } else if(bracketNum == 0 && question.endsWith(')') || bracketNum == 0 && !question.endsWith(')')) {
        question = question + 'x' + '(';
        bracketNum += 1;
      } else {
        question = question + '(';
        bracketNum += 1;
      }
    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/') {
      if(question.isEmpty) {
        question = question;
      } else if(question.endsWith(btnText)) {
        question = question;
      } else if(question.endsWith('(') && btnText == 'x' || question.endsWith('(') && btnText == '/' ) {
        question = question;
      } else if(question.endsWith('+') || question.endsWith('-') || question.endsWith('x') || question.endsWith('/')){
        if(question.endsWith('(+') || question.endsWith('(-')) {
          question = question.substring(0, question.length-1);
        } else {question = question.replaceRange(question.length-1, question.length, btnText);}
      } else if(isSolved) {
        question = answer;
        question = question + btnText;
        isSolved = false;
      } else {
        question = question + btnText;
        containsDecimal = false;
      }
    } else if(btnText == '%') {
      if(question.isEmpty) {
        question = question;
      } else if(question.endsWith(btnText)) {
        question = question;
      } else if(question.endsWith('+') || question.endsWith('-') || question.endsWith('x') || question.endsWith('/') || question.endsWith('(')){
        question = question;
      } else {question = question + btnText;}
    } else if(btnText == '=') {
      try{
        Parser p = Parser();
        Expression exp = p.parse(question.replaceAll('x', '*'));
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        answer = eval.toString();
        subAnswer = '';
        isSolved = true;
      } catch(e) {print(e);}
    } else if(btnText == '.') {
      if(containsDecimal) {
        question = question;
      } else {
        if(question.isEmpty) {
          question = question +'0' + '.';
          containsDecimal = true;
        } else if(question.endsWith('+') || question.endsWith('-') || question.endsWith('x') ||
            question.endsWith('/') || question.endsWith('%') || question.endsWith('(') || question.endsWith(')')) {
          if(question.endsWith('%')) {
            question = question + 'x' + '0' + '.';
            containsDecimal = true;
          } else {
            question = question + '0'  + '.';
            containsDecimal = true;
          }
        } else if(isSolved) {
          isSolved = false;
          question = '';
          question = question + '0' + '.';
          containsDecimal = true;
        } else {
          question = question + '.';
          containsDecimal = true;
        }
      }
    } else {
      if(isSolved) {
        isSolved = false;
        question = '';
      }
      question.endsWith(')') || question.endsWith('%') ? question += ('x' + btnText) : question += btnText;
    }
  }

  // calculate per input..
  void calc() {
    if(question.endsWith('+') || question.endsWith('-') || question.endsWith('x') ||
        question.endsWith('/') || question.endsWith('%') || question.endsWith('(')) {
      answer = '';
      subAnswer = '';
    } else {
      try {
        Parser p = Parser();
        Expression exp = p.parse(question.replaceAll('x', '*'));
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        answer = eval.toString();
        subAnswer = eval.toString();
      } catch (e) {
        print(e);
      }
    }
  }

  //Delete function
  void delete() {
    if(question.endsWith('(')) {
      question = question.substring(0, question.length-1);
      bracketNum -= 1;
    } else if(question.endsWith(')')) {
      question = question.substring(0, question.length-1);
      bracketNum += 1;
    } else if(question.endsWith('.')) {
      containsDecimal = false;
      question = question.substring(0, question.length-1);
    } else if(question.endsWith('+') || question.endsWith('-') || question.endsWith('x') ||
        question.endsWith('/') || question.endsWith('%') || question.endsWith('(') || question.endsWith(')')) {
      question = question.substring(0, question.length-1);
      containsDecimal = true;
    }
    else if(isSolved) {
      question = answer;
      question = question.substring(0, question.length - 1);
      isSolved = false;
    } else { question = question.substring(0, question.length-1);}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.42,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 27,),
                        SizedBox(
                          height: size.height * 0.131,
                          child: SingleChildScrollView(
                            reverse: true,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(!isSolved ? question : answer,
                                style: TextStyle(
                                  fontSize: question.length >= 13 ? 40 : 53,
                                  fontWeight: FontWeight.w300,
                                  color: isSolved ? Colors.lightGreenAccent : Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(subAnswer,
                          style: TextStyle(
                            color: Colors.grey.withOpacity(0.5),
                            fontSize: 33,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                        const SizedBox(height: 50,),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: question.isNotEmpty ? () {
                              setState(() {
                               delete();
                               calc();
                               if(question.isEmpty){
                                 answer = '';
                                 subAnswer = '';
                               }
                              });
                            } : null,
                            child: Icon(
                              Icons.backspace_outlined,size: 25,
                              color: question.isEmpty ?  Colors.lightGreenAccent.withOpacity(0.3) : Colors.lightGreenAccent,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Divider(thickness: 1, color: Colors.grey.withOpacity(0.5),),
            ),
            SizedBox(
              height: size.height * 0.53,
              child: Column(
                children: [
                  const SizedBox(height: 18,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          OperatorsIII(
                              operator: buttons[0],
                              onPressed: () {
                                setState(() {
                                  onTap(buttons[0]);
                                });
                              }
                          ),
                          NumberButtons(
                              number: buttons[4],
                              onPress: () {
                                setState(() {
                                  onTap(buttons[4]);
                                  calc();
                                });
                              }
                          ),
                          NumberButtons(
                              number: buttons[8],
                              onPress: () {
                                setState(() {
                                  onTap(buttons[8]);
                                  calc();
                                });
                              }
                          ),
                          NumberButtons(
                              number: buttons[12],
                              onPress: () {
                                setState(() {
                                  onTap(buttons[12]);
                                  calc();
                                });
                              }
                          ),
                          NumberButtons(
                              number: buttons[16],
                              onPress: () {
                                setState(() {
                                  onTap(buttons[16]);
                                });
                              }
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          OperatorsI(
                            operator: buttons[1],
                            onPressed: () {
                              setState(() {
                                containsDecimal = false;
                                onTap(buttons[1]);
                                calc();
                              });
                            },
                          ),
                          NumberButtons(
                              number: buttons[5],
                              onPress: () {
                                setState(() {
                                  onTap(buttons[5]);
                                  calc();
                                });
                              }
                          ),
                          NumberButtons(
                              number: buttons[9],
                              onPress: () {
                                setState(() {
                                  onTap(buttons[9]);
                                  calc();
                                });
                              }
                          ),
                          NumberButtons(
                              number: buttons[13],
                              onPress: () {
                                setState(() {
                                  onTap(buttons[13]);
                                  calc();
                                });
                              }
                          ),
                          NumberButtons(
                              number: buttons[17],
                              onPress: () {
                                setState(() {
                                  onTap(buttons[17]);
                                  calc();
                                });
                              }
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          OperatorsI(
                            operator: buttons[2],
                            onPressed: () {
                              setState(() {
                                containsDecimal = false;
                                onTap(buttons[2]);
                                calc();
                              });
                            },
                          ),
                          NumberButtons(
                              number: buttons[6],
                              onPress: () {
                                setState(() {

                                  onTap(buttons[6]);
                                  calc();

                                });
                              }
                          ),
                          NumberButtons(
                              number: buttons[10],
                              onPress: () {
                                setState(() {
                                  onTap(buttons[10]);
                                  calc();
                                });
                              }
                          ),
                          NumberButtons(
                              number: buttons[14],
                              onPress: () {
                                setState(() {
                                  onTap(buttons[14]);
                                  calc();
                                });
                              }
                          ),
                          NumberButtons(
                              number: buttons[18],
                              onPress: () {
                                setState(() {
                                  onTap(buttons[18]);
                                  calc();
                                });
                              }
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          OperatorsI(
                            operator: buttons[3],
                            onPressed: () {
                              setState(() {
                                containsDecimal = false;
                                onTap(buttons[3]);
                                calc();
                              });
                            },
                          ),
                          OperatorsI(
                            operator: buttons[7],
                            onPressed: () {
                              setState(() {
                                containsDecimal = false;
                                onTap(buttons[7]);
                                calc();
                              });
                            },
                          ),
                          OperatorsII(
                              operator: buttons[11],
                              onPressed: () {
                                setState(() {
                                  containsDecimal = false;
                                  onTap(buttons[11]);
                                  calc();
                                });
                              }
                          ),
                          OperatorsII(
                              operator: buttons[15],
                              onPressed: () {
                                setState(() {
                                  containsDecimal = false;
                                  onTap(buttons[15]);
                                  calc();
                                });
                              }
                          ),
                          OperatorsIII(
                              operator: buttons[19],
                              onPressed: () {
                                setState(() {
                                  onTap(buttons[19]);
                                });
                              }
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}


