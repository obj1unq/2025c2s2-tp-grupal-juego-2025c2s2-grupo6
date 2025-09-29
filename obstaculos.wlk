import wollok.game.*
import personaje.*

object obstaculo{
    var property position = game.height()
    var property image = "pelota.png"

    method caer() {
      position = game.at(0, position.y()-1)
    }


}