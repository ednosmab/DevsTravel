import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class ListCityPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  TextStyle styles = TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Helvetica Neue');

  void cityBoxAction(pageContext, cityData) {
    Navigator.pushNamed(pageContext, '/city', arguments: cityData);
  }

  @override
  Widget build(BuildContext context) {
    final continentIndex = ModalRoute.of(context)!.settings.arguments as int;
    return Consumer<AppData>(builder: (context, appdata, child) {
      var cities = [];

      for (var country in appdata.data[continentIndex]['countries']) {
        cities.addAll(country['cities']);
      }
      return Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
              scaffoldKey: _scaffoldKey,
              pageContext: context,
              title:
                  '${appdata.data[continentIndex]['name']} (${cities.length})',
              hideSerch: false,
              drawerShow: true,
              backShow: true),
          drawer: CustomDrawer(pageContext: context),
          backgroundColor: Theme.of(context).backgroundColor,
          body: GridView.count(
              crossAxisCount: 3,
              children: List.generate(cities.length, (index) {
                return CityBox(
                  data: cities[index],
                  onTap: (cityData) {
                    cityBoxAction(context, cityData);
                  },
                );
              })));
    });
  }
}
