import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/models/blogs_response.dart';

class SearchTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchTab();
  }
}

class _SearchTab extends State<SearchTab> {
  List<BlogOb> blogs;
  String strSearch = "";

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget parent, MainScope model) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              Card(
                elevation: 7,
                margin: EdgeInsetsDirectional.only(top: 20),
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 40,
                  child: TextFormField(
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      icon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.black87,
                        ),
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black87,
                        ),
                      ),
                      labelText: 'جستجو',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    onSaved: (String value) {
                      strSearch = value;
                    },
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(),
              ),
            ],
          ),
        );
      },
    );
  }

}
