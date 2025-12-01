import wollok.game.*
import juego.fallToPieces
import personajes.*
import addons.posicion


class Objeto {
  var   property position = posicion.randomizarEnFila(10)
  const property image 
  const clave = self.identity()
  const sonido
  var property tiempoDeCaida = 400
  method play(){
    game.sound(sonido).play()
  }
  method invocar() {
    if (game.getObjectsIn(position).isEmpty() && !game.hasVisual(self)){
      game.addVisual(self)
      self.caida()
    }
    else{
      position = posicion.randomizarEnFila(10)
    }
  }
  method chocarConEfecto(objeto) {
    game.removeVisual(self)
    self.play()
    self.efectoDeChoque(objeto)
  }
  method caida() {
      game.onTick(tiempoDeCaida, clave, {self.caer()})
  }
  method ocultar() {
    game.removeVisual(self)
    game.removeTickEvent(clave) 
  }
  method caer() {
    //Prop: realizar el efecto gravitatorio en el objeto dado
      if (position.y() != 0){
        position = game.at(position.x(), position.y()-1)
      }else{
        self.ocultar()
        position = posicion.randomizarEnFila(10)
      }
  }
  method efectoDeChoque(objeto) {}
}

class ObjetosConPuntos inherits Objeto {
  const puntosQueDa = 0
  override method efectoDeChoque(objeto) {
      game.say(objeto, "Ahora tengo:" + (objeto.puntosObtenidos()+puntosQueDa).toString())
        objeto.obtenerPuntos(puntosQueDa)
    }
}



object pocion inherits Objeto(sonido = "pocion.mp3",image = "pocion.png" ){
    //Prop: objeto que recupera la vida del personaje en 25 puntos de vida 
    override method efectoDeChoque(objeto) {
      game.say(objeto, "" + lille.vida() + " HP")
      lille.curar()
    }
}

object escudoMagico inherits Objeto(sonido = "escudoActivado.mp3",image = "escudoMagicoo.png") {
    
    override method efectoDeChoque(objeto) {
      game.say(objeto, "Escudo Activado")
      objeto.cambiarEstadoEscudo(true)
      game.schedule(10000, {   game.say(objeto, "Ya no soy invencible :(")
                                objeto.cambiarEstadoEscudo(false)
                                })
    }
}

object diamanteValioso inherits ObjetosConPuntos(sonido = "bigWin.mp3", puntosQueDa = 20, image = "diamanteValioso.png"){

}

object piedraPreciosa inherits ObjetosConPuntos(sonido = "littleWin.mp3", puntosQueDa = 10, image = "piedraPreciosa.png") {

}
