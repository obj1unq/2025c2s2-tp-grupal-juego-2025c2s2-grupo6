import wollok.game.*
import tableroJugable.*


class Obstaculo{
  var property position
  var property image 
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
  method chocarConEfecto(objeto) {
      //Prop: realizar un efecto sobre el objeto colisionado
      //self.play()
      self.efectoEn(objeto)
  }
  method cambiarImagen() = ""
  method efectoEn(objeto) {
    if (not objeto.tieneEscudoActivo()){
      objeto.recibirDaño(20)
      self.image(self.cambiarImagen())
      objeto.detenerJuegoSiEstoyMuerto()
    }
  }
}
class Ascuas inherits Obstaculo(image = "ascuas1.gif"){

    method play(){
    game.sound("ascuas.mp3").play()
    }
    override method cambiarImagen() {
      return "ascuassss.gif"
    }
    override method efectoEn(objeto){
        game.removeVisual(self)
        //game.schedule(5000, {game.addVisual(self)})
        self.play()
        if (not objeto.tieneEscudoActivo()){
          objeto.recibirDaño(40)
          objeto.detenerJuegoSiEstoyMuerto()
        }
    }
    method devolver() {
      self.image(self.cambiarImagen())
      game.removeTickEvent(clave)
      game.onTick(300, clave, {self.volver()})
    }
    method volver() {
      if (position.y() != game.height()){
          position = position.up(1)
      }
      else if (position.y() == game.height()){ 
        self.ocultar() 
      }
    }
    override method caer() {
      super()
      if (position.y() == -1){
        self.ocultar()
      }
    }
}

class PurpleBall inherits Ascuas(image = "purpleball1.gif"){
  override method cambiarImagen() {
    return "idk3.gif"
  }
}

class CajaNegra inherits Obstaculo(image = "aaa.png"){}

class Lava inherits Obstaculo(image = "lava1.png"){}

class Pared inherits Obstaculo(image = "pared.png"){
  override method cambiarImagen(){
    return "pared-rota1.png"
  }
}
class Vacio inherits Obstaculo(image = ""){
  override method chocarConEfecto(p) {
     
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

object u {
    
  method crear(position) {
    const obj = new PurpleBall(position = position) 
    return obj
  }
}

object _ {
  method crear(position) {
    const obj = new Vacio(position = position) 
    return obj
  }
}
