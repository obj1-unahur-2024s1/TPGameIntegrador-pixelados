import wollok.game.*

object juego{
    method iniciar(){
        game.width(15)
        game.height(10)
        game.cellSize(64)
        game.boardGround("pizarra.jpg")
        game.title("Ahorcado")
        game.start()
<<<<<<< HEAD
    }    
=======
    }    
}

keyboard.a().OnPressDo({
  if (unaPalabra.contains("a")){
    letra.colocarLetra("a")
  }else{
    letra.letraErronea("a")
  }
)}


class Letra {
  method colocarLetra(letra, palabra){
    position =
      if (palabra.charAt(0) == letra) game.at(3,5)
      else if ((palabra.charAt(1) == letra) game.at(4,5)
      else if ((palabra.chatAt(2) == letra) game.at(5,5)
      else if ((palabra.chatAt(3) == letra) game.at(6,5)
      else game.at(7,5)
  }
}
>>>>>>> 2e7d8bbfa36346ccc6c3388171104c19bbe693cf