// Ecuentra los datos de 5 corredores
db.Corredores.find({}).limit(5)

// Cuales es el corredor mas pesado
db.Corredores.find({}).sort({Peso:-1}).limit(1)

// Conocer la etapa (Y la carrera donde se encuentra dicha etapa) con mayor desnivel positivo (mas altimetria)
db.Etapas.find({})
db.Etapas.find({},{nº_etapa: 1,Carrera_nombre:1,_id:0}).sort({Altimetria : -1}).limit(1)

// Careras que son monumentos
db.Carreras.find({})
db.Carreras.find({Escala_UCI : {$regex : /Monument/}})

// Carreras por etapas que sean de 3 semanas (21 etapas)
db.Carreras.find({"nº_etapas" : 21})

// Equipos cuya marca de bici es Specialized
db.Equipos.find({})
db.Equipos.find({"Marca de Bici" : "Specialized"})

// Cual es el mejor equipo belga (con mas ptos UCI)
db.Equipos.find({Nacionalidad : "Belgica"}).sort({Nº_Ptos_UCI_Totales : -1}).limit(1)

// Municipios donde pasa el Giro d'Italia
db.Municipios.find({})
db.Municipios.find({Carreras_que_pasan : {$in : ["Giro d'Italia"] }})

// Cuales son los equipos españoles
db.Equipos.find({})
db.Equipos.find({Nacionalidad : "España"})

// Corredores que hayan tenido una presentacion donde hayan sumado mas de 200 ptos UCI en la general
db.Presentacion.find({})
db.Presentacion.find({Ptos_UCI_PosicionGen: {$gt : 200}})

// Cuantos tipos de contrato diferentes han firmado los corredores
db.Periodos.countDocuments()

// Ciudad con mas codigos postales
db.Municipios.find({})
db.Municipios.aggregate([
    {$unwind : "$Cod_Postal"},
    {$group : {_id : "$name",
                Apar : {$sum : 1}}},
    {$sort : {Apar : -1}},
    {$limit:1}     
])

// Periodo que mas eligen los corredores para firmar los contratos
db.Periodos.find({})
db.Periodos.aggregate([
    {$unwind : "$Vinculaciones"},
    {$group : {_id : {AI:"$Año_inicio",AF:"$Año_fin"},
                Apar : {$sum : 1}}},
    {$sort : {Apar : -1}},
    {$limit:1}     
])

// Equipo que mas ptos UCI ha sumado en las clasificaciones generales
db.Presentacion.aggregate([
    {$group: {_id: "$Equipo_nombre",
              Ptos_pres : {$sum : "$Ptos_UCI_PosicionGen"}}},
    {$sort : {Ptos_pres: -1}},
    {$limit : 1}
])

// Gregarios de Tadej Pogacar y Jonas Vingegaard
db.Presentacion.find({})
db.Presentacion.find({Lideres : {$in : ["Tadej Pogacar","Jonas Vingegaard"]}},{Corredor_nombre:1,_id:0})

// Añadir la Strade Bianche, una carrera italiana
db.Carreras.find({})
db.Carreras.insert({
    name: "Strade Bianche",
    country: "Italia",
    Pasa_por:[]
})

// Poner que la carrera pasa por Siena
db.Carreras.updateMany({name : "Strade Bianche"},
                   {$addToSet : {Pasa_por : "Siena"}})
            
// Suponiendo que nos hemos equivocado poniendole a Vergamo el cod postal 24100 cuando es el 24101. cambiarlo
db.Municipios.find({})
db.Municipios.update({name: "Vergamo", "Cod_Postal": 24100},
                        {$set : {"Cod_Postal.$":24101}})