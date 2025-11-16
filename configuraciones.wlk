import personaje.*
import wollok.game.*
import tableroJugable.puntos
object configurarJuego {

  method tecladoEnJuego() {
    keyboard.d().onPressDo{personaje.derecha()}
    keyboard.a().onPressDo{personaje.izquierda()}
    keyboard.p().onPressDo{personaje.parry()}
  }
  method agregarPersonaje() {
    if (!game.hasVisual(personaje)){
      game.addVisual(personaje)
      game.onCollideDo(personaje, {objeto => objeto.chocarConEfecto(personaje)})
    }
  }
  method agregarPuntos() {
    if (!game.hasVisual(puntos)){
      game.addVisual(puntos)
    }
  }
  method quitarPersonaje() {
      game.removeVisual(personaje)
  }
}