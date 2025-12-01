import addons.*
import wollok.game.*
import configuraciones.dificultadBaja
import configuraciones.dificultadAlta

class Patron {
    
  const property visuales = #{}
  var estaDisponible = true
  var tiempoDePatron = dificultadBaja.tiempoDeCaida()
  
  method borrarVisuales() {
    visuales.clear()
  }
  method estaDisponible() {
    return estaDisponible 
  }

  method tiempoDeCaida(tiempoDeDificultad) {
    tiempoDePatron = tiempoDeDificultad
  }

  method añadirObstaculos(patron) {
    (0..patron.size()-1).forEach({x => 
      const obs = patron.get(x).crear(game.at(x+1,10))
      visuales.add(obs)
    })
  }

  method startPatron() {
    estaDisponible = false // El patrón no esta disponible
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
    visuales.forEach({visual => visual.caer()})   
    
    if (visuales.any({obs => obs.position().y() < 0})){
      self.ocultarVisuales()
      self.pararPatron()
    }
  }

  method ocultarVisuales() {
    visuales.forEach({visual => visual.ocultar()})
  }

  method pararPatron() {
    game.removeTickEvent(self.identity())
    estaDisponible = true // El patron vuelve a estar disponible para el Nivel
  }

}

object patronFactory {
  method crear() {
    const obj = new Patron() 
    return obj
  }
}


