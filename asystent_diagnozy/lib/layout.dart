import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'pages/home/home.dart';
import 'pages/profile/profile.dart';
import 'pages/settings/settings.dart';

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
      {'name': 'Profile', 'page': const Profile(doctorId: 1), 'key': keyProfile},
      {'name': 'Settings', 'page': const Settings(doctorId: 1), 'key': keySettings},
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
          child: Text("Asystent diagnozy", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30, letterSpacing: 1.5),)
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              child: Container(
                height: 80,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: Theme.of(context).colorScheme.background,),
                padding: const EdgeInsets.all(10.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      SvgPicture.asset(
                      'assets/lekarz_logo.svg',
                      width: 45,
                      fit: BoxFit.scaleDown,
                    ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text("Jan Kowalski", style: TextStyle(fontSize: 20, color: Color.fromRGBO(22, 20, 35, 1.0))),
                      ),
                      IconButton(
                        onPressed: (){
                        }, 
                        icon: Icon(Icons.arrow_drop_down, size: 25,), color: Color.fromRGBO(22, 20, 35, 1.0),)
                    ])),
              ),
            ),
          )
        ], // default is 56
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            // labelType: NavigationRailLabelType.all,
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
                label: Text('Pacjenci'),
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
                label: Text('Profil'),
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
                label: Text('Ustawienia'),
              ),
            ],
          ),
          Expanded(
            child: Navigator(
              key: pages[_selectedIndex]['key'],
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                  builder: (context) => pages[_selectedIndex]['page'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
