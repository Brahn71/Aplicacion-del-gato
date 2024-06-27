import 'package:flutter/material.dart';
import 'package:gato/pantallas/app.dart';

void main() {
  runApp(const App());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juego del gato',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GatoGame(),
    );
  }
}

class GatoGame extends StatefulWidget {
  @override
  _GatoGameState createState() => _GatoGameState();
}

class _GatoGameState extends State<GatoGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const App(),
    );
  }
}
