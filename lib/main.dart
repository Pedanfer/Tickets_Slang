import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'src/views/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      // ...

      theme: ThemeData(
          textTheme:
              GoogleFonts.ibmPlexSansTextTheme(Theme.of(context).textTheme),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: 'login',
      routes: {'login': (context) => LoginPage()},
      debugShowCheckedModeBanner: false,
      title: 'Ticket Manager',
      home: LoginPage(),
    );
  }
}
