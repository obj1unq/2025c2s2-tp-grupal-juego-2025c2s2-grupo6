import wollok.game.*
import niveles.*
import obstaculos.*
object fallToPieces{
    var property nivelActual = nivel1
    method inicializar() {          //metodo que inicializa el nivel actual del juego.
        game.width(7)
        game.height(10)
        game.cellSize(64)
        game.title("fall to pieces")
        nivelActual.inicializar()
        //game.addVisual(obstaculo)
        //game.addVisual(cajaNegra)
        //game.onTick(200, "caer", {obstaculo.caer()})
        //game.onTick(100, "caer2", {cajaNegra.caer()})
    }
}