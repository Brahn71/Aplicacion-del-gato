library config.globals;

enum estados {vacio,x,o}
List<estados> tablero = List.filled(9, estados.vacio);
Map<estados,bool> ganador = {estados.o:false,estados.x:false};