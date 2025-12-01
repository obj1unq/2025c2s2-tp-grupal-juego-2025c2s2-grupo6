import personajes.*
import wollok.game.*
import addons.puntos
import addons.timer
import juego.fallToPieces

object configurarJuego {

  method tecladoEnJuego() {
    keyboard.d().onPressDo{lille.derecha()}
    keyboard.a().onPressDo{lille.izquierda()}
    keyboard.p().onPressDo{lille.parry()}
    keyboard.m().onPressDo{fallToPieces.irASiguienteNivelJugador()}
  }
  method agregarPersonaje() {
    if (!game.hasVisual(lille)){
      game.addVisual(lille)
      game.onCollideDo(lille, {objeto => objeto.chocarConEfecto(lille)})
      game.addVisual(marcadorDeVida)
    }
  }
  method agregarPuntos() {
    if (!game.hasVisual(puntos)){
      game.addVisual(puntos)
    }
  }
  method quitarPersonaje() {
      game.removeVisual(lille)
  }

  method agregarTimer() {
    if (!game.hasVisual(timer)){
      timer.startTimer()
    }
  }
  method quitarTimer() {
    if (game.hasVisual(timer)){
      game.removeVisual(timer)
    }
  }
  method quitarPuntos() {
    if (game.hasVisual(puntos)){
      game.removeVisual(puntos)
    }
  }
  method agregarVida(){
        if (!game.hasVisual(marcadorDeVida)){
      game.addVisual(marcadorDeVida)
    }

  }
  method quitarVida(){
    if (game.hasVisual(marcadorDeVida)){
      game.removeVisual(marcadorDeVida)
    }
  }
  method quitarInterfaz() {
    self.quitarPersonaje()
    self.quitarVida()
    self.quitarPuntos()
    self.quitarTimer()
  }
}

class Dificultad {
  
  method tiempoDeAparicion() 
  method tiempoDeCaida()
}

object dificultadBaja inherits Dificultad{
  override method tiempoDeAparicion() {
    return 800
  }
  override method tiempoDeCaida() {
    return 200
  }
}

object dificultadMedia inherits Dificultad{
  override method tiempoDeAparicion() {
    return 500 //800
  }
  override method tiempoDeCaida() {
    return 100
  }
}

object dificultadAlta inherits Dificultad{
  override method tiempoDeAparicion() {
    return 300 //500
  }
  override method tiempoDeCaida() {
    return 100
  }
}

object dificultadExtreme inherits Dificultad{
  override method tiempoDeAparicion() {
    return 200 //500
  }
  override method tiempoDeCaida() {
    return 100
  }
}