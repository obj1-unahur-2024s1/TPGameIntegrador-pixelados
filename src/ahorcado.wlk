import wollok.game.*
import teclado.*

object juego{
	var property nivel = 1
	var property vidas = 6
	var property aciertos = 0
	var property errores = 0
	var property juegoIniciado = false
	var property palabraActiva
		
	const pizarraNivel1 = new Fondo(image="fondos/pizarra1.png")
	const pizarraNivel2 = new Fondo(image="fondos/pizarra2.png")
	const pizarraNivel3 = new Fondo(image="fondos/pizarra3.png")
	
	const horca = new Elemento(image="horca/horca.png",position=game.at(0,4))
	
	const guiones1 = new Elemento(image="letras/3guiones.png",position=game.at(3,0))
	const guiones2 = new Elemento(image="letras/4guiones.png",position=game.at(3,0))
	const guiones3 = new Elemento(image="letras/5guiones.png",position=game.at(3,0))
		
    
     method iniciar(){
        game.width(15)
        game.height(10)
        game.cellSize(64)
        game.title("Ahorcado")
        game.addVisual(menu)
        menu.animacion()
        teclado.configuracion()
        game.start()
    }   
    
    method reiniciar(){
    	vidas = 6
    	errores = 0
    	aciertos = 0
    }
   
    method iniciarNivel1(){
    	const screenNivel1 = new Fondo(image="fondos/nivel1.png")
    	const palabraNivel1 = new Palabra(dificultad=1)
    	game.removeVisual(menu)
    	game.removeTickEvent("menu")
    	game.addVisual(new Fondo(image="fondos/instrucciones.png"))
    	game.schedule(3000,{
    						palabraActiva = palabraNivel1.elegirPalabra()
    						game.addVisual(screenNivel1)
    						game.removeVisual(screenNivel1)
					    	game.addVisual(pizarraNivel1)
					    	game.addVisual(horca)
					    	game.addVisual(guiones1)
					    	self.juegoIniciado(true)})
    }
    
    method iniciarNivel2(){
    	const screenNivel2 = new Fondo(image="fondos/nivel2.png")
    	const palabraNivel2 = new Palabra(dificultad=2)
    	self.juegoIniciado(false)
    	nivel = 2
    	game.schedule(1000,{
    		palabraActiva = palabraNivel2.elegirPalabra()
    		game.removeVisual(pizarraNivel1)
    		game.removeVisual(horca)
    		game.removeVisual(guiones1)
    		game.addVisual(screenNivel2)
    		self.reiniciar()
    		game.schedule(2000,{
    			game.removeVisual(screenNivel2)
    			game.addVisual(pizarraNivel2)
    			game.addVisual(horca)
				game.addVisual(guiones2)
				self.juegoIniciado(true)
    		})
    	})
    }
    
    method iniciarNivel3(){
    	const screenNivel3 = new Fondo(image="fondos/nivel3.png")
    	const palabraNivel3 = new Palabra(dificultad=3)
    	self.juegoIniciado(false)
    	nivel = 3
    	game.schedule(1000,{
    		palabraActiva = palabraNivel3.elegirPalabra()
    		game.removeVisual(pizarraNivel2)
    		game.removeVisual(horca)
    		game.removeVisual(guiones2)
    		game.addVisual(screenNivel3)
    		self.reiniciar()
    		game.schedule(2000,{
    			game.removeVisual(screenNivel3)
    			game.addVisual(pizarraNivel3)
    			game.addVisual(horca)
				game.addVisual(guiones3)
				self.juegoIniciado(true)
    		})
    	})
    }
    
    method hay_EnPalabra(letra){
    	if(palabraActiva.contains(letra)){
    		self.colocarLetra(letra)
    		aciertos += 1
    		if(self.nivel()==1 and aciertos==3){
    			self.iniciarNivel2()
    		}
    		else if (self.nivel()==2 and aciertos==4){
    			self.iniciarNivel3()
    		}
    		else if(aciertos==5){
    			game.clear()
    			self.ganaste()
    		}
    	}else{
    		self.letraErronea(letra)
    		if(vidas == 0){
    			game.schedule(500,{self.perdiste()})
    		}else{
    			errores+=1
    		}
    	}
    }
    
     method letraErronea(letra){
    	const unaLetra = new Letra(position=game.at(3,1),image="")
    	vidas -= 1
    	game.addVisual(new Elemento(image="horca/vidas" + self.vidas().toString() + ".png",position=game.at(0,4)))
    	game.addVisual(new Letra(image="letras/"+letra+".png",position=unaLetra.posErroneas().get(errores)))
    }
    
    method colocarLetra(letra){
    	const letraAcertada = 
			    		if (self.nivel()==1){
			    			new Letra(image="letras/"+letra+".png",
			    				position=
			    					if(palabraActiva.charAt(0)==letra) game.at(3,1)
			    					else if (palabraActiva.charAt(1)==letra) game.at(5,1)
			    					else game.at(7,1)
			    			)
			    		}else if (self.nivel()==2){
			    			new Letra(image="letras/"+letra+".png",
			    				position=
			    					if(palabraActiva.charAt(0)==letra) game.at(3,1)
			    					else if (palabraActiva.charAt(1)==letra) game.at(5,1)
			    					else if (palabraActiva.charAt(2)==letra) game.at(7,1)
			    					else game.at(9,1)
			    			)
			    		}else{
			    			new Letra(
								image="letras/" + letra + ".png",
								position =
									if (palabraActiva.charAt(0)==letra) game.at(3,1)
									else if (palabraActiva.charAt(1)==letra) game.at(5,1)
									else if (palabraActiva.charAt(2)==letra) game.at(7,1)
									else if (palabraActiva.charAt(3)==letra) game.at(9,1)
									else game.at(11,1)
							)
			    		}
			    		
    	game.addVisual(letraAcertada)
    }
    
   
    
    method ganaste(){
    	game.clear()
    	game.addVisual(new Fondo(image="fondos/ganaste.png"))
    }
    
    method perdiste(){
    	game.clear()
    	game.addVisual(new Fondo(image="fondos/perdiste.png"))
    	game.schedule(3000,{game.stop()})
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

class Palabra{
	var property dificultad
	const nivel1 = ["sol", "mar", "pan", "luz", "pie", "rey", "hoy", "paz", "ley"]
	const nivel2 = ["amor","azul","luna","flor","vino","copa","gato","risa","sola","pelo","malo","mesa","nube","pato","rosa"]
	const nivel3 = ["amigo","avion","bravo","calor","fresa","ganso","huevo","mango","noche","queso","tango"]
	
	method elegirPalabra() = 
		if(dificultad==1) nivel1.anyOne()
		else if(dificultad==2) nivel2.anyOne()
		else nivel3.anyOne()
}

class Letra{
	var property position
	var property image
	
	const property posErroneas = [game.at(7,7),game.at(9,7),game.at(11,7),game.at(7,5),game.at(9,5),game.at(11,5)]
}
