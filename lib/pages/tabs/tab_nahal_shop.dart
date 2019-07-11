import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/models/nahal_shop_info_response.dart';
import 'package:yek_nahal/utils/utils.dart';
import 'package:yek_nahal/widgets/YeNahal.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NahalShopTab extends StatefulWidget {

  NahalShopTab();

  @override
  State<StatefulWidget> createState() {
    return _NahalShopTab();
  }
}

class _NahalShopTab extends State<NahalShopTab> {
  List<NahalOb> nahals = [];
  List<HemayatOb> hemayats = [];
  bool isDataLoaded = false;
  String _currentNahal, _currentHemayat;
  List<DropdownMenuItem<String>> _nahalDropDownMenuItems;
  List<DropdownMenuItem<String>> _hemayatDropDownMenuItems;

  @override
  void initState() {
    super.initState();
    requestGetNahahlShopInfo('').then((response) {
      if (response != null && response is NahalShopInfoResponse) {
        nahals = response.nahal.toList();
        hemayats = response.hemayat.toList();
        loadData();
        setState(() {
          isDataLoaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScope>(
      builder: (BuildContext context, Widget parent, MainScope model) {
        if (isDataLoaded) {
          return Container(
            child: Card(
              elevation: 7,
              margin: EdgeInsets.only(right: 20, left: 20, top: 30, bottom: 10),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 70,
                      height: 110,
                      alignment: AlignmentDirectional.topStart,
                      child: Image.asset('assets/images/ic_violet_brush.png'),
                    ),
                    Container(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Image.asset('assets/images/ic_default_icon.png'),
                    ),
                    YeNahal(),
                    Container(
                      alignment: AlignmentDirectional.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10.0, right: 10.0, left: 10.0),
                                  width: double.infinity,
                                  height: 40,
                                  child: DropdownButtonHideUnderline(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: DropdownButton(
                                          value: _currentNahal,
                                          items: _nahalDropDownMenuItems,
                                          onChanged: changedNahalDropDown),
                                    ),
                                  ),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                          color: Colors.teal),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10.0, right: 10.0, left: 10.0),
                                  width: double.infinity,
                                  height: 40,
                                  child: DropdownButtonHideUnderline(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: DropdownButton(
                                          value: _currentHemayat,
                                          items: _hemayatDropDownMenuItems,
                                          onChanged: changedHemayatDropDown),
                                    ),
                                  ),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                          color: Colors.teal),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            width: 150,
                            child: RaisedButton(
                              child: Text(
                                'پرداخت',
                              ),
                              textColor: Colors.white,
                              color: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              onPressed: (){
                                _launchURL();
                                /*var url = "https://www.google.com/search?q={selectedHotelName}";
                                launch(url);*/
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void changedNahalDropDown(String selectedItem) {
    setState(() {
      _currentNahal = selectedItem;
    });
  }

  void changedHemayatDropDown(String selectedItem) {
    setState(() {
      _currentHemayat = selectedItem;
    });
  }

  void loadData(){
    List<DropdownMenuItem<String>> nahalItems = new List();
    for (NahalOb nahal in nahals) {
      nahalItems.add(
        DropdownMenuItem(
          value: '${nahal.id}',
          child: Text(
            nahal.name,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
          ),
        ),
      );
    }
    List<DropdownMenuItem<String>> hemayatItems = List();
    for (HemayatOb hemayat in hemayats) {
      hemayatItems.add(
        DropdownMenuItem(
          value: '${hemayat.id}',
          child: Text(
            '${hemayat.name}',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
          ),
        ),
      );
    }

    _currentNahal             = nahalItems[0].value;
    _nahalDropDownMenuItems   = nahalItems;
    _currentHemayat           = hemayatItems[0].value;
    _hemayatDropDownMenuItems = hemayatItems;
  }

  Future<NahalShopInfoResponse> requestGetNahahlShopInfo(String  token) async {
    NahalShopInfoResponse infoResult = NahalShopInfoResponse();
    try {
      Map<String, String> header = {'Authorization': token};
      final http.Response response = await http.get(api_get_shop_info, headers: header);
      if (response.statusCode != 200 && response.statusCode != 201) {
        return infoResult;
      } else {
        var result = json.decode(response.body);
        return infoResult = NahalShopInfoResponse.fromJson(result);
      }
    } catch (error) {
      return infoResult;
    }
  }

  void _launchURL() async {
    String url = api_payment+'n=$_currentNahal&h=$_currentHemayat';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      debugPrint('open error');
      throw 'Could not launch $url';
    }
  }

}
