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
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UpdateEmailScreen extends StatefulWidget {
  const UpdateEmailScreen({Key? key}) : super(key: key);

  @override
  _UpdateEmailScreenState createState() => _UpdateEmailScreenState();
}

class _UpdateEmailScreenState extends State<UpdateEmailScreen> {
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _countryCode = '';
  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;

    return SafeArea(child:

    ChangeNotifierProvider<ProfileViewModal>(
        create: (context)=> ProfileViewModal(),
        builder: (context,child){

          return Consumer<ProfileViewModal>(
              builder: (context, modal, child){


                return Scaffold(
                    appBar: GeneralAppbar(
                      color:kBlackColor,
                      title: '${user.firstName} ${user.lastName}',
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
                              child: Text('Update Email'.toUpperCase(),
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
                                  const FormsHeadings(title: "Please enter the phone number used in creating this account. This will help us know you are the owner of this account"),
                                  TextFormField(
                                    controller: _phoneNumber,
                                    autocorrect: true,
                                    autofocus: true,
                                    cursorColor: (kOrangeColor),
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization.sentences,
                                    style: Theme.of(context).textTheme.bodyText1,
                                    validator: Validator.validatePhoneNumber,
                                    decoration: InputDecoration(
                                      prefix:  CountryCodePicker(

                                        textStyle:  GoogleFonts.oxanium(
                                          fontSize: ScreenUtil().setSp(kFontSize16),
                                          fontWeight: FontWeight.bold,
                                          color: kTextColor,

                                        ),
                                        dialogTextStyle: Theme.of(context).textTheme.bodyText1,

                                        onInit: (code) {
                                          _countryCode = code.toString();
                                        },
                                        onChanged: (code){
                                          _countryCode = code.toString();
                                        },
                                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                        initialSelection: 'NG',
                                        favorite: ['+234','NG'],
                                        // optional. Shows only country name and flag
                                        showCountryOnly: false,
                                        // optional. Shows only country name and flag when popup is closed.
                                        showOnlyCountryWhenClosed: false,
                                        // optional. aligns the flag and the Text left
                                        alignLeft: false,
                                      ),

                                      hintText: AppLocalizations.of(context)!.phoneNumber,
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
                                      phoneNumber = _countryCode + value!;
                                    },
                                  ),
                                  spacing(context),
                                  FormsHeadings(title: AppLocalizations.of(context)!.newEmailText),
                                  TextFormField(
                                    controller: _email,
                                    autocorrect: true,
                                    autofocus: true,
                                    cursorColor: (kOrangeColor),
                                    keyboardType: TextInputType.emailAddress,
                                    style: Theme.of(context).textTheme.bodyText1,
                                    validator: Validator.validateEmail,

                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!.newEmailText,
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

                                ],
                              ),
                            ),
                            spacing(context),

                            Center(child: GButtons(title: "Update", color: kOrangeColor, tapSmsButton: (){

                        final form = _formKey.currentState;
                        if(form!.validate()) {
                          form.save();
                          modal.verifyUserEmailCode(context);
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
