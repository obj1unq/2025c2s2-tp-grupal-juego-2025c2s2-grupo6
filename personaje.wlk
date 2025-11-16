import juego.*
import niveles.*
import wollok.game.*
import obstaculosConClases.*
import objetosConClases.*
import tableroJugable.*


object personaje {
  var property position = game.at(3,1)
  var property image = "gifg.gif"
  var property vida  = 100
  var property puntosObtenidos = 0  
  var property tieneEscudoActivo = false 

  method puntosParaGanar() {
    return 200
  }

  method nada() {
    
  }

  method estoyMuerto() = vida <= 0 
  //Verificar si la vida es menor o igual a 0
  
  method curar() {
        if (vida >= 75){
            vida = 100
        }else{
            vida =+ 25
        }
  }
  method parry() {
    if (!game.getObjectsIn(position.up(1)).isEmpty()){
      game.getObjectsIn(position.up(1)).forEach({ataque => ataque.devolver()})
    }
  }
  method recibirDaño(cantidad) {
    //Reducir la vida del personaje tanto como la cantidad dada si no tiene el escudo activo en ese momento
    if (not self.tieneEscudoActivo()){
      self.vida(self.vida() - cantidad)
      game.say(self, "-" + cantidad + " HP")
    }
  }

  method obtenerPuntos(puntos) {
    if (puntosObtenidos >= self.puntosParaGanar()){
      game.say(self, "You WIN!!")
      puntosObtenidos = 0
      fallToPieces.irASiguienteNivel()
      //game.stop()
    }else{
      puntosObtenidos += puntos
    }
  }
  
  method detenerJuegoSiEstoyMuerto() {
    //Prop: detener el juego si la vida del jugador disminuye a 0
    if (self.estoyMuerto()){
      game.say(self,"GAME OVER")
      game.stop()
    }
  }
  method izquierda() {
	position = game.at(1.max(position.x() - 1), position.y()) 
  }
	
  method derecha() {
	position = game.at((game.width() - 2).min(position.x() + 1), position.y()) 
  }
}

object wizard {
  var property vida = 60
  var property position = game.at(5,10)
  var property image = "aaa.png"
  const property hechizosMagicos = #{a,u}
  
  method tieneEscudoActivo() {
    return false
  }
  method estoyMuerto() = vida <= 0 

  method recibirDaño(cantidad) {
    //Reducir la vida del personaje tanto como la cantidad dada si no tiene el escudo activo en ese momento
    if (not self.tieneEscudoActivo()){
      self.vida(self.vida() - cantidad)
      game.say(self, "-" + cantidad + " HP")
    }
  }

  method detenerJuegoSiEstoyMuerto() {
    //Prop: detener el juego si la vida del jugador disminuye a 0
    if (self.estoyMuerto()){
      game.say(self,"GAME OVER")
      game.removeTickEvent("moverYAtacar")
      game.removeTickEvent("moveRand")
      game.schedule(2000, {game.removeVisual(self) fallToPieces.irASiguienteNivel()})
  
    }
  }

  method atacar() {
    //game.onTick(2000, "moverYAtacar",{self.atacarHacia(personaje.position())})
    //prueba
    game.onTick(1000, "moverYAtacar",{self.atacarHacia(position)})
    game.onTick(1000, "moveRand", {self.posicionRandom()})
  }
  method posicionRandom() {
    position = game.at(tableroJugable.x().randomUpTo(game.width()-1).truncate(0),position.y())
  }
  method atacarHacia(posicion) {
    position = game.at(posicion.x(), game.height()-1)
    self.invocarAtaque()
  }
  method invocarAtaque() {
    const ataque = hechizosMagicos.anyOne().crear(position.down(1))
    game.addVisual(ataque)
    ataque.caida()
  }
}