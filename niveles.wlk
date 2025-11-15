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
    return 800
  }
  method tiempoDeCaida() {
    return 200
  }
}

object dificultadMedia {
  method tiempoDeAparicion() {
    return 800
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
  const property nivelActual
  const property siguienteNivel 
  const property setupDelNivel
  const property patronesDelNivel
  var property objetosDelNivel  
  const property dificultad
  
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
  //method showLevel() {
    //addons.mostrarNivelActual(nivelActual)
  //}
  //method dropearObjetos() {
    //game.onTick(30000, "objs", {objetosDelNivel.anyOne().invocar()})
  //}
  method startObjetos() {
    objetosDelNivel = objetosDelNivel.map({objeto => objeto.crear(posicion.randomizarEnFila(10))}).asSet() //modificar
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
    //self.startObjetos()
    //self.showLevel()
    //self.dropearObjetos()
    game.schedule(5000,{self.comenzarACaer()})

  }
}

class Batalla inherits Nivel{
  const boss  
  override method inicializar() {
    self.añadirPersonaje()
    //game.addVisual(personaje)
    game.addVisual(boss)
    game.schedule(3000, {boss.atacar()})
    game.onCollideDo(boss, {objeto => objeto.chocarConEfecto(boss)})
  }
}

const tutorial = new Nivel(
  nivelActual = 0,
  dificultad = dificultadBaja,
  objetosDelNivel = #{e,b,d},
  setupDelNivel = #{ [p,u,u,_,_,p],
                     [_,u,a,u,_,p],
                     [p,_,u,_,a,p],
                     [_,u,u,_,_,a],
                     [_,p,u,_,u,_],
                     [_,p,p,p,p,_],
                     [_,a,_,a,_,a]},
                     
  patronesDelNivel = #{},

  siguienteNivel = final
)

const nivel1 = new Nivel(
  nivelActual = 1,
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

  siguienteNivel = nivel2
)

const nivel3 = new Nivel(
  nivelActual = 3,
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

const nivel4 = new Nivel(
  nivelActual = 4,
  dificultad = dificultadMedia,
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
                     [_,a,_,a,_,a],
                     [p,_,l,l,_,p],
                     [p,p,_,_,p,p],
                     [_,p,_,p,l,_],
                     [_,p,p,p,_,l],
                     [a,a,_,a,a,a]
                     },
                     
  patronesDelNivel = #{},

  siguienteNivel = nivel2
)



const nivel2 = new Batalla(
  nivelActual = 2,
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

