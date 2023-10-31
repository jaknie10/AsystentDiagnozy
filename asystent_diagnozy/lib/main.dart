
import 'package:flutter/material.dart';

import 'home.dart';
import 'profile.dart';
import 'settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asystent Diagnozy',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, primary: Color.fromRGBO(0, 99, 248, 1.0), secondary: Color.fromRGBO(0, 99, 248, 0.1), background: Color.fromRGBO(238, 238, 238, 1)),
          fontFamily: 'Montserrat',
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _page = 'home';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        leading: Container(
          width: 80.0,
          child: IconButton(
            style: IconButton.styleFrom(
                      elevation: 0,
                      highlightColor: Colors.transparent, 
                      hoverColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),)
                    ),
            onPressed: () {
              setState(() { 
              if( _page != 'home') _page = 'home';
              });
             },
            icon: 
            ImageIcon(
                AssetImage('assets/cardiologyLogo.png'),
                size: 100,
                color: Theme.of(context).colorScheme.primary,
            ),
            )
            ),
        leadingWidth: 80,
        title: Align(
            alignment: Alignment.centerLeft,
            child: 
              Container(
                width: 350,
                child: SearchBar(),),),
        actions: [
          Container(
            width: 250,
            height: 80,
            color: Colors.blue,
            padding: EdgeInsets.all(20.0),
            child: 
              Align(
                alignment: Alignment.centerLeft,
                child: Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.people, size: 30,),
                    Text("Jan Kowalski", style: TextStyle(fontSize: 20))]
                )
              ),
          )
        ], // default is 56
      ),
      body:
        Row(
          children: <Widget>[
            Container(
              width: 80,
              color: Colors.white,
              child: 
              SafeArea( 
                
                child: Column(
                children: [
                  Container(
                    width: 100.0,
                    height: 80.0,
                    color: Colors.white,
                    child: IconButton(
                    style: IconButton.styleFrom(
                              elevation: 0,
                              hoverColor: Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),)
                            ),
                    onPressed: () {setState(() {
                      if( _page != 'home' ){ 
                        _page = 'home';
                        debugPrint('$_page');}
                      });
                    },
                    icon: _page == 'home' ? ImageIcon(
                      AssetImage('assets/home_focused.png'),
                      size: 30,
                      color: Color.fromRGBO(22, 20, 35, 60),
                  ) : ImageIcon(
                      AssetImage('assets/home.png'),
                      size: 30,
                      color: Color.fromRGBO(22, 20, 35, 60),
                  ),
                  )
                  ),
                  Container(
                    width: 100.0,
                    height: 80.0,
                    color: Colors.white,
                    child: IconButton(
                    style: IconButton.styleFrom(
                              elevation: 0,
                              hoverColor: Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),)
                            ),
                    onPressed: () {setState(() {
                      if( _page != 'profile' ){ 
                        _page = 'profile';
                        debugPrint('$_page');}
                      });
                    },
                    icon: _page == 'profile' ? ImageIcon(
                      AssetImage('assets/profile_focused.png'),
                      size: 30,
                      color: Color.fromRGBO(22, 20, 35, 60),
                  ) : ImageIcon(
                      AssetImage('assets/profile.png'),
                      size: 30,
                      color: Color.fromRGBO(22, 20, 35, 60),
                  ),
                  ),
                  ),
                  Container(
                    width: 100.0,
                    height: 80.0,
                    color: Colors.white,
                    child: IconButton(
                    style: IconButton.styleFrom(
                              elevation: 0,
                              hoverColor: Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),)
                            ),
                    onPressed: () {setState(() {
                      if( _page != 'settings' ){ 
                        _page = 'settings';
                        debugPrint('$_page');}
                      });
                    },
                    icon: _page == 'settings' ? ImageIcon(
                      AssetImage('assets/settings_focused.png'),
                      size: 30,
                      color: Color.fromRGBO(22, 20, 35, 60),
                  ) : ImageIcon(
                      AssetImage('assets/settings.png'),
                      size: 30,
                      color: Color.fromRGBO(22, 20, 35, 60),
                  ),
                  ),
                  ),
                ],
              )),
            ),
            if(_page == 'settings') new Settings() 
            else if(_page == 'home') new HomePage() 
            else if(_page == 'profile') new Profile(),

          ],
        ),
    );
  }
}
