const regexEmail =
    r"^((([!#$%&'*+\-/=?^_`{|}~\w])|([!#$%&'*+\-/=?^_`{|}~\w][!#$%&'*+\-/=?^_`{|}~\.\w]{0,}[!#$%&'*+\-/=?^_`{|}~\w]))[@]\w+([-.]\w+)*\.\w+([-.]\w+)*)$";
const regexPassword =
    r"(?=^.{6,10}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&amp;*()_+}{&quot;:;'?/&gt;.&lt;,])(?!.*\s).*$";
const regexDNI = r'^(\d{8})([A-z])$';
const regexCIF = r'^([ABCDEFGHJKLMNPQRSUVW])(\d{7})([0-9A-J])$';
const regexNIE = r'^[XYZ]\d{7,8}[A-Z]$';
