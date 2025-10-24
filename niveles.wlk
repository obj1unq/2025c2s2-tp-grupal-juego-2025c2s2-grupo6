import personaje.*
import wollok.game.*
import obstaculosConClases.*
import tableroJugable.*
import patron.*

class Nivel {

  const property siguienteNivel 
  const property setupDelNivel
  const property patronesDelNivel
 

  method siguienteNivel() {
    return siguienteNivel
  }
  method comenzarACaer() {
    game.onTick(1000, "mostrarPatronNuevo", {self.mostrarNuevoPatron()})
  }
  method start() {
    //construyo los patrones
    setupDelNivel.forEach({setup => self.crearPatron(setup)})
    //llamo a un patron distinto cada 3 segundosv
  }
  method crearPatron(setup) {
    const pat = patronFactory.crear() 
    pat.añadirObstaculos(setup)
    patronesDelNivel.add(pat)
  }

  method mostrarNuevoPatron() {
    //agarro cualquier patron de la lista de patrones
    const patron = patronesDelNivel.anyOne()
    if (game.hasVisual(patron.visuales().anyOne())){ 
      self.mostrarNuevoPatron()
    }
    else{
      patron.startPatron()
    }
  }

  method añadirPersonaje() {          // invoca al personaje.v
    game.addVisual(personaje)
    keyboard.d().onPressDo{personaje.derecha()}
    keyboard.a().onPressDo{personaje.izquierda()}
    game.onCollideDo(personaje, {objeto => objeto.chocarConEfecto(personaje)})
  }
  
  method inicializar() {        //inicializador del nivel.
    //game.addVisual(tableroJugable)
    self.añadirPersonaje()
    self.start()
    self.comenzarACaer()
    //algoritmo.level1()
  }
}
const nivel1 = new Nivel(
  setupDelNivel = #{ [p,l,l,_,_,p],
                     [_,l,l,l,_,p],
                     [p,_,l,_,a,p],
                     [_,l,l,_,_,l],
                     [_,p,l,_,l,_],
                     [_,p,p,p,p,_],
                     [_,a,_,a,_,a]},
                     
  patronesDelNivel = #{},

  siguienteNivel = final
)
object final {
  const property position = game.origin()
  const property image = "fintest.jpg"
  //game.addVisual(self)
}


// IMPLEMENTACION ANTERIOR.

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

Class nivel
  method añadirObstaculos() {
    objetosDelNivel.forEach{obstaculo => game.addVisual(obstaculo)}
    objetosDelNivel.forEach{obstaculo => game.schedule(0.randomUpTo(500),{ => obstaculo.caida()})}
    
  }


*/

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