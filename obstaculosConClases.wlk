import wollok.game.*
import tableroJugable.*

object clavesDeUso {
  const property claves =["a","b","c","d","e","f","g","h","i","j","k","l","m","1","2","3","4"]
  method darClave() {
    //prec: n = eventos.. n < claves.size() eventos en el tablero
    const clave = claves.first()
    claves.remove(clave)
    return clave
  }
  method agregarClave(clave) {
    claves.add(clave)
  }
}
class Ascuas{
    var property position
    var property image = "ascuas.gif"
    const clave = clavesDeUso.darClave()

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
      game.onTick(200, clave, {self.caer()})
    }

    method caer() {
      if (position.y() != 0){
        position = game.at(position.x(), position.y()-1)
      }else{game.removeVisual(self) game.removeTickEvent(clave) clavesDeUso.agregarClave(clave)}
    }
}

class CajaNegra {
  var property position
  var property image = "aaa.png"
  const clave = clavesDeUso.darClave()
  method colision() {
    image = "aaa.png"
  }
  method caida() {
      game.onTick(200, clave, {self.caer()})
  }
    method caer() {
      if (position.y() != 0){
          position = game.at(position.x(), position.y()-1)
      }else{game.removeVisual(self) game.removeTickEvent(clave) clavesDeUso.agregarClave(clave)}
    }
}

class Lava {
  var property position 
  var property image = "lava.png"
  const clave = clavesDeUso.darClave()
  method colision() {
    image = "aaa.png"
  }
  method caida() {
      game.onTick(200, clave, {self.caer()})
  }
    method caer() {
      if (position.y() != 0){
          position = game.at(position.x(), position.y()-1)
      }else{game.removeVisual(self) game.removeTickEvent(clave) clavesDeUso.agregarClave(clave)}
    }
}

class Pared {
  var property position 
  var property image = "aaa.png"
  const clave = clavesDeUso.darClave()
  method colision() {
    image = "aaa.png"
  }
  method caida() {
      game.onTick(200, clave, {self.caer()})
  }
    method caer() {
      if (position.y() != 0){
          position = game.at(position.x(), position.y()-1)
      }
      else{game.removeVisual(self) game.removeTickEvent(clave) clavesDeUso.agregarClave(clave)}
    }
}