object casaDePepeYJulian {

	var property montoReparacion = 0
	var property porcentajeViveres = 50
	var property estrategia
	var property cuentaAsignada

	method estaEnOrden() = not self.hayQueHacerReparaciones() && self.tieneViveresSuficientes()

	method hayQueHacerReparaciones() = montoReparacion > 0

	method tieneViveresSuficientes() = porcentajeViveres >= 40

	method porcentajeAComprar() = estrategia.porcentajeDeEstrategiaDeAhorroPara(self)

	method comprarViveres() {
		porcentajeViveres += self.porcentajeAComprar()
	}

	method gastar(cuanto) {
		cuentaAsignada.extraer(cuanto)
	}

	method mantenerCasa() {
		self.comprarViveres()
		cuentaAsignada.extraer(self.porcentajeAComprar() * estrategia.calidad())
		estrategia.hacerReparacionesPara(self)
	}

	method romperAlgoDe(cuanto) {
		montoReparacion += cuanto
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

	var property cuentaPrimaria
	var property cuentaSecundaria
	var property saldo = 0

	method saldo() = cuentaPrimaria.saldo() + cuentaSecundaria.saldo()

	method depositar(cuanto) {
		cuentaPrimaria.depositar(cuanto)
	}

	method extraer(cuanto) {
		if (cuentaPrimaria.saldo() <= cuanto) {
			cuentaSecundaria.extraer(cuanto)
		} else cuentaPrimaria.extraer(cuanto)
	}

}

object indispensable {

	var property calidad = 0

	method porcentajeDeEstrategiaDeAhorroPara(casa) = self.porcentajeAComprarPara(casa) * calidad

	method porcentajeAComprarPara(casa) = (self.porcentajeMinimoViveres() - casa.porcentajeViveres()) / calidad

	method porcentajeMinimoViveres() = 40

	method hacerReparacionesPara(casa) {
	// NO TIENE COMPORTAMIENTO 
	}

}

object full {

	const property calidad = 5

	method porcentajeDeEstrategiaDeAhorroPara(casa) {
		if (casa.estaEnOrden()) {
			return self.porcentajeAComprarPara(casa)
		} else return 40
	}

	method porcentajeAComprarPara(casa) = self.porcentajeFullViveres() - casa.porcentajeViveres()

	method porcentajeFullViveres() = 100

	method hacerReparacionesPara(casa) {
		if ((casa.cuentaAsignada().saldo() - casa.montoReparacion()) > 1000) {
			casa.cuentaAsignada().extraer(casa.montoReparacion())
			casa.montoReparacion(0)
		}
	}

}

