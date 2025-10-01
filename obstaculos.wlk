import wollok.game.*
import personaje.*

object obstaculo{
    var property position = game.at(2,10)
    var property image = "pelota.png"

    method caer() {
      if (position.y() != 0){
        position = game.at(position.x(), position.y()-1)
      }else{
        position = game.at(position.x(), 10)
      }
    }


}

object cura {
//Prop: objeto que recupera la vida del personaje en 25 puntos de vida 
    var property position = game.at(4,10)
    var property image    = "cura.png"


    method chocarConEfecto(objeto) {
      //Prop: realizar un efecto sobre el objeto colisionado
        if (personaje.vida() >= 75){
          personaje.vida(100)
        } else{
          personaje.vida(personaje.vida() + 25)
        }
    }


    method caer() {
      //Prop: realizar el efecto gravitatorio en el objeto cura
      if (position.y() != 0){
        position = game.at(position.x(), position.y()-1)
      }else{
        position = game.at(position.x(), 10)
      }
    }
    

}