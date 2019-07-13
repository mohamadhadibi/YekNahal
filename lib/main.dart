import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yek_nahal/di/MainScope.dart';
import 'package:yek_nahal/models/auth_response.dart';
import 'package:yek_nahal/pages/page_blog.dart';
import 'package:yek_nahal/pages/page_main.dart';
import 'package:yek_nahal/pages/page_share.dart';
import 'package:yek_nahal/pages/page_splash.dart';
import 'package:yek_nahal/pages/page_yeknahal_map.dart';
import 'package:yek_nahal/utils/routs.dart';
import 'package:map_view/map_view.dart';
import 'package:yek_nahal/utils/utils.dart';

import 'models/blogs_response.dart';
import 'pages/page_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    MapView.setApiKey(map_debug);
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
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
        onGenerateRoute: (RouteSettings settings) {
          final arguments = settings.arguments;
          switch (settings.name) {
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
                  builder: (BuildContext context) => BlogPage(blog),
                );
              }
              break;

            case rout_auth:
              if (arguments is PageState) {
                PageState state = arguments;
                return MaterialPageRoute(
                  builder: (BuildContext context) => AuthPage(),
                );
              }
              break;

            case rout_share:
              return MaterialPageRoute(
                builder: (BuildContext context) => SharePage(),
              );
              break;

            case rout_yek_nahal_map:
              return MaterialPageRoute(
                builder: (BuildContext context) => YekNahalMapPage(),
              );
              break;

            default:
              break;
          }
        },
        onUnknownRoute: (RouteSettings settings) {
        /*return MaterialPageRoute(
            builder: (BuildContext context) => MainPage(null),
          );*/
        },
      ),
    );
  }
}
