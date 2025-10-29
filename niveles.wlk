import personaje.*
import wollok.game.*
import obstaculosConClases.*
import tableroJugable.*
import patron.*

class Nivel {

  const property siguienteNivel 
  const property setupDelNivel
  const property patronesDelNivel
 
  method clearLevel() {
    setupDelNivel.clear()
    patronesDelNivel.clear()
  }
  method siguienteNivel() {
    return siguienteNivel
  }
  method comenzarACaer() {
    if (!patronesDelNivel.isEmpty()){
      game.onTick(500, "mostrarPatronNuevo", {self.mostrarNuevoPatron()})
    }
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
    keyboard.p().onPressDo{personaje.parry()}
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

class Batalla inherits Nivel{
  const boss  
  override method inicializar() {
    self.añadirPersonaje()
    game.addVisual(boss)
    game.schedule(3000, {boss.atacar()})
    game.onCollideDo(boss, {objeto => objeto.chocarConEfecto(boss)})
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

const nivel2 = new Batalla(
  boss = wizard,
  setupDelNivel = #{},         
  patronesDelNivel = #{},

  siguienteNivel = nivel1
)
object final {
  const property position = game.origin()
  const property image = "fintest.jpg"
  //game.addVisual(self)
}

