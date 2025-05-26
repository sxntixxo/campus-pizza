# Campus Pizza - Sistema de Gestión de Pizzería

Este proyecto implementa una base de datos para la gestión eficiente de productos, combos, pedidos y clientes de la pizzería "Campus Pizza". El sistema permite administrar pizzas, panzarottis, bebidas, postres, adiciones y el menú disponible, así como registrar los pedidos de los clientes para consumir en el lugar o para recoger.

## Estructura del Proyecto

El proyecto está organizado en los siguientes archivos:

- `estructura.sql`: Contiene la definición completa de la base de datos, incluyendo la creación de todas las tablas, claves primarias y foráneas.
- `datos.sql`: Incluye los scripts para insertar datos de prueba en las tablas.
- `consultas.sql`: Contiene las 20 consultas SQL solicitadas en el proyecto.
- `README.md`: Este archivo, que proporciona una descripción general del proyecto e instrucciones.

## Modelo de Datos

### Entidades Principales

1. **Producto**: Almacena información sobre pizzas, panzarottis, bebidas, postres y otros productos.
2. **Categoría**: Clasifica los productos (Pizza, Panzarotti, Bebida, Postre, Entrada).
3. **Ingrediente**: Registra los ingredientes disponibles para la elaboración de productos.
4. **Adición**: Almacena las adiciones que los clientes pueden agregar a sus productos.
5. **Combo**: Gestiona combinaciones de productos a precios especiales.
6. **Menú**: Define las opciones disponibles en diferentes períodos.
7. **Cliente**: Almacena información de los clientes.
8. **Pedido**: Registra los pedidos realizados por los clientes.
9. **DetallePedido**: Almacena los productos o combos incluidos en cada pedido.
10. **DetalleAdición**: Registra las adiciones solicitadas para cada producto.

### Relaciones

- Un Producto pertenece a una Categoría.
- Un Producto contiene varios Ingredientes.
- Un Combo contiene varios Productos.
- Un Menú incluye varios Productos y Combos.
- Un Pedido es realizado por un Cliente.
- Un Pedido contiene varios Productos o Combos.
- Un DetallePedido puede tener varias Adiciones.

## Instrucciones de Ejecución

Para implementar y probar la base de datos, siga estos pasos:

1. Asegúrese de tener MySQL instalado en su sistema.
2. Abra una terminal o línea de comandos.
3. Acceda a MySQL con sus credenciales:
   ```
   mysql -u [usuario] -p
   ```
4. Ejecute el script de estructura:
   ```
   source ruta/a/estructura.sql;
   ```
5. Ejecute el script de datos:
   ```
   source ruta/a/datos.sql;
   ```
6. Para probar las consultas, ejecute:
   ```
   source ruta/a/consultas.sql;
   ```

## Consultas SQL

A continuación, se explican las 20 consultas SQL implementadas en el proyecto:

### 1. Productos más vendidos (pizza, panzarottis, bebidas, etc.)

```sql
SELECT 
    p.nombre AS producto,
    c.nombre AS categoria,
    SUM(dp.cantidad) AS cantidad_vendida
FROM 
    detalle_pedido dp
JOIN 
    producto p ON dp.id_producto = p.id_producto
JOIN 
    categoria c ON p.id_categoria = c.id_categoria
WHERE 
    dp.id_producto IS NOT NULL
GROUP BY 
    p.id_producto, p.nombre, c.nombre
ORDER BY 
    cantidad_vendida DESC;
```

**Explicación**: Esta consulta suma la cantidad vendida de cada producto, agrupando por nombre y categoría. Se excluyen los combos (donde id_producto es NULL) y se ordenan los resultados de mayor a menor cantidad vendida.

### 2. Total de ingresos generados por cada combo

```sql
SELECT 
    c.nombre AS combo,
    SUM(dp.subtotal) AS ingresos_totales
FROM 
    detalle_pedido dp
JOIN 
    combo c ON dp.id_combo = c.id_combo
WHERE 
    dp.id_combo IS NOT NULL
GROUP BY 
    c.id_combo, c.nombre
ORDER BY 
    ingresos_totales DESC;
```

**Explicación**: Esta consulta suma los subtotales de todos los combos vendidos, agrupando por nombre de combo. Se filtran solo los registros donde id_combo no es NULL y se ordenan por ingresos totales de mayor a menor.

### 3. Pedidos realizados para recoger vs. comer en la pizzería

```sql
SELECT 
    tipo_consumo,
    COUNT(*) AS cantidad_pedidos,
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM pedido), 2) AS porcentaje
FROM 
    pedido
GROUP BY 
    tipo_consumo;
```

**Explicación**: Esta consulta cuenta la cantidad de pedidos por tipo de consumo (en_local o para_llevar) y calcula el porcentaje que representa cada tipo sobre el total de pedidos.

### 4. Adiciones más solicitadas en pedidos personalizados

```sql
SELECT 
    a.nombre AS adicion,
    SUM(da.cantidad) AS cantidad_solicitada
FROM 
    detalle_adicion da
JOIN 
    adicion a ON da.id_adicion = a.id_adicion
GROUP BY 
    a.id_adicion, a.nombre
ORDER BY 
    cantidad_solicitada DESC;
```

**Explicación**: Esta consulta suma la cantidad de cada adición solicitada en todos los pedidos, agrupando por nombre de adición y ordenando de mayor a menor cantidad.

### 5. Cantidad total de productos vendidos por categoría

```sql
SELECT 
    c.nombre AS categoria,
    SUM(dp.cantidad) AS cantidad_vendida
FROM 
    detalle_pedido dp
JOIN 
    producto p ON dp.id_producto = p.id_producto
JOIN 
    categoria c ON p.id_categoria = c.id_categoria
WHERE 
    dp.id_producto IS NOT NULL
GROUP BY 
    c.id_categoria, c.nombre
ORDER BY 
    cantidad_vendida DESC;
```

**Explicación**: Esta consulta suma la cantidad vendida de productos por categoría, excluyendo los combos y ordenando de mayor a menor cantidad.

### 6. Promedio de pizzas pedidas por cliente

```sql
SELECT 
    cl.id_cliente,
    CONCAT(cl.nombre, ' ', cl.apellido) AS cliente,
    ROUND(AVG(subquery.cantidad_pizzas), 2) AS promedio_pizzas
FROM 
    cliente cl
JOIN (
    SELECT 
        p.id_cliente,
        SUM(CASE WHEN pr.id_categoria = 1 THEN dp.cantidad ELSE 0 END) AS cantidad_pizzas
    FROM 
        pedido p
    JOIN 
        detalle_pedido dp ON p.id_pedido = dp.id_pedido
    LEFT JOIN 
        producto pr ON dp.id_producto = pr.id_producto
    GROUP BY 
        p.id_pedido, p.id_cliente
) AS subquery ON cl.id_cliente = subquery.id_cliente
GROUP BY 
    cl.id_cliente, cl.nombre, cl.apellido
ORDER BY 
    promedio_pizzas DESC;
```

**Explicación**: Esta consulta calcula el promedio de pizzas pedidas por cada cliente. Utiliza una subconsulta para contar la cantidad de pizzas (productos de categoría 1) en cada pedido, y luego calcula el promedio por cliente.

### 7. Total de ventas por día de la semana

```sql
SELECT 
    DAYNAME(fecha_hora) AS dia_semana,
    COUNT(*) AS cantidad_pedidos,
    SUM(total) AS total_ventas
FROM 
    pedido
GROUP BY 
    dia_semana
ORDER BY 
    FIELD(dia_semana, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
```

**Explicación**: Esta consulta agrupa los pedidos por día de la semana, contando la cantidad de pedidos y sumando el total de ventas para cada día. Los resultados se ordenan según el orden natural de los días de la semana.

### 8. Cantidad de panzarottis vendidos con extra queso

```sql
SELECT 
    p.nombre AS panzarotti,
    SUM(dp.cantidad) AS cantidad_vendida
FROM 
    detalle_pedido dp
JOIN 
    producto p ON dp.id_producto = p.id_producto
JOIN 
    detalle_adicion da ON dp.id_detalle = da.id_detalle
JOIN 
    adicion a ON da.id_adicion = a.id_adicion
WHERE 
    p.id_categoria = 2 -- Categoría de panzarottis
    AND a.nombre = 'Extra queso'
GROUP BY 
    p.id_producto, p.nombre
ORDER BY 
    cantidad_vendida DESC;
```

**Explicación**: Esta consulta cuenta la cantidad de panzarottis (productos de categoría 2) vendidos con la adición "Extra queso", agrupando por nombre de panzarotti y ordenando de mayor a menor cantidad.

### 9. Pedidos que incluyen bebidas como parte de un combo

```sql
SELECT 
    p.id_pedido,
    p.fecha_hora,
    c.nombre AS combo,
    GROUP_CONCAT(pr.nombre SEPARATOR ', ') AS bebidas_incluidas
FROM 
    pedido p
JOIN 
    detalle_pedido dp ON p.id_pedido = dp.id_pedido
JOIN 
    combo c ON dp.id_combo = c.id_combo
JOIN 
    combo_producto cp ON c.id_combo = cp.id_combo
JOIN 
    producto pr ON cp.id_producto = pr.id_producto
WHERE 
    pr.id_categoria = 3 -- Categoría de bebidas
GROUP BY 
    p.id_pedido, p.fecha_hora, c.nombre
ORDER BY 
    p.fecha_hora DESC;
```

**Explicación**: Esta consulta identifica los pedidos que incluyen combos con bebidas (productos de categoría 3), mostrando el ID del pedido, la fecha, el nombre del combo y las bebidas incluidas, concatenadas en una sola columna.

### 10. Clientes que han realizado más de 5 pedidos en el último mes

```sql
SELECT 
    c.id_cliente,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    COUNT(p.id_pedido) AS cantidad_pedidos
FROM 
    cliente c
JOIN 
    pedido p ON c.id_cliente = p.id_cliente
WHERE 
    p.fecha_hora >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY 
    c.id_cliente, c.nombre, c.apellido
HAVING 
    COUNT(p.id_pedido) > 5
ORDER BY 
    cantidad_pedidos DESC;
```

**Explicación**: Esta consulta identifica los clientes que han realizado más de 5 pedidos en el último mes, contando la cantidad de pedidos por cliente y filtrando por fecha (último mes) y cantidad (más de 5).

### 11. Ingresos totales generados por productos no elaborados (bebidas, postres, etc.)

```sql
SELECT 
    c.nombre AS categoria,
    SUM(dp.subtotal) AS ingresos_totales
FROM 
    detalle_pedido dp
JOIN 
    producto p ON dp.id_producto = p.id_producto
JOIN 
    categoria c ON p.id_categoria = c.id_categoria
WHERE 
    c.id_categoria IN (3, 4) -- Categorías de bebidas y postres
GROUP BY 
    c.id_categoria, c.nombre
ORDER BY 
    ingresos_totales DESC;
```

**Explicación**: Esta consulta suma los ingresos generados por productos no elaborados (bebidas y postres, categorías 3 y 4), agrupando por categoría y ordenando de mayor a menor ingreso.

### 12. Promedio de adiciones por pedido

```sql
SELECT 
    ROUND(AVG(cantidad_adiciones), 2) AS promedio_adiciones_por_pedido
FROM (
    SELECT 
        p.id_pedido,
        SUM(da.cantidad) AS cantidad_adiciones
    FROM 
        pedido p
    JOIN 
        detalle_pedido dp ON p.id_pedido = dp.id_pedido
    LEFT JOIN 
        detalle_adicion da ON dp.id_detalle = da.id_detalle
    GROUP BY 
        p.id_pedido
) AS subquery;
```

**Explicación**: Esta consulta calcula el promedio de adiciones por pedido. Utiliza una subconsulta para sumar la cantidad de adiciones en cada pedido, y luego calcula el promedio general.

### 13. Total de combos vendidos en el último mes

```sql
SELECT 
    c.nombre AS combo,
    SUM(dp.cantidad) AS cantidad_vendida
FROM 
    detalle_pedido dp
JOIN 
    combo c ON dp.id_combo = c.id_combo
JOIN 
    pedido p ON dp.id_pedido = p.id_pedido
WHERE 
    p.fecha_hora >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY 
    c.id_combo, c.nombre
ORDER BY 
    cantidad_vendida DESC;
```

**Explicación**: Esta consulta suma la cantidad de cada combo vendido en el último mes, filtrando por fecha y agrupando por nombre de combo.

### 14. Clientes con pedidos tanto para recoger como para consumir en el lugar

```sql
SELECT 
    c.id_cliente,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    COUNT(DISTINCT CASE WHEN p.tipo_consumo = 'en_local' THEN p.id_pedido END) AS pedidos_en_local,
    COUNT(DISTINCT CASE WHEN p.tipo_consumo = 'para_llevar' THEN p.id_pedido END) AS pedidos_para_llevar
FROM 
    cliente c
JOIN 
    pedido p ON c.id_cliente = p.id_cliente
GROUP BY 
    c.id_cliente, c.nombre, c.apellido
HAVING 
    pedidos_en_local > 0 AND pedidos_para_llevar > 0
ORDER BY 
    (pedidos_en_local + pedidos_para_llevar) DESC;
```

**Explicación**: Esta consulta identifica los clientes que han realizado pedidos tanto para consumir en el local como para llevar, contando la cantidad de cada tipo de pedido y filtrando aquellos que tienen al menos uno de cada tipo.

### 15. Total de productos personalizados con adiciones

```sql
SELECT 
    COUNT(DISTINCT dp.id_detalle) AS total_productos_personalizados
FROM 
    detalle_pedido dp
JOIN 
    detalle_adicion da ON dp.id_detalle = da.id_detalle;
```

**Explicación**: Esta consulta cuenta la cantidad total de productos que han sido personalizados con adiciones, contando los detalles de pedido distintos que tienen al menos una adición.

### 16. Pedidos con más de 3 productos diferentes

```sql
SELECT 
    p.id_pedido,
    p.fecha_hora,
    COUNT(DISTINCT COALESCE(dp.id_producto, dp.id_combo)) AS cantidad_productos_diferentes
FROM 
    pedido p
JOIN 
    detalle_pedido dp ON p.id_pedido = dp.id_pedido
GROUP BY 
    p.id_pedido, p.fecha_hora
HAVING 
    cantidad_productos_diferentes > 3
ORDER BY 
    cantidad_productos_diferentes DESC, p.fecha_hora DESC;
```

**Explicación**: Esta consulta identifica los pedidos que incluyen más de 3 productos o combos diferentes, contando la cantidad de productos/combos distintos en cada pedido y filtrando aquellos con más de 3.

### 17. Promedio de ingresos generados por día

```sql
SELECT 
    DATE(fecha_hora) AS fecha,
    ROUND(AVG(total), 2) AS promedio_ingresos
FROM 
    pedido
GROUP BY 
    fecha
ORDER BY 
    fecha DESC;
```

**Explicación**: Esta consulta calcula el promedio de ingresos generados por día, agrupando los pedidos por fecha y calculando el promedio del total.

### 18. Clientes que han pedido pizzas con adiciones en más del 50% de sus pedidos

```sql
SELECT 
    c.id_cliente,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    COUNT(DISTINCT p.id_pedido) AS total_pedidos,
    COUNT(DISTINCT CASE WHEN da.id_detalle IS NOT NULL AND pr.id_categoria = 1 THEN p.id_pedido END) AS pedidos_pizza_con_adiciones,
    ROUND((COUNT(DISTINCT CASE WHEN da.id_detalle IS NOT NULL AND pr.id_categoria = 1 THEN p.id_pedido END) * 100.0) / COUNT(DISTINCT p.id_pedido), 2) AS porcentaje
FROM 
    cliente c
JOIN 
    pedido p ON c.id_cliente = p.id_cliente
JOIN 
    detalle_pedido dp ON p.id_pedido = dp.id_pedido
LEFT JOIN 
    producto pr ON dp.id_producto = pr.id_producto
LEFT JOIN 
    detalle_adicion da ON dp.id_detalle = da.id_detalle
GROUP BY 
    c.id_cliente, c.nombre, c.apellido
HAVING 
    porcentaje > 50
ORDER BY 
    porcentaje DESC;
```

**Explicación**: Esta consulta identifica los clientes que han pedido pizzas con adiciones en más del 50% de sus pedidos totales. Calcula el porcentaje de pedidos que incluyen pizzas con adiciones sobre el total de pedidos por cliente.

### 19. Porcentaje de ventas provenientes de productos no elaborados

```sql
SELECT 
    ROUND((SUM(CASE WHEN c.id_categoria IN (3, 4) THEN dp.subtotal ELSE 0 END) * 100.0) / SUM(dp.subtotal), 2) AS porcentaje_ventas_no_elaborados
FROM 
    detalle_pedido dp
JOIN 
    producto p ON dp.id_producto = p.id_producto
JOIN 
    categoria c ON p.id_categoria = c.id_categoria
WHERE 
    dp.id_producto IS NOT NULL;
```

**Explicación**: Esta consulta calcula el porcentaje de ventas que provienen de productos no elaborados (bebidas y postres, categorías 3 y 4) sobre el total de ventas de productos individuales.

### 20. Día de la semana con mayor número de pedidos para recoger

```sql
SELECT 
    DAYNAME(fecha_hora) AS dia_semana,
    COUNT(*) AS cantidad_pedidos_recoger
FROM 
    pedido
WHERE 
    tipo_consumo = 'para_llevar'
GROUP BY 
    dia_semana
ORDER BY 
    cantidad_pedidos_recoger DESC
LIMIT 1;
```

**Explicación**: Esta consulta identifica el día de la semana con mayor número de pedidos para recoger, contando la cantidad de pedidos de tipo "para_llevar" por día de la semana y seleccionando el día con mayor cantidad.

## Diseño de la Base de Datos

El diseño de la base de datos se realizó utilizando drawSQL, siguiendo un enfoque relacional que permite gestionar eficientemente todas las entidades y relaciones necesarias para el sistema de la pizzería.

### Características del Diseño

- **Normalización**: Las tablas están normalizadas para evitar redundancia de datos.
- **Integridad Referencial**: Se utilizan claves foráneas para mantener la integridad referencial entre tablas.
- **Triggers**: Se implementaron triggers para automatizar cálculos como subtotales y totales de pedidos.
- **Enumeraciones**: Se utilizan tipos ENUM para campos con valores predefinidos como el tipo de consumo y el estado del pedido.

### Consideraciones de Diseño

1. **Productos y Categorías**: Se separaron los productos por categorías para facilitar su gestión y consulta.
2. **Ingredientes**: Se implementó una relación muchos a muchos entre productos e ingredientes para permitir la personalización.
3. **Combos y Menús**: Se diseñaron como entidades separadas con relaciones muchos a muchos con productos.
4. **Adiciones**: Se implementaron como personalizaciones que pueden agregarse a cualquier producto en un pedido.
5. **Pedidos y Detalles**: Se utilizó un diseño de cabecera-detalle para los pedidos, permitiendo múltiples productos o combos por pedido.

## Conclusión

Este sistema de base de datos proporciona una solución completa para la gestión de la pizzería Campus Pizza, permitiendo administrar eficientemente productos, combos, pedidos y clientes. Las consultas implementadas ofrecen información valiosa para la toma de decisiones y el análisis del negocio.
