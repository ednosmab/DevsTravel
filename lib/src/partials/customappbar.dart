import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  BuildContext pageContext;
  String title;
  bool hideSerch;
  bool drawerShow;
  bool backShow;

  CustomAppBar({
    Key? key,
    required this.scaffoldKey,
    required this.pageContext,
    required this.title,
    required this.hideSerch,
    this.drawerShow = true,
    required this.backShow,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _CustomAppBar(
        scaffoldKey,
        pageContext,
        title,
        hideSerch,
        drawerShow,
        backShow,
      );

  @override
  Size get preferredSize {
    return const Size.fromHeight(80);
  }
}

class _CustomAppBar extends State<CustomAppBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final BuildContext _pageContext;
  final String _title;
  final bool _hideSerch;
  final bool _drawerShow;
  final bool _backShow;

  _CustomAppBar(this._scaffoldKey, this._pageContext, this._title,
      this._hideSerch, this._drawerShow, this._backShow);

  @override
  Widget build(BuildContext context) {
    String showDrawerBack = '';
    if (_drawerShow) {
      showDrawerBack = "menu";
    }
    if (_backShow) {
      showDrawerBack = 'arrow_back';
    }
    funcDrawerBack(showDrawerBack) {
      if (showDrawerBack == 'menu') {
        return IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu, color: Colors.black, size: 30));
      } else if (showDrawerBack == 'arrow_back') {
        return IconButton(
            onPressed: () {
              Navigator.pop(_pageContext);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30));
      }
    }

    void searchAction() {
      Navigator.pushReplacementNamed(_pageContext, '/search');
    }

    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            padding: const EdgeInsets.only(bottom: 8),
            child: funcDrawerBack(showDrawerBack),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.only(top: 30),
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              _title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Helvetica Neue'),
            ),
          ),
          !_hideSerch
              ? Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.only(bottom: 8),
                  child: IconButton(
                      onPressed: searchAction,
                      icon: const Icon(Icons.search,
                          color: Colors.black, size: 30)))
              : Container(),
        ],
      ),
    );
  }
}
