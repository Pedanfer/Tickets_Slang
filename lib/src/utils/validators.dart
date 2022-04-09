import 'package:exploration_planner/src/utils/constants.dart';

String? validateEmail(dynamic value) {
  if (value.length == 0) return 'Campo vacío';
  return RegExp(regexEmail).hasMatch(value)
      ? null
      : 'Formato incorrecto en el mail';
}

String? validatePassword(dynamic value) {
  return value.length == 0 ? 'Campo vacío' : null;
}

String? validateCreatedPassword(dynamic value) {
  if (value.length == 0) return 'Campo vacío';
  return RegExp(regexPassword).hasMatch(value)
      ? null
      : 'Contraseña débil, incluya al menos 6 caracteres: mayúsculas, minúsculas y números';
}

String? validateName(dynamic value) {
  if (value.length == 0) return 'Campo vacío';
  return RegExp(regexName).hasMatch(value)
      ? null
      : 'El nombre ha de contener sólo letras, al menos tres.';
}

String? validatePhone(dynamic value) {
  if (value.length == 0) return 'Campo vacío';
  return RegExp(regexPhone).hasMatch(value)
      ? null
      : 'Introduzca un número de teléfono válido.';
}
