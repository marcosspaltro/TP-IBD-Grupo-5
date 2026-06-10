------------ MESAS;
INSERT INTO Mesa (nro_mesa, capacidad) values (1, 2), (2, 2), (3, 2), (4, 6), (5, 6), (6, 6), (7, 4), (8, 4), (9, 8), (10, 3), (11, 3);

------------ Categorias;
INSERT INTO categoria (nombre_categoria) values ('Tragos'), ('Vinos'), ('Cervezas'), ('Bebidas'), ('Entradas'), ('Pizzas'), ('Milanesas'), ('Carnes'), ('cafetería'), ('Postre');

------------ Productos;
------ Tragos;
INSERT INTO producto (categoria_id_categoria, nombre_producto, precio_actual) values 
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Tragos'), 'Daikiri', 8000), 
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Tragos'), 'Fernet', 7000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Tragos'), 'Gancia', 6000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Tragos'), 'Aperol', 8000);

------ Vinos;
INSERT INTO producto (categoria_id_categoria, nombre_producto, precio_actual) values 
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Vinos'), 'Malbec', 9000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Vinos'), 'Blanco', 5500),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Vinos'), 'Tinto dulce', 12000);

------ Cervezas;
INSERT INTO producto (categoria_id_categoria, nombre_producto, precio_actual) values 
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Cervezas'), 'Rubia', 6500),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Cervezas'), 'Irish', 6500),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Cervezas'), 'Stout', 8500);

------ Bebidas;
INSERT INTO producto (categoria_id_categoria, nombre_producto, precio_actual) values 
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Bebidas'), 'Agua', 3000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Bebidas'), 'Jugo', 3500),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Bebidas'), 'Coca cola', 4000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Bebidas'), 'Sprite', 4000);

------ Entradas;
INSERT INTO producto (categoria_id_categoria, nombre_producto, precio_actual) values 
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Entradas'), 'Papas con chedar y verdeo', 9000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Entradas'), 'Tequeños', 8000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Entradas'), 'Chicken fingers', 7500);

------ Pizzas;
INSERT INTO producto (categoria_id_categoria, nombre_producto, precio_actual) values 
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Pizzas'), 'Muzzarella', 20000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Pizzas'), 'Jamón y Morrón', 27000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Pizzas'), 'Calabresa', 27000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Pizzas'), 'Napolitana', 24000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Pizzas'), 'New York', 30000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Pizzas'), 'Fugazzeta', 29000);

------ Milanesas;
INSERT INTO producto (categoria_id_categoria, nombre_producto, precio_actual) values 
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Milanesas'), 'Carne', 22000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Milanesas'), 'Pollo', 22000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Milanesas'), 'Napolitana', 25000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Milanesas'), 'A caballo', 28000);

------ Carnes;
INSERT INTO producto (categoria_id_categoria, nombre_producto, precio_actual) values 
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Carnes'), 'Entraña', 35000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Carnes'), 'Ojo de bife', 38000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Carnes'), 'Filete mignon', 42000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Carnes'), 'Parrillada', 50000);

------ cafetería;
INSERT INTO producto (categoria_id_categoria, nombre_producto, precio_actual) values 
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'cafetería'), 'Americano', 4000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'cafetería'), 'Cortado', 5000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'cafetería'), 'Irlandés', 7500),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'cafetería'), 'Porción de torta', 9000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'cafetería'), 'Cookie', 7000);

------ Postre;
INSERT INTO producto (categoria_id_categoria, nombre_producto, precio_actual) values 
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Postre'), 'Tiramisú', 12000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Postre'), 'Volcán de chocolate', 12000),
((SELECT id_categoria FROM categoria WHERE nombre_categoria = 'Postre'), 'Chocotorta', 8000);

------------ mozos;
INSERT INTO mozo (dni, nombre, apellido) values 
(48151623, 'Hugo', 'Reyes'),
(42898534, 'Jack', 'Shephard'),
(22865534, 'Jorge Luis', 'Borges'),
(43210916, 'Sofía', 'Acosta'),
(49121812, 'Julían', 'Alvarez');

------------ Pedido;
INSERT INTO Pedido (mesa_id_mesa, mozo_id_mozo, fecha, estado) VALUES
(1, 1, '2026-06-02 12:15:30', 'Completo'),
(2, 2, '2026-05-09 13:42:18', 'Completo'),
(2, 3, '2026-03-09 20:05:47', 'Completo'),
(3, 4, '2026-07-08 11:23:09', 'Completo'),
(3, 4, '2026-07-08 14:37:22', 'Completo'),
(2, 4, '2026-07-08 21:11:55', 'Completo'),
(4, 2, '2026-07-07 19:48:03', 'Completo'),
(1, 3, '2026-05-01 08:32:41', 'Completo'),
(3, 3, '2026-06-01 16:27:14', 'Completo'),
(1, 1, '2026-06-02 22:09:58', 'Completo');

------------ Detalle_pedido;

INSERT INTO detalle_pedido (pedido_id_pedido, producto_id_producto, cantidad, precio_unitario) values 
(1, 1, 1, (SELECT precio_actual FROM producto WHERE id_producto = 1)),
(1, 2, 2, (SELECT precio_actual FROM producto WHERE id_producto = 2)),
(1, 3, 2, (SELECT precio_actual FROM producto WHERE id_producto = 3)),
(1, 4, 2, (SELECT precio_actual FROM producto WHERE id_producto = 4)),
(2, 4, 3, (SELECT precio_actual FROM producto WHERE id_producto = 4)),
(2, 6, 4, (SELECT precio_actual FROM producto WHERE id_producto = 6)),
(2, 5, 1, (SELECT precio_actual FROM producto WHERE id_producto = 5)),
(3, 4, 1, (SELECT precio_actual FROM producto WHERE id_producto = 4)),
(3, 8, 3, (SELECT precio_actual FROM producto WHERE id_producto = 8)),
(4, 9, 3, (SELECT precio_actual FROM producto WHERE id_producto = 9)),
(4, 10, 2, (SELECT precio_actual FROM producto WHERE id_producto = 10)),
(4, 11, 5, (SELECT precio_actual FROM producto WHERE id_producto = 11)),
(4, 12, 5, (SELECT precio_actual FROM producto WHERE id_producto = 12)),
(5, 15, 2, (SELECT precio_actual FROM producto WHERE id_producto = 15)),
(6, 6, 3, (SELECT precio_actual FROM producto WHERE id_producto = 6)),
(7, 8, 9, (SELECT precio_actual FROM producto WHERE id_producto = 8)),
(7, 7, 4, (SELECT precio_actual FROM producto WHERE id_producto = 7)),
(8, 10, 2, (SELECT precio_actual FROM producto WHERE id_producto = 10)),
(8, 11, 2, (SELECT precio_actual FROM producto WHERE id_producto = 11)),
(8, 20, 3, (SELECT precio_actual FROM producto WHERE id_producto = 20)),
(9, 18, 8, (SELECT precio_actual FROM producto WHERE id_producto = 18)),
(9, 19, 2, (SELECT precio_actual FROM producto WHERE id_producto = 19)),
(10, 6, 1, (SELECT precio_actual FROM producto WHERE id_producto = 6));