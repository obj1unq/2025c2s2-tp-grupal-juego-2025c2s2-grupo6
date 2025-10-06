import wollok.game.*
import personaje.*
import tableroJugable.*

object obstaculo{
    var property position = game.at(2,10)
    var property image = "pelota.png"
    method caida() {
      game.onTick(500, "ob2", {self.caer()})
    }
    method caer() {
      if (position.y() != 0){
          position = game.at(position.x(), position.y()-1)
      }else{
          position = game.at(tableroJugable.x().randomUpTo(game.width()-1).truncate(0), 10)
      }
    }


}

object cajaNegra {
  var property position = game.at(2,10)
  var property image = "aaa.png"
  method colision() {
    image = "aaa.png"
  }
  method caida() {
      game.onTick(400, "ob32", {self.caer()})
  }
    method caer() {
      if (position.y() != 0){
          position = game.at(position.x(), position.y()-1)
      }else{
          position = game.at(tableroJugable.x().randomUpTo(game.width()-1).truncate(0), 10)
      }
    }
}