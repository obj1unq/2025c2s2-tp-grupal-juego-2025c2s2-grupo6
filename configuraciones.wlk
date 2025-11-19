import personaje.*
import wollok.game.*
import tableroJugable.puntos
object configurarJuego {

  method tecladoEnJuego() {
    keyboard.d().onPressDo{lille.derecha()}
    keyboard.a().onPressDo{lille.izquierda()}
    keyboard.p().onPressDo{lille.parry()}
  }
  method agregarPersonaje() {
    if (!game.hasVisual(lille)){
      game.addVisual(lille)
      game.onCollideDo(lille, {objeto => objeto.chocarConEfecto(lille)})
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
}