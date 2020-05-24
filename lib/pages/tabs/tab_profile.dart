import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/models/auth_response.dart';
import 'package:yek_nahal/utils/routs.dart';
import 'package:yek_nahal/utils/utils.dart';

import '../page_auth.dart';

class ProfileTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileTab();
  }
}

class _ProfileTab extends State<ProfileTab> {
  UserOb _user;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget parent, MainScope model) {
        _user = model.getUser();
        return SingleChildScrollView(
            child: (_user != null)
                ? Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: Card(
                            elevation: 3,
                            margin: EdgeInsets.all(10),
                            child: Container(
                              padding: EdgeInsets.all(30),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsetsDirectional.only(bottom: 15),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(180),
                                      child: FadeInImage(
                                        width: 60,
                                        height: 60,
                                        image: NetworkImage(_user.avatarUrl),
                                        placeholder:
                                            AssetImage(image_place_holder),
                                      ),
                                    ),
                                  ),
                                  Text(_user.email),
                                  Container(
                                    height: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: ListTile(
                                            title: Text(
                                              '${_user.waitingPlantedNumber}',
                                              textAlign: TextAlign.center,
                                            ),
                                            subtitle: Text(
                                              'منتظر کاشت',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: ListTile(
                                            title: Text(
                                              '${_user.plantedNumber}',
                                              textAlign: TextAlign.center,
                                            ),
                                            subtitle: Text(
                                              'کاشته شده',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Card(
                            elevation: 3,
                            margin: EdgeInsets.only(
                                right: 10, left: 10, bottom: 10),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  FlatButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.color_lens),
                                    label: Text('نهال های خریداری شده'),
                                  ),
                                  FlatButton.icon(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        rout_edit_profile,
                                      );
                                    },
                                    icon: Icon(Icons.color_lens),
                                    label: Text('ویرایش پروفایل'),
                                  ),
                                  FlatButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.color_lens),
                                    label: Text('درباره یک نهال'),
                                  ),
                                  FlatButton.icon(
                                    onPressed: () {

                                    },
                                    icon: Icon(Icons.color_lens),
                                    label: Text('پشتیبانی'),
                                  ),
                                  FlatButton.icon(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        rout_our_team,
                                      );
                                    },
                                    icon: Icon(Icons.color_lens),
                                    label: Text('تیم ما'),
                                  ),
                                  FlatButton.icon(
                                    onPressed: () {
                                      model.logout().then((bool result){
                                        if(result){
                                          setState(() {
                                            _user = model.getUser();
                                          });
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.color_lens),
                                    label: Text('خروج از حساب کاربری'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Container(
                    margin: EdgeInsetsDirectional.only(
                        top: 200, start: 20, end: 20),
                    alignment: AlignmentDirectional.center,
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            'برای استفاده از امکانات این بخش ابتدا میبایست به اکانت خود وارد شوید.',
                            style: TextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          width: 150,
                          margin: EdgeInsetsDirectional.only(top: 30),
                          child: FlatButton(
                            child: Text(
                              'ورود',
                            ),
                            textColor: Colors.white,
                            color: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                rout_auth,
                                arguments: PageState.reg_email,
                              );
                            },
                          ),
                        ),
                      ],
                    )));
      },
    );
  }
}
