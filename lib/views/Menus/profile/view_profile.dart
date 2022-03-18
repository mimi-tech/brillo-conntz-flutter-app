import 'package:brillo_connetz_app/components/appbar.dart';
import 'package:brillo_connetz_app/components/constants.dart';
import 'package:brillo_connetz_app/components/form_headings.dart';
import 'package:brillo_connetz_app/components/modalProgressFunction.dart';

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

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({Key? key}) : super(key: key);

  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _lName = TextEditingController();
  final TextEditingController _interest = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _countryCode = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;
    _fName.text = user.firstName.toString();
    _lName.text = user.lastName.toString();
    _interest.text = user.interest.toString();
    _username.text = user.username.toString();
    _phoneNumber.text = user.phoneNumber.toString();
    return SafeArea(child:
    ChangeNotifierProvider<ProfileViewModal>(
        create: (context)=> ProfileViewModal(),
    builder: (context,child){

    return Consumer<ProfileViewModal>(
    builder: (context, modal, child){


    return
    Scaffold(
        appBar: GeneralAppbar(
            color:kBlackColor,
            title: '${user.firstName} ${user.lastName}',
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: kMargin),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacing(context),

              Center(
                child: Text('User Information'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline2!.copyWith(color: kOrangeColor)
                ),
              ),
              spacing(context),

              Center(
                child:  CircleAvatar(
                  backgroundColor: kOrangeColor,
                  radius: 55,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.profileImageUrl.toString()),
                  ),
                ),
              ),

              spacing(context),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spacing(context),
                FormsHeadings(title: AppLocalizations.of(context)!.fullName),

                    TextFormField(

                      controller: _fName,
                      autocorrect: true,
                      autofocus: true,
                      readOnly: true,
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
                      readOnly: true,
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
                    FormsHeadings(title: AppLocalizations.of(context)!.usernameText),
                    TextFormField(
                      readOnly: true,
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
                      readOnly: true,
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
                    TextFormField(
                      readOnly: true,
                      controller: _interest,
                      autocorrect: true,
                      autofocus: true,
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

                  ],
                ),
              ),
            ],
          ),
    ),
        )
    );
    });
    






  }));

  }}
