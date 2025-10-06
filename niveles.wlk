import personaje.*
import wollok.game.*
import obstaculos.*
class Nivel {
  //const property comenzarNivel 
  //const property siguienteNivel 

  const property objetosDelNivel
  const property posicionesDisponibles = #{3,4,5,6}

//------------------------------------------------------------------------------------
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
//-------------------------------------------------------------------------------------

  method personaje() {          // invoca al personaje.
    game.addVisual(personaje)
    keyboard.d().onPressDo{personaje.derecha()}
    keyboard.a().onPressDo{personaje.izquierda()}
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
    objetosDelNivel = #{obstaculo,cajaNegra}
)
//timings
// #{2000,3000,1500,1000,800}
