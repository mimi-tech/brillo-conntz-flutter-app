import 'dart:io';

import 'package:brillo_connetz_app/components/appbar.dart';
import 'package:brillo_connetz_app/components/constants.dart';
import 'package:brillo_connetz_app/components/form_headings.dart';
import 'package:brillo_connetz_app/components/modalProgressFunction.dart';
import 'package:brillo_connetz_app/components/sms_buttons.dart';
import 'package:brillo_connetz_app/utility/Validators.dart';
import 'package:brillo_connetz_app/utility/colors.dart';
import 'package:brillo_connetz_app/utility/dimen.dart';
import 'package:brillo_connetz_app/utility/routes.dart';
import 'package:brillo_connetz_app/utility/strings.dart';
import 'package:brillo_connetz_app/view_model/account_provider.dart';
import 'package:brillo_connetz_app/views/Registration/interest-list.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _fName = TextEditingController();
  final TextEditingController _lName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _countryCode = '';


  @override
  Widget build(BuildContext context) {

    AuthProvider auth = Provider.of<AuthProvider>(context);
    return SafeArea(child: Scaffold(
      appBar: GeneralAppbar(color:kOrangeColor,title: '$kAppName ${AppLocalizations.of(context)!.appbarRegText}'),
      body:ProgressHUDFunction(
        inAsyncCall: auth.loading,
        child: SingleChildScrollView(
          child: Container(
          margin: const EdgeInsets.symmetric(horizontal: kMargin),
          child: Column(
            children: [
              spacing(context),
              GestureDetector(
                   onTap: (){
                     auth.getImageFromGallery();
                   },
                  child:  profileImageUrl == null?SvgPicture.asset('assets/user.svg')
              :CircleAvatar(
                    backgroundColor: kOrangeColor,
                    radius: 55,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(profileImageUrl.toString()),
                    ),
                  ),
              ),

              Text(profileImageUrl == null?"Please select your profile picture":"Edit Profile Image",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.normal)
              ),
              spacing(context),


              spacing(context),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spacing(context),
                    FormsHeadings(title: AppLocalizations.of(context)!.fullName),
                    TextFormField(

                      controller: _fName,
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: (kOrangeColor),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validateFirstName,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.fullName,
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
                        firstName = value;
                        },
                    ),

                    spacing(context),
                    FormsHeadings(title: AppLocalizations.of(context)!.lastNameText),
                    TextFormField(

                      controller: _lName,
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: (kOrangeColor),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validateLastName,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.lastNameText,
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
                        lastName = value;
                      },
                    ),


                    spacing(context),
                    FormsHeadings(title: AppLocalizations.of(context)!.emailText),
                    TextFormField(
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
                    spacing(context),
                    FormsHeadings(title: AppLocalizations.of(context)!.phoneNumber),

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
                    FormsHeadings(title: AppLocalizations.of(context)!.interestText),
                    GestureDetector(
                      onTap: (){
                        //open a bottom sheet where users will select their interest
                        showModalBottomSheet(
                            isDismissible: false,
                            isScrollControlled: true,
                            enableDrag: false,
                            context: context,
                            builder: (context) => InterestList()
                        );
                      },
                      child: AbsorbPointer(
                        child: TextFormField(

                          controller: userInterest,
                          autocorrect: true,
                          cursorColor: (kOrangeColor),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          style: Theme.of(context).textTheme.bodyText1,
                          validator: Validator.validateInterest,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.interestText,
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
                            interest = value;
                          },
                        ),
                      ),
                    ),
                    spacing(context),
                    FormsHeadings(title: AppLocalizations.of(context)!.passwordText),
                    TextFormField(
                      controller: _password,
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: (kOrangeColor),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validatePassword,

                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.passwordText,
                        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                        errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                        border: Theme.of(context).inputDecorationTheme.border,
                        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                        focusedErrorBorder: Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                        errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
                        contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                      ),
                      onChanged: (String value) {
                        password = value;
                      },
                    ),

                    spacing(context),
                    FormsHeadings(title: AppLocalizations.of(context)!.confirmPassword),

                    TextFormField(
                      controller: _confirmPassword,
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: (kOrangeColor),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validatePassword,

                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.confirmPassword,

                        hintStyle: Theme.of(context).inputDecorationTheme.helperStyle,
                        errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                        border: Theme.of(context).inputDecorationTheme.border,
                        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                        focusedErrorBorder: Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                        errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
                        contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                      ),
                      onSaved: (String? value) {
                        password = value;
                      },
                    ),
                  ],
                ),


                ),





              space(context),
             GButtons(title: "Register", color: kOrangeColor, tapSmsButton: () async {
               final form = _formKey.currentState;
               if(form!.validate()) {
                 form.save();
                 FocusScopeNode currentFocus = FocusScope.of(context);

                 if (!currentFocus.hasPrimaryFocus) {
                   currentFocus.unfocus();
                 }
                 if(_password.text.trim() != _confirmPassword.text.trim()){
                    notifyFlutterToastError(title:"Password doesn't match");
                 }else if(profileImageUrl == null){
                      notifyFlutterToastError(title:"Please select your profile picture");
                   }else{
                   await auth.userRegistration(context);
                 }




               }
             }),
              space(context),

            ],
          )
    ),
        ),
      ),
    ));


  }
}
