import personajes.*
import wollok.game.*
import addons.*

class Obstaculo{
  var property position
  var property image
  const clave = self.identity()

  method caida() {
      game.onTick(300, clave, {self.caer()})
  }

  method caer() {
      if (position.y() >= 0){
          position = position.down(1)
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

  method efectoEn(objeto) {
    if (not objeto.tieneEscudoActivo()){
      objeto.recibirDaño(self.dañoQueHace())
    }
    
  }
  method dañoQueHace() = 20 
}
class Ascuas inherits Obstaculo(image = "ascuas1.gif"){

    method play(){
      game.sound("ascuas.mp3").play()
    }
    method imagenTrasParry() {
      return "ascuassss.gif"
    }
    override method efectoEn(objeto){
        game.removeVisual(self)
        //game.schedule(5000, {game.addVisual(self)})
        self.play()
        super(objeto)
    }

    override method dañoQueHace() {
      return 40
    }

    method devolver() {
      self.image(self.imagenTrasParry())
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
      if (position.y() < 0){
        self.ocultar()
      }
    }
}

class PurpleBall inherits Ascuas(image = "purpleball1.gif"){
  override method imagenTrasParry() {
    return "idk3.gif"
  }
}

class Lava inherits Obstaculo(image = "lava1.png"){
}

class Arbol inherits Obstaculo(image = "arborr.png"){
  override method dañoQueHace() = 20
}
class Pared inherits Obstaculo(image = "pared.png"){
  override method dañoQueHace() = 10
}
class Vacio inherits Obstaculo(image = "vacio.png"){
  override method chocarConEfecto(p) {}
}


object p {
  method crear(position) {
    const obj = new Pared(position = position) 
    return obj
  }
}

object r {
  method crear(position) {
    const obj = new Arbol(position = position) 
    return obj
  }
}

object l {
  method crear(position) {
    const obj = new Lava(position = position) 
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
