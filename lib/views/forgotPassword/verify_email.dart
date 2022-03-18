import 'package:brillo_connetz_app/components/appbar.dart';
import 'package:brillo_connetz_app/components/constants.dart';
import 'package:brillo_connetz_app/components/modalProgressFunction.dart';
import 'package:brillo_connetz_app/components/sms_buttons.dart';
import 'package:brillo_connetz_app/utility/Validators.dart';
import 'package:brillo_connetz_app/utility/colors.dart';
import 'package:brillo_connetz_app/utility/dimen.dart';
import 'package:brillo_connetz_app/utility/routes.dart';
import 'package:brillo_connetz_app/views/Registration/password_screen.dart';
import 'package:brillo_connetz_app/views/forgotPassword/change_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {

  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      appBar: GeneralAppbar(color:kOrangeColor,title: '${AppLocalizations.of(context)!.appName} ${AppLocalizations.of(context)!.forgotPasswordText}'),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: kMargin),
            child: Column(
              children: [
                spacing(context),

                Center(
                  child: Text(
                      AppLocalizations.of(context)!.emailText,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold)
                  ),
                ),
                spacing(context),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    controller: _email,
                    autocorrect: true,
                    autofocus: true,
                    cursorColor: (kOrangeColor),
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context).textTheme.bodyText1,
                    validator: Validator.validateEmail,

                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.emailText,
                      hintStyle: Theme.of(context).inputDecorationTheme.helperStyle,
                      errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                      border: Theme.of(context).inputDecorationTheme.border,
                      enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
                      focusedBorder:Theme.of(context).inputDecorationTheme.focusedBorder,
                      focusedErrorBorder:Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                      errorBorder:Theme.of(context).inputDecorationTheme.errorBorder,
                      contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                    ),
                    onSaved: (String? value) {
                      emailAddress = value;
                    },
                  ),
                ),

                space(context),
                Center(

                    child: GButtons(
                      title: "Next",
                      color: kOrangeColor,
                      tapSmsButton: (){
                        final form = _formKey.currentState;
                        if(form!.validate()) {
                          form.save();
                          Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ChangePassword()));


                        }
                        }

                    )
                ),


              ],
            )
        ),
      ),
    ));


  }
}
