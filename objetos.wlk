import wollok.game.*
import personaje.*
import tableroJugable.*

object pocion {
//Prop: objeto que recupera la vida del lille en 25 puntos de vida 
    var property position = game.at(4,10)
    var property image    = "pocion.png"
    
    method play(){
    game.sound("pocion.mp3").play()
    }

    method chocarConEfecto(objeto) {
      //Prop: realizar un efecto sobre el objeto colisionado
        game.removeVisual(self)
        game.schedule(2000, {game.addVisual(self)})
        self.play()
        game.say(objeto, "" + lille.vida() + " HP")
        if (lille.vida() >= 75){
            lille.vida(100)
        } else{
            lille.vida(lille.vida() + 25)
        }
        marcadorDeVida.marcarVidaDe(objeto)
    }

    method caida() {
        game.onTick(400, "ob29", {self.caer()})
    }
    method caer() {
      if (position.y() != 0){
          position = game.at(position.x(), position.y()-1)
      }else{
          position = game.at(tableroJugable.x().randomUpTo(game.width()-1).truncate(0), 10)
      }
    }
}

object escudoMagico {
    //Prop: Otorgar un escudo temporal 
    var property position = game.at(3,10)
    var property image    =  "escudoMagico.png"
    
    method play(){
    game.sound("escudoActivado.mp3").play()
    }

    method chocarConEfecto(objeto) {
      //Prop: realizar un efecto sobre el objeto colisionado
        game.removeVisual(self)
        game.schedule(5000, {game.addVisual(self)})
        self.play()
        game.say(objeto, "Escudo Activado")
        objeto.tieneEscudoActivo(true)
        marcadorDeVida.marcarVidaDe(objeto)
        game.schedule(10000, {   game.say(objeto, "Ya no soy invencible :(")
                                objeto.tieneEscudoActivo(false)
                                marcadorDeVida.marcarVidaDe(objeto) })
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

object piedraPreciosa{
    //Prop: aumentar la puntuación en 100 pts 
    var property position = game.at(1,10)
    var property image    = "piedraPreciosa.png"

    method play(){
    game.sound("littleWin.mp3").play()
    }

    method chocarConEfecto(objeto) {
      //Prop: realizar un efecto sobre el objeto colisionado
    game.removeVisual(self)
    game.schedule(7000, {game.addVisual(self)})
    self.play()
    objeto.puntosObtenidos(objeto.puntosObtenidos() + 100)
    game.say(objeto, "Ahora tengo:" + objeto.puntosObtenidos())
    objeto.detenerJuegoSiGane()
    marcadorDeVida.marcarVidaDe(objeto)
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

object diamanteValioso {
    //Prop: aumentar la puntuacion en 200 pts 
    var property position = game.at(6,10)
    var property image    = "diamanteValioso.png"

    method play(){
      game.sound("bigWin.mp3").play()
    }

    method chocarConEfecto(objeto) {
      //Prop: realizar un efecto sobre el objeto colisionado
    self.play()
    objeto.puntosObtenidos(objeto.puntosObtenidos() + 200)
    game.say(objeto, "Ahora tengo:" + objeto.puntosObtenidos())
    objeto.detenerJuegoSiGane()
    marcadorDeVida.marcarVidaDe(objeto)
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