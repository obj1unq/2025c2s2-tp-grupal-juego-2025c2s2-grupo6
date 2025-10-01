import wollok.game.*
import obstaculos.*

object personaje {
  var property position = game.at(3,0)
  var property image = "lionel-titular.png"
  var property vida  = 100

  method obtenerCura() = "Cura obtenida"
  method izquierda() {
	position = game.at(1.max(position.x() - 1), position.y()) 
  }
	
  method derecha() {
	position = game.at((game.width() - 2).min(position.x() + 1), position.y()) 
  }
}