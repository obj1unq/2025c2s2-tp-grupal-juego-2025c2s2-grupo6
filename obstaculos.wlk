import juego.*
import wollok.game.*
import personaje.*
import tableroJugable.*

object obstaculo{
    var property position = game.at(2,10)
    var property image = "pelota.png"
    method caida() {
      game.onTick(500, "ob2", {self.caer()})
    }
    method chocarConEfecto(objeto) {
      
    }
    method caer() {
      if (position.y() != 0){
          position = game.at(position.x(), position.y()-1)
      }else{
          position = game.at(tableroJugable.x().randomUpTo(game.width()-1).truncate(0), 10)
      }
    }

  /*  
    method caer() {
      var posRandom = game.at(tableroJugable.x().randomUpTo(game.width()-1).truncate(0), 10)
      if (position.y() != 0){
          position = game.at(position.x(), position.y()-1)
      }else if (self.tienenLaMismaPosicion(posRandom)) {
          position = posRandom
      }else{
        posRandom = game.at(tableroJugable.x().randomUpTo(game.width()-1).truncate(0), 10)
        position  = posRandom
      }
    }
    method tienenLaMismaPosicion(posicion) {
      return fallToPieces.nivelActual.objetosDelNivel().any({objecto => game.onSameCell(position,objecto.position())})
    }
  */


}
object ascuas{
    var property position = game.at(2,10)
    var property image = "ascuas.gif"

    method play(){
    game.sound("ascuas.mp3").play()
    }

    method chocarConEfecto(objeto) {
      //Prop: realizar un efecto sobre el objeto colisionado
        game.removeVisual(self)
        game.schedule(5000, {game.addVisual(self)})
        self.play()
        if (not objeto.tieneEscudoActivo()){
          objeto.recibirDaño(40)
          objeto.detenerJuegoSiEstoyMuerto()
        }
    }
    method caida() {
      game.onTick(400, "ob31", {self.caer()})
    }

    method caer() {
      if (position.y() != 0){
        position = game.at(position.x(), position.y()-1)
      }else{
        position = game.at(position.x(), 10)
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