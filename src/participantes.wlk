import conocimientos.*
import cumbre.*

class Participante {

	var property pais
	var property conocimientos = #{}
	var property commits = 0

	method esCape()

	method cumpleRequisitos() = conocimientos.contains(programacionBasica)

	method hacerActividad(unaActividad) {
		conocimientos.add(unaActividad)
		commits += (unaActividad.tema().commitsPorHora() * unaActividad.horas())
	}

}

class Programador inherits Participante {

	var property horasDeCapacitacion = 0

	override method esCape() = commits > 500

	override method cumpleRequisitos() = super() and self.commitsMinimos()

	method commitsMinimos() = commits >= cumbre.commitsMinimosProgramador()

	override method hacerActividad(unaActividad) {
		super(unaActividad)
		horasDeCapacitacion += unaActividad.horas()
	}

}

class Especialista inherits Participante {

	override method esCape() = conocimientos.size() > 2

	override method cumpleRequisitos() = super() and self.commitsMinimos() and conocimientos.contains(objetos)

	method commitsMinimos() = commits >= cumbre.commitsMinimosProgramador() - 100

}

class Gerente inherits Participante {

	const property empresa

	override method esCape() = empresa.esMultinacional()

	override method cumpleRequisitos() = super() and conocimientos.contains(manejoDeGrupos)

}

class Empresa {

	const property paisesEstablecida = #{}

	method esMultinacional() = paisesEstablecida.size() >= 3

}

