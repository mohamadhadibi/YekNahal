import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/models/auth_response.dart';
import 'package:yek_nahal/utils/utils.dart';
import 'package:yek_nahal/widgets/Toolbar.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfilePage();
  }
}

class _EditProfilePage extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget parent, MainScope model) {
        UserOb _user = model.getUser();
        return Scaffold(
          appBar: makeAppbar('ویرایش پروفایل', context),
          body: Container(
            child: Container(
              margin: EdgeInsets.all(8),
              child: Card(
                elevation: 3,
                margin: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsetsDirectional.only(bottom: 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(180),
                                child: FadeInImage(
                                  width: 60,
                                  height: 60,
                                  image: NetworkImage('_user.avatarUrl'),
                                  placeholder: AssetImage(image_place_holder),
                                ),
                              ),
                            ),
                            Container(
                              width: 200,
                              child: ListTile(
                                title: Container(
                                  child: Text('آپلود عکس'),
                                  margin: EdgeInsets.only(bottom: 15),
                                ),
                                subtitle: Text('حداکثر حجم 2 مگابایت'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
