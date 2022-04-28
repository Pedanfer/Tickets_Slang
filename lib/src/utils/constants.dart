import 'package:flutter/material.dart';

const regexEmail =
    r"^((([!#$%&'*+\-/=?^_`{|}~\w])|([!#$%&'*+\-/=?^_`{|}~\w][!#$%&'*+\-/=?^_`{|}~\.\w]{0,}[!#$%&'*+\-/=?^_`{|}~\w]))[@]\w+([-.]\w+)*\.\w+([-.]\w+)*)$";
const regexPassword =
    r"(?=^.{6,10}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&€amp;*()_+}{&quot;:;'?/&gt;.&lt;,])(?!.*\s).*$";
const regexDNI = r'^(\d{8})([A-z])$';
const regexCIF = r'^([ABCDEFGHJKLMNPQRSUVW])(\d{7})([0-9A-J])$';
const regexNIE = r'^[XYZ]\d{7,8}[A-Z]$';
const regexName = r'^[a-zA-ZÀ-ÿ\u00f1\u00d1 ]{3,}$';
const regexPhone = r'^[0-9]{9}$';

const blue100 = Color(0xff011A58);
const blue75 = Color(0xff415382);
const blue50 = Color(0xffA0A9C0);
const blue10 = Color(0xffECEEF3);
const blue5 = Color(0xffF2F4F7);
const pink100 = Color(0xffD0098D);
const pink75 = Color(0xffDC47A9);
const pink50 = Color(0xffE784C6);
const pink10 = Color(0xffFAE6F4);
const pink5 = Color(0xffFDF3F9);
const formBackground = Color(0xffF2F4F7);
