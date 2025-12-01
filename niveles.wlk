import personajes.*
import juego.fallToPieces
import wollok.game.*
import obstaculos.*
import objetos.*
import addons.*
import patron.*
import configuraciones.*

class NivelLore{
  const property nivelActual
  var property siguienteNivel 
  const property fondo 
  method agregarLille() {
    configurarJuego.agregarPersonaje()
    lille.reiniciarEstadisticas()
  }
  method cambiarEscenario(){
    escenario.image(fondo)
  }
  method siguienteNivel() {
    return siguienteNivel
  }
  method clearLevel() {
    configurarJuego.quitarInterfaz()
    configurarJuego.quitarPersonaje()
  }

  method inicializar() {        //inicializador del nivel.
    self.cambiarEscenario()
  }
}

class Nivel inherits NivelLore (fondo = "backgr.gif"){
  const property setupDelNivel
  const property patronesDelNivel = #{}
  const property objetosDelNivel  
  const property dificultad
  override method agregarLille(){
    super()
    configurarJuego.agregarInterfaz()
  }
  override method clearLevel() {
    super()
    self.ocultarPatrones()
    self.ocultarObjetos()
    game.removeTickEvent("mostrarPatronNuevo")
    game.removeTickEvent("puntosPorSegundo")
    game.removeTickEvent("agregarObjeto")
    patronesDelNivel.clear()
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
    patronesDelNivel.forEach({patron => patron.ocultarVisuales() patron.borrarVisuales()}) 
  }
  method ocultarObjetos() {
    objetosDelNivel.forEach({obj => obj.ocultar()}) 
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
  method sumarPuntos() {
    game.onTick(1000, "puntosPorSegundo", {lille.obtenerPuntos(10)})
  }
  override method inicializar() {        //inicializador del nivel.
    self.cambiarEscenario()
    self.agregarLille() 
    self.startSetup()
    game.schedule(5000,{
      self.comenzarACaer() 
      self.sumarPuntos()
      self.agregarObjetos()
    })
  }
}

class Batalla inherits NivelLore{
  const boss 
  override method inicializar() {
    super()
    self.agregarLille()
    //game.addVisual(lille)
    game.addVisual(boss)
    game.schedule(3000, {boss.iniciarAtaque()})
    game.onCollideDo(boss, {objeto => objeto.chocarConEfecto(boss)})
  }
  override method clearLevel(){
    super()
    boss.ocultar()
  }
}
object finalJuego inherits NivelLore(nivelActual = finalJuego, fondo = "conclusion.jpeg", siguienteNivel = portada){
  override method inicializar(){
    super()
    game.removeVisual(lille)
    game.removeVisual(marcadorDeVida)
    game.stop()
  }
}

const pantallaDerrota = new NivelLore(
  fondo = "pantallaDerrota.gif",
  nivelActual = pensamientoPreBatalla,
  siguienteNivel = fallToPieces.nivelActual()
)

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

const tutorial = new Nivel(
  nivelActual = 0,
  dificultad = dificultadBaja,
  objetosDelNivel = #{escudoMagico},
  setupDelNivel = #{ [p,r,r,_,_],
                     [_,r,l,r,_],
                     [p,_,r,_,l],
                     [_,r,r,_,_],
                     [_,p,r,_,r],
                     [_,p,p,p,p],
                     [_,l,_,l,_]},
                     
  siguienteNivel = nivel1
)

const nivel1 = new Nivel(
  nivelActual = 1,
  dificultad = dificultadMedia,
  objetosDelNivel = #{pocion,escudoMagico,piedraPreciosa},
  setupDelNivel = #{ [p,l,l,_,_],
                     [_,l,l,l,_],
                     [p,_,l,_,p],
                     [_,l,l,_,_],
                     [_,r,l,_,l],
                     [_,p,r,r,p],
                     [_,p,_,p,_]},
                     
  siguienteNivel = nivel2
)
const nivel2 = new Nivel(
  nivelActual = 2,
  dificultad = dificultadMedia,
  objetosDelNivel = #{pocion,escudoMagico,diamanteValioso,piedraPreciosa},
  setupDelNivel = #{ [p,l,l,_,_],
                     [_,l,l,l,_],
                     [p,_,l,_,_],
                     [_,l,l,_,_],
                     [_,p,l,_,l],
                     [_,r,r,p,p],
                     [p,_,_,_,_],
                     [_,l,_,_,l],
                     [_,p,_,p,l],
                     [_,_,p,r,_],
                     [_,r,_,r,_]},

  siguienteNivel = nivel3
)
const nivel3 = new Nivel(
  nivelActual = 3,
  dificultad = dificultadMedia,
  objetosDelNivel = #{pocion,escudoMagico,diamanteValioso},
  setupDelNivel = #{ [p,l,l,_,_],
                     [_,l,l,l,_],
                     [p,_,l,_,_],
                     [_,l,l,_,_],
                     [_,p,l,_,l],
                     [_,p,p,p,p],
                     [p,_,_,_,_],
                     [_,l,_,_,l],
                     [_,p,_,p,l],
                     [_,_,p,p,_],
                     [_,l,_,r,_],
                     [p,_,l,l,_],
                     [p,p,_,_,p],
                     [_,p,_,p,l],
                     [_,p,p,p,_],
                     [l,l,_,r,r],///
                     [_,p,_,p,l],
                     [_,_,p,p,_],
                     [_,r,_,r,_],
                     [p,_,l,l,_],
                     [p,p,_,_,p],
                     [_,p,_,p,l],
                     [_,p,p,p,_],
                     [r,r,_,r,r]
                     },
                    

  siguienteNivel = nivel4
)

const nivel4 = new Nivel(
  nivelActual = 4,
  dificultad = dificultadMedia,
  objetosDelNivel = #{pocion,escudoMagico,diamanteValioso,piedraPreciosa},
  setupDelNivel = #{ [p,l,l,_,_],
                     [_,l,l,l,_],
                     [p,_,l,_,_],
                     [_,l,l,_,_],
                     [_,p,l,_,l],
                     [_,p,p,p,p],
                     [p,_,_,_,_],
                     [_,l,_,_,l],
                     [_,p,_,p,l],
                     [_,_,p,p,_],
                     [_,r,_,r,_],
                     [p,_,l,l,_],
                     [p,p,_,_,p],
                     [_,p,_,p,l],
                     [_,p,p,p,_],
                     [r,r,_,r,r]
                     },

  siguienteNivel = primerBatalla
)

const primerBatalla = new Batalla(
  fondo = "fondoBosque.jpeg",
  nivelActual = primerBatalla,
  boss = wizard,
  siguienteNivel = pensamientoPreBatalla
)
const pensamientoPreBatalla = new NivelLore(
  fondo = "pensamientosPreBatalla.jpeg",
  nivelActual = pensamientoPreBatalla,
  siguienteNivel = segundaBatalla
)


const segundaBatalla = new Batalla(
  fondo = "escenario.jpeg",
  nivelActual = nivel2,
  boss = juan,
  siguienteNivel = finalJuego
)