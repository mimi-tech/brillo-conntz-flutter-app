import 'package:brillo_connetz_app/components/appbar.dart';
import 'package:brillo_connetz_app/components/constants.dart';
import 'package:brillo_connetz_app/components/modalProgressFunction.dart';
import 'package:brillo_connetz_app/components/sms_buttons.dart';
import 'package:brillo_connetz_app/services/auth_services.dart';
import 'package:brillo_connetz_app/utility/colors.dart';
import 'package:brillo_connetz_app/view_model/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestForOTP extends StatefulWidget {

  @override
  _RequestForOTPState createState() => _RequestForOTPState();
}

class _RequestForOTPState extends State<RequestForOTP> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return  SafeArea(

      child: Scaffold(
        appBar: const GeneralAppbar(color: kOrangeColor,title: "Verify Account",),
        body: ProgressHUDFunction(
          inAsyncCall: auth.loading,
          child: SingleChildScrollView(
            child: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child:Text('Please enter the OTP sent \nto your mobile and email',
                    style: Theme.of(context).textTheme.caption!.copyWith(color: kNavyColor),

                  ),
                ),


                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [


                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          cursorColor: kOrangeColor,
                          controller: _otpController,
                          decoration: InputDecoration(
                            hintText: 'Otp',
                            hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                            errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                            border: Theme.of(context).inputDecorationTheme.border,
                            enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
                            focusedBorder:Theme.of(context).inputDecorationTheme.focusedBorder,
                            focusedErrorBorder:Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                            errorBorder:Theme.of(context).inputDecorationTheme.errorBorder,
                            contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                          ),
                          validator: _pinValidator,
                          onChanged: (String value){
                            otpText = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30,),
                      GButtonsNew(tapSmsButton:(){
                        auth.verifyAuthCode(context);
                      }, color: kOrangeColor, title: 'Verify'),
                      const SizedBox(height: 30,),


                    ],
                  ),
                ),
                spacing(context),
                GestureDetector(
                  onTap: () async {await auth.getResendService();},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Didn't see any code ",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kTextColor,fontWeight: FontWeight.w500),

                            children: <TextSpan>[
                              TextSpan(
                                text: 'Resend',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kLightBlue,fontWeight: FontWeight.bold),
                              ),


                            ]

                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

          ),
        ),
      ),
    );
  }

  String? _pinValidator(String? value) {
    return value!.trim().isEmpty ? "Otp is required" : null;
  }


}
