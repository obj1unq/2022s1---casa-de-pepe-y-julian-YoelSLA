object casaDePepeYJulian {

	var montoDeReparacion = 0
	const porcentajeDeViveres = 0.5

	method montoDeReparacion() = montoDeReparacion

	method romperAlgoDeValor(valor) {
		montoDeReparacion += valor
	}

	method hayReparacionesPorHacer() = montoDeReparacion > 0

	method hayViveresSuficientes() = porcentajeDeViveres > 0.4

	method estaEnOrden() = not self.hayReparacionesPorHacer() && self.hayViveresSuficientes()

}

object cuentaCorriente {

	var saldo = 0

	method depositar(cantidad) {
		saldo += cantidad
	}

	method saldo() = saldo

	method extraer(cantidad) {
		saldo -= cantidad
	}

}

object cuentaConGastos {

	var saldo = 0
	var property costoPorOperacion = 20

	method saldo() = saldo

	method depositar(cantidad) {
		saldo += cantidad - self.costoPorOperacion()
	}

	method extraer(cantidad) {
		saldo -= cantidad
	}

}

object cuentaCombinada {

	method saldo() = cuentaConGastos.saldo() + cuentaCorriente.saldo()

	method depositar(cantidad) {
		cuentaConGastos.depositar(cantidad)
	}

	method extraer(cantidad) {
		if (cuentaConGastos.saldo() <= cantidad) {
			cuentaCorriente.extraer(cantidad)
		} else cuentaConGastos.extraer(cantidad)
	}

}

