import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/config.dart';

class Celda extends StatelessWidget {
  final estados? inicial;
  final double? espacio;
  final Function() clicked;
  const Celda({required this.inicial,required this.espacio,required this.clicked, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: espacio,
        width: espacio,
        child: CupertinoButton(child: selecionImagen(), onPressed: clicked ));
  }

  Widget selecionImagen() {
    if (inicial == estados.vacio)
      return SizedBox(
        height: espacio,
        width: espacio,
      );
    else if (inicial == estados.x)
      return Image.asset("imagenes/x.png");
    else
      return Image.asset("imagenes/o.png");
  }
}
