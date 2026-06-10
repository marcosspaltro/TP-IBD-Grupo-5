----- Detalle cuenta
SELECT cantidad, nombre_producto, precio_unitario, (cantidad * precio_unitario) AS Total FROM detalle_pedido det
JOIN producto prod ON det.producto_id_producto = prod.id_producto 
WHERE det.pedido_id_pedido = 1 ORDER BY id_producto;

----- Total cuenta
SELECT pedido_id_pedido, SUM(cantidad * precio_unitario) AS Total FROM detalle_pedido WHERE pedido_id_pedido = 1 GROUP BY pedido_id_pedido;

----- Mozos
--- Actividad por mozo en rango de fecha específico por el total generado
SELECT CONCAT(Mo.Nombre, ' ', Mo.apellido) AS Nombre_completo, COUNT(DISTINCT ped.id_pedido) AS Cantidad_pedidos, SUM(cantidad * precio_unitario) AS Total 
FROM pedido ped
JOIN detalle_pedido det ON ped.id_pedido = det.pedido_id_pedido 
AND ped.fecha BETWEEN '2026-07-02 00:00:00' AND '2026-07-09 23:59:59'
RIGHT JOIN mozo mo ON ped.mozo_id_mozo = mo.id_mozo
WHERE ped.estado = 'Completo' AND mo.activo = true
GROUP BY mo.id_mozo
ORDER BY Total DESC;

--- Actividad por mozo ordenada por el total generado
SELECT CONCAT(Mo.Nombre, ' ', Mo.apellido) AS Nombre_completo, COUNT(DISTINCT ped.id_pedido) AS Cantidad_pedidos, SUM(cantidad * precio_unitario) AS Total 
FROM pedido ped
JOIN detalle_pedido det ON ped.id_pedido = det.pedido_id_pedido 
RIGHT JOIN mozo mo ON ped.mozo_id_mozo = mo.id_mozo
WHERE ped.estado = 'Completo' AND mo.activo = true
GROUP BY mo.id_mozo
ORDER BY Total DESC;

----- Mesas
--- Actividad por mesa ordenada por el total generado, con el rendimiento según la capacidad de la mesa
-- (El rendimiento ayudaría para evaluar si conviene agregar mesas con mayor o menor capacidad)
SELECT me.id_mesa, me.nro_mesa, COUNT(DISTINCT ped.id_pedido) AS Cantidad_pedidos, SUM(cantidad * precio_unitario) AS Total, ROUND(SUM(cantidad * precio_unitario) / (me.capacidad * COUNT(DISTINCT ped.id_pedido)), 2) AS rendimiento_por_capacidad
FROM pedido ped
JOIN detalle_pedido det ON ped.id_pedido = det.pedido_id_pedido 
RIGHT JOIN mesa me ON ped.mesa_id_mesa = me.id_mesa
WHERE ped.estado = 'Completo'
GROUP BY me.id_mesa
ORDER BY Total DESC;

----- Productos
--- Productos más vendidos, con el total real ingresado en ventas de este, contemplando la posibilidad de un cambio de precio en el medio
SELECT nombre_categoria, prod.nombre_producto, SUM(det.cantidad) AS ventas, SUM(det.cantidad * det.precio_unitario) AS Total
FROM producto prod
JOIN categoria cat ON prod.categoria_id_categoria = cat.id_categoria
LEFT JOIN detalle_pedido det ON prod.id_producto = det.producto_id_producto AND det.pedido_id_pedido IN (SELECT id_pedido FROM pedido WHERE estado = 'completo')
GROUP BY prod.id_producto
ORDER BY ventas DESC, total DESC;
-- Se puede cambiar el ORDER BY por ORDER BY cat.id_categoria, ventas DESC, total DESC; para ordenarlos por categoria y reemplazar POR JOIN el LEFT JOIN para que solo haya productos que tienen ventas

--- Venta por categoría
SELECT nombre_categoria, SUM(det.cantidad) AS ventas, SUM(det.cantidad * det.precio_unitario) AS Total
FROM producto prod
RIGHT JOIN categoria cat ON prod.categoria_id_categoria = cat.id_categoria
JOIN detalle_pedido det ON prod.id_producto = det.producto_id_producto AND det.pedido_id_pedido IN (SELECT id_pedido FROM pedido WHERE estado = 'completo')
GROUP BY id_categoria
ORDER BY ventas DESC, total DESC;


----- Menú
SELECT nombre_categoria AS categoría, nombre_producto AS producto, precio_actual AS precio FROM producto prod
JOIN categoria cat ON prod.categoria_id_categoria = cat.id_categoria
WHERE prod.activo = true
ORDER BY cat.id_categoria, prod.id_producto;