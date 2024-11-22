import emociones.*

class Persona {
    const property emociones = []
    const property edad
    
    method esAdolescente() = edad.between(12, 18)
    
    method agregarEmocion(emocion) {
        emociones.add(emocion)
    }
    
    method porExplotar() = 
        emociones.all{ emocion => emocion.puedeSerLiberada() }
    
    method vivirEvento(evento) {
        emociones.forEach{ emocion => emocion.experimentarEvento(evento) }
    }
}


