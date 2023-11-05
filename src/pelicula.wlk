class Pelicula {
	const property titulo
	const property genero
	var property fecha
	const property duracion
	
	method esLarga() {
		if (genero == "Infantil") return duracion.horas() >= 1 and duracion.minutos() > 29
		if (genero == "Ciencia Ficción") return duracion.horas() >= 2
		return duracion.horas() > 3
	}
	
	override method toString() = titulo
}
