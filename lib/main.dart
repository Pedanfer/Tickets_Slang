import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/views/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme:
              GoogleFonts.titilliumWebTextTheme(Theme.of(context).textTheme),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: 'login',
      routes: {'login': (context) => LoginPage()},
      debugShowCheckedModeBanner: false,
      title: 'Ticket Manager',
      home: LoginPage(),
    );
  }
}
