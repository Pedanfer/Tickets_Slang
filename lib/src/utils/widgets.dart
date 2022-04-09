import 'package:exploration_planner/src/functions/utilidades.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextButton CustomButton(
    {required String text, required double width, Function()? onPressed}) {
  return TextButton(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      backgroundColor: Color(0xffDC47A9),
      elevation: 1.0,
      minimumSize: Size(width, 40),
    ),
    onPressed: onPressed,
    child: Text(text,
        style: GoogleFonts.ibmPlexSans(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
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
    backgroundColor: Color(0xffDC47A9),
    titlePadding: EdgeInsets.all(dimension.width * 0.03),
    contentPadding: EdgeInsets.all(0),
    content: Image.asset(
      'lib/assets/loadSlang.gif',
      fit: BoxFit.cover,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );
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
