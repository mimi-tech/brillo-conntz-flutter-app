import 'package:brillo_connetz_app/components/appbar.dart';
import 'package:brillo_connetz_app/components/sms_buttons.dart';
import 'package:brillo_connetz_app/models/new_user.dart';
import 'package:brillo_connetz_app/services/match-users-interest.dart';
import 'package:brillo_connetz_app/utility/colors.dart';
import 'package:brillo_connetz_app/view_model/matched_interest_provider.dart';
import 'package:brillo_connetz_app/view_model/users_Auth_provider.dart';
import 'package:brillo_connetz_app/views/Menus/matched-user-tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {


  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
        appBar: const GeneralAppbar(
          title: "Matched user", color: kOrangeColor,),
        body: ChangeNotifierProvider<MatchingUsersProvider>(
            create: (context) => MatchingUsersProvider(),
            builder: (context, child) {
              return Consumer<MatchingUsersProvider>(
                  builder: (context, matchedUsers, child) {

                    return  Column(
                      children: [

                        Expanded(
                          child: FutureBuilder(
    future: matchedUsers.getProducts(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {

       if(snapshot.connectionState == ConnectionState.waiting){
         return const Center(child: CircularProgressIndicator());
       }

      return  ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: matchedUsers.allUsers.length,//snapshot.data.length,
          itemBuilder: (BuildContext context, int index){

            return MatchedUserTile(users: matchedUsers.allUsers[index]);
          });


    }
                          )
                        ),
                      ],
                    );
                  });
            }
        )
    ));
  }}







