import wollok.game.*
import obstaculos.*

object personaje {
  var property position = game.at(3,1)
  var property image = "gifg.gif"

  method izquierda() {
	position = game.at(1.max(position.x() - 1), position.y()) 
  }
	
  method derecha() {
	position = game.at((game.width() - 2).min(position.x() + 1), position.y()) 
  }
}

