import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget implements PreferredSizeWidget {
  BuildContext pageContext;
  CustomDrawer({Key? key, required this.pageContext}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomDrawer(pageContext);

  @override
  Size get preferredSize {
    return const Size.fromHeight(80);
  }
}

class _CustomDrawer extends State<CustomDrawer> {
  BuildContext _pageContext;
  _CustomDrawer(this._pageContext);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: 'Menu de navegação',
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'DevsTravel',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Helvetica Neue'),
                  ),
                  Text(
                    'versão 1.0',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Helvetica Neue'),
                  ),
                ]),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.black),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.public, color: Colors.black),
            title: Text('Escolher Continente'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/continent');
            },
          ),
          ListTile(
            leading: Icon(Icons.search, color: Colors.black),
            title: Text('Buscar Cidade'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/search');
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.black),
            title: Text('Cidades Salvas'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/favorites');
            },
          ),
        ],
      ),
    );
  }
}
