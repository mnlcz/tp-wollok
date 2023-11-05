class Asientos {
	const property numerados
	const property lugares
	
	method ultimoNumeroOcupado() =
		if (lugares.isEmpty()) 0 else lugares.sortedBy({ a, b => a < b }).last()
}

/*
 * Los asientos ocupados son independientes de la pelicula, se asume que al terminar la película
 * se "liberan", es decir, se asume que no va a haber colisión de comprar simultaneamente 2 películas
 * distintas para la misma sala. En caso de que haya que tener en cuenta esto hay que redefinir la clase 
 * para que los asientos tengan un enlace con cada pelicula y que la compra de la entrada reduzca los 
 * asientos solamente para X pelicula en Y horario.
 */
class Sala {
	const property capacidad
	const property asientos
	const property peliculas
	const property sistemaDeSonido
	
	method lugaresDisponibles() = capacidad - asientos.lugares().size()
	
	method tienePelicula(pelicula, horario) = peliculas.any({ p => p.get(0) == pelicula and p.get(1) == horario })
	method tienePelicula(pelicula) = peliculas.any({ p => p.get(0) == pelicula })
	
	method obtenerHorarios(pelicula) {
		if (!self.tienePelicula(pelicula)) throw new Exception(message = "La película no está disponible en esta sala")
		return peliculas
			.filter({ p => p.get(0) == pelicula })
			.map({ p => p.get(1) })
	}
	
	method comprarEntrada(pelicula) {
		if (!self.tienePelicula(pelicula)) throw new Exception(message = "La película no está disponible en esta sala")
		if (self.lugaresDisponibles() <= 0) throw new Exception(message = "No hay lugares disponibles")
		if (asientos.numerados()) {
			asientos.lugares().add(asientos.ultimoNumeroOcupado() + 1)
			return "Asiento nro: " + asientos.ultimoNumeroOcupado().toString()
		} else {
			asientos.lugares().add(0)
			return "Entrada general"
		}
	}
	
	method costo(pelicula, horario) {
		var costo = 0
		if (sistemaDeSonido == "Dolby super surround 8.12") {
			if (capacidad < 150) costo += 1 else costo += 2
		} else if (sistemaDeSonido == "Qwert 360 XWF") {
			costo += pelicula.titulo().replace(" ", "").size() * 0.1
		}
		
		if (!asientos.numerados()) {
			if (pelicula.esLarga()) costo += 3 else costo += 2
		} else {
			if (horario.horas() < 18) costo += 2 else costo += 3
		}
		return costo
	}
	
	method costo(pelicula) {
		var costoTotal = 0
		self.obtenerHorarios(pelicula)
			.forEach({ h => costoTotal += self.costo(pelicula, h) })
		return costoTotal
	}
}
