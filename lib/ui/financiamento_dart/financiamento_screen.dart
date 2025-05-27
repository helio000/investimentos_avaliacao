import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FinancingCalculator(),
    );
  }
}

class FinancingCalculator extends StatefulWidget {
  @override
  _FinancingCalculatorState createState() => _FinancingCalculatorState();
}

class _FinancingCalculatorState extends State<FinancingCalculator> {
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _taxaController = TextEditingController();
  final TextEditingController _parcelasController = TextEditingController();

  String _resultado = "";
  String _totalPago = "";
  
  void _calcularFinanciamento() {
    final valor = double.tryParse(_valorController.text);
    final taxaAnual = double.tryParse(_taxaController.text);
    final numParcelas = int.tryParse(_parcelasController.text);

    if (valor != null && taxaAnual != null && numParcelas != null && valor > 0 && numParcelas > 0) {

      double taxaMensal = (taxaAnual / 100) / 12;

      double parcela = (valor * taxaMensal * (1 + taxaMensal).pow(numParcelas)) / ((1 + taxaMensal).pow(numParcelas) - 1);

      double totalPago = parcela * numParcelas;

      setState(() {
        _resultado = "R\$ ${parcela.toStringAsFixed(2)}";
        _totalPago = "Total pago: R\$ ${totalPago.toStringAsFixed(2)}";
      });
    } else {
      setState(() {
        _resultado = "Dados inválidos";
        _totalPago = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Financiamento'),
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
                labelText: 'Valor do Financiamento (R\$)',
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
              controller: _parcelasController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número de Parcelas',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularFinanciamento,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            if (_resultado.isNotEmpty)
              Column(
                children: [
                  Text('Parcela Mensal: $_resultado', style: TextStyle(fontSize: 22)),
                  Text(_totalPago, style: TextStyle(fontSize: 20)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}