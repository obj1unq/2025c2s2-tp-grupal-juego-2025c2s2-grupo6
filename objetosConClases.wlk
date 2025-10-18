import wollok.game.*
import personaje.*
class Pocion{
    //Prop: objeto que recupera la vida del personaje en 25 puntos de vida 
    var property position 
    const property image  = "pocion.png"
    
    method play(){
        game.sound("pocion.mp3").play()
    }

    method chocarConEfecto(objeto) {
      //Prop: realizar un efecto sobre el objeto colisionado
        game.removeVisual(self)
        game.schedule(2000, {game.addVisual(self)})
        self.play()
        game.say(objeto, "" + personaje.vida() + " HP")
        personaje.curar()
    }
    method caida() {
        game.onTick(400, "ob29", {self.caer()})
    }
    method caer() {
      if (position.y() != 0){
          position = game.at(position.x(), position.y()-1)
      }
    }
}

class EscudoMagico {
    var property position
    var property image    =  "escudoMagico.png"
    
    method play(){
    game.sound("escudoActivado.mp3").play()
    }

    method chocarConEfecto(objeto) {
      //Prop: realizar un efecto sobre el objeto colisionado
        game.removeVisual(self)
        self.play()
        game.say(objeto, "Escudo Activado")
        objeto.tieneEscudoActivo(true)
        game.schedule(10000, {   game.say(objeto, "Ya no soy invencible :(")
                                objeto.tieneEscudoActivo(false) })
    }
    method caida() {
      game.onTick(400, "ob35", {self.caer()})
    }
    method caer() {
      //Prop: realizar el efecto gravitatorio en el objeto dado
        if (position.y() != 0){
        position = game.at(position.x(), position.y()-1)
        }else{
        position = game.at(position.x(), 10)
        }
    }
}

class DiamanteValioso {
    var property position 
    var property image    = "diamanteValioso.png"

    method play(){
      game.sound("bigWin.mp3").play()
    }

    method chocarConEfecto(objeto) {
      //Prop: realizar un efecto sobre el objeto colisionado
    self.play()
    game.say(objeto, "Ahora tengo:" + objeto.puntosObtenidos()+200)
    objeto.obtenerPuntos(200)
    }

    method caida() {
      game.onTick(400, "ob30", {self.caer()})
    }

    method caer() {
      //Prop: realizar el efecto gravitatorio en el objeto dado
        if (position.y() != 0){
        position = game.at(position.x(), position.y()-1)
        }else{
        position = game.at(position.x(), 10)
        }
    }
}

class PiedraPreciosa {
    var property position
    var property image    = "piedraPreciosa.png"

    method play(){
    game.sound("littleWin.mp3").play()
    }

    method chocarConEfecto(objeto) {
      //Prop: realizar un efecto sobre el objeto colisionado
    game.removeVisual(self)
    self.play()
    game.say(objeto, "Ahora tengo:" + objeto.puntosObtenidos()+100)
    objeto.obtenerPuntos(100)
    }
    method caida() {
      game.onTick(400, "ob34", {self.caer()})
    }
    method caer() {
      //Prop: realizar el efecto gravitatorio en el objeto dado
        if (position.y() != 0){
        position = game.at(position.x(), position.y()-1)
        }else{
        position = game.at(position.x(), 10)
        }
    }
}