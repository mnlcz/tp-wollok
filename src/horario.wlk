class Horario {
	const property horas
	const property minutos
	
	override method toString() = "Horas: " + horas.toString() + ". Minutos: " + minutos.toString()
	override method ==(other) = self.horas() == other.horas() and self.minutos() == other.minutos()
}
