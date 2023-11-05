class Cine {
	const property salas
	
	method lugaresDisponibles(pelicula, sala, horario) {
		if (salas.contains(sala) and sala.tienePelicula(pelicula)) return sala.lugaresDisponibles()
		else return 0
	}
	
	method horariosDisponibles(pelicula) {
		const horarios = #{}
		salas.forEach({ s => {
			if (s.tienePelicula(pelicula)) {
				s.obtenerHorarios(pelicula).forEach({ h => horarios.add(h) })
			}
		}.apply()})
		return horarios
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
			 .map({ s => s.costo(pelicula) })
			 .sum()
			
	method cartelera() {
		const peliculas = []
		salas.map({ s => s.peliculas() })
			 .forEach({ x => peliculas.addAll(x) })
		return peliculas.map({ x => x.get(0) })
						.asSet()
						.sortedBy({ a, b => self.recaudacion(a) > self.recaudacion(b) })
	}
}
