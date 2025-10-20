import personaje.*
import wollok.game.*
import obstaculosConClases.*
import objetos.*
import tableroJugable.*
/*
object p {
  method crearInstancia(position) {
    return new Pared(position = position)
  }
  method crear(position,tiempo) {
    const obj = self.crearInstancia(position)
    game.schedule(tiempo, {game.addVisual(obj) obj.caida()})
  }
}

object l {
  method crearInstancia(position) {
    return new Lava(position = position)
  }
  method crear(position,tiempo) {
    var obj = self.crearInstancia(position)
    game.schedule(tiempo, {game.addVisual(obj) obj.caida()})
  }
}

object c {


  method crear(position,tiempo) {
    game.schedule(tiempo, {const obj = new CajaNegra(position = position) game.addVisual(obj) obj.caida()})
  }
}

object _ {
  method crear(position,tiempo) {
    
  }
}
*/

class Nivel {
  //const property comenzarNivel 
  const property siguienteNivel 
  const property objetosDelNivel
  //const property programaciones
  //const property programaciones2
  //const property posicionesObstaculos

  method siguienteNivel() {
    return siguienteNivel
  }
  
  /*
  method incializarPosicionesObstaculos() {
    (0..posicionesObstaculos.size()-1).forEach({x => 
                                      (0..posicionesObstaculos.get(x).size()-1).forEach({y => 
                                                              posicionesObstaculos.get(x).get(y).crear(game.at(y,10),programaciones.get(x).get(y))})})
  2da implementacion
  (0..posicionesObstaculos.size()-1).forEach({x => 
                                      (0..posicionesObstaculos.get(x).size()-1).forEach({y => 
                                                              posicionesObstaculos.get(x).get(y).crear(game.at(y,10),programaciones2.anyOne())})})
  }
  */
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
    algoritmo.level1()
    //self.añadirObstaculos()
    //self.incializarPosicionesObstaculos()
    //self.añadirObjetos() 
  }
}
const nivel1 = new Nivel(
  objetosDelNivel = #{pocion, escudoMagico, piedraPreciosa},
  siguienteNivel = final
)
/*
const nivel1 = new Nivel( 
    objetosDelNivel = #{pocion, escudoMagico, piedraPreciosa},
    //implementacion2
    programaciones2 = [1000,1000,1000,2000,4000,3000],
    //implementacion1
    programaciones = [[1000,1000,1000,1000,1000,1000],
                      [1000,2000,2000,2000,2000,2000],
                      [1000,3000,3000,3000,3000,2000],
                      [1000,4000,4000,4000,4000,1000],
                      [1000,5000,5000,5000,5000,2000],
                      [1000,6000,6000,6000,6000,2000],
                      [1000,7000,7000,7000,7000,2000]],
    posicionesObstaculos = [[_,p,l,c,_,_],
                            [_,_,p,p,_,_],
                            [_,p,_,_,c,_],
                            [_,_,p,p,_,_],
                            [_,p,_,_,c,_],
                            [_,p,_,_,p,_],
                            [_,p,l,c,_,_]],
    siguienteNivel  = final
)
*/
object final {
  const property position = game.origin()
  const property image = "fintest.jpg"
  //game.addVisual(self)
}

