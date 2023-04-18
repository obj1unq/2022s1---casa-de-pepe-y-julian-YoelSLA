import casa.*

object minimoEIndispensable {

	var property calidad = 0

	// @public Number
	method porcentajeAComprarPara(casa) = self.porcentajeDeViveresPara(casa) * calidad

	// @public void
	method hacerMantenimientoPara(casa) {
		if (!casa.hayViveresSuficientes()) {
			casa.comprarViveres()
		}
	}

	// @private Number
	method porcentajeDeViveresPara(casa) = (40 - casa.porcentajeViveres()) / calidad

}

object full {

	const property calidad = 5

	// @public Number
	method porcentajeAComprarPara(casa) {
		return if (casa.estaEnOrden()) {
			100 - casa.porcentajeViveres()
		} else 40
	}

	// @public @void
	method hacerMantenimientoPara(casa) {
		casa.comprarViveres()
		casa.reparar()
	}

}

