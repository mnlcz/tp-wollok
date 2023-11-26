class Cine {
	const property salas
	
	method lugaresDisponibles(pelicula, sala) {
		if (salas.contains(sala) and sala.tienePelicula(pelicula)) return sala.lugaresDisponibles()
		else throw new Exception(message = "Sala inválida")
	}
	
	method horariosDisponibles(pelicula) {
		 return salas.filter({ s => s.tienePelicula(pelicula) })
		 			 .map({ s => s.obtenerHorarios(pelicula) })
		 			 .flatten()
		 			 .asSet()
	}
	
	// Por el enunciado se asume que la venta y disponibilidad es válida siempre
	method comprarEntrada(pelicula, horario) = 
		salas.filter({ s => s.tienePelicula(pelicula, horario) }).first().comprarEntrada(pelicula)
		
	/* 
	 * Se asume que una pelicula X en un horario Y solo está disponible en una sala.
	 * En caso de que esto no sea así, costoEntrada podría devolver un Dictionary,
	 * siendo la clave la sala y el valor el costo de la película en esa sala
	 */
	method costoEntrada(pelicula, horario) =
		salas.filter({ s => s.tienePelicula(pelicula, horario) }).first().costo(pelicula, horario)
		
	method recaudacion(pelicula) =
		salas.filter({ s => s.tienePelicula(pelicula) })
			 .map({ s => s.costo(pelicula) * s.asientos().ocupados() })
			 .sum()
			
	method cartelera() {
		return salas.flatMap({ s => s.funciones() })
					.map({ f => f.pelicula() })
					.asSet()
					.sortedBy({ a, b => self.recaudacion(a) > self.recaudacion(b) })
	}
}
