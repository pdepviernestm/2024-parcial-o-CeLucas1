
object configuracionEmociones {
    var property valorIntensidadElevada = 50
}

class Emocion {
    var property intensidad 
    var eventosExperimentados = 0
    var property puedeSerLiberada = true
    
    method experimentarEvento(evento) {
        eventosExperimentados= eventosExperimentados +1
        if (puedeSerLiberada && self.puedeLiberar()) {
            self.liberar(evento)
            puedeSerLiberada = false
        }
    }
     method puedeLiberar()
    
    method liberar(evento) {
        self.disminuirIntensidad(evento.impacto())
    }
    
    method disminuirIntensidad(cantidad) {
        intensidad = (intensidad - cantidad).max(0)
    }
    
    method intensidadElevada() = intensidad >  configuracionEmociones.valorIntensidadElevada()
    
    method cantidadEventos() = eventosExperimentados
    
    
}

class Furia inherits Emocion {
    var property palabrotas = [] 

    override method initialize() {
        intensidad = 100
    }
    override method puedeLiberar() = 
        self.intensidadElevada() && 
        palabrotas.any{ palabrota => palabrota.size() > 7 }
    
    override method liberar(evento) {
        super(evento)
        if(palabrotas.size() > 0) {
            palabrotas.remove(palabrotas.first())
        }
    }
    
    method aprenderPalabrota(palabrota) {
        palabrotas.add(palabrota)
    }
    
    method olvidarPalabrota(palabrota) {
        palabrotas.remove(palabrota)
    }
}

class Alegria inherits Emocion {

    override method puedeLiberar() = 
        self.intensidadElevada() && 
        eventosExperimentados % 2 == 0
        
    override method disminuirIntensidad(cantidad) {
        intensidad = (intensidad - cantidad).abs()
    }
}

class Tristeza inherits Emocion {
    var property causa = "melancolía"
    
    override method puedeLiberar() = 
        self.intensidadElevada() && 
        causa != "melancolía"
        
    override method liberar(evento) {
        super(evento)
        causa = evento.descripcion()
    }
}

class DesagradoTemor inherits Emocion {
    override method puedeLiberar() = 
        self.intensidadElevada() && 
        eventosExperimentados > intensidad
}

class Ansiedad inherits Emocion {
    var nivelEstres = 0
    
    override method puedeLiberar() = 
        self.intensidadElevada() && 
        nivelEstres > 80
        
    override method liberar(evento) {
        super(evento)
        nivelEstres = 0
    }
    
    method aumentarEstres(cantidad) {
        nivelEstres = (nivelEstres + cantidad).min(100)
    }
}
class Evento{
const property impacto 
const property descripcion
}

