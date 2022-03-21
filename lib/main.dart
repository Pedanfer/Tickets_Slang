import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/login_page.dart';

//Dentro de MyApp hay una cascada de returns:
//MaterialApp > Scaffold > AppBar|body: Column > Progress|TaskList
void main() => runApp(MyApp());

//Los widgets sin estado no se modifican, los TaskList (checkboxes)
//son los únicos con estado
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: 'login',
      routes: {'login': (context) => LoginPage()},
      debugShowCheckedModeBanner: false,
      title: 'Ticket Manager',
      home: LoginPage(),
    );
  }
}
