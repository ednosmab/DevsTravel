import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/models/appdata.dart';

import 'src/pages/preload.dart';
import 'src/pages/homepage.dart';
import 'src/pages/searchpage.dart';
import 'src/pages/continentpage.dart';
import 'src/pages/listcitypage.dart';
import 'src/pages/citypage.dart';
import 'src/pages/favoritespage.dart';

void main() => runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AppData())],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //isso serve para tirar aquela faixa dizendo que o app tá em modo debug
      theme: ThemeData(
          brightness: Brightness.light, backgroundColor: Colors.white),
      routes: {
        '/preload': (context) => PreloadPage(),
        '/home': (context) => HomePage(),
        '/search': (context) => SearchPage(),
        '/continent': (context) => ContinentPage(),
        '/listcity': (context) => ListCityPage(),
        '/city': (context) => CityPage(),
        '/favorites': (context) => FavoritesPage(),
      },
      initialRoute: '/preload',
    );
  }
}
