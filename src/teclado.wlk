import wollok.game.*
import ahorcado.*

object teclado{
	method configuracion(){
		keyboard.a().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("a")
			}
		}
		keyboard.b().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("b")
			}
		}
		keyboard.c().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("c")
			}
		}
		keyboard.d().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("d")
			}
		}
		keyboard.e().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("e")
			}
		}
		keyboard.f().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("f")
			}
		}
		keyboard.g().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("g")
			}
		}
		keyboard.h().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("h")
			}
		}
		keyboard.i().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("i")
			}
		}
		keyboard.j().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("j")
			}
		}
		keyboard.k().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("k")
			}
		}
		keyboard.l().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("l")
			}
		}
		keyboard.m().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("m")
			}
		}
		keyboard.n().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("n")
			}
		}
		keyboard.o().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("o")
			}
		}
		keyboard.p().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("p")
			}
		}
		keyboard.q().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("q")
			}
		}
		keyboard.r().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("r")
			}
		}
		keyboard.s().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("s")
			}
		}
		keyboard.t().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("t")
			}
		}
		keyboard.u().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("u")
			}
		}
		keyboard.v().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("v")
			}
		}
		keyboard.w().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("w")
			}
		}
		keyboard.x().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("x")
			}
		}
		keyboard.y().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("y")
			}
		}
		keyboard.z().onPressDo{
			if (juego.juegoIniciado()){
				juego.hay_EnPalabra("z")
			}
		}
		
		keyboard.enter().onPressDo{
			
			juego.iniciarNivel1()
		}
	}
}