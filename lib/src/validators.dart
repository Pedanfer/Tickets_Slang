import 'package:exploration_planner/src/constants.dart';

String? validateEmail(dynamic value) {
  if (value.length == 0) return '';
  return RegExp(regexEmail).hasMatch(value)
      ? null
      : 'Formato incorrecto en el mail';
}

String? validatePassword(dynamic value) {
  if (value.length == 0) return '';
}
