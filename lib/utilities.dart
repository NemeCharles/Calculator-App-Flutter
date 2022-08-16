import 'package:flutter/material.dart';

class NumberButtons extends StatelessWidget {
  const NumberButtons({Key? key, required this.number, required this.onPress}) : super(key: key);

  final String number;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6),
        child: GestureDetector(
          onTap: onPress,
          child: TextButton(
            onPressed: null,
            child: Text(number,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 47,
                  fontWeight: FontWeight.w300
              ),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.1)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    StadiumBorder(
                        side: BorderSide(
                            width: 1.4, color: Colors.grey.withOpacity(0.3)
                        )
                    )
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                    const Size(82, 69)
                )
            ),
          ),
        )
    );
  }
}

class OperatorsI extends StatelessWidget {
  const OperatorsI({Key? key, required this.operator, required this.onPressed}) : super(key: key);

  final String operator;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: GestureDetector(
          onTap: onPressed,
          child: TextButton(
            onPressed: null,
            child: Text(operator,
              style: TextStyle(
                  color: Colors.lightGreenAccent,
                  fontSize: operator == 'x' ? 50 : 35,
                  fontWeight: operator == 'x' ? FontWeight.w300 : FontWeight.w400
              ),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.1)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    StadiumBorder(
                        side: BorderSide(
                            width: 1.4, color: Colors.grey.withOpacity(0.3)
                        )
                    )
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                    const Size(82, 69)
                )
            ),
          ),
        )
    );
  }
}

class OperatorsII extends StatelessWidget {
  const OperatorsII({Key? key, required this.operator, required this.onPressed}) : super(key: key);

  final String operator;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: GestureDetector(
          onTap: onPressed,
          child: TextButton(
            onPressed: null,
            child: Text(operator,
              style: const TextStyle(
                  color: Colors.lightGreenAccent,
                  fontSize:  55,
                  fontWeight: FontWeight.w300
              ),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.1)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    StadiumBorder(
                        side: BorderSide(
                            width: 1.4, color: Colors.grey.withOpacity(0.3)
                        )
                    )
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                    const Size(82, 69)
                )
            ),
          ),
        )
    );
  }
}

class OperatorsIII extends StatelessWidget {
  const OperatorsIII({Key? key, required this.operator, required this.onPressed}) : super(key: key);

  final String operator;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: GestureDetector(
          onTap: onPressed,
          child: TextButton(
            onPressed: null,
            child: Text(operator,
              style: TextStyle(
                  color: operator == 'C' ? Colors.deepOrangeAccent : Colors.white,
                  fontSize:  operator == 'C' ? 40 : 50,
                  fontWeight: operator == 'C' ? FontWeight.w400 : FontWeight.w300
              ),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(operator == 'C' ? Colors.white.withOpacity(0.1) : Colors.lightGreen.shade900),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    operator == 'C' ? StadiumBorder(
                        side: BorderSide(
                            width: 1.4, color: Colors.grey.withOpacity(0.3)
                        )
                    ) : const StadiumBorder()
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                    const Size(82, 69)
                )
            ),
          ),
        )
    );
  }
}

