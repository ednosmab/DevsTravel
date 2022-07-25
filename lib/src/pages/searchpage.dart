import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  // para permitir manipulação ao Scaffold de homepage pela customappbar
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  var list = [];

  void doSearch(pageContext, text) async {
    var newList =
        await Provider.of<AppData>(pageContext, listen: false).searchCity(text);

    setState(() {
      list = newList;
    });
  }

  TextStyle styles = TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Helvetica Neue');
  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
        builder: (context, appdata, child) => Scaffold(
            key: _scaffoldKey,
            appBar: CustomAppBar(
                scaffoldKey: _scaffoldKey,
                pageContext: context,
                title: 'Busque uma cidade',
                hideSerch: true, //para true o button search não aparecerá
                backShow: false),
            drawer: CustomDrawer(pageContext: context),
            backgroundColor: Theme.of(context).backgroundColor,
            body: Column(
              children: [
                Container(
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (text) {
                        doSearch(context, text);
                      },
                      decoration: InputDecoration(
                          hintText: 'Digite uma cidade',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.search,
                            size: 32,
                          )),
                    )),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(list.length, (index) {
                    return CityBox(
                      data: list[index],
                      onTap: (cityData) {
                        Navigator.pushNamed(context, '/city',
                            arguments: cityData);
                      },
                    );
                  }),
                ))
              ],
            )));
  }
}
