import wollok.game.*
import teclado.*

object juego{
	var property nivel = 1
	var property vidas = 6
	var property aciertos = 0
	var property errores = 0
	var property juegoIniciado = false
	var property palabraActiva = ""
	const property letrasSeleccionadas = []
	const property instrucciones = new Fondo(image="fondos/instrucciones.png")
	const property horca = new Elemento(image="horca/horca.png",position=game.at(0,4))
	var property cancionActiva 
	const property posErroneas = [game.at(7,7),game.at(9,7),game.at(11,7),game.at(7,5),game.at(9,5),game.at(11,5)]
	const niveles = [nivel1,nivel2,nivel3,pantallaFinal]
	
	method seAcertoPalabra() = palabraActiva.size()==aciertos 
	
    method iniciar(){
        game.width(15)
        game.height(10)
        game.cellSize(64)
        game.title("Ahorcado")
        game.addVisual(menu)
        menu.animacion()
        teclado.configuracion()
        self.cancionActiva(nivel1.cancion())
        game.schedule(0, { self.cancionActiva().play()} )
		self.cancionActiva().shouldLoop(true)
		self.cancionActiva().volume(0.3)
        game.start()
    }   
    
    method reiniciar(){
    	vidas = 6
    	errores = 0
    	aciertos = 0
    	letrasSeleccionadas.clear()
    }
    
    method perderVida(){vidas-=1}

    method hay_EnPalabra(letra){
    	if (palabraActiva.contains(letra) and errores!=6){
    		self.colocarLetra(letra)
    		aciertos += 1
    		if(self.seAcertoPalabra()){
    			niveles.get(nivel).iniciarNivel()
    		}
    	}else{
	    	errores +=1    			
    		self.letraErronea(letra)
    		if(errores==6){
    			game.schedule(500,{
	    			pantallaFinal.ganaste(false)
	    			pantallaFinal.iniciarNivel()    				
    			})
    		}
    	}
    }
    
     method letraErronea(letra){
    	self.perderVida()
    	game.addVisual(new Elemento(image="horca/vidas" + self.vidas().toString() + ".png",position=game.at(0,4)))
    	game.addVisual(new Letra(image="letras/"+letra+".png",position=self.posErroneas().get(errores-1)))
    	game.sound("sonidos/pifia.mp3").play()
    }
    
    method colocarLetra(letra){
		const positionY = palabraActiva.indexOf(letra.toString())*2 + 3
		const letraAcertada = new Letra(image = "letras/"+letra+".png", position = game.at(positionY,1))
		game.sound("sonidos/tiza.mp3").play()	    		
    	game.addVisual(letraAcertada)
    }
}

object pantallaFinal{
	var property ganaste = true
	
	method position() = game.origin()
	method image() = if(ganaste) "fondos/ganaste.png" else "fondos/perdiste.png"
	method sonido(){
		juego.cancionActiva().stop()
		juego.cancionActiva(game.sound(if(ganaste) "sonidos/victoria.mp3" else "sonidos/derrota.mp3"))	
    	game.schedule(0, { juego.cancionActiva().play()} )
    	juego.cancionActiva().volume(0.7)
    	game.schedule(7000,{game.stop()})
	}
	method iniciarNivel(){
		game.clear()
	   	game.addVisual(new Fondo(image = self.image()))
	    self.sonido()
	}
}

object nivel1{
	const palabras = ["sol", "mar", "pan", "luz", "pie", "rey", "hoy", "paz", "ley","gas","ola","uva","osa","mas","mil","usa","uso","tos","pez"]
	
	method cancion() = game.sound("sonidos/nivel1.mp3")
	
	method iniciarNivel(){	
		const screenNivel1 = new Fondo(image="fondos/nivel1.png")
	    	
	    game.removeVisual(menu)
	    game.removeTickEvent("menu")
	    game.addVisual(screenNivel1)
	    game.schedule(3000,{
	    					juego.palabraActiva(palabras.anyOne())
	    					game.removeVisual(screenNivel1)
						    game.addVisual(new Fondo(image="fondos/pizarra1.png"))
						    game.addVisual(letraInstrucciones)
						    game.addVisual(juego.horca())
						    game.addVisual(new Elemento(image="letras/3guiones.png",position=game.at(3,0)))
						    juego.juegoIniciado(true)})
	}
} 

 object nivel2{
 	const palabras = ["sapo","amor","azul","luna","flor","vino","copa","gato","risa","sola","pelo","malo","mesa","nube","pato","rosa","mufa","cosa","caso","cabj"]
 	
 	method cancion() = game.sound("sonidos/nivel2.mp3")
 	
 	method iniciarNivel(){
 		const screenNivel2 = new Fondo(image="fondos/nivel2.png")
    	
    	game.removeVisual(juego.horca())
    	juego.reiniciar()
    	juego.juegoIniciado(false)
    	juego.nivel(2)
    	juego.cancionActiva().stop()
    	juego.cancionActiva(self.cancion())
    	game.schedule(0, { juego.cancionActiva().play()} )
		juego.cancionActiva().volume(0.1)
		game.schedule(1000,{
    		juego.palabraActiva(palabras.anyOne())
    		game.removeVisual(letraInstrucciones)
    		game.addVisual(screenNivel2)
    		game.schedule(2000,{
    			game.removeVisual(screenNivel2)
    			game.addVisual(new Fondo(image="fondos/pizarra2.png"))
    			game.addVisual(letraInstrucciones)
    			game.addVisual(juego.horca())
				game.addVisual(new Elemento(image="letras/4guiones.png",position=game.at(3,0)))
				juego.juegoIniciado(true)
    		})
    	})
    	
 	}
 }

object nivel3{
	const palabras = ["poema","amigo","avion","bravo","calor","fresa","ganso","huevo","mango","noche","queso","tango","pecho","sopla","audio"]
	
	method cancion() = game.sound("sonidos/nivel3.mp3")
	
	method iniciarNivel(){
		const screenNivel3 = new Fondo(image="fondos/nivel3.png")
		
		juego.cancionActiva().stop()
    	juego.cancionActiva(self.cancion())
    	game.schedule(0, { juego.cancionActiva().play()} )
    	juego.cancionActiva().volume(0.1)
    	juego.juegoIniciado(false)
    	juego.nivel(3)
    	game.schedule(1000,{
    		juego.palabraActiva(palabras.anyOne())
    		game.removeVisual(letraInstrucciones)
    		game.removeVisual(juego.horca())
    		game.addVisual(screenNivel3)
    		juego.reiniciar()
    		game.schedule(2000,{
    			game.removeVisual(screenNivel3)
    			game.addVisual(new Fondo(image="fondos/pizarra3.png"))
    			game.addVisual(letraInstrucciones)
    			game.addVisual(juego.horca())
				game.addVisual(new Elemento(image="letras/5guiones.png",position=game.at(3,0)))
				juego.juegoIniciado(true)
    		})
    	})
	}
}

class Elemento{
	var property position = game.origin()
	var property image

}

class Fondo inherits Elemento{
	//clase abstracta para mejorar legibilidad
}

object menu{
	var foto = 1
	
	method position()= game.origin()
	
	method image() = "fondos/menu"+ foto.toString() +".png"
	
	method animacion(){
		game.onTick(300,"menu",{foto = if(foto<6) foto+1 else 1})
	}
}

class Letra inherits Elemento{
	//abstracta
}

object letraInstrucciones{
	const property position = game.at(game.width()-3,game.height()-2)
	method image() = "fondos/letraInstrucciones.png"
}