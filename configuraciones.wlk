import personaje.*
import wollok.game.*

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
  method quitarPersonaje() {
      game.removeVisual(personaje)
  }
}