import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';

class HomePage extends StatelessWidget {
  // debug(verDados) {
  //   debugPrint('debug: ${verDados}');
  // }

  // para permitir manipulação ao Scaffold de homepage pela customappbar
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
                title: 'Página Home',
                hideSerch: false, //button search
                drawerShow: true, //button drawer
                backShow: false //button back
                ),
            drawer: CustomDrawer(pageContext: context),
            backgroundColor: Theme.of(context).backgroundColor,
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Bem vindo(a) ao',
                          style: styles,
                        )),
                    Container(
                        margin: EdgeInsets.zero,
                        child: Image.asset(
                          // '../../lib/assets/devstravel_logo.png',
                          'lib/assets/devstravel_logo.png',

                          // para celular
                          width: MediaQuery.of(context).size.width * 0.6,

                          // width: MediaQuery.of(context).size.width * 0.3,
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          'Seu guia de viagem',
                          style: styles,
                        )),
                  ]),

              // Estava gerando um erro de carregamento, essa função debuga
              // e exibe o que contém no array data da page preload
              // debug(appdata.data)),
            )));
  }
}
