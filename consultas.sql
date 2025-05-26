-- Consultas SQL para Campus Pizza

-- 1. Productos más vendidos (pizza, panzarottis, bebidas, etc.)
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

-- 2. Total de ingresos generados por cada combo
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

-- 3. Pedidos realizados para recoger vs. comer en la pizzería
SELECT 
    tipo_consumo,
    COUNT(*) AS cantidad_pedidos,
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM pedido), 2) AS porcentaje
FROM 
    pedido
GROUP BY 
    tipo_consumo;

-- 4. Adiciones más solicitadas en pedidos personalizados
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

-- 5. Cantidad total de productos vendidos por categoría
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

-- 6. Promedio de pizzas pedidas por cliente
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

-- 7. Total de ventas por día de la semana
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

-- 8. Cantidad de panzarottis vendidos con extra queso
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

-- 9. Pedidos que incluyen bebidas como parte de un combo
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

-- 10. Clientes que han realizado más de 5 pedidos en el último mes
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

-- 11. Ingresos totales generados por productos no elaborados (bebidas, postres, etc.)
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

-- 12. Promedio de adiciones por pedido
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

-- 13. Total de combos vendidos en el último mes
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

-- 14. Clientes con pedidos tanto para recoger como para consumir en el lugar
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

-- 15. Total de productos personalizados con adiciones
SELECT 
    COUNT(DISTINCT dp.id_detalle) AS total_productos_personalizados
FROM 
    detalle_pedido dp
JOIN 
    detalle_adicion da ON dp.id_detalle = da.id_detalle;

-- 16. Pedidos con más de 3 productos diferentes
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

-- 17. Promedio de ingresos generados por día
SELECT 
    DATE(fecha_hora) AS fecha,
    ROUND(AVG(total), 2) AS promedio_ingresos
FROM 
    pedido
GROUP BY 
    fecha
ORDER BY 
    fecha DESC;

-- 18. Clientes que han pedido pizzas con adiciones en más del 50% de sus pedidos
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

-- 19. Porcentaje de ventas provenientes de productos no elaborados
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

-- 20. Día de la semana con mayor número de pedidos para recoger
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
