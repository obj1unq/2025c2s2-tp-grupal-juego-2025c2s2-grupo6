import juego.*
import niveles.*
import wollok.game.*
import obstaculos.*
import objetos.*
import addons.*
import configuraciones.*

class Personaje {
  var property position
  var property image  
  var property vida
  var property tieneEscudoActivo = false
  method estoyMuerto() = vida <= 0 
  method recibirDaño(cantidad) {
    //Reducir la vida del personaje tanto como la cantidad dada si no tiene el escudo activo en ese momento
    self.vida(self.vida() - cantidad)
    game.say(self, "-" + cantidad + " HP")
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
  const tiposDeAtaques
  const claveDeAtaque = self.identity().toString()
  //var tiempoPostAtaque = 2000
  method iniciarAtaque() {
    game.onTick(2500, claveDeAtaque, { self.ataqueAleatorio()})
    self.cambiarPosicion()
  }
  method ataqueAleatorio() {
    tiposDeAtaques.anyOne().atacar(self)
  }

  method cambiarPosicion() {
    position = game.at(tableroJugable.minPosition().randomUpTo(game.width()-1).truncate(0),position.y())
  }
  method crearAtaque() {
    return hechizosMagicos.anyOne().crear(position.down(1))
  }
  override method accionAlMorir(){ // el ataque del villano no se va.
    game.say(self,"GAME OVER")
    game.removeTickEvent(claveDeAtaque)
    game.schedule(2000, {game.removeVisual(self) fallToPieces.irASiguienteNivel()})
    //game.removeTickEvent("moveRand")
  }
}

object wizardd inherits Villano (hechizosMagicos = #{a,u},image = "wizardd.gif", vida = 100, tiposDeAtaques = #{ataqueNormal,ataqueLluvia}) {
}
object juan inherits Villano (hechizosMagicos = #{a,u},image = "wizardd.gif", vida = 100, tiposDeAtaques = #{ataqueNormal,ataqueLluvia}) {
}

object lille inherits Personaje(position = game.at(3,1), image = "gifg.gif", vida = 100){
  var property puntosObtenidos = 0
  method cambiarEstadoEscudo(bool) {
    tieneEscudoActivo = bool
    marcadorDeVida.marcarVidaDe(self)
  }
  method puntosParaGanar() {
    return 200
  }
  method curar() {
  if (vida >= 75){
      vida = 100
  }else{
      vida = vida + 25 
  }
  marcadorDeVida.marcarVidaDe(self)
  }

  override method recibirDaño(cantidad){
    if(!self.tieneEscudoActivo()){
      super(cantidad)
    }
    marcadorDeVida.marcarVidaDe(self)
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
  /*
  override method accionAlMorir() {
    game.say(self,"GAME OVER")
    self.vida(100)
    marcadorDeVida.marcarVidaDe(self)
    //fallToPieces.ponerPantallaDeMuerte()
    //fallToPieces.nivelActual().clearLevel()
    //game.stop()
  }
  */
  method reiniciarEstadisticas() {
    self.puntosObtenidos(0)
    self.vida(100)
    marcadorDeVida.marcarVidaDe(self)
  }
  override method accionAlMorir() {
  //  game.say(self,"GAME OVER")
    fallToPieces.nivelActual().clearLevel()
    pantallaDerrota.siguienteNivel(fallToPieces.nivelActual())
    configurarJuego.quitarInterfaz()
    self.reiniciarEstadisticas()
    fallToPieces.nivelActual(pantallaDerrota)
    pantallaDerrota.inicializar()
  //  game.stop()
  }
  method izquierda() {
	position = game.at(1.max(position.x() - 1), position.y()) 
  }
	
  method derecha() {
	position = game.at((game.width() - 2).min(position.x() + 1), position.y()) 
  }
}

object marcadorDeVida {
  var property position = game.at(0, 9)
  var property image = "vida 100.png"
  
  method text() {
    return lille.vida().toString()
  }
  method textColor() = paleta.colorDeTexto()
  method marcarVidaDe(personaje) {
    if(personaje.tieneEscudoActivo()){
      self.marcarVidaConEscudoDe(personaje)
    } else {
      self.marcarVidaSinEscudoDe(personaje)
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

class Ataque {
  method atacar(personajeAtacante) {
    if (game.getObjectsIn(personajeAtacante.position().down(1)).isEmpty()){
      self.invocarAtaque(personajeAtacante)
    }
  }
  method detenerAtaque(personajeAtacante) {
    
  }
  method invocarAtaque(personaje){}
  method ataqueNormal(personaje) {
    const ataque = personaje.crearAtaque()
    game.addVisual(ataque)
    ataque.caida()
  }
}


object ataqueNormal inherits Ataque{
  override method invocarAtaque(personaje) {
    self.ataqueNormal(personaje)
    //self.direccionarAtaque(ataque)
  }
}
object ataqueExpansivo inherits Ataque{
  
}

object ataqueLluvia inherits Ataque{
  override method invocarAtaque(personaje) {
    self.atacarEnPosicion(personaje, tableroJugable.minPosition())
  }
  method atacarEnPosicion(personaje, columna) {
    personaje.position(game.at(columna, personaje.position().y()))
    self.ataqueNormal(personaje) 
    const siguienteColumna = columna + 1
    if (siguienteColumna < game.width() - 1){ // Usamos < para no exceder los límites
      game.schedule(500, { self.atacarEnPosicion(personaje, siguienteColumna) })
    } else {
      personaje.cambiarPosicion()
    }
  }
}
