import 'package:flutter/material.dart';

class ConclusionesPage extends StatelessWidget {
  const ConclusionesPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Conclusiones'),
        backgroundColor: const Color(0xffe8a96c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "Concluir este proyecto de programación para la zapatería ha sido una experiencia gratificante y educativa. Diseñar y implementar formularios interactivos junto con una base de datos sólida ha mejorado significativamente la gestión de inventario y ventas. Este proyecto me ha permitido desarrollar habilidades en programación y solución de problemas, además de proporcionar una base sólida para enfrentar desafíos similares en el futuro con confianza y creatividad",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
