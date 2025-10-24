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

class Obstaculo{
  var property position
  
  const clave = self.identity()

  method caida() {
      game.onTick(300, clave, {self.caer()})
  }
  method caer() {
      if (position.y() != 0){
          position = game.at(position.x(), position.y()-1)
      }
  }
  method ocultar() {
    position = game.at(position.x(), 10)
    game.removeVisual(self)
    game.removeTickEvent(clave) 
  }
}

class Ascuas inherits Obstaculo{
    var property image = "ascuas.gif"

    method play(){
    game.sound("ascuas.mp3").play()
    }

    method chocarConEfecto(objeto) {
      //Prop: realizar un efecto sobre el objeto colisionado
        game.removeVisual(self)
        //game.schedule(5000, {game.addVisual(self)})
        self.play()
        if (not objeto.tieneEscudoActivo()){
          objeto.recibirDaño(40)
          objeto.detenerJuegoSiEstoyMuerto()
        }
    }
}

class CajaNegra inherits Obstaculo {
  var property image = "aaa.png"

  method chocarConEfecto(p) {
    image = "aaa.png"
  }
}

class Lava inherits Obstaculo{
  var property image = "lava.png"
  method chocarConEfecto(p) {
    image = "aaa.png"
  }

}

class Pared inherits Obstaculo{
  var property image = "aaa.png"

  method chocarConEfecto(p) {
    image = "aaa.png"
  }
}
class Vacio inherits Obstaculo{
  var property image = ""

  method chocarConEfecto(p) {
     
  }
}


object p {
  method crear(position) {
    const obj = new Pared(position = position) 
    return obj
  }
}

object l {
  method crear(position) {
    const obj = new Lava(position = position) 
    return obj
  }
}

object c {
    
  method crear(position) {
    const obj = new CajaNegra(position = position) 
    return obj
  }
}
object a {
    
  method crear(position) {
    const obj = new Ascuas(position = position) 
    return obj
  }
}

object _ {
  method crear(position) {
    const obj = new Vacio(position = position) 
    return obj
  }
}