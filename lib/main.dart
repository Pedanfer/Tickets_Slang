import 'dart:async';
import 'package:slang_mobile/src/functions/utilidades.dart';
import 'package:slang_mobile/src/views/chooseApp.dart';
import 'package:slang_mobile/src/views/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

var prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await loadImage(AssetImage('lib/assets/backgrounds/fondo.png'));
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
                image: DecorationImage(
                  image: AssetImage("lib/assets/backgrounds/fondo.png"),
                  fit: BoxFit.cover,
                ),
              ),
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
    prefs = await getPrefs();
    var login = await prefs!.getStringList('login');
    if (login != null) return ChooseApp();
    return LoginPage();
  }
}

/*Código copiado de Internet, el fondo tarda en cargar por alguna razón,
falta implementar para iOS, quizás se puede usar con todas las imágenes
al principio con un for*/
Future<void> loadImage(ImageProvider provider) {
  final config = ImageConfiguration(
    bundle: rootBundle,
    devicePixelRatio: 1,
    platform: TargetPlatform.android,
  );

  final Completer<void> completer = Completer();
  final ImageStream stream = provider.resolve(config);
  late final ImageStreamListener listener;

  listener = ImageStreamListener(
    (ImageInfo image, bool sync) {
      completer.complete();
      stream.removeListener(listener);
    },
  );

  stream.addListener(listener);
  return completer.future;
}
