import personajes.*
import wollok.game.*
import obstaculos.*
import objetos.*
import addons.*
import patron.*
import configuraciones.*

class Nivel {
  const property nivelActual
  const property siguienteNivel 
  const property setupDelNivel
  const property patronesDelNivel = #{}
  const property objetosDelNivel  
  const property dificultad
  
  method clearLevel() {
    //setupDelNivel.clear()
    self.ocultarPatrones()
    game.removeTickEvent("mostrarPatronNuevo")
    game.removeTickEvent("puntosPorSegundo")
    game.removeTickEvent("agregarObjeto")
    patronesDelNivel.clear()
    //configurarJuego.quitarPersonaje()
  }
  method siguienteNivel() {
    return siguienteNivel
  }
  method comenzarACaer() {
    //llamo a un patron distinto cada tiempo de dificultad segundos
    if (!patronesDelNivel.isEmpty()){
      game.onTick(dificultad.tiempoDeAparicion(), "mostrarPatronNuevo", {self.mostrarNuevoPatron()})
    }
  }
  method startSetup() {
    //construyo los patrones
    setupDelNivel.forEach({setup => self.crearPatron(setup)})
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
    const patron = patronesDelNivel.anyOne()
    // el patron esta activo?
    if (!patron.estaDisponible()){ 
      self.mostrarNuevoPatron() // recursion hasta encontrar uno que no este activo
    }
    else{
      patron.startPatron() // se inicia startPatron() y cambia el estado del patron a no disponible.
    }
  }

  method tiempoDeCaidaObj(){
    return dificultad.tiempoDeAparicion() / 0.27
  }

  method agregarObjetos() {
    if(!objetosDelNivel.isEmpty()){
      game.onTick(self.tiempoDeCaidaObj(), "agregarObjeto", {self.aparecerObjeto()})
    }
  }
  method aparecerObjeto(){
    const objeto = objetosDelNivel.anyOne()
    objeto.tiempoDeCaida(dificultad.tiempoDeCaida())
    objeto.invocar()
  }
  method añadirPersonaje() {          // invoca al lille.v
    configurarJuego.agregarPersonaje()
    configurarJuego.agregarPuntos()
    configurarJuego.agregarTimer()
  }
  method sumarPuntos() {
    game.onTick(1000, "puntosPorSegundo", {lille.obtenerPuntos(10)})
  }
  method cambiarEscenario(){
    escenario.image("backgr.gif")
  }
  method inicializar() {        //inicializador del nivel.
    self.cambiarEscenario()
    self.añadirPersonaje()
    self.startSetup()
    game.schedule(5000,{
      self.comenzarACaer() 
      self.sumarPuntos()
      self.agregarObjetos()
    })
  }
}

class Batalla inherits NivelLore(){
  const boss 

  override method inicializar() {
    super()
    self.añadirPersonaje()
    game.removeVisual(barraProgreso)
    //game.addVisual(lille)
    game.addVisual(boss)
    game.schedule(3000, {boss.iniciarAtaque()})
    game.onCollideDo(boss, {objeto => objeto.chocarConEfecto(boss)})
  }
}

class NivelLore{
  const property nivelActual
  var property siguienteNivel 
  const property fondo 
  method añadirPersonaje() {          
    configurarJuego.agregarPersonaje()
    configurarJuego.agregarPuntos()
    configurarJuego.agregarTimer()
  }
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
/////
const portada = new NivelLore(
  fondo = "portada.gif",
  nivelActual = portada,
  siguienteNivel = carta
)

const carta = new NivelLore(
  fondo = "cartaInicio.jpeg",
  nivelActual = carta,
  siguienteNivel = tutorial
)

const pensamientoPreBatalla = new NivelLore(
  fondo = "pensamientosPreBatalla.jpeg",
  nivelActual = pensamientoPreBatalla,
  siguienteNivel = nivel2
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

////////////////

const tutorial = new Nivel(
  nivelActual = 0,
  dificultad = dificultadBaja,
  objetosDelNivel = #{escudoMagico},
  setupDelNivel = #{ [p,u,u,_,_,p],
                     [_,u,a,u,_,p],
                     [p,_,u,_,a,p],
                     [_,u,u,_,_,a],
                     [_,p,u,_,u,_],
                     [_,p,p,p,p,_],
                     [_,a,_,a,_,a]},
                     
  siguienteNivel = nivel1
)

const nivel1 = new Nivel(
  nivelActual = 1,
  dificultad = dificultadMedia,
  objetosDelNivel = #{pocion,escudoMagico,diamanteValioso},
  setupDelNivel = #{ [p,l,l,_,_,p],
                     [_,l,l,l,_,p],
                     [p,_,l,_,p,p],
                     [_,l,l,_,_,l],
                     [_,p,l,_,l,_],
                     [_,p,p,p,p,_],
                     [_,p,_,p,_,p]},
                     
  siguienteNivel = primerBatalla
)
const primerBatalla = new Batalla(
  fondo = "fondoBosque.jpeg",
  nivelActual = primerBatalla,
  boss = juan,
  siguienteNivel = pensamientoPreBatalla
)

const nivel2 = new Batalla(
  fondo = "escenario.jpeg",
  nivelActual = nivel2,
  boss = wizardd,
  siguienteNivel = nivel3
)
const nivel3 = new Nivel(
  nivelActual = 3,
  dificultad = dificultadAlta,
  objetosDelNivel = #{pocion,escudoMagico,diamanteValioso},
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

  siguienteNivel = nivel4
)
const nivel4 = new Nivel(
  nivelActual = 4,
  dificultad = dificultadMedia,
  objetosDelNivel = #{pocion,escudoMagico,diamanteValioso},
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
  nivelActual = 5,
  dificultad = dificultadMedia,
  objetosDelNivel = #{pocion,escudoMagico,diamanteValioso},
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
const prueba = new Nivel(
    nivelActual = 0,
    siguienteNivel = null, 
    setupDelNivel = #{},
    objetosDelNivel = #{},  
    dificultad = dificultadBaja
    )

/*
object final {
  const property position = game.origin()
  const property image = "fintest.jpg"
  method inicializar() {
    game.stop()
  }
}
*/
