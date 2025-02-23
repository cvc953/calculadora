import 'package:calculadora/botones.dart';
import 'package:flutter/material.dart';

class Pantallaprincipal extends StatefulWidget {
  const Pantallaprincipal({super.key});

  @override
  State<Pantallaprincipal> createState() => _Pantallaprincipal();
}

class _Pantallaprincipal extends State<Pantallaprincipal> {
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
                    '0',
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
                      width: screenSize.width / 4,
                      height: screenSize.height / 5,
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
    return Center(child: Text(value));
  }
}
