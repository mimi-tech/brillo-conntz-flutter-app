import 'package:brillo_connetz_app/components/appbar.dart';
import 'package:brillo_connetz_app/components/constants.dart';
import 'package:brillo_connetz_app/components/form_headings.dart';
import 'package:brillo_connetz_app/components/modalProgressFunction.dart';
import 'package:brillo_connetz_app/components/sms_buttons.dart';

import 'package:brillo_connetz_app/models/new_user.dart';
import 'package:brillo_connetz_app/utility/Validators.dart';
import 'package:brillo_connetz_app/utility/colors.dart';
import 'package:brillo_connetz_app/utility/dimen.dart';
import 'package:brillo_connetz_app/view_model/profile_view_modal.dart';
import 'package:brillo_connetz_app/view_model/users_Auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class UpdateUsernameScreen extends StatefulWidget {
  const UpdateUsernameScreen({Key? key}) : super(key: key);

  @override
  _UpdateUsernameScreenState createState() => _UpdateUsernameScreenState();
}

class _UpdateUsernameScreenState extends State<UpdateUsernameScreen> {

  final TextEditingController _username = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;
    _username.text = user.username.toString();
    return SafeArea(child:

    ChangeNotifierProvider<ProfileViewModal>(
        create: (context)=> ProfileViewModal(),
        builder: (context,child){

          return Consumer<ProfileViewModal>(
              builder: (context, modal, child){


                return Scaffold(
                    appBar: GeneralAppbar(
                      color:kBlackColor,
                      title: '${user.firstName}',
                    ),
                    body: ProgressHUDFunction(
                      inAsyncCall: modal.loading,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: kMargin),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            spacing(context),

                            Center(
                              child: Text('Update user name'.toUpperCase(),
                                  style: Theme.of(context).textTheme.headline2!.copyWith(color: kOrangeColor)
                              ),
                            ),
                            spacing(context),


                            spacing(context),
                            Form(
                              key: _formKey,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: [

                                  spacing(context),
                                  FormsHeadings(title: AppLocalizations.of(context)!.usernameText),
                                  TextFormField(

                                    controller: _username,
                                    autocorrect: true,
                                    autofocus: true,
                                    cursorColor: (kOrangeColor),
                                    keyboardType: TextInputType.text,
                                    textCapitalization: TextCapitalization.sentences,
                                    style: Theme.of(context).textTheme.bodyText1,
                                    validator: Validator.validateUsername,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!.usernameText,
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
                                      username = value;
                                    },
                                  ),

                                ],
                              ),
                            ),

                            spacing(context),

                            Center(child: GButtons(title: "Update", color: kOrangeColor, tapSmsButton: (){
    final form = _formKey.currentState;
    if(form!.validate()) {
      form.save();
      modal.getUpdateUsername(context);
    }
                              }))
                          ],
                        ),
                      ),
                    )
                );
              });





        }));
  }}
