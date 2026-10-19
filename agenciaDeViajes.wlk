class Pack{
    const duracion
    const precioBase
    const beneficiosEspeciales = []
    const coordinador

    method agregarBeneficioEspecial(beneficio){beneficiosEspeciales.add(beneficio)}
    method quitarBeneficioEspecial(beneficio){beneficiosEspeciales.remove(beneficio)}
    method beneficiosEspecialesVigentes(){
        return beneficiosEspeciales.filter({b=>b.estaVigente()})
    }
    method valorFinal(){
        return precioBase + self.beneficiosEspecialesVigentes().sum({b=>b.costo()})
    }
    method esPremium
}
class Nacional inherits Pack{
    const provincia
    const actividades =[] //cada una en formato texto

    method agregarActividades(actividad){actividades.add(actividad)}
    override method esPremium(){
        return duracion > 10 and coordinador.altamenteCalificado()
    }

}
class Provincial inherits Nacional{
    const ciudades = []

    method agregarCiudades(ciudad){ciudades.add(ciudad)}
    override method esPremium(){
        return actividades.size() > 4 and ciudades.size() > 5 and self.beneficiosEspecialesVigentes().size() >= 3
    }
    override method valorFinal(){
        if (self.esPremium()) return super() * 1.05 else return super()
    }
}
class Internacional inherits Pack{
    const pais
    const escalas
    const deInteres

    override method valorFinal(){
        return super() * 1.20
    }

    override method esPremium(){
        return deInteres and duracion > 20 and escalas == 0
    }
}
class Coordinador {
    const viajesRealizados
    const estaMotivado
    const aniosExperiencia
    var rol

    method aniosExperiencia() = aniosExperiencia
    method estaMotivado() = estaMotivado
    method cambiarRol(nuevoRol) {rol = nuevoRol}
    method altamenteCalificado(){
        return viajesRealizados > 20 and rol.condicionExtra(self)
    }
}
//ROL
object guia{
    method condicionExtra(coordinador){
        return coordinador.estaMotivado()
    }
}
object asistenteLogistico{
        method condicionExtra(coordinador){
        return coordinador.aniosExperiencia() >= 3
    }
}
object acompaniante{
        method condicionExtra(coordinador){
        return true
    }
}
//BENEFICIOS ESPECIALES
class TrasladoPrivado{
    const tipo = "traslados privados"
    const costo
    const estaVigente

    method tipo() = tipo
    method costo() = costo
    method estaVigente() = estaVigente
}
class AccesoSalaVip{
    const tipo = "acceso a sala vip"
    const costo
    const estaVigente

    method tipo() = tipo
    method costo() = costo
    method estaVigente() = estaVigente
}
class SeguroAdicional{
    const tipo = "seguro adicional"
    const costo
    const estaVigente

    method tipo() = tipo
    method costo() = costo
    method estaVigente() = estaVigente
}
//PRUEBA//
const juan = new Coordinador(viajesRealizados=2,estaMotivado=true,aniosExperiencia=1,rol=guia)
const motivado1 = new Coordinador(viajesRealizados=21,estaMotivado=true,aniosExperiencia=1,rol=guia)
const asistenteNo = new Coordinador(viajesRealizados=21,estaMotivado=true,aniosExperiencia=2,rol=asistenteLogistico)
const acompaniante1 = new Coordinador(viajesRealizados=21,estaMotivado=true,aniosExperiencia=1,rol=acompaniante)

const pack1 = new Internacional(duracion=21,precioBase=10,coordinador=juan,pais="argentina",escalas=1,deInteres=true)
const pack2 = new Nacional(duracion=8,precioBase=10,coordinador=motivado1,provincia="santaFe")
const pack3 = new Provincial(duracion=8,precioBase=10,coordinador=motivado1,provincia="santaFe",actividades=["1","2","3","4","5"])
const traslado = new TrasladoPrivado(costo=10,estaVigente=true)
const vip = new AccesoSalaVip(costo=20,estaVigente=false)
const seguro = new SeguroAdicional(costo=10,estaVigente=true)