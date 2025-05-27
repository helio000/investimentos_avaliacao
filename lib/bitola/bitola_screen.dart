import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BitolaCalculator(),
    );
  }
}

class BitolaCalculator extends StatefulWidget {
  @override
  _BitolaCalculatorState createState() => _BitolaCalculatorState();
}

class _BitolaCalculatorState extends State<BitolaCalculator> {
  final TextEditingController _diametroController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  String _resultado = "";

  void _calcularArea() {
    final diametro = double.tryParse(_diametroController.text);
    
    if (diametro != null && diametro > 0) {
      double raio = diametro / 2;
      double area = pi * pow(raio, 2);

      setState(() {
        _resultado = "Área da seção transversal: ${area.toStringAsFixed(2)} mm²";
      });
    } else {
      setState(() {
        _resultado = "Por favor, insira um diâmetro válido!";
      });
    }
  }

  void _calcularDiametro() {
    final area = double.tryParse(_areaController.text);
    
    if (area != null && area > 0) {
      double raio = sqrt(area / pi);
      double diametro = raio * 2;

      setState(() {
        _resultado = "Diâmetro do fio: ${diametro.toStringAsFixed(2)} mm";
      });
    } else {
      setState(() {
        _resultado = "Por favor, insira uma área válida!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Bitola de Fio'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _diametroController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Diâmetro do fio (mm)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _calcularArea,
              child: Text('Calcular Área'),
            ),
            SizedBox(height: 20),
            
            TextField(
              controller: _areaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Área da seção transversal (mm²)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _calcularDiametro,
              child: Text('Calcular Diâmetro'),
            ),
            SizedBox(height: 20),
            
            Text(_resultado, style: TextStyle(fontSize: 22)),
          ],
        ),
      ),
    );
  }
}