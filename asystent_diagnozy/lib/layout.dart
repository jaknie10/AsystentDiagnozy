import 'package:flutter/material.dart';

import 'home.dart';
import 'profile.dart';
import 'settings.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;

  var keyHome = GlobalKey<NavigatorState>();
  var keyProfile = GlobalKey<NavigatorState>();
  var keySettings = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    changeState(state) {
      setState(() {
        _selectedIndex = state;
      });
    }

    List<Map<String, dynamic>> pages = [
      {'name': 'Home', 'page': const HomePage(), 'key': keyHome},
      {
        'name': 'Profile',
        'page': const Profile(doctorId: 1),
        'key': keyProfile
      },
      {'name': 'Settings', 'page': const Settings(), 'key': keySettings},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        toolbarHeight: 80,
        leading: Container(
            color: Colors.white,
            width: 80.0,
            child: IconButton(
              style: IconButton.styleFrom(
                  elevation: 0,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  )),
              onPressed: () {
                changeState(0);
              },
              icon: ImageIcon(
                const AssetImage('assets/cardiologyLogo.png'),
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
            )),
        leadingWidth: 80,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 300,
            height: 45,
            child: SearchBar(),
          ),
        ),
        actions: [
          Container(
            width: 250,
            height: 80,
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: const Align(
                alignment: Alignment.centerLeft,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.people,
                        size: 30,
                        color: Colors.black,
                      ),
                      Text("Jan Kowalski",
                          style: TextStyle(fontSize: 20, color: Colors.black))
                    ])),
          )
        ], // default is 56
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: ImageIcon(
                  AssetImage('assets/home.png'),
                  size: 30,
                  color: Color.fromRGBO(22, 20, 35, 60),
                ),
                selectedIcon: ImageIcon(
                  AssetImage('assets/home_focused.png'),
                  size: 30,
                  color: Color.fromRGBO(22, 20, 35, 60),
                ),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: ImageIcon(
                  AssetImage('assets/profile.png'),
                  size: 30,
                  color: Color.fromRGBO(22, 20, 35, 60),
                ),
                selectedIcon: ImageIcon(
                  AssetImage('assets/profile_focused.png'),
                  size: 30,
                  color: Color.fromRGBO(22, 20, 35, 60),
                ),
                label: Text('Profile'),
              ),
              NavigationRailDestination(
                icon: ImageIcon(
                  AssetImage('assets/settings.png'),
                  size: 30,
                  color: Color.fromRGBO(22, 20, 35, 60),
                ),
                selectedIcon: ImageIcon(
                  AssetImage('assets/settings_focused.png'),
                  size: 30,
                  color: Color.fromRGBO(22, 20, 35, 60),
                ),
                label: Text('Settings'),
              ),
            ],
          ),
          Expanded(
            child: WillPopScope(
              onWillPop: () async =>
                  !await pages[_selectedIndex]['key'].currentState!.maybePop(),
              child: Navigator(
                key: pages[_selectedIndex]['key'],
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                    builder: (context) => pages[_selectedIndex]['page'],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
