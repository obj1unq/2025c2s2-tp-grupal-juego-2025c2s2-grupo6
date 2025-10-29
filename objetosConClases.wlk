import wollok.game.*
import personaje.*

class Objeto {
  var property position 
  const clave = self.identity()
  const sonido
  method play(){
    game.sound(sonido).play()
  }

  method chocarConEfecto(objeto) {
    game.removeVisual(objeto)
    self.play()
    self.efectoDeChoque(objeto)
  }
  method caida() {
      game.onTick(400, clave, {self.caer()})
    }
  method caer() {
    //Prop: realizar el efecto gravitatorio en el objeto dado
      if (position.y() != 0){
        position = game.at(position.x(), position.y()-1)
      }else{
        position = game.at(position.x(), 10)
      }
    }
  method efectoDeChoque(objeto) {}
}

class Pocion inherits Objeto(sonido = "pocion.mp3"){
    //Prop: objeto que recupera la vida del personaje en 25 puntos de vida 
    const property image  = "pocion.png" 

    override method efectoDeChoque(objeto) {
      game.say(objeto, "" + personaje.vida() + " HP")
      personaje.curar()
    }
}

class EscudoMagico inherits Objeto(sonido = "escudoActivado.mp3") {
    var property image    =  "escudoMagico.png"
    
    override method efectoDeChoque(objeto) {
      game.say(objeto, "Escudo Activado")
      objeto.tieneEscudoActivo(true)
      game.schedule(10000, {   game.say(objeto, "Ya no soy invencible :(")
                                objeto.tieneEscudoActivo(false) })
    }
}

class DiamanteValioso inherits Objeto(sonido = "bigWin.mp3"){
    var property image    = "diamanteValioso.png"

    override method efectoDeChoque(objeto) {
      game.say(objeto, "Ahora tengo:" + objeto.puntosObtenidos()+200)
        objeto.obtenerPuntos(200)
    }
}

class PiedraPreciosa inherits Objeto(sonido = "littleWin.mp3") {
    var property image    = "piedraPreciosa.png"

    override method efectoDeChoque(objeto) {
      game.say(objeto, "Ahora tengo:" + objeto.puntosObtenidos()+100)
        objeto.obtenerPuntos(100)
    }
}