import 'dart:async';
import 'package:brillo_connetz_app/services/auth_services.dart';
import 'package:brillo_connetz_app/utility/colors.dart';
import 'package:brillo_connetz_app/utility/routes.dart';
import 'package:brillo_connetz_app/utility/shared_prefrences.dart';
import 'package:brillo_connetz_app/utility/strings.dart';
import 'package:brillo_connetz_app/view_model/account_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  var _visible = true;

  AnimationController? animationController;
  Animation<double>? animation;

  startTime() async {
    var _duration = const Duration(seconds: 4);
    return  Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    String userId = await UserPreferences().getUserId();

    //check if user is already logged in
    if (userId == "") {
      Navigator.pop(context);
      loginScreen(context);
    } else {
      //check if users account has been verified
      AuthProvider().getLoggedInUserIsVerified(context);



    }
  }
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync:this,
        value: 0.1,

        duration: const Duration(seconds: 4));
    animation = CurvedAnimation(parent: animationController!, curve: Curves.easeOut);

    animation!.addListener(() => setState(() {}));
    animationController!.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }
  @override
  void dispose() {
    animationController!.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:  Container(
      decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/bg2.png'),
    fit: BoxFit.cover,)),

    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(kAppName.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kWhiteColor,fontWeight: FontWeight.bold)
            ),

          ],),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        Container(
        height: animation!.value * 250,
        width: animation!.value * 250,
        decoration: const BoxDecoration(
          color: kOrangeColor,
        image: DecorationImage(
        image: AssetImage('assets/football.png'),
        fit: BoxFit.cover,))),

      //    IconButton(
      //      icon:AssetImage('assets/splash_bg.png'),
      //        fit: BoxFit.cover,)
      //   //icon:  FaIcon(FontAwesomeIcons.footballBall,size: animation!.value * 250,color: kWhiteColor,),
      //     onPressed: () { },
      //
      // ),


          ],
        ),
      ],
    )

      ),
    ));
  }
}
