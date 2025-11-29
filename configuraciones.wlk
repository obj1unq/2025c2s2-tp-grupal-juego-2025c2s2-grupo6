import juego.*
import personaje.*
import wollok.game.*
import tableroJugable.puntos
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

  method quitarPuntos() {
    if (game.hasVisual(puntos)){
      game.removeVisual(puntos)
    }
  }
  method quitarPersonaje() {
      game.removeVisual(lille)
  }

  method quitarVida(){
    if (game.hasVisual(marcadorDeVida)){
      game.removeVisual(marcadorDeVida)
    }
  }
}

