import 'package:flutter_svg/flutter_svg.dart';
import 'package:slang_mobile/src/functions/utilidades.dart';
import 'package:slang_mobile/src/utils/constants.dart';
import 'package:slang_mobile/src/views/menu.dart';
import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  final Color backgroundColor;
  final String loadingGif;
  final String message;
  final int loadingTime;
  final Widget whatLoads;
  Loader(
      {required this.backgroundColor,
      required this.loadingGif,
      required this.loadingTime,
      required this.whatLoads,
      required this.message});
  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.loadingTime), () {
      changePageFadeRemoveUntil(widget.whatLoads, context);
    });
  }

  @override
  Widget build(BuildContext context) {
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
        color: widget.backgroundColor,
        child: Column(
          children: [
            Spacer(),
            Image.asset('lib/assets/Slang/' + widget.loadingGif),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.message,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: blue75),
              textAlign: TextAlign.center,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
