hiera_resources para poder usar defined types (las clases no me permiten definir varias veces un check). Cambiado para poder definir el mismo check varias veces en json distintos.

hiera backend postgresql.

Hack de hiera para poder usar wildcards. DESCARTADO.

ensure_resources() con clase propia exportada para no tener problemas de duplicación de recursos.

Pruebas con dos servidores en el mismo servicio (para mostrar que no hay problemas al definir dos veces el mismo exported resource)
