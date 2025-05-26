	-- Estructura de la base de datos para Campus Pizza

-- Eliminar base de datos si existe
DROP DATABASE IF EXISTS campus_pizza;

-- Crear base de datos
CREATE DATABASE campus_pizza;

-- Usar la base de datos
USE campus_pizza;

-- Tabla Categoria
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT
);

-- Tabla Producto
CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio_base DECIMAL(10, 2) NOT NULL,
    id_categoria INT NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

-- Tabla Ingrediente
CREATE TABLE ingrediente (
    id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    stock DECIMAL(10, 2) DEFAULT 0,
    unidad_medida VARCHAR(20),
    precio_unitario DECIMAL(10, 2) NOT NULL
);

-- Tabla ProductoIngrediente (relación N:M entre Producto e Ingrediente)
CREATE TABLE producto_ingrediente (
    id_producto INT,
    id_ingrediente INT,
    cantidad DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_producto, id_ingrediente),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id_ingrediente)
);

-- Tabla Adicion
CREATE TABLE adicion (
    id_adicion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla Combo
CREATE TABLE combo (
    id_combo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio_combo DECIMAL(10, 2) NOT NULL,
    descuento DECIMAL(5, 2) DEFAULT 0,
    activo BOOLEAN DEFAULT TRUE,
    fecha_inicio DATE,
    fecha_fin DATE
);

-- Tabla ComboProducto (relación N:M entre Combo y Producto)
CREATE TABLE combo_producto (
    id_combo INT,
    id_producto INT,
    cantidad INT NOT NULL DEFAULT 1,
    PRIMARY KEY (id_combo, id_producto),
    FOREIGN KEY (id_combo) REFERENCES combo(id_combo),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- Tabla Menu
CREATE TABLE menu (
    id_menu INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla MenuProducto (relación N:M entre Menu y Producto)
CREATE TABLE menu_producto (
    id_menu INT,
    id_producto INT,
    PRIMARY KEY (id_menu, id_producto),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- Tabla MenuCombo (relación N:M entre Menu y Combo)
CREATE TABLE menu_combo (
    id_menu INT,
    id_combo INT,
    PRIMARY KEY (id_menu, id_combo),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu),
    FOREIGN KEY (id_combo) REFERENCES combo(id_combo)
);

-- Tabla Cliente
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion TEXT,
    fecha_registro DATE DEFAULT (CURRENT_DATE)
);

-- Tabla Pedido
CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    tipo_consumo ENUM('en_local', 'para_llevar') NOT NULL,
    estado ENUM('pendiente', 'en_preparacion', 'listo', 'entregado', 'cancelado') DEFAULT 'pendiente',
    total DECIMAL(10, 2) DEFAULT 0,
    observaciones TEXT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabla DetallePedido
CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT,
    id_combo INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    observaciones TEXT,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_combo) REFERENCES combo(id_combo),
    CHECK (id_producto IS NOT NULL OR id_combo IS NOT NULL)
);

-- Tabla DetalleAdicion (relación N:M entre DetallePedido y Adicion)
CREATE TABLE detalle_adicion (
    id_detalle INT,
    id_adicion INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_detalle, id_adicion),
    FOREIGN KEY (id_detalle) REFERENCES detalle_pedido(id_detalle),
    FOREIGN KEY (id_adicion) REFERENCES adicion(id_adicion)
);

-- Triggers para actualizar el total del pedido
DELIMITER //
CREATE TRIGGER actualizar_subtotal_detalle
BEFORE INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    SET NEW.subtotal = NEW.cantidad * NEW.precio_unitario;
END //

CREATE TRIGGER actualizar_subtotal_adicion
BEFORE INSERT ON detalle_adicion
FOR EACH ROW
BEGIN
    SET NEW.subtotal = NEW.cantidad * NEW.precio_unitario;
END //

CREATE TRIGGER actualizar_total_pedido_insert
AFTER INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    UPDATE pedido
    SET total = (SELECT SUM(subtotal) FROM detalle_pedido WHERE id_pedido = NEW.id_pedido)
    WHERE id_pedido = NEW.id_pedido;
END //

CREATE TRIGGER actualizar_total_pedido_update
AFTER UPDATE ON detalle_pedido
FOR EACH ROW
BEGIN
    UPDATE pedido
    SET total = (SELECT SUM(subtotal) FROM detalle_pedido WHERE id_pedido = NEW.id_pedido)
    WHERE id_pedido = NEW.id_pedido;
END //

CREATE TRIGGER actualizar_total_pedido_delete
AFTER DELETE ON detalle_pedido
FOR EACH ROW
BEGIN
    UPDATE pedido
    SET total = (SELECT SUM(subtotal) FROM detalle_pedido WHERE id_pedido = OLD.id_pedido)
    WHERE id_pedido = OLD.id_pedido;
END //
DELIMITER ;
