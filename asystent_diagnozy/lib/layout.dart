import 'dart:ui';

import 'package:asystent_diagnozy/models/user_model.dart';
import 'package:asystent_diagnozy/pages/badania/badania.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'pages/home/home.dart';
import 'pages/profile/profile.dart';

class Layout extends StatefulWidget {
  const Layout({super.key, required this.user});

  final User user;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  //-------------do tutoriala
  late TutorialCoachMark tutorialCoachMark;

  GlobalKey tutorialKey1 = GlobalKey();
  GlobalKey tutorialKey2 = GlobalKey();
  GlobalKey tutorialKey3 = GlobalKey();
  GlobalKey tutorialKey4 = GlobalKey();
  //-----------------

  int _selectedIndex = 0;

  var keyHome = GlobalKey<NavigatorState>();
  var keyProfile = GlobalKey<NavigatorState>();
  var keySettings = GlobalKey<NavigatorState>();
  var keyBadania = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var userId = prefs.getInt('LOGGED_USER');
        if (!prefs.containsKey('${userId}TUTORIAL_SEEN')) {
          if (!context.mounted) return;
          createTutorial(MediaQuery.of(context).size.width);
          showTutorial();
          prefs.setBool('${userId}TUTORIAL_SEEN', true);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    changeState(state) {
      setState(() {
        _selectedIndex = state;
      });
    }

    List<Map<String, dynamic>> pages = [
      {'name': 'Home', 'page': const HomePage(), 'key': keyHome},
      {'name': 'Badania', 'page': const Badania(), 'key': keyBadania},
      {
        'name': 'Profile',
        'page': Profile(user: widget.user),
        'key': keyProfile
      },
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
            icon: const Image(
              image: AssetImage('assets/logo_new.png'),
              width: 50,
              height: 50,
            ),
          ),
        ),
        leadingWidth: 80,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Asystent diagnozy",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 1.5),
          ),
        ),
        actions: [
          Padding(
            key: tutorialKey1,
            padding: const EdgeInsets.all(10.0),
            child: PopupMenuButton(
              tooltip: "",
              position: PopupMenuPosition.under,
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: const Text('Profil'),
                ),
                PopupMenuItem(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('LOGGED_USER');
                    prefs.remove('REMEMBER_USER');
                    if (!context.mounted) return;
                    Phoenix.rebirth(context);
                  },
                  child: const Text('Wyloguj'),
                ),
              ],
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Theme.of(context).colorScheme.background,
                ),
                padding: const EdgeInsets.all(10.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            'assets/lekarz_logo.svg',
                            width: 45,
                            fit: BoxFit.scaleDown,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(widget.user.login,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(22, 20, 35, 1.0))),
                          ),
                        ])),
              ),
            ),
          )
        ], // default is 56
      ),
      body: Row(
        children: [
          Drawer(
            shape: InputBorder.none,
            width: 80,
            child: Container(
              height: 200,
              color: Colors.white,
              child: Column(
                children: [
                  IconButton(
                    key: tutorialKey2,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    isSelected: _selectedIndex == 0,
                    selectedIcon: SvgPicture.asset(
                      'assets/home_icon_filled.svg',
                      height: 50,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    icon: SvgPicture.asset(
                      'assets/home_icon.svg',
                      height: 50,
                      colorFilter: const ColorFilter.mode(
                          Color.fromARGB(255, 99, 99, 99), BlendMode.srcIn),
                    ),
                  ),
                  IconButton(
                    key: tutorialKey3,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    isSelected: _selectedIndex == 1,
                    selectedIcon: SvgPicture.asset(
                      'assets/list_icon_filled.svg',
                      height: 50,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    icon: SvgPicture.asset(
                      'assets/list_icon.svg',
                      height: 50,
                      colorFilter: const ColorFilter.mode(
                          Color.fromARGB(255, 99, 99, 99), BlendMode.srcIn),
                    ),
                  ),
                  IconButton(
                    key: tutorialKey4,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    isSelected: _selectedIndex == 2,
                    selectedIcon: SvgPicture.asset(
                      'assets/person_icon_filled.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn),
                      height: 50,
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    icon: SvgPicture.asset(
                      'assets/person_icon.svg',
                      height: 50,
                      colorFilter: const ColorFilter.mode(
                          Color.fromARGB(255, 99, 99, 99), BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ),
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

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial(double windowWidth) {
    tutorialCoachMark = TutorialCoachMark(
      targets: [
        TargetFocus(
          keyTarget: tutorialKey1,
          enableOverlayTab: true,
          contents: [
            TargetContent(
              align: ContentAlign.custom,
              customPosition: CustomTargetContentPosition(
                  top: 150, left: windowWidth - 300),
              builder: (context, controller) {
                return const Text(
                  "Kliknij, aby przejść \ndo profilu użytkownika",
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ],
        ),
        TargetFocus(
          keyTarget: tutorialKey2,
          enableOverlayTab: true,
          contents: [
            TargetContent(
              align: ContentAlign.right,
              builder: (context, controller) {
                return const Text(
                  "Zakładka z listą pacjentów",
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ],
        ),
        TargetFocus(
          keyTarget: tutorialKey3,
          enableOverlayTab: true,
          contents: [
            TargetContent(
              align: ContentAlign.right,
              builder: (context, controller) {
                return const Text(
                  "Lista wszystkich przeprowadzonych badań",
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ],
        ),
        TargetFocus(
          keyTarget: tutorialKey4,
          enableOverlayTab: true,
          contents: [
            TargetContent(
              align: ContentAlign.right,
              builder: (context, controller) {
                return const Text(
                  "Profil użytkownika",
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ],
        ),
        TargetFocus(
          shape: ShapeLightFocus.RRect,
          radius: 15,
          targetPosition: TargetPosition(
            const Size(150, 70),
            const Offset(95, 80),
          ),
          enableOverlayTab: true,
          contents: [
            TargetContent(
              align: ContentAlign.right,
              builder: (context, controller) {
                return const Text(
                  "Dodaj nowego pacjenta",
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ],
        ),
        TargetFocus(
          shape: ShapeLightFocus.RRect,
          radius: 15,
          targetPosition: TargetPosition(
            const Size(300, 70),
            Offset(windowWidth - 320, 80),
          ),
          enableOverlayTab: true,
          contents: [
            TargetContent(
              align: ContentAlign.custom,
              customPosition:
                  CustomTargetContentPosition(top: 30, left: windowWidth - 460),
              builder: (context, controller) {
                return const Text(
                  "Sortuj listę \npacjentów",
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ],
        ),
      ],
      textSkip: "POMIŃ",
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
    );
  }
}
