import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/config.dart';

import 'botones.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("Jueego Gato"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'Reiniciar') {
                reiniciarJuego();
              } else if (result == 'Salir') {
                SystemNavigator.pop();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Reiniciar',
                child: Text('Reiniciar'),
              ),
              const PopupMenuItem<String>(
                value: 'Salir',
                child: Text('Salir'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Image.asset(
              "imagenes/board.png",
            ),
            Botones()
          ],
        ),
      ),
    );
  }

  void reiniciarJuego() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const Home(),
      ),
    );
    tablero = List.filled(9, estados.vacio);
    ganador = {estados.o: false, estados.x: false};
  }
}