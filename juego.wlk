import addons.*
import configuraciones.*
import wollok.game.*
import niveles.*
import personajes.lille

object fallToPieces{
    var property nivelActual = nivel1
    method irASiguienteNivel() {
      nivelActual.clearLevel()
      nivelActual = nivelActual.siguienteNivel()
      nivelActual.inicializar()
    }
    method IrAPantallaDeMuerte() {
      nivelActual.clearLevel()
      nivelActual = pantallaDerrota 
      configurarJuego.quitarInterfaz()
      lille.reiniciarEstadisticas()
      pantallaDerrota.inicializar()
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
        musicaPrincipal.volume(0.3)
        nivelActual.inicializar()
        configurarJuego.tecladoEnJuego()
        game.onCollideDo(lille, {objeto => if(!lille.estoyMuerto() || lille.puntosObtenidos() == lille.puntosParaGanar()) {objeto.chocarConEfecto(lille)}})
        //objeto configurarControles
    }
    method volverACargarNivel() {
      nivelActual.clearLevel()
      nivelActual.inicializar()
    }

    method irASiguienteNivelJugador(){
      if (nivelActual == portada || nivelActual == carta || nivelActual == pensamientoPreBatalla  || nivelActual == pantallaDerrota){
          self.irASiguienteNivel()
      }  
    }
}





class Pantalla {
  const property position = game.at(0, 0)
  const property image
  method volverAlIncio() {
    fallToPieces.nivelActual(tutorial)
  }
  method empezarJuego() {
    
  }
  method reintentarNivel() {
    fallToPieces.nivelActual().volverACargarNivel()
  }
}