----- Pedido
---- Crear
--- El cliente debe seleccionar una mesa y un mozo para dar de alta un nuevo pedido, en una mesa disponible (que no tenga pedidos en preparción), mostrados en estos listados:
SELECT * FROM mesa WHERE id_mesa NOT IN (SELECT mesa_id_mesa FROM pedido WHERE estado = 'En preparación') AND activo = true;
SELECT * FROM mozo WHERE activo = true;

--- Para este ejemplo simulamos que el cliente seleccionó la mesa con el id 1 y al mozo con el id 2
INSERT INTO pedido (mesa_id_mesa, mozo_id_mozo, fecha, estado)
VALUES (1, 2, now(), 'En preparación');

---- Edición
--- Las ediciones se pueden hacer únicamente con pedidos en preparación
--- Una vez dado de alta, al cliente se le mostraría la lista de pedidos para seleccionar, indicando el mozo y la mesa mediante esta consulta:
SELECT id_pedido, mesa_id_mesa, CONCAT(mo.nombre, ' ', mo.apellido) AS mozo FROM pedido ped
JOIN mozo mo ON ped.mozo_id_mozo = mo.id_mozo
WHERE ped.estado = 'En preparación'
ORDER BY mesa_id_mesa;

--- Una vez seleccionado el pedido (recordemos que si llego a esta instancia ya está filtrado por estado) se muestra una lista completa de productos a los cuales se les puede sumar o restar cantidades mediante esta consulta:
SELECT prod.id_producto, cat.nombre_categoria, prod.nombre_producto, det.cantidad AS cantidad
FROM producto prod
LEFT JOIN detalle_pedido det ON prod.id_producto = det.producto_id_producto AND det.pedido_id_pedido = 11
JOIN categoria cat ON prod.categoria_id_categoria = cat.id_categoria
WHERE prod.activo = true
GROUP BY prod.id_producto
ORDER BY cantidad DESC, cat.nombre_categoria, prod.nombre_producto; 

--- En caso de que sea un producto aún no agregado: en el ejemplo se usa el prod 1, pedido 11, realizando una subconsulta para agregar el precio
INSERT INTO detalle_pedido (producto_id_producto, pedido_id_pedido, cantidad, precio_unitario)
VALUES (1, 11, 1, (SELECT precio_actual FROM producto WHERE id_producto = 1));

--- En caso de que sea uno y el operador lo reste:
DELETE FROM detalle_pedido WHERE producto_id_producto = 1 AND pedido_id_pedido = 11;

--- En caso de que siga apretando el botón de suma y la cantidad sea 1 o más
UPDATE detalle_pedido SET cantidad = cantidad + 1 WHERE producto_id_producto = 1 AND pedido_id_pedido = 11;

--- En caso de que sean 2 o más y el operador apriete el botón de resta:
UPDATE detalle_pedido SET cantidad = cantidad - 1 WHERE producto_id_producto = 1 AND pedido_id_pedido = 11;

---- Cancelación
--- Se muestra el mismo listado de pedidos en preparación mencionada anteriormente, el operador decide cancelarlo (No hace falta limpiar la tabla de detalles, ya que en todos los reportes se filtra por el estado del pedido)
UPDATE Pedido SET estado = 'Cancelado' WHERE id_pedido = 11;

----- Categorías
---- Crear
INSERT INTO categoria (nombre_categoria) VALUES ('Empanadas');

---- Edición
--- Se muestra por pantalla las categorías para cambiar, una vez hecha la selección se pide el nuevo nombre y se edita
SELECT * FROM categoria;
UPDATE categoria SET nombre_categoria = 'Ensaladas' WHERE id_categoria = 11;

---- Eliminación 
--- Partiendo de la misma lista mencionada anteriormente se elimina la categoría
DELETE FROM categoria WHERE id_categoria = 11;

----- Productos
---- Crear
--- Se muestra en pantalla para seleccionar una categoría de productos, una vez seleccionada se usa ese id para agregar un producto nuevo en la categoría correspondiente con el nombre y precio ingresado por el cliente

SELECT * FROM categoria;
INSERT INTO producto (categoria_id_categoria, nombre_producto, precio_actual) VALUES (10, 'Helado', 13000);

---- Edición
--- Aquí se muestra el listado de productos completos para determinar cual editar
--- Mostrar una vez más el listado de categorías en caso de que el cliente quiera cambiarla, esto se hace repetidamente para asegurarnos que los clientes elijan una categoría, un pedido o lo que sea válido y no ingresen un id cualquiera
UPDATE producto SET categoria_id_categoria = 9, nombre_producto = 'Affogato', precio_actual = 16000 WHERE id_producto = 40;

--- No se eliminan productos para evitar pérdida de datos en los reportes, se los cambia a inactivos mediante el siguiente comando:
UPDATE producto SET activo = false WHERE id_producto = 40;
--- Se podría volver a dar de alta seteando activo = true, en caso de que un producto haya estado fuera de stock y se vuelva a vender por ejemplo

---- Eliminación únicamente si no fue pedido nunca:
DELETE FROM producto WHERE id_producto = 40 AND id_producto NOT IN (SELECT producto_id_producto FROM detalle_pedido);


----- Mozos
--- Crear
INSERT INTO mozo (dni, nombre, apellido) VALUES (42226897, 'Juan', 'Sanchez');

--- Edición
--- Se muestra un listado completo de mozos, tanto activos como no
SELECT * FROM mozo;
--- Una vez seleccionado se procede a editar
UPDATE mozo SET dni = 123456789, nombre = 'Jhon', apellido = 'Locke'WHERE id_mozo = 6;
--- Dar de baja o nuevamente de alta (evitando eliminar para no perder redundancia)
UPDATE mozo SET activo = false WHERE id_mozo = 6;

--- Eliminación únicamente en caso de que no tenga ningún pedido
DELETE FROM mozo WHERE id_mozo = 6 AND id_mozo NOT IN (SELECT mozo_id_mozo FROM pedido);

----- Mesas
--- Aclaración: el campo nro_mesa es para que el cliente pueda numerarlas y reconocerlas a gusto, internamente todas las consultas se van a manejar por el id de la mesa, estás no se pueden eliminar 
--- ni modificar su capacidad para evitar incoherencias en los reportes pero si renumerar ya que funciona más como un "Nombre", en caso de quererlo que el cliente puede darlas de baja y agregue nuevas mesas para reorganizarlas

---- Crear
INSERT INTO mesa (nro_mesa, capacidad) VALUES (11, 4);

---- Editar 
--- Partiendo como siempre de una seleccion entre las mesas
SELECT * FROM mesa;

UPDATE mesa SET nro_mesa = 100 WHERE id_mesa = 12;

---- Eliminar
UPDATE mesa SET activo = false WHERE id_mesa = 12;