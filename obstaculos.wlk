import wollok.game.*
import personaje.*

object controladorDeCaida {
  var columnasDisponibles = [0, 1, 2, 3, 4]
  method obtenerColumnaAleatoria() {
    if (columnasDisponibles.isEmpty()) {
        columnasDisponibles = [0, 1, 2, 3, 4]
    }
    var columna = columnasDisponibles.sample()
    columnasDisponibles.remove(columna)
    return columna
  }
}
object obstaculo{
    var property position = game.at(2,10)
    var property image = "pelota.png"

    method caer() {
      if (position.y() != 0){
        position = game.at(position.x(), position.y()-1)
      }else{
        position = game.at(position.x(), 10)
      }
    }
}


/*



obtenerColumnaAleatoria() {
    
}


var nuevaColumna = obtenerColumnaAleatoria()
crearObstaculoEnColumna(nuevaColumna)


columnaLibre(columna) {
    return !obstaculos.any { o => o.columna == columna && o.y < 100 } // Por ejemplo, distancia vertical mínima
}

generarObstaculo() {
    var posibles = columnas.filter { c => columnaLibre(c) }
    if (!posibles.isEmpty()) {
        var columna = posibles.sample()
        crearObstaculoEnColumna(columna)
    }
}

*/


