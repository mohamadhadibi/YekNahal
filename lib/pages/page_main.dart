import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/models/auth_response.dart';
import 'package:yek_nahal/pages/tabs/tab_gallery.dart';
import 'package:yek_nahal/pages/tabs/tab_nahal_shop.dart';
import 'package:yek_nahal/pages/tabs/tab_profile.dart';
import 'package:yek_nahal/pages/tabs/tab_home.dart';
import 'package:yek_nahal/pages/tabs/tab_search.dart';

class MainPage extends StatefulWidget {
  UserOb user;

  MainPage(UserOb user) {
    this.user = user;
  }

  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  int _currentIndex = 2;
  final List<Widget> _children = [
    SearchTab(),
    NahalShopTab(),
    HomeTab(),
    GalleryTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget parent, MainScope model) {
        model.setUser(widget.user);
        return Scaffold(
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: Colors.black87,
            unselectedItemColor: Colors.black26,
            onTap: onTabTapped,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.search),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_florist),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.image),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text(''),
              ),
            ],
          ),
        );
      },
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}
