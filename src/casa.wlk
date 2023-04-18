object casaDePepeYJulian {

	var cuenta
	var estrategiaDeAhorro
	var property montoReparaciones = 0
	var property porcentajeViveres = 50

	// @public Boolean
	method estaEnOrden() = !self.hayQueHacerReparaciones() && self.hayViveresSuficientes()

	// @public Boolean
	method hayQueHacerReparaciones() = montoReparaciones > 0

	// @public Boolean
	method hayViveresSuficientes() = porcentajeViveres > 40

	// @public void
	method arreglar() {
		self.gastar(montoReparaciones)
		montoReparaciones = 0
	}

	// @public void
	method comprarViveres() {
		self.gastar(self.porcentajeAComprar() * estrategiaDeAhorro.calidad())
		self.aumentarViveres()
	}

	// @public void
	method cuenta(_cuenta) {
		cuenta = _cuenta
	}

	// @public void
	method estrategiaDeAhorro(_estrategiaDeAhorro) {
		estrategiaDeAhorro = _estrategiaDeAhorro
	}

	// @public void
	method gastar(cantidad) {
		cuenta.extraer(cantidad)
	}

	// @public void
	method mantener() {
		estrategiaDeAhorro.hacerMantenimientoPara(self)
	}

	// @public void
	method reparar() {
		if (self.dineroRestanteAlHacerReparaciones() > 1000) {
			self.arreglar()
		}
	}

	// @public void
	method romper(cantidad) {
		montoReparaciones += cantidad
	}

	// @private Number
	method dineroRestanteAlHacerReparaciones() = cuenta.saldo() - montoReparaciones

	// @private Number
	method porcentajeAComprar() = estrategiaDeAhorro.porcentajeAComprarPara(self)

	// @private void
	method aumentarViveres() {
		porcentajeViveres += self.porcentajeAComprar()
	}

}

