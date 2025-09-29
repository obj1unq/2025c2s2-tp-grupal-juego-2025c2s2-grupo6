import wollok.game.*
object personaje {
  var property position = game.origin()
  var property image = "lionel-titular.png"
  method mover() {
    //self.validarMovimiento()
    position = game.at(position.x()+1, 0)
  }
  method validarMoviemiento() {
    if (position == game.width()-1){
        self.error("no puedo moverme")
    }
  }
}