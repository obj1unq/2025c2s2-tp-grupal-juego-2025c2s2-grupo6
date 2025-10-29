import personaje.*
object configDelJuego {
  method tecladoEnJuego() {
    keyboard.d().onPressDo{personaje.derecha()}
    keyboard.a().onPressDo{personaje.izquierda()}
    keyboard.p().onPressDo{personaje.parry()}
  }
}