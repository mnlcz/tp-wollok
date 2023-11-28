class Asientos {
	const property lugares = []
		
	method dameUnAsiento() {
		self.lugares().add(0)
		return "Entrada general"
	}
	
	method costo(pelicula, horario) = 0
	
	method ocupados() = self.lugares().size()
	
	override method toString() = "Ocupados: " + self.ocupados()
}

class AsientosNumerados inherits Asientos {
	method ultimoNumeroOcupado() =
		if (lugares.isEmpty()) 0 else lugares.sortedBy({ a, b => a < b }).last()
		
	override method dameUnAsiento() {
		self.lugares().add(self.ultimoNumeroOcupado() + 1)
		return "Asiento nro: " + self.ultimoNumeroOcupado().toString()
	}
	
	override method costo(pelicula, horario) = if (horario.horas() < 18) 2 else 3
}
