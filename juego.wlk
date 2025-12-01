import addons.*
import configuraciones.*
import wollok.game.*
import niveles.*
import personajes.lille

object fallToPieces{
    var property nivelActual = nivel4
    method irASiguienteNivel() {
      nivelActual.clearLevel()
      nivelActual = nivelActual.siguienteNivel()
      nivelActual.inicializar()
    }
    method irAPantallaDeMuerte() {
      nivelActual.clearLevel()
      pantallaDerrota.siguienteNivel(nivelActual)
      nivelActual = pantallaDerrota 
      lille.reiniciarEstadisticas()
      nivelActual.inicializar()
    }
    method inicializar() {          //metodo que inicializa el nivel actual del juego.
        const musicaPrincipal = game.sound("elcaminoDelMago.mp3")
        game.addVisual(escenario)
        game.width(7)
        game.height(10)
        game.cellSize(64)
        game.title("fall to pieces")
        musicaPrincipal.shouldLoop(true)
        game.schedule(500, { musicaPrincipal.play()} )
        musicaPrincipal.volume(0.1)
        nivelActual.inicializar()
        configurarJuego.tecladoEnJuego()
        game.onCollideDo(lille, {objeto => if(!lille.estoyMuerto() || lille.puntosObtenidos() == lille.puntosParaGanar()) {objeto.chocarConEfecto(lille)}})
        //objeto configurarControles
    }
    method irASiguienteNivelJugador(){
      if (nivelActual.puedeAvanzarPantalla()){
          self.irASiguienteNivel()
      }  
    }
}
