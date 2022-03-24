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
        style: GoogleFonts.josefinSans(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
  );
}

class CustomAlertDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomAlertDialogState();
}

class CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(children: [
        Image.asset('lib/assets/error.png',
            width: 50, height: 50, fit: BoxFit.contain),
        Text('\t\t\t\t\t\t\t\tError')
      ]),
      content: Text('Oops! Parece que has olvidado rellenar un campo.'),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
