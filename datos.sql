-- Datos de prueba para la base de datos Campus Pizza

USE campus_pizza;

-- Insertar categorías
INSERT INTO categoria (nombre, descripcion) VALUES
('Pizza', 'Pizzas tradicionales y especiales'),
('Panzarotti', 'Panzarottis con diferentes rellenos'),
('Bebida', 'Bebidas frías y calientes'),
('Postre', 'Postres y dulces'),
('Entrada', 'Entradas y aperitivos');

-- Insertar ingredientes
INSERT INTO ingrediente (nombre, descripcion, stock, unidad_medida, precio_unitario) VALUES
('Masa de pizza', 'Masa base para pizzas', 100, 'unidad', 2.50),
('Salsa de tomate', 'Salsa de tomate casera', 50, 'litro', 3.00),
('Queso mozzarella', 'Queso mozzarella rallado', 30, 'kg', 8.50),
('Pepperoni', 'Pepperoni en rodajas', 15, 'kg', 12.00),
('Jamón', 'Jamón en cubos', 15, 'kg', 10.00),
('Piña', 'Piña en trozos', 10, 'kg', 5.00),
('Champiñones', 'Champiñones frescos', 8, 'kg', 7.50),
('Cebolla', 'Cebolla en rodajas', 10, 'kg', 2.00),
('Pimiento', 'Pimiento en rodajas', 10, 'kg', 3.00),
('Aceitunas', 'Aceitunas negras', 5, 'kg', 9.00),
('Pollo', 'Pollo desmenuzado', 20, 'kg', 9.50),
('Carne molida', 'Carne de res molida', 15, 'kg', 11.00),
('Tocino', 'Tocino en trozos', 8, 'kg', 13.00),
('Masa de panzarotti', 'Masa para panzarottis', 50, 'unidad', 2.00),
('Salsa de ajo', 'Salsa de ajo casera', 10, 'litro', 4.00),
('Salsa BBQ', 'Salsa barbacoa', 10, 'litro', 5.00),
('Queso cheddar', 'Queso cheddar rallado', 15, 'kg', 9.00),
('Chocolate', 'Chocolate para postres', 5, 'kg', 15.00),
('Fresa', 'Fresas frescas', 8, 'kg', 6.00),
('Helado de vainilla', 'Helado de vainilla', 10, 'litro', 7.00);

-- Insertar productos
INSERT INTO producto (nombre, descripcion, precio_base, id_categoria, activo) VALUES
('Pizza Margarita', 'Pizza tradicional con queso y salsa de tomate', 12.99, 1, TRUE),
('Pizza Pepperoni', 'Pizza con pepperoni y queso', 14.99, 1, TRUE),
('Pizza Hawaiana', 'Pizza con jamón y piña', 15.99, 1, TRUE),
('Pizza Vegetariana', 'Pizza con champiñones, cebolla, pimiento y aceitunas', 16.99, 1, TRUE),
('Pizza Suprema', 'Pizza con pepperoni, jamón, champiñones, cebolla y pimiento', 18.99, 1, TRUE),
('Pizza BBQ', 'Pizza con pollo, cebolla y salsa BBQ', 17.99, 1, TRUE),
('Pizza Carnívora', 'Pizza con pepperoni, jamón, carne molida y tocino', 19.99, 1, TRUE),
('Panzarotti de Queso', 'Panzarotti relleno de queso', 9.99, 2, TRUE),
('Panzarotti de Jamón y Queso', 'Panzarotti relleno de jamón y queso', 11.99, 2, TRUE),
('Panzarotti Supremo', 'Panzarotti relleno de pepperoni, jamón, champiñones y queso', 13.99, 2, TRUE),
('Panzarotti de Pollo', 'Panzarotti relleno de pollo y queso', 12.99, 2, TRUE),
('Coca-Cola', 'Refresco de cola', 2.99, 3, TRUE),
('Sprite', 'Refresco de lima-limón', 2.99, 3, TRUE),
('Agua mineral', 'Agua mineral sin gas', 1.99, 3, TRUE),
('Jugo de naranja', 'Jugo natural de naranja', 3.99, 3, TRUE),
('Café', 'Café americano', 2.50, 3, TRUE),
('Brownie', 'Brownie de chocolate', 4.99, 4, TRUE),
('Helado', 'Helado de vainilla con salsa de chocolate', 5.99, 4, TRUE),
('Tarta de fresa', 'Tarta de fresa casera', 6.99, 4, TRUE),
('Palitos de ajo', 'Palitos de pan con ajo y queso', 7.99, 5, TRUE),
('Nachos con queso', 'Nachos con queso cheddar derretido', 8.99, 5, TRUE);

-- Insertar relaciones producto-ingrediente
INSERT INTO producto_ingrediente (id_producto, id_ingrediente, cantidad) VALUES
-- Pizza Margarita
(1, 1, 1), -- Masa
(1, 2, 0.2), -- Salsa de tomate
(1, 3, 0.3), -- Queso mozzarella

-- Pizza Pepperoni
(2, 1, 1), -- Masa
(2, 2, 0.2), -- Salsa de tomate
(2, 3, 0.3), -- Queso mozzarella
(2, 4, 0.15), -- Pepperoni

-- Pizza Hawaiana
(3, 1, 1), -- Masa
(3, 2, 0.2), -- Salsa de tomate
(3, 3, 0.3), -- Queso mozzarella
(3, 5, 0.15), -- Jamón
(3, 6, 0.15), -- Piña

-- Pizza Vegetariana
(4, 1, 1), -- Masa
(4, 2, 0.2), -- Salsa de tomate
(4, 3, 0.3), -- Queso mozzarella
(4, 7, 0.1), -- Champiñones
(4, 8, 0.1), -- Cebolla
(4, 9, 0.1), -- Pimiento
(4, 10, 0.05), -- Aceitunas

-- Pizza Suprema
(5, 1, 1), -- Masa
(5, 2, 0.2), -- Salsa de tomate
(5, 3, 0.3), -- Queso mozzarella
(5, 4, 0.1), -- Pepperoni
(5, 5, 0.1), -- Jamón
(5, 7, 0.1), -- Champiñones
(5, 8, 0.1), -- Cebolla
(5, 9, 0.1), -- Pimiento

-- Pizza BBQ
(6, 1, 1), -- Masa
(6, 16, 0.2), -- Salsa BBQ
(6, 3, 0.3), -- Queso mozzarella
(6, 11, 0.2), -- Pollo
(6, 8, 0.1), -- Cebolla

-- Pizza Carnívora
(7, 1, 1), -- Masa
(7, 2, 0.2), -- Salsa de tomate
(7, 3, 0.3), -- Queso mozzarella
(7, 4, 0.1), -- Pepperoni
(7, 5, 0.1), -- Jamón
(7, 12, 0.1), -- Carne molida
(7, 13, 0.1), -- Tocino

-- Panzarotti de Queso
(8, 14, 1), -- Masa de panzarotti
(8, 3, 0.2), -- Queso mozzarella

-- Panzarotti de Jamón y Queso
(9, 14, 1), -- Masa de panzarotti
(9, 3, 0.15), -- Queso mozzarella
(9, 5, 0.1), -- Jamón

-- Panzarotti Supremo
(10, 14, 1), -- Masa de panzarotti
(10, 3, 0.15), -- Queso mozzarella
(10, 4, 0.05), -- Pepperoni
(10, 5, 0.05), -- Jamón
(10, 7, 0.05), -- Champiñones

-- Panzarotti de Pollo
(11, 14, 1), -- Masa de panzarotti
(11, 3, 0.15), -- Queso mozzarella
(11, 11, 0.15); -- Pollo

-- Insertar adiciones
INSERT INTO adicion (nombre, descripcion, precio, activo) VALUES
('Extra queso', 'Porción adicional de queso mozzarella', 2.50, TRUE),
('Extra pepperoni', 'Porción adicional de pepperoni', 2.00, TRUE),
('Extra jamón', 'Porción adicional de jamón', 2.00, TRUE),
('Extra champiñones', 'Porción adicional de champiñones', 1.50, TRUE),
('Salsa de ajo', 'Salsa de ajo para acompañar', 1.00, TRUE),
('Salsa BBQ', 'Salsa BBQ para acompañar', 1.00, TRUE),
('Borde de queso', 'Borde de la pizza relleno de queso', 3.00, TRUE),
('Queso cheddar', 'Cambiar a queso cheddar', 1.50, TRUE);

-- Insertar combos
INSERT INTO combo (nombre, descripcion, precio_combo, descuento, activo, fecha_inicio, fecha_fin) VALUES
('Combo Familiar', 'Pizza grande, 4 bebidas y palitos de ajo', 29.99, 15.00, TRUE, '2025-01-01', '2025-12-31'),
('Combo Pareja', 'Pizza mediana, 2 bebidas y postre', 24.99, 10.00, TRUE, '2025-01-01', '2025-12-31'),
('Combo Individual', 'Panzarotti, bebida y postre', 15.99, 8.00, TRUE, '2025-01-01', '2025-12-31'),
('Combo Fiesta', '2 pizzas grandes, 6 bebidas y 2 postres', 49.99, 20.00, TRUE, '2025-01-01', '2025-12-31'),
('Combo Panzarotti', '2 panzarottis y 2 bebidas', 19.99, 12.00, TRUE, '2025-01-01', '2025-12-31');

-- Insertar relaciones combo-producto
INSERT INTO combo_producto (id_combo, id_producto, cantidad) VALUES
-- Combo Familiar
(1, 5, 1), -- Pizza Suprema
(1, 12, 2), -- Coca-Cola
(1, 13, 2), -- Sprite
(1, 20, 1), -- Palitos de ajo

-- Combo Pareja
(2, 2, 1), -- Pizza Pepperoni
(2, 12, 1), -- Coca-Cola
(2, 13, 1), -- Sprite
(2, 17, 1), -- Brownie

-- Combo Individual
(3, 8, 1), -- Panzarotti de Queso
(3, 12, 1), -- Coca-Cola
(3, 17, 1), -- Brownie

-- Combo Fiesta
(4, 5, 1), -- Pizza Suprema
(4, 7, 1), -- Pizza Carnívora
(4, 12, 3), -- Coca-Cola
(4, 13, 3), -- Sprite
(4, 17, 1), -- Brownie
(4, 18, 1), -- Helado

-- Combo Panzarotti
(5, 9, 1), -- Panzarotti de Jamón y Queso
(5, 10, 1), -- Panzarotti Supremo
(5, 12, 1), -- Coca-Cola
(5, 13, 1); -- Sprite

-- Insertar menús
INSERT INTO menu (nombre, descripcion, fecha_inicio, fecha_fin, activo) VALUES
('Menú Regular', 'Menú regular disponible todo el año', '2025-01-01', '2025-12-31', TRUE),
('Menú Verano', 'Menú especial de verano', '2025-06-01', '2025-08-31', TRUE),
('Menú Promocional', 'Menú con promociones especiales', '2025-03-01', '2025-04-30', TRUE);

-- Insertar relaciones menú-producto
INSERT INTO menu_producto (id_menu, id_producto) VALUES
-- Menú Regular
(1, 1), -- Pizza Margarita
(1, 2), -- Pizza Pepperoni
(1, 3), -- Pizza Hawaiana
(1, 4), -- Pizza Vegetariana
(1, 5), -- Pizza Suprema
(1, 8), -- Panzarotti de Queso
(1, 9), -- Panzarotti de Jamón y Queso
(1, 12), -- Coca-Cola
(1, 13), -- Sprite
(1, 14), -- Agua mineral
(1, 17), -- Brownie
(1, 18), -- Helado
(1, 20), -- Palitos de ajo

-- Menú Verano
(2, 3), -- Pizza Hawaiana
(2, 6), -- Pizza BBQ
(2, 14), -- Agua mineral
(2, 15), -- Jugo de naranja
(2, 18), -- Helado
(2, 19), -- Tarta de fresa

-- Menú Promocional
(3, 5), -- Pizza Suprema
(3, 7), -- Pizza Carnívora
(3, 10), -- Panzarotti Supremo
(3, 11), -- Panzarotti de Pollo
(3, 21); -- Nachos con queso

-- Insertar relaciones menú-combo
INSERT INTO menu_combo (id_menu, id_combo) VALUES
(1, 1), -- Combo Familiar en Menú Regular
(1, 2), -- Combo Pareja en Menú Regular
(1, 3), -- Combo Individual en Menú Regular
(2, 2), -- Combo Pareja en Menú Verano
(2, 3), -- Combo Individual en Menú Verano
(3, 1), -- Combo Familiar en Menú Promocional
(3, 4), -- Combo Fiesta en Menú Promocional
(3, 5); -- Combo Panzarotti en Menú Promocional

-- Insertar clientes
INSERT INTO cliente (nombre, apellido, telefono, email, direccion, fecha_registro) VALUES
('Juan', 'Pérez', '555-1234', 'juan.perez@email.com', 'Calle 123 #45-67', '2025-01-15'),
('María', 'González', '555-5678', 'maria.gonzalez@email.com', 'Avenida 456 #78-90', '2025-01-20'),
('Carlos', 'Rodríguez', '555-9012', 'carlos.rodriguez@email.com', 'Carrera 789 #12-34', '2025-02-05'),
('Ana', 'Martínez', '555-3456', 'ana.martinez@email.com', 'Calle 234 #56-78', '2025-02-10'),
('Luis', 'Sánchez', '555-7890', 'luis.sanchez@email.com', 'Avenida 567 #89-01', '2025-02-15'),
('Laura', 'López', '555-2345', 'laura.lopez@email.com', 'Carrera 890 #23-45', '2025-03-01'),
('Pedro', 'Díaz', '555-6789', 'pedro.diaz@email.com', 'Calle 345 #67-89', '2025-03-10'),
('Sofía', 'Torres', '555-0123', 'sofia.torres@email.com', 'Avenida 678 #90-12', '2025-03-15'),
('Miguel', 'Ramírez', '555-4567', 'miguel.ramirez@email.com', 'Carrera 901 #34-56', '2025-04-01'),
('Valentina', 'Herrera', '555-8901', 'valentina.herrera@email.com', 'Calle 456 #78-90', '2025-04-10');

-- Insertar pedidos (con fechas recientes para simular actividad)
INSERT INTO pedido (id_cliente, fecha_hora, tipo_consumo, estado, observaciones) VALUES
(1, '2025-04-26 12:30:00', 'en_local', 'entregado', 'Sin observaciones'),
(2, '2025-04-26 13:45:00', 'para_llevar', 'entregado', 'Entregar en recepción'),
(3, '2025-04-26 18:15:00', 'en_local', 'entregado', 'Mesa cerca de la ventana'),
(4, '2025-04-27 19:30:00', 'para_llevar', 'entregado', 'Llamar al llegar'),
(5, '2025-04-27 20:45:00', 'en_local', 'entregado', 'Cumpleaños'),
(1, '2025-04-28 12:00:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(6, '2025-04-28 13:30:00', 'en_local', 'entregado', 'Sin observaciones'),
(7, '2025-04-28 19:00:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(8, '2025-04-29 18:30:00', 'en_local', 'entregado', 'Sin observaciones'),
(9, '2025-04-29 20:00:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(10, '2025-04-30 19:15:00', 'en_local', 'entregado', 'Sin observaciones'),
(2, '2025-04-30 20:30:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(3, '2025-05-01 12:45:00', 'en_local', 'entregado', 'Sin observaciones'),
(4, '2025-05-01 18:00:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(5, '2025-05-02 19:30:00', 'en_local', 'entregado', 'Sin observaciones'),
(6, '2025-05-02 20:45:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(7, '2025-05-03 13:15:00', 'en_local', 'entregado', 'Sin observaciones'),
(8, '2025-05-03 18:30:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(9, '2025-05-04 19:00:00', 'en_local', 'entregado', 'Sin observaciones'),
(10, '2025-05-04 20:15:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(1, '2025-05-05 12:30:00', 'en_local', 'entregado', 'Sin observaciones'),
(2, '2025-05-05 18:45:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(3, '2025-05-06 19:15:00', 'en_local', 'entregado', 'Sin observaciones'),
(4, '2025-05-06 20:30:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(5, '2025-05-07 13:00:00', 'en_local', 'entregado', 'Sin observaciones'),
(6, '2025-05-07 18:15:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(7, '2025-05-08 19:30:00', 'en_local', 'entregado', 'Sin observaciones'),
(8, '2025-05-08 20:45:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(9, '2025-05-09 12:15:00', 'en_local', 'entregado', 'Sin observaciones'),
(10, '2025-05-09 18:30:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(1, '2025-05-10 19:00:00', 'en_local', 'entregado', 'Sin observaciones'),
(2, '2025-05-10 20:15:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(3, '2025-05-11 12:30:00', 'en_local', 'entregado', 'Sin observaciones'),
(4, '2025-05-11 18:45:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(5, '2025-05-12 19:15:00', 'en_local', 'entregado', 'Sin observaciones'),
(6, '2025-05-12 20:30:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(7, '2025-05-13 13:00:00', 'en_local', 'entregado', 'Sin observaciones'),
(8, '2025-05-13 18:15:00', 'para_llevar', 'entregado', 'Sin observaciones'),
(9, '2025-05-14 19:30:00', 'en_local', 'entregado', 'Sin observaciones'),
(10, '2025-05-14 20:45:00', 'para_llevar', 'entregado', 'Sin observaciones');

-- Insertar detalles de pedido
INSERT INTO detalle_pedido (id_pedido, id_producto, id_combo, cantidad, precio_unitario, subtotal, observaciones) VALUES
-- Pedido 1
(1, 2, NULL, 1, 14.99, 14.99, 'Sin observaciones'),
(1, 12, NULL, 2, 2.99, 5.98, 'Bien frías'),

-- Pedido 2
(2, NULL, 2, 1, 24.99, 24.99, 'Sin observaciones'),

-- Pedido 3
(3, 5, NULL, 1, 18.99, 18.99, 'Sin observaciones'),
(3, 20, NULL, 1, 7.99, 7.99, 'Extra queso'),
(3, 12, NULL, 3, 2.99, 8.97, 'Sin observaciones'),

-- Pedido 4
(4, NULL, 3, 2, 15.99, 31.98, 'Sin observaciones'),

-- Pedido 5
(5, NULL, 4, 1, 49.99, 49.99, 'Para celebración'),

-- Pedido 6
(6, 3, NULL, 1, 15.99, 15.99, 'Sin piña'),
(6, 14, NULL, 1, 1.99, 1.99, 'Sin observaciones'),

-- Pedido 7
(7, 8, NULL, 2, 9.99, 19.98, 'Sin observaciones'),
(7, 12, NULL, 2, 2.99, 5.98, 'Sin observaciones'),

-- Pedido 8
(8, NULL, 5, 1, 19.99, 19.99, 'Sin observaciones'),

-- Pedido 9
(9, 7, NULL, 1, 19.99, 19.99, 'Sin observaciones'),
(9, 21, NULL, 1, 8.99, 8.99, 'Extra queso'),
(9, 13, NULL, 2, 2.99, 5.98, 'Sin observaciones'),

-- Pedido 10
(10, NULL, 1, 1, 29.99, 29.99, 'Sin observaciones'),

-- Pedidos adicionales (11-40) con variedad de productos y combos
(11, 4, NULL, 1, 16.99, 16.99, 'Sin aceitunas'),
(11, 17, NULL, 2, 4.99, 9.98, 'Sin observaciones'),
(12, NULL, 2, 1, 24.99, 24.99, 'Sin observaciones'),
(13, 6, NULL, 1, 17.99, 17.99, 'Extra pollo'),
(13, 15, NULL, 2, 3.99, 7.98, 'Sin observaciones'),
(14, 9, NULL, 2, 11.99, 23.98, 'Sin observaciones'),
(14, 13, NULL, 2, 2.99, 5.98, 'Sin observaciones'),
(15, NULL, 3, 3, 15.99, 47.97, 'Sin observaciones'),
(16, 1, NULL, 1, 12.99, 12.99, 'Extra queso'),
(16, 12, NULL, 1, 2.99, 2.99, 'Sin observaciones'),
(17, NULL, 4, 1, 49.99, 49.99, 'Para reunión familiar'),
(18, 10, NULL, 2, 13.99, 27.98, 'Sin observaciones'),
(18, 14, NULL, 2, 1.99, 3.98, 'Sin observaciones'),
(19, 5, NULL, 1, 18.99, 18.99, 'Sin pimiento'),
(19, 20, NULL, 1, 7.99, 7.99, 'Sin observaciones'),
(19, 12, NULL, 2, 2.99, 5.98, 'Sin observaciones'),
(20, NULL, 5, 2, 19.99, 39.98, 'Sin observaciones'),
(21, 2, NULL, 2, 14.99, 29.98, 'Una con extra queso'),
(21, 13, NULL, 3, 2.99, 8.97, 'Sin observaciones'),
(21, 17, NULL, 1, 4.99, 4.99, 'Sin observaciones'),
(22, NULL, 1, 1, 29.99, 29.99, 'Sin observaciones'),
(23, 7, NULL, 1, 19.99, 19.99, 'Sin tocino'),
(23, 21, NULL, 1, 8.99, 8.99, 'Extra queso'),
(23, 12, NULL, 2, 2.99, 5.98, 'Sin observaciones'),
(24, 8, NULL, 3, 9.99, 29.97, 'Sin observaciones'),
(24, 14, NULL, 3, 1.99, 5.97, 'Sin observaciones'),
(25, NULL, 2, 2, 24.99, 49.98, 'Sin observaciones'),
(26, 3, NULL, 1, 15.99, 15.99, 'Sin jamón'),
(26, 15, NULL, 1, 3.99, 3.99, 'Sin observaciones'),
(27, NULL, 3, 1, 15.99, 15.99, 'Sin observaciones'),
(28, 6, NULL, 2, 17.99, 35.98, 'Una con extra BBQ'),
(28, 13, NULL, 4, 2.99, 11.96, 'Sin observaciones'),
(29, 4, NULL, 1, 16.99, 16.99, 'Sin champiñones'),
(29, 20, NULL, 1, 7.99, 7.99, 'Sin observaciones'),
(29, 12, NULL, 2, 2.99, 5.98, 'Sin observaciones'),
(30, NULL, 4, 1, 49.99, 49.99, 'Para evento'),
(31, 1, NULL, 2, 12.99, 25.98, 'Sin observaciones'),
(31, 14, NULL, 2, 1.99, 3.98, 'Sin observaciones'),
(32, NULL, 5, 1, 19.99, 19.99, 'Sin observaciones'),
(33, 5, NULL, 1, 18.99, 18.99, 'Extra queso'),
(33, 17, NULL, 2, 4.99, 9.98, 'Sin observaciones'),
(33, 12, NULL, 2, 2.99, 5.98, 'Sin observaciones'),
(34, 9, NULL, 2, 11.99, 23.98, 'Sin observaciones'),
(34, 13, NULL, 2, 2.99, 5.98, 'Sin observaciones'),
(35, NULL, 1, 1, 29.99, 29.99, 'Sin observaciones'),
(36, 7, NULL, 1, 19.99, 19.99, 'Extra carne'),
(36, 21, NULL, 1, 8.99, 8.99, 'Sin observaciones'),
(36, 15, NULL, 2, 3.99, 7.98, 'Sin observaciones'),
(37, NULL, 3, 2, 15.99, 31.98, 'Sin observaciones'),
(38, 10, NULL, 3, 13.99, 41.97, 'Sin observaciones'),
(38, 14, NULL, 3, 1.99, 5.97, 'Sin observaciones'),
(39, 2, NULL, 1, 14.99, 14.99, 'Extra pepperoni'),
(39, 20, NULL, 1, 7.99, 7.99, 'Sin observaciones'),
(39, 12, NULL, 2, 2.99, 5.98, 'Sin observaciones'),
(40, NULL, 2, 2, 24.99, 49.98, 'Sin observaciones');

-- Insertar detalles de adiciones
INSERT INTO detalle_adicion (id_detalle, id_adicion, cantidad, precio_unitario, subtotal) VALUES
-- Adiciones para el detalle 1 (Pizza Pepperoni en Pedido 1)
(1, 1, 1, 2.50, 2.50), -- Extra queso

-- Adiciones para el detalle 3 (Pizza Suprema en Pedido 3)
(3, 1, 1, 2.50, 2.50), -- Extra queso
(3, 2, 1, 2.00, 2.00), -- Extra pepperoni

-- Adiciones para el detalle 5 (Combo Fiesta en Pedido 5)
(5, 7, 2, 3.00, 6.00), -- Borde de queso para las dos pizzas

-- Adiciones para el detalle 6 (Pizza Hawaiana en Pedido 6)
(6, 3, 1, 2.00, 2.00), -- Extra jamón

-- Adiciones para el detalle 9 (Pizza Carnívora en Pedido 9)
(9, 2, 1, 2.00, 2.00), -- Extra pepperoni
(9, 7, 1, 3.00, 3.00), -- Borde de queso

-- Adiciones para el detalle 11 (Pizza Vegetariana en Pedido 11)
(11, 1, 1, 2.50, 2.50), -- Extra queso
(11, 4, 1, 1.50, 1.50), -- Extra champiñones

-- Adiciones para el detalle 13 (Pizza BBQ en Pedido 13)
(13, 6, 1, 1.00, 1.00), -- Salsa BBQ

-- Adiciones para el detalle 16 (Pizza Margarita en Pedido 16)
(16, 1, 2, 2.50, 5.00), -- Doble extra queso

-- Adiciones para el detalle 19 (Pizza Suprema en Pedido 19)
(19, 3, 1, 2.00, 2.00), -- Extra jamón

-- Adiciones para el detalle 21 (Pizza Pepperoni en Pedido 21)
(21, 1, 1, 2.50, 2.50), -- Extra queso para una de las pizzas

-- Adiciones para el detalle 23 (Pizza Carnívora en Pedido 23)
(23, 2, 1, 2.00, 2.00), -- Extra pepperoni

-- Adiciones para el detalle 28 (Pizza BBQ en Pedido 28)
(28, 6, 1, 1.00, 1.00), -- Extra salsa BBQ para una de las pizzas

-- Adiciones para el detalle 33 (Pizza Suprema en Pedido 33)
(33, 1, 1, 2.50, 2.50), -- Extra queso

-- Adiciones para el detalle 36 (Pizza Carnívora en Pedido 36)
(36, 2, 1, 2.00, 2.00), -- Extra pepperoni
(36, 3, 1, 2.00, 2.00), -- Extra jamón

-- Adiciones para el detalle 39 (Pizza Pepperoni en Pedido 39)
(39, 2, 2, 2.00, 4.00); -- Doble extra pepperoni
