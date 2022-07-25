import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class ContinentPage extends StatelessWidget {
  // para permitir manipulação ao Scaffold de homepage pela customappbar
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  TextStyle styles = TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Helvetica Neue');

  void seeCityAction(context, continentIndex) {
    print(continentIndex);
    Navigator.pushNamed(context, '/listcity', arguments: continentIndex);
  }

  cityBoxAction(pageContext, cityData) {
    Navigator.pushNamed(pageContext, '/city', arguments: cityData);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
        builder: (context, appdata, child) => Scaffold(
            key: _scaffoldKey,
            appBar: CustomAppBar(
                scaffoldKey: _scaffoldKey,
                pageContext: context,
                title: 'Escolha um Continente',
                hideSerch: false,
                drawerShow: true,
                backShow: true),
            drawer: CustomDrawer(pageContext: context),
            backgroundColor: Theme.of(context).backgroundColor,
            body: ListView.builder(
              itemCount: appdata.data.length,
              itemBuilder: (context, index) {
                var cities = [];

                for (var country in appdata.data[index]['countries']) {
                  cities.addAll(country['cities']);
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              '${appdata.data[index]['name']} (${cities.length})',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Helvetica Neue'),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              seeCityAction(context, index);
                            },
                            child: Text(
                              'Ver Cidades',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Helvetica Neue'),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white)),
                      ],
                    ),
                    Container(
                      height: 150,
                      margin: EdgeInsets.only(bottom: 15),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cities.length,
                        itemBuilder: (cityContext, cityIndex) {
                          return CityBox(
                              data: cities[cityIndex],
                              onTap: (cityData) {
                                cityBoxAction(context, cityData);
                              });
                        },
                      ),
                    )
                  ],
                );
              },
            )));
  }
}
