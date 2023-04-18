import casa.*

object cuentaCorriente {

	var property saldo = 0

	// @public void
	method depositar(cuanto) {
		saldo += cuanto
	}

	// @public void
	method extraer(cuanto) {
		saldo -= cuanto
	}

}

object cuentaConGastos {

	var property saldo = 0
	var property costoPorOperacion = 20

	// @public void
	method depositar(cantidad) {
		saldo += cantidad - costoPorOperacion
	}

	// @public void
	method extraer(cantidad) {
		saldo -= cantidad
	}

}

object cuentaCombinada {

	var primaria
	var secundaria

	// @public Number
	method saldo() = primaria.saldo() + secundaria.saldo()

	// @public void
	method primaria(_primaria) {
		primaria = _primaria
	}

	// @public void
	method secundaria(_secundaria) {
		secundaria = _secundaria
	}

	// @public void
	method depositar(cantidad) {
		primaria.depositar(cantidad)
	}

	// @public void
	method extraer(cantidad) {
		if (primaria.saldo() >= cantidad) {
			primaria.extraer(cantidad)
		} else secundaria.extraer(cantidad)
	}

}

