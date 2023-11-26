object dolby {
	const property nombre = "Dolby super surround 8.12"
	
	method costo(sala, pelicula) = if (sala.capacidad() < 150) 1 else 2
}

object qwert {
	const property nombre = "Qwert 360 XWF"
	
	method costo(sala, pelicula) = pelicula.titulo().replace(" ", "").size() * 0.1
}

object estandar {
	const property nombre = "Estandar"
	
	method costo(sala, pelicula) = 0
}