import asientos.*

class Sala {
	const property capacidad
	const property asientos
	const property funciones
	const property sistemaDeSonido
	
	method lugaresDisponibles() = capacidad - asientos.lugares().size()
	
	method tienePelicula(pelicula, horario) = funciones.any({ f => f.pelicula() == pelicula and f.horario() == horario })
	method tienePelicula(pelicula) = funciones.any({ f => f.pelicula() == pelicula })
	
	method obtenerHorarios(pelicula) {
		if (!self.tienePelicula(pelicula)) throw new Exception(message = "La película no está disponible en esta sala")
		return funciones
			.filter({ f => f.pelicula() == pelicula })
			.map({ f => f.horario() })
	}
	
	method comprarEntrada(pelicula) {
		if (self.lugaresDisponibles() <= 0) throw new Exception(message = "No hay lugares disponibles")
		return self.asientos().dameUnAsiento()
	}
	
	method costo(pelicula, horario) {
		var costo = 0
		costo += self.sistemaDeSonido().costo(self, pelicula)
		costo += self.asientos().costo(pelicula, horario)
		return costo
	}
	
	method costo(pelicula) {
		var costoTotal = 0
		self.obtenerHorarios(pelicula)
			.forEach({ h => costoTotal += self.costo(pelicula, h) })
		return costoTotal
	}
}
