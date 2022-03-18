import 'package:brillo_connetz_app/utility/colors.dart';
import 'package:flutter/material.dart';
class FormsHeadings extends StatelessWidget {
  const FormsHeadings({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return  Text(title,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold,color: kHintColor)
    );
  }
}
