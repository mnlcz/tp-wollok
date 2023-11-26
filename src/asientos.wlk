class Asientos {
	const property lugares = []
	
	method ultimoNumeroOcupado() =
		if (lugares.isEmpty()) 0 else lugares.sortedBy({ a, b => a < b }).last()
		
	method dameUnAsiento() {
		self.lugares().add(0)
		return "Entrada general"
	}
	
	method costo(pelicula, horario) = if (horario.horas() < 18) 2 else  3
	
	method ocupados() = self.lugares().size()
}

class AsientosNumerados inherits Asientos {
	override method dameUnAsiento() {
		self.lugares().add(self.ultimoNumeroOcupado() + 1)
		return "Asiento nro: " + self.ultimoNumeroOcupado().toString()
	}
	
	override method costo(pelicula, horario) = if (horario.horas() < 18) 2 else 3
}
