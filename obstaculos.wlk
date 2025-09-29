import wollok.game.*
import personaje.*

object obstaculo{
    var property position = game.at(2,10)
    var property image = "pelota.png"

    method caer() {
      if (position.y() != 0){
        position = game.at(position.x(), position.y()-1)
      }else{
        position = game.at(position.x(), 10)
      }
    }


}