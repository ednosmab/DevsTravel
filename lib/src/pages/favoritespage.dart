import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class FavoritesPage extends StatelessWidget {
  // debug(verDados) {
  //   debugPrint('debug: ${verDados}');
  // }

  // para permitir manipulação ao Scaffold de homepage pela customappbar
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  TextStyle styles = TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Helvetica Neue');
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, appdata, child) {
      List favorites = appdata.favoritesCities();

      return Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
              scaffoldKey: _scaffoldKey,
              pageContext: context,
              title: 'Cidades Salvas',
              hideSerch: false, //button search
              drawerShow: true, //button drawer
              backShow: false //button back
              ),
          drawer: CustomDrawer(pageContext: context),
          backgroundColor: Theme.of(context).backgroundColor,
          body: GridView.count(
            crossAxisCount: 2,
            children: List.generate(favorites.length, (index) {
              return CityBox(
                data: favorites[index],
                onTap: (cityData) {
                  Navigator.pushNamed(context, '/city', arguments: cityData);
                },
              );
            }),
          ));
    });
  }
}
