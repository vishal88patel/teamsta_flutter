import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:teamsta/constants/prefrence_box.dart';
import 'package:teamsta/constants/images.dart';
import 'package:teamsta/representation/userScreens/find.dart';
import 'package:teamsta/representation/userScreens/following.dart';
import 'package:teamsta/representation/userScreens/home.dart';
import 'package:teamsta/representation/userScreens/messaging.dart';
import 'package:teamsta/representation/userScreens/morePage.dart';

import '../constants/colors.dart';
import '../representation/organisationScreens/org_find_screen.dart';
import '../representation/organisationScreens/org_home_screen.dart';
import '../representation/organisationScreens/org_messages_screen.dart';
import '../representation/organisationScreens/org_more_screen.dart';
import '../representation/organisationScreens/org_news_screen.dart';


class CustomNavigation extends StatefulWidget {
  const CustomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomNavigation> createState() => _CustomNavigationState();
}


class _CustomNavigationState extends State<CustomNavigation> {
  int _selectedIndex = 0;
  // check if the user is a team or user
 

  var _teamMember = boxTeamMember.read('isTeam')??true;

// pages for the user
  static const List<Widget> _screenSelection = <Widget>[
    HomePage(),
    FindPage(),
    FollowingPage(),
    MessagingPage(),
    More(),
  ];

// pages for the organisation
  static const List<Widget> _teamScreenSelection = <Widget>[
    OrgHomePage(),
    TeamNews(),
    TeamMessages(),
    TeamFind(),
    TeamMore()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_teamMember);
    return Scaffold(
      body: _teamMember == true
          ? _teamScreenSelection.elementAt(_selectedIndex)
          : _screenSelection.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              CustomImage().homeIcon,
              fit: BoxFit.contain,
              height: 25,
              color: customPurple,
            ),
            activeIcon: Image.asset(
              CustomImage().homeIcon,
              color: customOrange,
              height: 25,
            ),
            label: _teamMember ? "Fixtures" : "Home",
          ),
          BottomNavigationBarItem(
              //? Don't have an asset for this yet. using news icon instead.
              icon: _teamMember
                  ? Icon(Icons.newspaper)
                  : Image.asset(
                      CustomImage().searchIcon,
                      color: customPurple,
                      height: 25,
                    ),
              activeIcon: _teamMember
                  ? Icon(Icons.newspaper)
                  : Image.asset(
                      CustomImage().searchIcon,
                      color: customOrange,
                      height: 25,
                    ),
              label: _teamMember ? "News" : "Find"),
          BottomNavigationBarItem(
              icon: _teamMember
                  ? Badge(
                      badgeContent: Text(
                        "1",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: Image.asset(
                        CustomImage().chatting,
                        color: customPurple,
                        height: 25,
                      ),
                    )
                  : Image.asset(
                      CustomImage().followingIcon,
                      color: customPurple,
                      height: 25,
                    ),
              activeIcon: _teamMember
                  ? Badge(
                      badgeContent: Text(
                        "1",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: Image.asset(
                        CustomImage().chatting,
                        color: customPurple,
                        height: 25,
                      ),
                    )
                  : Image.asset(
                      CustomImage().followingIcon,
                      color: customOrange,
                      height: 25,
                    ),
              label: _teamMember ? "Messages" : "Following"),
          BottomNavigationBarItem(
              icon: _teamMember
                  ? Image.asset(
                      CustomImage().searchIcon,
                      color: customPurple,
                      height: 25,
                    )
                  : Badge(
                      badgeContent: Text(
                        "1",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: Image.asset(
                        CustomImage().chatting,
                        color: customPurple,
                        height: 25,
                      ),
                    ),
              activeIcon: _teamMember
                  ? Image.asset(
                      CustomImage().searchIcon,
                      color: customOrange,
                      height: 25,
                    )
                  : Badge(
                      badgeColor: Colors.red,
                      badgeContent: Text(
                        "1",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      child: Image.asset(
                        CustomImage().chatting,
                        color: customOrange,
                        height: 25,
                      ),
                    ),
              label: _teamMember ? "Find" : "Messaging"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "More"),
        ],
        currentIndex: _selectedIndex,
        elevation: 0,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        selectedItemColor: customOrange,
        iconSize: 30,
        unselectedItemColor: customPurple,
        showUnselectedLabels: true,
      ),
    );
  }
}
