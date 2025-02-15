## Obtener todos los datos de 4 corredores
select *
from corredor
limit 4;

## Obetener el nombre de los equipos de corredores que son de alemania, ordenandolos por estos
select distinct Equipo_Nombre
from Esta_vinculado
where Corredor_Id in (select Id
					  from corredor
                      where Nacionalidad = 'Alemania')
order by Equipo_Nombre;

## Selecciona los distintos años en los que acaban los contratos 
## de los corredores en el equipo Intermarche
select distinct Periodo_Año_fin_vinc
from Esta_vinculado
where Equipo_Nombre like 'Intermarche%';

## Conocer el numero de distintas escalas UCI que reciben las carreras
select count(distinct Escala_UCI)
from carrera;

## Conocer los municipios por donde pasa el Tour de Francia
select municipio_nombre
from pasa_por
where carrera_nombre = 'Tour de France';

## Saber los equipos que han tenido entre 10000 y 15000 puntos UCI (junto con los ptos UCI que han tenido)
select nombre ,Nº_puntos_UCI_totales
from equipo
where Nº_puntos_UCI_totales between 10000 and 15000;


## Conocer las provincias de los pueblos por los que pasa la vuelta a España
select distinct Provincia_Nombre
from Municipio
where nombre in (select municipio_nombre
				 from pasa_por
                 where carrera_nombre like 'La Vuelta%');

## La media de etapas que tienen las carreras por etapas 
select avg(nº_etapas)
from carrera_por_etapas;

## Conocer cuantos kilometros se han recorrido entre todos los monumentos
select sum(distancia_recorrida)
from carrera_de_un_dia
where carrera_nombre in (select nombre
						 from carrera
                         where escala_uci like '%Monument%');

## Conocer las posiciones finales de los lideres en las distintas carreras
select PosicionGen, corredor_id, carrera_nombre
from presentacion
where Id in (select Id_lider
			 from es);

## Conocer el nombre de los corredores que han sido gregarios
select nombre, apellido
from corredor
where Id in (select Corredor_Id
			 from presentacion
             where Id in (select Id_gregario
						  from Es));
                          
## Cual es la etapa y carrera con mayor desnivel positivo (altimetria)
select nº_etapa,  carrera_nombre
from etapa
where altimetria in (select max(altimetria) from etapa);                         
                          
## Cuantos puntos han conseguido los corredores entre todas las etapas de cada carrera y que hayan conseguido mas de 50
select  PtosUCIposicionEtp  
from corre
having PtosUCiposicionEtp > 50;                      
                          
##  Conocer los corredores que han ganado una etapa                       
select nombre, apellido
from corredor inner join presentacion
where (corredor.Id = presentacion.Corredor_Id) and
	  (presentacion.Id in (select Presentacion_Id      
						  from corre
                          where PosicionEtp = 1));

## Conocer la nacionalidad del equipo que tiene el corredor que ha ganado la Milano Sanremo
select Nacionalidad 
from equipo
where Nombre in (select equipo_nombre
				 from presentacion
                 where Carrera_nombre = 'Milano-Sanremo' and PosicionGen = 1);

## Conocer los equipos que han sumado mas de 1000 ptos UCI entre todos los monumentos
select equipo_nombre, sum(ptos_uci_posiciongen)
from presentacion
where (carrera_nombre in (select nombre
						 from carrera 
                         where Escala_UCI like '%Monument%'))
group by equipo_nombre
having sum(ptos_uci_posiciongen) >= 1000;

## Inserte un corredor llamado Carlos Manzano que sea español y corra en el movistar 
## y que este vinculado entre 2024 y 2026
insert into corredor (Nombre, Apellido, Nacionalidad) values ('Carlos', 'Manzano', 'España');
insert into Esta_vinculado values ('Movistar', 81, 2024, 2026);

## Este corredor corrió la vuelta a España quedando en la posicion 50 en la general
## por lo que no consiguio ptos UCI

insert into presentacion (Equipo_nombre, Carrera_nombre, Corredor_Id, PosicionGen, Ptos_UCI_posicionGen)
			values ('Movistar', 'La vuelta Ciclista a España', 81, 50, 0);
select *
from presentacion;            

select Presentacion_Id, sum(PtosUCIposicionEtp) as s
from corre
group by Presentacion_Id
having s >0
order by s desc;


						