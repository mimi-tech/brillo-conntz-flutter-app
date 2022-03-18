import 'dart:io';

import 'package:brillo_connetz_app/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class ShowProgress extends StatelessWidget {
  const ShowProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS?Center(child: CupertinoActivityIndicator(
      animating: true,
      radius: 30,
    ))
        :Center(child: CircularProgressIndicator(backgroundColor: kOrangeColor,));

  }
}
