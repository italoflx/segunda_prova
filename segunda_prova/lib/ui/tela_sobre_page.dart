import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter App',
      home: TelaSobre(),
    );
  }
}

class TelaSobre extends StatelessWidget {
  const TelaSobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Sobre'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Nome: Rômulo Felipe', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8), // Adiciona uma distância de 8 pixels
                  Text('Idade: 20 anos', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8), // Adiciona uma distância de 8 pixels
                  Text('Formação: Analista de Sistemas', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 15),
                  Text('Nome: Emanuel Italo', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8), // Adiciona uma distância de 8 pixels
                  Text('Idade: 20 anos', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8), // Adiciona uma distância de 8 pixels
                  Text('Formação: Nutrição', style: TextStyle(fontSize: 18)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
