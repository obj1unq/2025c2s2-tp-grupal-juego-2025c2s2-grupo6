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
    marcadorDeVida.marcarEstadisticaDe(self)
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
  marcadorDeVida.marcarEstadisticaDe(self)
  }

  override method recibirDaño(cantidad){
    if(!self.tieneEscudoActivo()){
      super(cantidad)
    }
    marcadorDeVida.marcarEstadisticaDe(self)
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
      barraProgreso.marcarEstadisticaDe(self)
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
    marcadorDeVida.marcarEstadisticaDe(self)
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


class Marcador{

  var property image 
  method marcarEstadisticaDe(personaje){
    if(self.puntosARevisar() == 200){
      image = self.imagenTipoMarcador() + "100.png"
    } else if(self.puntosARevisar().between(180, 199)){
      image = self.imagenTipoMarcador()  + "90.png"
    } else if(self.puntosARevisar().between(160, 179)){
      image = self.imagenTipoMarcador()   + "80.png"
    } else if(self.puntosARevisar().between(140, 159)){
      image = self.imagenTipoMarcador()  + "70.png"
    } else if(self.puntosARevisar().between(120, 139)){
      image = self.imagenTipoMarcador()  + "60.png"
    } else if(self.puntosARevisar().between(100, 119)){
      image = self.imagenTipoMarcador()  + "50.png"
    } else if(self.puntosARevisar().between(80, 99)){
      image = self.imagenTipoMarcador()  + "40.png"
    } else if(self.puntosARevisar().between(60, 79)){
      image = self.imagenTipoMarcador()  + "30.png"
    } else if(self.puntosARevisar().between(40, 59)){
      image = self.imagenTipoMarcador()  + "20.png"
    } else if(self.puntosARevisar().between(20, 39)){
      image = self.imagenTipoMarcador()  + "10.png"
    } else {
      image = self.imagenTipoMarcador()  + "0.png"
    }
 }
  method imagenTipoMarcador(){
    return ""
  }
  method puntosARevisar() {
    return
}

}

object marcadorDeVida inherits Marcador(image = "vida 100.png") {
  const property position = game.at(0, 9)
  method text() {
    return lille.vida().toString()
  }
  method textColor() = paleta.colorDeTexto()

  method estadoEscudoDe(personaje) {
    if(personaje.tieneEscudoActivo()){
      return " escudo"
    } else {
      return ""
    }
  }

  override method imagenTipoMarcador() {
    return "vida" + self.estadoEscudoDe(lille)
  }

  override method puntosARevisar(){
    return lille.vida() * 2
  }


}


class Barrita inherits Marcador{
  method color()
  override method puntosARevisar(){
    return lille.puntosObtenidos()
  }
  override method imagenTipoMarcador() {
    return "progreso" + self.color()
  }

}

object barraProgreso inherits Barrita(image = "progreso" + self.color() + "0.png") {
  const property position = game.at(7, 1)
   override method puntosARevisar() = lille.puntosObtenidos()
   override method color() {
    return "amarillo"
  }
}


object barraVidaEnemigo inherits Barrita(image = "progreso" + self.color() + "0.png") {
   override method puntosARevisar() = wizardd.vida()
   override method color() {
    return "rojo"
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
