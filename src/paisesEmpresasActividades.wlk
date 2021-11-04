import cumbre.*

class Pais {

	const property conflictos = #{}
	const property nombrePais

	method registrarConflictoCon(unPais) {
		conflictos.add(unPais)
		unPais.conflictos().add(self)
	}

	method estaEnConflictoCon(unPais) = conflictos.contains(unPais)

}

class Actividad {

	const property tema
	var property horas

}

