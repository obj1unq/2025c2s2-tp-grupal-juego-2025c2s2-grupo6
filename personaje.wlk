import juego.*
import niveles.*
import wollok.game.*
import obstaculosConClases.*
import objetosConClases.*
import tableroJugable.*

class Personaje {
  var property position
  var property image  
  var property vida
  var property tieneEscudoActivo = false
  method estoyMuerto() = vida <= 0 
  method recibirDaño(cantidad) {
    //Reducir la vida del personaje tanto como la cantidad dada si no tiene el escudo activo en ese momento
    if (not self.tieneEscudoActivo()){
      self.vida(self.vida() - cantidad)
      game.say(self, "-" + cantidad + " HP")
    }
  }
  method realizarAlMorir() {
    //Prop: detener el juego si la vida del jugador disminuye a 0
    if (self.estoyMuerto()){
      self.accionAlMorir()
    }
  }
  method accionAlMorir()
}

class Villano inherits Personaje(position = game.at(3,9)) {
  const property hechizosMagicos
  method atacar() {
    //game.onTick(2000, "moverYAtacar",{self.atacarHacia(personaje.position())})
    //prueba
    game.onTick(1000, "moverYAtacar",{self.atacarHacia(position)})
    game.onTick(1000, "moveRand", {self.cambiarPosicion()})
  }
  method cambiarPosicion() {
    position = game.at(tableroJugable.x().randomUpTo(game.width()-1).truncate(0),position.y())
  }
  method atacarHacia(posicion) {
    position = game.at(posicion.x(), game.height()-1)
    self.invocarAtaque()
  }
  method invocarAtaque() {
    const ataque = self.crearAtaque()
    game.addVisual(ataque)
    ataque.caida()
  }
  method crearAtaque() {
    return hechizosMagicos.anyOne().crear(position.down(1))
  }
  override method accionAlMorir(){
    game.say(self,"GAME OVER")
    game.removeTickEvent("moverYAtacar")
    game.removeTickEvent("moveRand")
    game.schedule(2000, {game.removeVisual(self) fallToPieces.irASiguienteNivel()})
  }
}

object wizardd inherits Villano(hechizosMagicos = #{a,u},image = "wizardd.gif", vida = 100) {
  
}


object lille inherits Personaje(position = game.at(3,1), image = "gifg.gif", vida = 100){
  var property puntosObtenidos = 0
  method puntosParaGanar() {
    return 200
  }
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
  override method accionAlMorir() {
    game.say(self,"GAME OVER")
    fallToPieces.nivelActual().clearLevel()
    game.stop()
  }
  method izquierda() {
	position = game.at(1.max(position.x() - 1), position.y()) 
  }
	
  method derecha() {
	position = game.at((game.width() - 2).min(position.x() + 1), position.y()) 
  }
}

object marcadorDeVida {
  var property position = game.at(0, 1)
  var property image = "vida 100.png"
  
  method marcarVidaDe(personaje) {
    if(personaje.tieneEscudoActivo()){
      self.marcarVidaConEscudoDe(personaje)
    } else {
      self.marcarVidaSinEscudoDe(personaje)
    }

  if(!game.hasVisual(self)){
    game.addVisual(self)
    }
  }

  method marcarVidaSinEscudoDe(personaje) {
    //Proposito: marcar la vida en rojo

  if(personaje.vida() == 100){
    image = "vida 100.png"
  } else if(personaje.vida().between(80, 99)){
    image = "vida 99 - 80.png"
  } else if(personaje.vida().between(60, 79)){
    image = "vida 79 - 60.png"
  } else if(personaje.vida().between(30, 59)){
    image = "vida 59 - 30.png"
  } else if(personaje.vida().between(15, 29)){
    image = "vida 15 - 0.png"
  } else {
    image = "vida 0.png"
  }

  }

  method marcarVidaConEscudoDe(personaje) {
    // Proposito: Marcar la vida del personaje en azul

    if(personaje.vida() == 100){
        image = "vida 100 escudo.png"
      } else if(personaje.vida().between(80, 99)){
        image = "vida 99 - 80 escudo.png"
      } else if(personaje.vida().between(60, 79)){
        image = "vida 79 - 60 escudo.png"
      } else if(personaje.vida().between(30, 59)){
        image = "vida 59 - 30 escudo.png"
      } else if(personaje.vida().between(15, 29)){
        image = "vida 15 - 0 escudo.png"
      } else {
        image = "vida 0.png"
      }
  }
}