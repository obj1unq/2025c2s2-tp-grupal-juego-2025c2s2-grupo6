import obstaculosConClases.*
import wollok.game.*
object tableroJugable {
    method position() {
      return game.origin()
    }
    method image() {
      return "fondo.png"
    }
    const property x = 2 
    const property y = game.width()-2
}

object addons {
  const property niveles = ["","levelup.gif","","",""] 
  const property position = game.at(1,3)
  var property image = ""
  method mostrarNivelActual(nivel) {
    self.cambiarImagen(nivel)
    game.addVisual(self)
    game.schedule(5000, {game.removeVisual(self)})
  }
  method cambiarImagen(nivel) {
    image = niveles.get(nivel)
  }

}




// implementacion anterior...
// object algoritmo {
//   const patrones = #{[p,l,l,_,_,p],
//                      [_,l,l,l,_,p],
//                      [p,_,l,_,a,p],
//                      [_,l,l,_,_,l],
//                      [_,p,l,_,l,_],
//                      [_,p,p,p,p,_],
//                      [_,a,_,a,_,a]}
//   method level1() {
//     game.onTick(1200, "name",{self.añadirObstaculos(patrones.anyOne())})
//   }
//   method añadirObstaculos(patron) {
//     (1..patron.size()-1).forEach({x => patron.get(x).crear(game.at(x,10))})
//     //patron.forEach({obstaculo => (1..patron.size()-1).forEach({ x => obstaculo.crear(game.at(x,10))})})
//   }
// }
