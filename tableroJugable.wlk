import obstaculos.*
import obstaculosConClases.*
import wollok.game.*
object tableroJugable {
    const property x = 2 
    const property y = game.width()-2
}

object p {
  method crear(position) {
    const obj = new Pared(position = position) 
    game.addVisual(obj) 
    obj.caida()
  }
}

object l {
  method crear(position) {
    const obj = new Lava(position = position) 
    game.addVisual(obj) 
    obj.caida()
  }
}

object c {
    
  method crear(position) {
    const obj = new CajaNegra(position = position) 
    game.addVisual(obj) 
    obj.caida()
  }
}
object a {
    
  method crear(position) {
    const obj = new Ascuas(position = position) 
    game.addVisual(obj) 
    obj.caida()
  }
}

object _ {
  method crear(position) {
    
  }
}

object algo2 {
  const colecciones = #{p,p,l,l,_,a,_,_,l}
  const patrones = #{[p,l,l,_,_,p],
                     [_,l,l,l,_,p],
                     [p,_,l,_,a,p],
                     [_,l,l,_,_,l],
                     [_,p,l,_,l,_],
                     [_,p,p,p,p,_],
                     [_,a,_,a,_,a]}
  method inicializar() {
    self.añadirObstaculos(patrones.anyOne())
  }
  method añadirObstaculos(patron) {
    (1..patron.size()-1).forEach({x => patron.get(x).crear(game.at(x,10))})
  }
}
object algoritmo {
  const patrones = #{[p,l,l,_,_,p],
                     [_,l,l,l,_,p],
                     [p,_,l,_,a,p],
                     [_,l,l,_,_,l],
                     [_,p,l,_,l,_],
                     [_,p,p,p,p,_],
                     [_,a,_,a,_,a]}
  method level1() {
    game.onTick(1200, "name",{self.añadirObstaculos(patrones.anyOne())})
  }
  method añadirObstaculos(patron) {
    (1..patron.size()-1).forEach({x => patron.get(x).crear(game.at(x,10))})
    //patron.forEach({obstaculo => (1..patron.size()-1).forEach({ x => obstaculo.crear(game.at(x,10))})})
  }
}