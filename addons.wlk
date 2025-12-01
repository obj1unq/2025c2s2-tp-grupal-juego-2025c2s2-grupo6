import obstaculos.*
import wollok.game.*
import personajes.lille

object tableroJugable {
    const property minPosition = 1 
    const property maxPosition = game.width()-1
    method position() {
      return game.origin()
    }
    method image() {
      return "fondo.png"
    }

}

object escenario {
  const property position = game.origin() 
  var property image = ""
}

object puntos {
  const property position = game.at(5, 9)
  method text(){
    return "Puntuacion: " + lille.puntosObtenidos() + "/" + lille.puntosParaGanar()
  }
  method textColor() = paleta.colorDePuntos()
  method chocarConEfecto(objeto){}
}

object posicion {
  method randomizarEnFila(fila) {
    return game.at(tableroJugable.minPosition().randomUpTo(tableroJugable.maxPosition()).truncate(0), fila)
  }
}

object paleta{
  const property colorDeTexto = "#FFFFFF"
  const property colorDePuntos = "#F1C232"
}

object timer {
  const property position = game.at(3,9)
  var tiempo = 0


  method startTimer(){
    game.addVisual(self)
    self.empezarAContar()
  }
  method text() = tiempo.toString() + "s"
  method textColor() = paleta.colorDeTexto()
  method empezarAContar(){
      game.onTick(1000, "tiempo", {self.sumarATimer(1)})
  }
  method sumarATimer(segundos) {
    tiempo += segundos
  }
  method quitarTimer() {
    game.removeVisual(self)
    game.removeTickEvent("tiempo")
    tiempo = 0
  }
  method chocarConEfecto(objeto){}
}
