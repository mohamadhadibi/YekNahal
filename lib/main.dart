import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/models/auth_response.dart';
import 'package:yek_nahal/pages/page_blog.dart';
import 'package:yek_nahal/pages/page_main.dart';
import 'package:yek_nahal/pages/page_splash.dart';
import 'package:yek_nahal/utils/routs.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'models/blogs_response.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }

}

class _MyApp extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainScope>(
      model: MainScope(),
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("fa", "IR"),
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.teal,
            fontFamily: 'IranSans',
            buttonColor: Colors.tealAccent,
            brightness: Brightness.light,
        ),
        home: SplashPage(),
        onGenerateRoute: (RouteSettings settings){
          final arguments = settings.arguments;
          switch(settings.name){
            case rout_main:
              UserOb ob = (arguments is UserOb) ? arguments : null;
              return MaterialPageRoute(
                builder: (BuildContext context) => MainPage(ob),
              );
              break;

            case rout_blog:
              if (arguments is BlogOb) {
                BlogOb blog = arguments;
                return MaterialPageRoute(
                  builder: (BuildContext context) =>
                      BlogPage(blog),
                );
              }
              break;

            default:
              break;
          }
        },
        onUnknownRoute: (RouteSettings settings){
//          return MaterialPageRoute(
//            builder: (BuildContext context) => MainPage(null),
//          );
        },
      ),
    );
  }

}
