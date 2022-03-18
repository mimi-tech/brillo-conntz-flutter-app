import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class GButtons extends StatelessWidget {
 final String title;
 final Color color;
 final VoidCallback tapSmsButton;

  const GButtons({Key? key, required this.title, required this.color, required this.tapSmsButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: tapSmsButton,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 30.0),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(color),
        fixedSize: MaterialStateProperty.all<Size>(
          const Size.fromHeight(50.0),
        ),
      ),
        child:Text(title,
          style: Theme.of(context).textTheme.button,
        )


    );
  }
}


class GButtonsNew extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback tapSmsButton;

  const GButtonsNew({Key? key, required this.title, required this.color, required this.tapSmsButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: tapSmsButton,
        style: ButtonStyle(

          backgroundColor: MaterialStateProperty.all<Color>(color),

        ),
        child:Text(title,
          style: Theme.of(context).textTheme.button,
        )


    );
  }
}
