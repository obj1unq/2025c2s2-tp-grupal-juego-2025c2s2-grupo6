import personaje.*
import wollok.game.*
import obstaculos.*
import objetos.*
class Nivel {
  //const property comenzarNivel 
  const property siguienteNivel 
  const property objetosDelNivel
  //const property obstaculosDelNivel
  const property posicionesDisponibles = #{3,4,5,6}

//------------------------------------------------------------------------------------
  /*
  method añadirObjetos(){
    objetosDelNivel.forEach({objeto => objeto.caer(self.posicionDistinta(), self)})
  }

  method posicionDistinta() {
    const pos = posicionesDisponibles.anyOne()
    posicionesDisponibles.remove(pos)
    return pos
  }
  method añadirPosicionDisponible(posicion) {
    posicionesDisponibles.add(posicion)
  }
  */
  //posible implementacion de randomizacion 
//-------------------------------------------------------------------------------------
  method siguienteNivel() {
    return siguienteNivel
  }
  method personaje() {          // invoca al personaje.
    game.addVisual(personaje)
    keyboard.d().onPressDo{personaje.derecha()}
    keyboard.a().onPressDo{personaje.izquierda()}
    game.onCollideDo(personaje, {objeto => objeto.chocarConEfecto(personaje)})
  }
  
  method añadirObstaculos() {
    objetosDelNivel.forEach{obstaculo => game.addVisual(obstaculo)}
    objetosDelNivel.forEach{obstaculo => game.schedule(0.randomUpTo(500),{ => obstaculo.caida()})}
    
  }
  method inicializar() {        //inicializador del nivel.
    self.personaje()
    self.añadirObstaculos()
    //self.añadirObjetos() 
  }
}

const nivel1 = new Nivel( 
    siguienteNivel  = final,
    objetosDelNivel = #{pocion,ascuas ,escudoMagico, piedraPreciosa,obstaculo}
)

object final {
  const property position = game.origin()
  const property image = "fintest.jpg"
  //game.addVisual(self)
}

