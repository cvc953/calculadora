import 'package:flutter/material.dart';

class Menu {
  static const String menudeopciones = 'No hay nada que ver aqui,';
  static const String salir = 'salir';

  static const List<String> choice = <String>[menudeopciones];

  static const Map<String, IconData> choiceIcons = <String, IconData>{
    menudeopciones: Icons.share,
    salir: Icons.exit_to_app,
  };
}
