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
      self.agregarBarra()
      self.agregarVida()
    }
  }
  method agregarPuntos() {
    if (!game.hasVisual(puntos)){
      game.addVisual(puntos)
    }
  }
  method agregarBarra() {
    if(!game.hasVisual(barraProgreso)){
      game.addVisual(barraProgreso)
    }
  }
  method quitarBarra() {
    if (game.hasVisual(barraProgreso)){
      game.removeVisual(barraProgreso)
    }
  }
  method quitarPersonaje() {
    if (game.hasVisual(lille)){
      game.removeVisual(lille)
      self.quitarVida()
    }
  }

  method agregarTimer() {
    if (!game.hasVisual(timer)){
      timer.startTimer()
    }
  }
  method quitarTimer() {
    if (game.hasVisual(timer)){
      timer.quitarTimer()
    }
  }
  method quitarPuntos() {
    if (game.hasVisual(puntos)){
      game.removeVisual(puntos)
    }
  }

  method quitarVida(){
    if (game.hasVisual(marcadorDeVida)){
      game.removeVisual(marcadorDeVida)
    }
  }

  method agregarVida() {
    if(!game.hasVisual(marcadorDeVida)){
      game.addVisual(marcadorDeVida)
    }
  }
  method agregarInterfaz(){
    self.agregarPuntos()
    self.agregarTimer()
  }
  method quitarInterfaz() {
    self.quitarBarra()
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
    return 400 //500
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
