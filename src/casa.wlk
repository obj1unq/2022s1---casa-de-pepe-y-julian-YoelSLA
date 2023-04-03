object casaDePepeYJulian {

	var property montoReparacion = 0
	var property porcentajeViveres = 50
	var property estrategia = indispensable
	var property cuentaAsignada = cuentaCorriente

	method hayQueHacerReparaciones() = montoReparacion > 0

	method tieneViveresSuficientes() = porcentajeViveres >= 40

	method estaEnOrden() = not self.hayQueHacerReparaciones() && self.tieneViveresSuficientes()

	method porcentajeAComprar() = estrategia.estrategiaDeAhorroPara(self)

	method gastar(cuanto) {
		cuentaAsignada.extraer(cuanto)
	}

	method comprarViveres() {
		porcentajeViveres += self.porcentajeAComprar()
	}

	method romperAlgoDe(cuanto) {
		montoReparacion += cuanto
	}

	method mantenerCasa() {
		self.comprarViveres()
		cuentaAsignada.extraer(self.porcentajeAComprar() * estrategia.calidad())
		if (cuentaAsignada.saldo() + 1000 < montoReparacion) {
			cuentaAsignada.extraer(montoReparacion)
			montoReparacion = 0
		}
	}

}

object indispensable {

	var property calidad = 0

	method porcentajeMinimoViveres() = 40

	method estrategiaDeAhorroPara(casa) = self.porcentajeAComprarPara(casa) * self.calidad()

	method porcentajeAComprarPara(casa) = (self.porcentajeMinimoViveres() - casa.porcentajeViveres()) / self.calidad()

}

object full {

	const property calidad = 5

	method estrategiaDeAhorroPara(casa) {
		if (casa.estaEnOrden()) {
			return self.porcentajeAComprarPara(casa)
		} else return 40
	}

	method porcentajeAComprarPara(casa) = self.porcentajeFullViveres() - casa.porcentajeViveres()

	method porcentajeFullViveres() = 100

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

	var property cuentaPrimaria = cuentaDeGastos
	var property cuentaSecundaria = cuentaCorriente
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

