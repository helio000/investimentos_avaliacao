import 'package:flutter/material.dart';

class ImcScreen extends StatefulWidget {
  const ImcScreen({super.key});

  @override
  State<ImcScreen> createState() => _ImcScreenState();
}

class _ImcScreenState extends State<ImcScreen> {
  String peso = '';
  String altura = '';
  
  double calcularImc(double peso, double altura) {
    return peso / (altura * altura);
  }

  String determinarCategoria(double imc) {
    if (imc < 18.5) {
      return 'Abaixo do peso';
    } else if (imc >= 18.5 && imc < 24.9) {
      return 'Peso normal';
    } else if (imc >= 25 && imc < 29.9) {
      return 'Acima do peso';
    } else if (imc >= 30 && imc < 34.9) {
      return 'Obesidade nivel 1';
    } else if (imc >= 35 && imc < 39.9) {
      return 'Obesidade nivel 2';
    } else {
      return 'Obesidade nivel 3';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cálculo de IMC'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Peso (kg)',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite seu peso',
              ),
              onChanged: (value) {
                setState(() {
                  peso = value;
                });
              },
            ),
            Text(
              'Altura',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite sua altura',
              ),
              onChanged: (value) {
                setState(() {
                  altura = value;
                });
              },
            ),
            ElevatedButton(
                onPressed: () {
                  // Verificar se os campos estão vazios
                  if (peso.isEmpty || altura.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Preencha todos os campos para continuar'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    // Converter os valores para números
                    double pesoNum = double.tryParse(peso) ?? 0;
                    double alturaNum = double.tryParse(altura) ?? 0;

                    // Verificar se os valores são válidos
                    if (pesoNum > 0 && alturaNum > 0) {
                      double imc = calcularImc(pesoNum, alturaNum);
                      String categoria = determinarCategoria(imc);

                      // Mostrar o resultado do IMC em um AlertDialog
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Resultado do IMC'),
                            content: Text(
                              'Seu IMC é: ${imc.toStringAsFixed(2)}\nCategoria: $categoria',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Fechar'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // Caso os valores não sejam válidos, mostra o SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Por favor, insira valores válidos para peso e altura'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                },
                child: Text('Calcular IMC'),
              ),
          ],
        ),
      ),
    );
  }
}