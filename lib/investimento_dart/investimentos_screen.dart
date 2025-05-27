import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InvestmentCalculator(),
    );
  }
}

class InvestmentCalculator extends StatefulWidget {
  @override
  _InvestmentCalculatorState createState() => _InvestmentCalculatorState();
}

class _InvestmentCalculatorState extends State<InvestmentCalculator> {
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _taxaController = TextEditingController();
  final TextEditingController _periodosController = TextEditingController();

  String _resultado = "";
  String _totalInvestido = "";
  
  void _calcularInvestimento() {
    final valor = double.tryParse(_valorController.text);
    final taxaAnual = double.tryParse(_taxaController.text);
    final numPeriodos = int.tryParse(_periodosController.text);

    if (valor != null && taxaAnual != null && numPeriodos != null && valor > 0 && numPeriodos > 0) {

      double taxaMensal = (taxaAnual / 100);

      double valorFuturo = valor * (1 + taxaMensal).pow(numPeriodos);

      setState(() {
        _resultado = "R\$ ${valorFuturo.toStringAsFixed(2)}";
        _totalInvestido = "Total investido: R\$ ${valor.toStringAsFixed(2)}";
      });
    } else {
      setState(() {
        _resultado = "Dados inválidos";
        _totalInvestido = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Investimentos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _valorController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Valor Inicial (R\$)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _taxaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Taxa de Juros Anual (%)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _periodosController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número de Períodos (anos)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularInvestimento,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            if (_resultado.isNotEmpty)
              Column(
                children: [
                  Text('Valor Futuro: $_resultado', style: TextStyle(fontSize: 22)),
                  Text(_totalInvestido, style: TextStyle(fontSize: 20)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}