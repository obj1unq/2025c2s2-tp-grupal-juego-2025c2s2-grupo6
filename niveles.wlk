import personaje.*
import wollok.game.*
import obstaculosConClases.*
import objetosConClases.*
import tableroJugable.*
import patron.*
import configuraciones.*

class Dificultad {
  
  method tiempoDeAparicion() 
  method tiempoDeCaida()
}

object dificultadBaja {
  method tiempoDeAparicion() {
    return 1000
  }
  method tiempoDeCaida() {
    return 300
  }
}

object dificultadMedia {
  method tiempoDeAparicion() {
    return 1000
  }
  method tiempoDeCaida() {
    return 100
  }
}

object dificultadAlta {
  method tiempoDeAparicion() {
    return 500
  }
  method tiempoDeCaida() {
    return 100
  }
}



class Nivel {

  const property siguienteNivel 
  const property setupDelNivel
  const property patronesDelNivel
  const property objetosDelNivel  
  const dificultad
  
  method clearLevel() {
    setupDelNivel.clear()
    patronesDelNivel.clear()
    configurarJuego.quitarPersonaje()
  }
  method siguienteNivel() {
    return siguienteNivel
  }
  method comenzarACaer() {
    if (!patronesDelNivel.isEmpty()){
      game.onTick(dificultad.tiempoDeAparicion(), "mostrarPatronNuevo", {self.mostrarNuevoPatron()})
    }
  }
  method startSetup() {
    //construyo los patrones
    setupDelNivel.forEach({setup => self.crearPatron(setup)})
    //llamo a un patron distinto cada 3 segundosv
  }

  method startObjetos() {
    const objNivel = objetosDelNivel.map({objeto => objeto.crear(game.at(5,10))}).asSet() //modificar
    objetosDelNivel.clear()
    objNivel.forEach({objeto => objetosDelNivel.add(objeto)})
    game.onTick(20000, "objs", objetosDelNivel.anyOne().invocar())
  }
  method crearPatron(setup) {
    const pat = patronFactory.crear() 
    pat.tiempoDeCaida(dificultad.tiempoDeCaida())
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
    configurarJuego.agregarPersonaje()
  }
  
  method inicializar() {        //inicializador del nivel.
    self.añadirPersonaje()
    self.startSetup()
    game.schedule(3000,{self.comenzarACaer()})
  }
}

class Batalla inherits Nivel{
  const boss  
  override method inicializar() {
    self.añadirPersonaje()
    self.startObjetos()
    //game.addVisual(personaje)
    game.addVisual(boss)
    game.schedule(3000, {boss.atacar()})
    game.onCollideDo(boss, {objeto => objeto.chocarConEfecto(boss)})
  }
}

const tutorial = new Nivel(
  dificultad = dificultadAlta,
  objetosDelNivel = #{e,b,d},
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

const nivel1 = new Nivel(
  dificultad = dificultadAlta,
  objetosDelNivel = #{e,b,d},
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

const nivel3 = new Nivel(
  dificultad = dificultadAlta,
  objetosDelNivel = #{e,b,d},
  setupDelNivel = #{ [p,l,l,_,_,p],
                     [_,l,l,l,_,p],
                     [p,_,l,_,_,p],
                     [_,l,l,_,_,l],
                     [_,p,l,_,l,_],
                     [_,p,p,p,p,_],
                     [p,_,_,_,_,p],
                     [_,l,_,_,l,_],
                     [_,p,_,p,l,_],
                     [_,_,p,p,_,_],
                     [_,a,_,a,_,a]},
                     
  patronesDelNivel = #{},

  siguienteNivel = final
)


const nivel2 = new Batalla(
  dificultad = dificultadBaja,
  objetosDelNivel = #{e,b,d},
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

