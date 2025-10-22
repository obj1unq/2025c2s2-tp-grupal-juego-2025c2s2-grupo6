import wollok.game.*

class Patron  {
  const property visuales = #{}

  method añadirObstaculos(patron) {
    (1..patron.size()-1).forEach({x => visuales.add(patron.get(x).crear(game.at(x,10)))})
  }
  method start() {
    visuales.forEach({visual => game.addVisual(visual) visual.caida()})
    game.schedule(11000, {self.stop()})
  }
  method stop() {
    visuales.forEach({visual => visual.ocultar()})
  }
}

object patronFactory {
  method crear() {
    const obj = new Patron() 
    return obj
  }
}
