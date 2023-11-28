import asientos.*

class Sala {
	const property capacidad
	const property funciones
	const property sistemaDeSonido
	
	method buscarFuncion(pelicula, horario) {
		return funciones.find({ f => f.pelicula() == pelicula and f.horario() == horario })
	}
	
	method lugaresDisponibles(pelicula, horario) {
		const ocupados = self.buscarFuncion(pelicula, horario).asientos().ocupados()
		return self.capacidad() - ocupados
	}
	
	method tienePelicula(pelicula, horario) = funciones.any({ f => f.pelicula() == pelicula and f.horario() == horario })
	method tienePelicula(pelicula) = funciones.any({ f => f.pelicula() == pelicula })
	
	method obtenerHorarios(pelicula) {
		return funciones.filter({ f => f.pelicula() == pelicula })
						.map({ f => f.horario() })
	}
	
	method comprarEntrada(pelicula, horario) {
		const funcion = self.buscarFuncion(pelicula, horario)
		if (self.lugaresDisponibles(pelicula, horario) <= 0) throw new Exception(message = "No hay lugares disponibles")
		return funcion.asientos().dameUnAsiento()
	}
	
	method costo(pelicula, horario) {
		const funcion = self.buscarFuncion(pelicula, horario)
		return pelicula.costo() + self.sistemaDeSonido().costo(self, pelicula) + funcion.asientos().costo(pelicula, horario)
	}
	
	method costo(pelicula) {
		var costoTotal = 0
		self.obtenerHorarios(pelicula)
			.forEach({ h => costoTotal += self.costo(pelicula, h) })
		return costoTotal
	}
	
	method entradasVendidas(pelicula) =
		self.funciones().filter({ f => f.pelicula() == pelicula }).sum({ f => f.asientos().ocupados() })
	
	method recaudacion(pelicula) = self.costo(pelicula) * self.entradasVendidas(pelicula)
}
