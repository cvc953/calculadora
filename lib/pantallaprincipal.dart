import 'package:calculadora/botones.dart';
import 'package:flutter/material.dart';

class Pantallaprincipal extends StatefulWidget {
  const Pantallaprincipal({super.key});

  @override
  State<Pantallaprincipal> createState() => _Pantallaprincipal();
}

class _Pantallaprincipal extends State<Pantallaprincipal> {
  String numero1 = '';
  String operacion = '';
  String numero2 = '';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '$numero1$operacion$numero2'.isEmpty
                        ? '0'
                        : '$numero1$operacion$numero2',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),

            Wrap(
              children:
                  Botones.BotonesValor.map(
                    (value) => SizedBox(
                      width:
                          value == Botones.cero
                              ? screenSize.width / 2
                              : (screenSize.width / 4),
                      height: screenSize.height / 9,
                      child: buildButton(value),
                    ),
                  ).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBotonesColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          onTap: () => onBotonesTap(value),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }

  Color getBotonesColor(value) {
    return [Botones.borrar, Botones.eliminar].contains(value)
        ? Colors.blueGrey
        : [
          Botones.dividir,
          Botones.multiplicar,
          Botones.restar,
          Botones.sumar,
          Botones.igual,
          Botones.porcentaje,
        ].contains(value)
        ? Colors.blue
        : Colors.black26;
  }

  void onBotonesTap(String value) {
    if (value == Botones.borrar) {
      borrar();
      return;
    }

    if (value == Botones.eliminar) {
      eliminar();
      return;
    }

    if (value == Botones.igual) {
      igual();
      return;
    }

    if (value == Botones.porcentaje) {
      porcentaje();
      return;
    }

    tomarValores(value);
  }

  void borrar() {
    if (numero2.isNotEmpty) {
      numero2 = numero2.substring(0, numero2.length - 1);
    } else if (operacion.isNotEmpty) {
      operacion = '';
    } else if (numero1.isNotEmpty) {
      numero1 = numero1.substring(0, numero1.length - 1);
    }

    setState(() {});
  }

  void igual() {
    if (numero1.isEmpty) return;
    if (operacion.isEmpty) return;
    if (numero2.isEmpty) return;

    final double num1 = double.parse(numero1);
    final double num2 = double.parse(numero2);

    var resultado = 0.0;

    switch (operacion) {
      case Botones.sumar:
        resultado = num1 + num2;
        break;
      case Botones.restar:
        resultado = num1 - num2;
        break;
      case Botones.multiplicar:
        resultado = num1 * num2;
        break;
      case Botones.dividir:
        resultado = num1 / num2;
        break;
      default:
    }

    setState(() {
      numero1 = resultado.toString();

      if (numero1.endsWith('.0')) {
        numero1 = numero1.substring(0, numero1.length - 2);
      }

      operacion = '';
      numero2 = '';
    });
  }

  void eliminar() {
    setState(() {
      numero1 = '';
      operacion = '';
      numero2 = '';
    });
  }

  void porcentaje() {
    if (numero1.isNotEmpty && operacion.isNotEmpty && numero2.isNotEmpty) {
      igual();
    }
    if (operacion.isNotEmpty) {
      return;
    }

    final numero = double.parse(numero1);
    setState(() {
      numero1 = '${(numero / 100)}';
      operacion = '';
      numero2 = '';
    });
  }

  void tomarValores(String value) {
    if (value != Botones.punto && int.tryParse(value) == null) {
      if (operacion.isNotEmpty && numero2.isNotEmpty) {
        igual();
      }
      operacion = value;
    } else if (numero1.isEmpty || operacion.isEmpty) {
      if (value == Botones.punto && numero1.contains(Botones.punto)) return;
      if (value == Botones.punto && numero1.isEmpty ||
          numero2 == Botones.cero) {
        value = '0.';
      }

      numero1 += value;
    } else if (numero2.isEmpty || operacion.isNotEmpty) {
      if (value == Botones.punto && numero2.contains(Botones.punto)) return;
      if (value == Botones.punto && numero2.isEmpty ||
          numero2 == Botones.cero) {
        value = '0.';
      }

      numero2 += value;
    }

    setState(() {});
  }
}
