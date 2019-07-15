import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/widgets/Toolbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_extend/share_extend.dart';

class SharePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SharePage();
  }
}

class _SharePage extends State<SharePage> {

  PermissionStatus _permissionStatus = PermissionStatus.unknown;
  ScreenshotController _screenshotController = ScreenshotController();
  File _imageFile;

  @override
  void initState() {
    super.initState();
    requestPermission(false);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget parent, MainScope model) {
        return Scaffold(
          appBar: makeAppbar('اشتراک گزاری', context),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    margin: EdgeInsets.all(30),
                    padding: EdgeInsetsDirectional.only(top: 10, start: 10),
                    child: Screenshot(
                      controller: _screenshotController,
                      child: Card(
                        elevation: 10,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: Image.asset('assets/images/ic_default_icon.png'),
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.only(start: 15, top: 15),
                              alignment: AlignmentDirectional.centerStart,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsetsDirectional.only(bottom: 8),
                                    child: Text(model.getUser().email),
                                    alignment: AlignmentDirectional.centerStart,
                                  ),
                                  Container(
                                    margin: EdgeInsetsDirectional.only(bottom: 15),
                                    child: Text('حامی یک نهال هستم', style: TextStyle(color: Colors.teal,),),
                                    alignment: AlignmentDirectional.centerStart,
                                  ),
                                  Container(
                                    margin: EdgeInsetsDirectional.only(bottom: 8),
                                    child: Text('سهم من'),
                                    alignment: AlignmentDirectional.centerStart,
                                  ),
                                  Container(
                                    child: Text('${model.getUser().plantedNumber} نهال درخت', style: TextStyle(color: Colors.teal,),),
                                    alignment: AlignmentDirectional.centerStart,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                        start: 40, end: 35, bottom: 10),
                    width: double.infinity,
                    height: 40,
                    child: FlatButton.icon(
                      textColor: Colors.white,
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {
                        requestPermission(true);
                      },
                      icon: Icon(
                        Icons.file_download,
                        color: Colors.white,
                      ),
                      label: Text(
                        'دانلود',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  Text(
                    'با اشتراک گذاری پروفایل خود در شبکه های اجتماعی \n یک نهال را به دوستان خود معرفی کنید.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black26,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> requestPermission(bool reqToCapture) async {
    final Map<PermissionGroup, PermissionStatus> permissionRequestResult =
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);


    _permissionStatus = permissionRequestResult[PermissionGroup.storage];
    if(_permissionStatus != PermissionStatus.granted){
      Toast.show('برای استفاده از این بخش شما میبایست مجوز مربوطه را تایید کنید.',context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }else{
      if(reqToCapture){
        _screenshotController.capture().then((File image) {
          setState(() {
            _imageFile = image;
            print('$_imageFile');
            ShareExtend.share(_imageFile.path, "image");
          });
        }).catchError((onError) {
          print(onError);
        });
      }
    }

  }


}
