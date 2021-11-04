import participantes.*

object cumbre {

	const property paisesAuspiciantes = #{}
	const property participantes = #{}
	var property commitsMinimosProgramador = 300
	const property actividadesRealizadas = #{}

	method registrarIngresoDe(unParticiparnte) {
		participantes.add(unParticiparnte)
	}

	method agregarAuspiciante(pais) {
		paisesAuspiciantes.add(pais)
	}

	method ingresa(unParticipante) {
		participantes.add(unParticipante)
	}

	method esConflictivo(unPais) = self.paisesAuspiciantes().any{ p => unPais.estaEnConflictoCon(p) }

	method paisDeCadaParticipante() = participantes.map{ part => part.pais() }

	method paisDeLesParticipantes() = self.paisDeCadaParticipante().asSet()

	method cantidadDeParticipantesDe(unPais) = participantes.count{ part => part.pais() == unPais }

	method paisConMasParticipantes() = self.paisDeLesParticipantes().max{ pais => self.cantidadDeParticipantesDe(pais) }

	method participantesExtranjeros() = participantes.filter{ part => not self.paisesAuspiciantes().contains(part.pais()) }

	method esRelevante() = participantes.all{ part => part.esCape() }

	// method esDePaisAuspiciante(unParticipante) = paisesAuspiciantes.contains(unParticipante.pais())
	method cantidadDeParticipantesExtranjeros() = self.participantesExtranjeros().size()

	method tieneAccesoRestringido(unParticipante) = self.esConflictivo(unParticipante.pais()) and self.cantidadDeParticipantesExtranjeros() < 2

	method puedeIngresar(unParticipante) = unParticipante.cumpleRequisitos() and not self.tieneAccesoRestringido(unParticipante)

	method dejarIngresar(unParticipante) {
		if (self.puedeIngresar(unParticipante)) self.registrarIngresoDe(unParticipante) else self.error("no permite su ingreso")
	}

	method esSegura() = participantes.all{ part => self.puedeIngresar(part) }

	method registrarActividad(unaActividad) {
		actividadesRealizadas.add(unaActividad)
		participantes.forEach{ part => part.hacerActividad(unaActividad)}
	}

	method totalDeHorasDeActividad() = actividadesRealizadas.sum{ activ => activ.hora() }

}

