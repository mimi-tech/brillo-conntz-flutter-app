
import 'package:brillo_connetz_app/utility/colors.dart';
import 'package:brillo_connetz_app/utility/internet_connection.dart';
import 'package:brillo_connetz_app/utility/dimen.dart';
import 'package:brillo_connetz_app/view_model/matched_interest_provider.dart';
import 'package:brillo_connetz_app/views/Menus/LandingPage.dart';
import 'package:brillo_connetz_app/views/Menus/Settings/settings_home.dart';
import 'package:brillo_connetz_app/views/Menus/buddies.dart';
import 'package:brillo_connetz_app/views/Menus/discover.dart';
import 'package:brillo_connetz_app/views/Menus/profile/view_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BasicBottomNavBar extends StatefulWidget {
  BasicBottomNavBar ({Key? key}) : super(key: key);

  @override
  _BasicBottomNavBarState createState() => _BasicBottomNavBarState();
}

class _BasicBottomNavBarState extends State<BasicBottomNavBar > {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    LandingPage(),
    ViewProfileScreen(),
    BuddiesScreen(),
    DiscoverScreen(),
    SettingsHomeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InternetConnections().checkConnection(context);

  }


  @override
  void deactivate() {
    InternetConnections().dispose();
    super.deactivate();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
       bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              //backgroundColor: Colors.green
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            //backgroundColor: Colors.blue,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Buddies',
            //backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Discover',
            //backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
            //backgroundColor: Colors.pink,
          ),

        ],
        currentIndex: _selectedIndex,
        iconSize: 20,
        onTap: _onItemTapped,
        elevation: 5,

    showUnselectedLabels: true,
    type:  BottomNavigationBarType.fixed,
    backgroundColor: kBlackColor,
    mouseCursor: SystemMouseCursors.grab,
    selectedFontSize: 20,
    selectedIconTheme: const IconThemeData(color: kOrangeColor, size: 20),
    selectedItemColor: kOrangeColor,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold,
    color: kAshColor,
    fontSize: kFontSize16.sp
    ),
    unselectedIconTheme: const IconThemeData(
    color: Colors.grey,
    ),
    unselectedItemColor: Colors.grey,


    ),
    );
  }
}