import wollok.game.*
import niveles.*
import obstaculos.*
object fallToPieces{
    var property nivelActual = nivel1
    method inicializar() {          //metodo que inicializa el nivel actual del juego.
        const musicaPrincipal = game.sound("elcaminoDelMago.mp3")
        game.width(7)
        game.height(10)
        game.cellSize(64)
        game.title("fall to pieces")
        musicaPrincipal.shouldLoop(true)
        game.schedule(500, { musicaPrincipal.play()} )
        musicaPrincipal.volume(0.5)
        nivelActual.inicializar()
        //objeto configurarControles
    }
}

