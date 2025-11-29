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
/*
object dificultadNula {
  method tiempoDeAparicion(){}
  method tiempoDeCaida(){}
}
*/
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
class NivelLore{
  const property nivelActual
  var property siguienteNivel 
  const property fondo 
  method cambiarEscenario(){
    escenario.image(fondo)
  }
  method siguienteNivel() {
    return siguienteNivel
  }
  method clearLevel() {
    //configurarJuego.quitarPersonaje()
  }

    method inicializar() {        //inicializador del nivel.
    self.cambiarEscenario()
  }
}

class Nivel inherits NivelLore {
  const property patronesDelNivel = #{}
  var property objetosDelNivel  
  const property dificultad
  const property setupDelNivel

  override method clearLevel() {
    setupDelNivel.clear()
    self.ocultarPatrones()
    patronesDelNivel.clear()
    game.removeTickEvent("puntosPorSegundo")
    game.removeTickEvent("mostrarNuevoPatron")
    //configurarJuego.quitarPersonaje()
  }
  method comenzarACaer() {
    if (!patronesDelNivel.isEmpty()){
      game.onTick(dificultad.tiempoDeAparicion(), "mostrarPatronNuevo", {self.mostrarNuevoPatron()})
    }
  }
  method startSetup() {
    //construyo los patrones
    setupDelNivel.forEach({setup => self.crearPatron(setup)})
    //llamo a un patron distinto cada 3 segundos
  }
  method ocultarPatrones() {
    patronesDelNivel.forEach({patron => patron.ocultarVisuales()})
  }
  method crearPatron(setup) {
    const pat = patronFactory.crear() 
    pat.tiempoDeCaida(dificultad.tiempoDeCaida())
    pat.añadirObstaculos(setup)
    patronesDelNivel.add(pat)
  }
  method mostrarNuevoPatron() {
    if(!patronesDelNivel.isEmpty()){
      self.llamarPatron()
    }
  }
  method llamarPatron() {
    //agarro cualquier patron de la lista de patrones
    const patron = patronesDelNivel.anyOne()
    if (game.hasVisual(patron.visuales().anyOne())){ // encapsular condicion
      self.mostrarNuevoPatron()
    }
    else{
      patron.startPatron()
    }
  }

  method añadirPersonaje() {          // invoca al lille.v
    configurarJuego.agregarPersonaje()
    configurarJuego.agregarPuntos()
  }
  method sumarPuntos() {
    game.onTick(1000, "puntosPorSegundo", {lille.obtenerPuntos(10)})
  }
  override method inicializar() {        //inicializador del nivel.
    self.cambiarEscenario()
    self.añadirPersonaje()
    self.startSetup()
    game.schedule(5000,{
      self.comenzarACaer() 
      self.sumarPuntos()
    })
  }
}

class Batalla inherits Nivel(setupDelNivel = #{}){
  const boss 
  override method cambiarEscenario(){
    escenario.image("escenario.jpeg")
  }
  override method inicializar() {
    self.cambiarEscenario()
    self.añadirPersonaje()
    //game.addVisual(lille)
    game.addVisual(boss)
    game.schedule(3000, {boss.atacar()})
    game.onCollideDo(boss, {objeto => objeto.chocarConEfecto(boss)})
  }
}

const portada = new NivelLore(
  fondo = "portada.gif",
  nivelActual = portada,
  siguienteNivel = carta
)

const carta = new NivelLore(
  fondo = "cartaInicio.jpeg",
  nivelActual = carta,
  siguienteNivel = nivel5
)


const tutorial = new Nivel(
  fondo = "backgr.gif",
  nivelActual = 0,
  dificultad = dificultadBaja,
  objetosDelNivel = #{e,b,d},
  setupDelNivel = #{},
  siguienteNivel = nivel1
)

const nivel1 = new Nivel(
  fondo = "fondoBosque.jpeg",
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
                     
  siguienteNivel = nivel2
)


const nivel2 = new Batalla(
  fondo = "fondoBosque.jpeg",
  nivelActual = 2,
  dificultad = dificultadBaja,
  objetosDelNivel = #{e,b,d},
  boss = wizardd,

  siguienteNivel = pensamientoPreBatalla
)

const pensamientoPreBatalla = new NivelLore(
  fondo = "pensamientosPreBatalla.jpeg",
  nivelActual = pensamientoPreBatalla,
  siguienteNivel = nivel3
)

const nivel3 = new Nivel(
  fondo = "escenario.jpeg",
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

  siguienteNivel = finalJuego
)
const nivel4 = new Nivel(
  fondo = "escenario.jpeg",
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
                    

  siguienteNivel = nivel5
)

const nivel5 = new Nivel(
  fondo = "escenario.jpeg",
  nivelActual = 5,
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

  siguienteNivel = finalJuego
)
const pantallaDerrota = new NivelLore(
  fondo = "pantallaDerrota.gif",
  nivelActual = pensamientoPreBatalla,
  siguienteNivel = portada
)


object finalJuego inherits NivelLore(nivelActual = finalJuego, fondo = "conclusion.jpeg", siguienteNivel = portada){
  override method inicializar(){
    super()
    game.removeVisual(lille)
    game.removeVisual(marcadorDeVida)
    game.stop()
  }
}

/*
(nivelActual = self(), fondo = "conclusion.jpeg",siguienteNivel = portada){
  override method inicializar(){
    super()
    game.stop()
  }

  }


const pantallaDerrota inherits NivelLore(
  nivelActual = finalJuego,
  fondo = "pantallaDerrota.gif", 
  siguienteNivel = portada
)

object finalJuego inherits NivelLore( fondo = "conclusion.jpeg", siguienteNivel = portada){
  override method inicializar(){
    super()
    game.stop()
  }
}

*/


