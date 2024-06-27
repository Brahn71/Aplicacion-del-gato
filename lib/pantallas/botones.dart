import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

import '../config/config.dart';
import '../widgets/celda.dart';

class Botones extends StatefulWidget {
  const Botones({super.key});

  @override
  State<Botones> createState() => _BotonesState();
}

class _BotonesState extends State<Botones> {
  double ancho = 0, alto = 0;
  estados inicial = estados.x;
  int clicks = 0;
  int xWins = 0;
  int oWins = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ancho = MediaQuery.of(context).size.width;
    alto = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: ancho,
          height: ancho,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    Celda(inicial: tablero[0], espacio: ancho / 3, clicked: () => clicked(0)),
                    Celda(inicial: tablero[1], espacio: ancho / 3, clicked: () => clicked(1)),
                    Celda(inicial: tablero[2], espacio: ancho / 3, clicked: () => clicked(2)),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Celda(inicial: tablero[3], espacio: ancho / 3, clicked: () => clicked(3)),
                    Celda(inicial: tablero[4], espacio: ancho / 3, clicked: () => clicked(4)),
                    Celda(inicial: tablero[5], espacio: ancho / 3, clicked: () => clicked(5)),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Celda(inicial: tablero[6], espacio: ancho / 3, clicked: () => clicked(6)),
                    Celda(inicial: tablero[7], espacio: ancho / 3, clicked: () => clicked(7)),
                    Celda(inicial: tablero[8], espacio: ancho / 3, clicked: () => clicked(8)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Victorias de X: $xWins", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(width: 60),
              Text("Victorias de O: $oWins", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  void clicked(int index) {
    if (tablero[index] == estados.vacio) {
      tablero[index] = inicial;
      inicial = inicial == estados.x ? estados.o : estados.x;
      setState(() {});
      if (++clicks >= 5) {
        estados ganador = buscarGanador();
        if (ganador != estados.vacio || clicks == 9) {
          mostrarDialogo(ganador);
        }
      }
      debugPrint("Ganador: $ganador");
    }
  }

  estados buscarGanador() {

    for (int i = 0; i < tablero.length; i += 3) {
      sonIguales(i, i + 1, i + 2);
    }

    for (int i = 0; i < 3; i++) {
      sonIguales(i, i + 3, i + 6);
    }

    sonIguales(0, 4, 8);
    sonIguales(2, 4, 6);
    if (ganador[estados.x] == true) return estados.x;
    if (ganador[estados.o] == true) return estados.o;
    return estados.vacio;
  }

  void sonIguales(int a, int b, int c) {
    if (tablero[a] != estados.vacio) {
      if (tablero[a] == tablero[b] && tablero[b] == tablero[c]) {
        ganador[tablero[a]] = true;
      }
    }
  }

  void mostrarDialogo(estados ganador) {
    String mensaje;
    Icon icono;
    if (ganador == estados.x) {
      mensaje = "¡X ha ganado!";
      icono = Icon(Icons.close, size: 80, color: Colors.red);
      xWins++;
    } else if (ganador == estados.o) {
      mensaje = "¡O ha ganado!";
      icono = Icon(Icons.circle_outlined, size: 80, color: Colors.blue);
      oWins++;
    } else {
      mensaje = "¡Es un empate!";
      icono = Icon(Icons.handshake, size: 80, color: Colors.grey);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              icono,
              SizedBox(width: 10),
              Text("Fin del juego", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text(
            mensaje,
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              child: Text("Continuar", style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.of(context).pop();
                reiniciarJuego();
              },
            ),
            TextButton(
              child: Text("Salir", style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.of(context).pop();
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }

  void reiniciarJuego() {
    tablero = List.filled(9, estados.vacio);
    ganador = {estados.o: false, estados.x: false};
    clicks = 0;
    setState(() {});
  }
}