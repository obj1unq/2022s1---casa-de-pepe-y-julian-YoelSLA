object casaDePepeYJulian {

	var property porcentajeViveres = 50
	var property montoReparaciones = 0
	var property cuenta
	var property estrategiaDeAhorro

	method tieneViveresSuficientes() = porcentajeViveres > 40

	method hayQueHacerReparaciones() = montoReparaciones > 0

	method estaEnOrden() = !self.hayQueHacerReparaciones() && self.tieneViveresSuficientes()

	method gastar(cantidad) {
		cuenta.extraer(cantidad)
	}

	method romper(cantidad) {
		montoReparaciones += cantidad
	}

	method mantener() {
		estrategiaDeAhorro.hacerMantenimientoPara(self)
	}

	method comprarViveres() {
		self.gastar(self.porcentajeAComprar() * self.calidadAComprar())
		self.aumentarViveres()
	}

	method aumentarViveres() {
		porcentajeViveres += self.porcentajeAComprar()
	}

	method porcentajeAComprar() = estrategiaDeAhorro.porcentajeAComprarPara(self)

	method calidadAComprar() = estrategiaDeAhorro.calidad()

	method dineroRestanteAlHacerReparaciones() = cuenta.saldo() - montoReparaciones

	method arreglar() {
		self.gastar(montoReparaciones)
		montoReparaciones = 0
	}

}

object cuentaCorriente {

	var property saldo = 0

	method depositar(cuanto) {
		saldo += cuanto
	}

	method extraer(cuanto) {
		saldo -= cuanto
	}

}

object cuentaDeGastos {

	var property saldo = 0
	var property costoOperacion = 20

	method depositar(cuanto) {
		saldo += cuanto - costoOperacion
	}

	method extraer(cuanto) {
		saldo -= cuanto
	}

}

object cuentaCombinada {

	var property primaria
	var property secundaria

	method saldo() = primaria.saldo() + secundaria.saldo()

	method depositar(cuanto) {
		primaria.depositar(cuanto)
	}

	method extraer(cuanto) {
		if (primaria.saldo() >= cuanto) {
			primaria.extraer(cuanto)
		} else secundaria.extraer(cuanto)
	}

}

object minimoEIndispensable {

	var property calidad = 0

	method hacerMantenimientoPara(casa) {
		if (!casa.tieneViveresSuficientes()) {
			casa.comprarViveres()
		}
	}

	method porcentajeAComprarPara(casa) = self.porcentajeDeViveresPara(casa) * calidad

	method porcentajeDeViveresPara(casa) = (40 - casa.porcentajeViveres()) / calidad

}

object full {

	const property calidad = 5

	method hacerMantenimientoPara(casa) {
		casa.comprarViveres()
		self.reparar(casa)
	}

	method porcentajeAComprarPara(casa) {
		return if (casa.estaEnOrden()) {
			100 - casa.porcentajeViveres()
		} else 40
	}

	method reparar(casa) {
		if (casa.dineroRestanteAlHacerReparaciones() > 1000) {
			casa.arreglar()
		}
	}

}

