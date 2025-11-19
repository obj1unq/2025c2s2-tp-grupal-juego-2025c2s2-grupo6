import tableroJugable.*
import wollok.game.*
import niveles.dificultadBaja
import niveles.dificultadAlta
class Patron  {
  const property visuales = #{}
  var tiempoDePatron = dificultadBaja.tiempoDeCaida()

  method tiempoDeCaida(tiempoDeDificultad) {
    tiempoDePatron = tiempoDeDificultad
  }
  method añadirObstaculos(patron) {
    (1..patron.size()-1).forEach({x => visuales.add(patron.get(x).crear(game.at(x,10)))})
  }
  method startPatron() {
    self.agregarVisuales()
    self.caida()
  }
  method agregarVisuales() {
    visuales.forEach({visual => game.addVisual(visual)})
  }
  
  method caida() {
    game.onTick(tiempoDePatron, self.identity(), {self.caerObjetos()})
  }
  method caerObjetos() {
    if (visuales.anyOne().position().y() != 0){
      visuales.forEach({visual => visual.caer()})  
    }
    else{
      self.ocultarVisuales()
      self.stop()
    }
  }

  method ocultarVisuales() {
    visuales.forEach({visual => visual.ocultar()})
  }

  method stop() {
    game.removeTickEvent(self.identity())
  }
}

object patronFactory {
  method crear() {
    const obj = new Patron() 
    return obj
  }
}


