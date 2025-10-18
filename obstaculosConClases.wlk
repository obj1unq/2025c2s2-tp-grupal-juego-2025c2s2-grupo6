import wollok.game.*
import tableroJugable.*
class Ascuas{
    var property position
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
      }else{game.removeVisual(self)}
    }
}

class CajaNegra {
  var property position
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
      }else{game.removeVisual(self)}
    }
}

class Lava {
  var property position 
  var property image = "lava.png"
  method colision() {
    image = "aaa.png"
  }
  method caida() {
      game.onTick(100, "ob", {self.caer()})
  }
    method caer() {
      if (position.y() != 0){
          position = game.at(position.x(), position.y()-1)
      }else{game.removeVisual(self)}
    }
}

class Pared {
  var property position 
  var property image = "aaa.png"
  method colision() {
    image = "aaa.png"
  }
  method caida() {
      game.onTick(400, "obbb", {self.caer()})
  }
    method caer() {
      if (position.y() != 0){
          position = game.at(position.x(), position.y()-1)
      }
      else{game.removeVisual(self)}
    }
}