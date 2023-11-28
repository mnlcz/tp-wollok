class Cine {
	const property salas
	
	method lugaresDisponibles(pelicula, sala, horario) {
		return sala.lugaresDisponibles(pelicula, horario)
	}
	
	method horariosDisponibles(pelicula) {
		 return salas.map({ s => s.obtenerHorarios(pelicula) })
		 			 .flatten()
		 			 .asSet()
	}
	
	method comprarEntrada(pelicula, horario) = 
		salas.filter({ s => s.tienePelicula(pelicula, horario) }).first().comprarEntrada(pelicula, horario)
		
	method costoEntrada(pelicula, horario) =
		salas.filter({ s => s.tienePelicula(pelicula, horario) }).first().costo(pelicula, horario)
		
	method recaudacion(pelicula) {
		return salas.sum({ s => s.recaudacion(pelicula) })
	}
			
	method cartelera() {
		return salas.flatMap({ s => s.funciones() })
					.map({ f => f.pelicula() })
					.asSet()
					.sortedBy({ a, b => self.recaudacion(a) > self.recaudacion(b) })
	}
}
