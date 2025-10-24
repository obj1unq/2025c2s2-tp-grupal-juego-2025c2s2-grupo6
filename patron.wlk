import wollok.game.*

class Patron  {
  const property visuales = #{}

  method añadirObstaculos(patron) {
    (1..patron.size()-1).forEach({x => visuales.add(patron.get(x).crear(game.at(x,10)))})
  }
  method startPatron() {
    visuales.forEach({visual => 
      game.addVisual(visual) 
    })
    self.caida()
  }
  method caida() {
    game.onTick(100, self.identity(), {self.caerObjetos()})
  }
  method caerObjetos() {
    if (visuales.anyOne().position().y() != 0){
      visuales.forEach({visual => visual.caer()})  
    }else{
      visuales.forEach({visual => visual.ocultar()})
      self.stop()
    }
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
