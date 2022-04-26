import 'package:exploration_planner/src/functions/utilidades.dart';
import 'package:exploration_planner/src/utils/constants.dart';
import 'package:exploration_planner/src/views/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'src/views/login_page.dart';

//Dentro de MyApp hay una cascada de returns:
//MaterialApp > Scaffold > AppBar|body: Column > Progress|TaskList
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder(
        future: checkLogin(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  blue100,
                  blue50,
                ],
              )),
            );
          }
          return MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('es', ''),
              const Locale('en', ''),
            ],
            theme: ThemeData(
                textTheme: GoogleFonts.ibmPlexSansTextTheme(
                    Theme.of(context).textTheme),
                visualDensity: VisualDensity.adaptivePlatformDensity),
            initialRoute: 'login',
            routes: {'login': (context) => snapshot.data as Widget},
            debugShowCheckedModeBanner: false,
            title: 'Ticket Manager',
            home: LoginPage(),
          );
        });
  }

  Future<StatefulWidget> checkLogin() async {
    var prefs = await getPrefs();
    var login = await prefs!.getStringList('login');
    if (login != null) return DashBoard();
    return LoginPage();
  }
}
