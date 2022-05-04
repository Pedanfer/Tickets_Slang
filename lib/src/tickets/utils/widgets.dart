import 'package:slang_mobile/src/tickets/functions/utilidades.dart';
import 'package:slang_mobile/src/tickets/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

Padding getBackButton(Size dimension, Widget screen, BuildContext context) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
      dimension.width * 0.85,
      dimension.height * 0.1,
      dimension.width * 0.03,
      0,
    ),
    child: IconButton(
      icon: SvgPicture.asset(getBackButtonIcon),
      onPressed: () => changePageFade(screen, context),
    ),
  );
}

TextButton CustomButton(
    {required String text,
    required double width,
    required double height,
    Function()? onPressed}) {
  return TextButton(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      backgroundColor: pink75,
      elevation: 1.0,
      minimumSize: Size(width, height),
    ),
    onPressed: onPressed,
    child: Text(text,
        style: GoogleFonts.ibmPlexSans(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
  );
}

AlertDialog CustomAlertDialog(String message, Size dimension) {
  return AlertDialog(
    title: Text(
      message,
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      textAlign: TextAlign.center,
    ),
    backgroundColor: blue75,
    titlePadding: EdgeInsets.all(dimension.width * 0.03),
    contentPadding: EdgeInsets.all(0),
    content: Image.asset(
      'lib/assets/loadSlang2.gif',
      fit: BoxFit.cover,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );
}

//Truco que hace invisible el texto y usa en realidad su sombra con offset
Text TitleWithUnderline(
    {required String text,
    required Color color,
    required double fontSize,
    required int spaceLength,
    required bool dashed}) {
  return Text.rich(
    TextSpan(
      text: text,
      style: TextStyle(
          shadows: [Shadow(color: color, offset: Offset(0, -10))],
          color: Colors.transparent,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          decorationStyle:
              dashed ? TextDecorationStyle.dashed : TextDecorationStyle.solid,
          decorationColor: color,
          decorationThickness: 1),
      children: <TextSpan>[
        TextSpan(
            text: ' ' * spaceLength,
            style: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: dashed
                    ? TextDecorationStyle.dashed
                    : TextDecorationStyle.solid)),
        // can add more TextSpans here...
      ],
    ),
    textAlign: TextAlign.start,
  );
}

/*Las clases con todas los campos como constantes se pueden instanciar como
objetos const lo cual mejora el rendimiento*/
class CustomCheckBox extends StatefulWidget {
  final Color color;
  final Size dimension;
  final double offsetCheck;
  final double offsetText;
  final List<TextSpan> text;

  CustomCheckBox(
      {required this.color,
      required this.dimension,
      required this.offsetCheck,
      required this.offsetText,
      required this.text,
      Key? key})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => CustomCheckBoxState();
}

//Es siempre en el estado donde modificamos los widgets
class CustomCheckBoxState extends State<CustomCheckBox> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          checkboxTheme: CheckboxThemeData(
              fillColor: MaterialStateProperty.all(Colors.transparent),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)))),
      child: Transform.scale(
        scale: 0.85,
        child: Transform.translate(
          offset: Offset(widget.offsetCheck, 0),
          child: CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              checkColor: widget.color,
              side: BorderSide(color: widget.color),
              title: Transform.translate(
                offset: Offset(widget.offsetText, 0),
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                        height: widget.dimension.height * 0.0025,
                        fontSize: 12,
                        color: widget.color,
                      ),
                      children: widget.text),
                ),
              ),
              value: checked,
              onChanged: (bool? newValue) {
                setState(() {
                  checked = newValue!;
                });
              }),
        ),
      ),
    );
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(
    BuildContext context, String message, int duration) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color(0xff011A58),
      content: Text(message,
          style: TextStyle(fontSize: 14), textAlign: TextAlign.center),
      duration: Duration(seconds: duration)));
}

class DropDownCategs extends StatefulWidget {
  final Function func;
  final String hint;
  final String categList;

  DropDownCategs(this.func, this.hint, this.categList, {Key? key})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => DropDownCategsState();
}

class DropDownCategsState extends State<DropDownCategs> {
  String hint = '';

  @override
  void initState() {
    hint = widget.hint;
    super.initState();
  }

  void changeHint(String hint) {
    setState(() {
      this.hint = hint;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.5),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.black),
          color: Colors.white),
      child: DropdownButton(
          items: prefs!.getStringList(widget.categList)!.map((String e) {
            return DropdownMenuItem(value: e, child: Text(e));
          }).toList(),
          onChanged: (value) => {
                setState(() {
                  hint = value.toString();
                }),
                widget.func(value)
              },
          hint: Text(hint),
          underline: SizedBox()),
    );
  }
}
