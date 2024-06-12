import wollok.game.*
import teclado.*

const screenNivel1 = new Fondo(img="fondos/nivel1.png")
const screenNivel2 = new Fondo(img="fondos/nivel2.png")
const screenNivel3 = new Fondo(img="fondos/nivel3.png")
const pizarraNivel1 = new Fondo(img="fondos/pizarra1.png")
const pizarraNivel2 = new Fondo(img="fondos/pizarra2.png")
const pizarraNivel3 = new Fondo(img="fondos/pizarra3.png")
const menu = new Menu(img="")

const palabraNivel1 = new Palabra(dificultad=1)
const palabraNivel2 = new Palabra(dificultad=2)
const palabraNivel3 = new Palabra(dificultad=3)

const unaLetra = new Letra(position=game.at(3,1),img="")

const horca = new Fondo(img="horca/horca.png",position=game.at(0,4))
const guiones1 = new Elemento(img="letras/3guiones.png",position=game.at(3,0))
const guiones2 = new Elemento(img="letras/4guiones.png",position=game.at(3,0))
const guiones3 = new Elemento(img="letras/5guiones.png",position=game.at(3,0))


object juego{
	var nivel = 1
	var vidas = 5
	var aciertos = 0
	var errores = 0
	var property juegoIniciado = false
	var palabraActiva
	
    method nivel() = nivel
    method vidas() = vidas
    method aciertos() = aciertos
    method errores() = errores
    method palabraActivda() = palabraActiva
    
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
    
     method tablero(){
    	game.removeVisual(screenNivel1)
    	palabraActiva = palabraNivel1.elegirPalabra()
    	game.addVisual(pizarraNivel1)
    	game.addVisual(horca)
    	game.addVisual(guiones1)
    	self.juegoIniciado(true)
    }
    
    method iniciarNivel1(){
    	game.removeVisual(menu)
    	game.removeTickEvent("menu")
    	game.addVisual(screenNivel1)
    	game.schedule(2000,{self.tablero()})
    }
    
    method iniciarNivel2(){
    	self.juegoIniciado(false)
    	nivel = 2
    	game.schedule(1000,{
    		palabraActiva = palabraNivel2.elegirPalabra()
    		game.removeVisual(pizarraNivel1)
    		game.removeVisual(horca)
    		game.removeVisual(guiones1)
    		game.addVisual(screenNivel2)
    		vidas = 5
    		errores = 0
    		aciertos = 0
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
    	self.juegoIniciado(false)
    	nivel = 3
    	game.schedule(1000,{
    		palabraActiva = palabraNivel3.elegirPalabra()
    		game.removeVisual(pizarraNivel2)
    		game.removeVisual(horca)
    		game.removeVisual(guiones2)
    		game.addVisual(screenNivel3)
    		vidas = 5
    		errores = 0
    		aciertos = 0
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
    		if(self.nivel()==1 and aciertos==3){self.iniciarNivel2()}
    		else if (self.nivel()==2 and aciertos==4){self.iniciarNivel3()}
    		else if(aciertos==5){
    			game.clear()
    			self.ganaste()
    		}
    	}else{
    		self.letraErronea(letra)
    	}
    }
    
    method colocarLetra(letra){
    	const letraAcertada = 
    		if (self.nivel()==1){
    			new Letra(img="letras/"+letra+".png",
    				position=
    					if(palabraActiva.charAt(0)==letra) game.at(3,1)
    					else if (palabraActiva.charAt(1)==letra) game.at(5,1)
    					else game.at(7,1)
    			)
    		}else if (self.nivel()==2){
    			new Letra(img="letras/"+letra+".png",
    				position=
    					if(palabraActiva.charAt(0)==letra) game.at(3,1)
    					else if (palabraActiva.charAt(1)==letra) game.at(5,1)
    					else if (palabraActiva.charAt(2)==letra) game.at(7,1)
    					else game.at(9,1)
    			)
    		}else{
    			new Letra(
					img="letras/" + letra + ".png",
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
    
    method letraErronea(letra){
    	if(vidas!=0){
    		vidas = vidas-1
    		game.addVisual(new Letra(img="letras/"+letra+".png",position=unaLetra.posErroneas().get(errores)))
    		errores +=1
    	}else{
    		self.perdiste()
    	}
    }
    
    method ganaste(){
    	game.clear()
    	game.addVisual(new Fondo(img="fondos/pizarra1.png"))
    }
    
    method perdiste(){
    	game.clear()
    	game.addVisual(new Fondo(img="fondos/pizarra2.png"))
    }
  
}

class Elemento{
	var property position = game.origin()
	var img
	
	method image()=img
}

class Fondo inherits Elemento{
	
}


class Ahorcado inherits Elemento{
	override method image() = "horca/vidas" + juego.vidas() + ".png"
}

class Menu inherits Fondo{
	var foto = 1
	
	override method image() = "fondos/menu"+ foto +".png"
	
	method animacion(){
		game.onTick(300,"menu",{foto = if(foto<6) foto+1 else 1})
	}
}

class Palabra{
	var property dificultad
	const nivel1 = ["luz","mar"]
	const nivel2 = ["sapo","pico"]
	const nivel3 = ["monte","juego"]
	
	method elegirPalabra() = 
		if(dificultad==1) nivel1.anyOne()
		else if(dificultad==2) nivel2.anyOne()
		else nivel3.anyOne()
}

class Letra{
	var property position
	var img
	
	const property posErroneas = [game.at(7,7),game.at(9,7),game.at(11,7),game.at(7,5),game.at(9,5),game.at(11,5)]
	method image()=img
}
