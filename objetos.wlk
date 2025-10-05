import wollok.game.*
import personaje.*


object pocion {
//Prop: objeto que recupera la vida del personaje en 25 puntos de vida 
    var property position = game.at(4,10)
    var property image    = "pocion.png"


    method chocarConEfecto(objeto) {
      //Prop: realizar un efecto sobre el objeto colisionado
        if (personaje.vida() >= 75){
            personaje.vida(100)
        } else{
            personaje.vida(personaje.vida() + 25)
        }
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

object escudoMagico {
    //Prop: Otorgar un escudo temporal 
    var property position = game.at(3,10)
    var property image    =  "escudoMagico.png"

    method chocarConEfecto(objeto) {
      //Prop: realizar un efecto sobre el objeto colisionado
    

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
    var property position = game.at(5,10)
    var property image    = "piedraPreciosa.png"

    method chocarConEfecto(objeto) {
      //Prop: realizar un efecto sobre el objeto colisionado
    

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

    method chocarConEfecto(objeto) {
      //Prop: realizar un efecto sobre el objeto colisionado
    

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