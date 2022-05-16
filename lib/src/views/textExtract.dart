import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slang_mobile/src/functions/utilidades.dart';
import 'package:slang_mobile/src/utils/widgets.dart';
import 'package:slang_mobile/src/views/addPhoto.dart';
import 'package:slang_mobile/src/views/menu.dart';
import 'package:slang_mobile/src/views/ticketlist.dart';
import 'package:flutter/material.dart';

class TextExtract extends StatefulWidget {
  final int? paginaActual;
  TextExtract({this.paginaActual = 0});
  @override
  State<TextExtract> createState() => _TextExtractState();
}

class _TextExtractState extends State<TextExtract> {
  List<Widget> paginas = [
    AddPhoto(),
    Ticketlist(),
  ];

  var paginaActual;

  @override
  void initState() {
    paginaActual = widget.paginaActual;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('lib/assets/icons/Burger_Menu.svg'),
          onPressed: () => changePageFade(Menu(), context),
        ),
        title: Container(
            padding: EdgeInsets.fromLTRB(60, 30, 60, 30),
            child: SvgPicture.asset('lib/assets/Slang/IconHorizontal.svg')),
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.person)),
        ],
        backgroundColor: Color(0xFF011A58),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("lib/assets/backgrounds/fondo3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('lib/assets/Slang/SlangCelebrando.svg'),
            SizedBox(height: dimension.height*0.05,),
            Container(
              height: dimension.height * 0.18,
              width: dimension.width * 0.82,
              decoration: BoxDecoration(
                  color: Color(0xFF011A58),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                children: <Widget>[
                  Text(
                    '¡El Ticket se ha almacenado correctamente!',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  CustomButton(
                      text: 'Nuevo Ticket',
                      width: dimension.width * 0.44,
                      height: dimension.height * 0.060),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Color(0xFFDC47A9),
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 1.0,
                      minimumSize: Size(
                          dimension.width * 0.44, dimension.height * 0.060),
                    ),
                    onPressed: () => {},
                    child: Text('Ver Archivador',
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: 16,
                            color: Color(0xFFDC47A9),
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
