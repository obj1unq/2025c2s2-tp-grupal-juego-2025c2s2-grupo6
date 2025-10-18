import juego.*
import niveles.*
import wollok.game.*
import obstaculos.*
import objetos.*

object personaje {
  var property position = game.at(3,1)
  var property image = "gifg.gif"
  var property vida  = 100
  var property puntosObtenidos = 0  
  var property tieneEscudoActivo = false 

  method estoyMuerto() = self.vida() <= 0 
  //Verificar si la vida es menor o igual a 0
  
  method curar() {
        if (vida >= 75){
            vida = 100
        }else{
            vida =+ 25
        }
  }

  method recibirDaño(cantidad) {
    //Reducir la vida del personaje tanto como la cantidad dada si no tiene el escudo activo en ese momento
    if (not self.tieneEscudoActivo()){
      self.vida(self.vida() - cantidad)
      game.say(self, "-" + cantidad + " HP")
    }
  }

  method obtenerPuntos(puntos) {
    if (puntosObtenidos >= 1000){
      game.say(self, "You WIN!!")
      game.stop()
    }else{
      puntosObtenidos += puntos
    }
  }
  
  method detenerJuegoSiEstoyMuerto() {
    //Prop: detener el juego si la vida del jugador disminuye a 0
    if (self.estoyMuerto()){
      game.say(self,"GAME OVER")
      game.stop()
    }
  }
  method izquierda() {
	position = game.at(1.max(position.x() - 1), position.y()) 
  }
	
  method derecha() {
	position = game.at((game.width() - 2).min(position.x() + 1), position.y()) 
  }
}