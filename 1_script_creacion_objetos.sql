DROP DATABASE IF EXISTS fabrica_de_pintura;
CREATE DATABASE IF NOT EXISTS fabrica_de_pintura;

USE fabrica_de_pintura;

DROP TABLE IF EXISTS unidades_medida;
CREATE TABLE IF NOT EXISTS unidades_medida (
	id_unidad_medida INT NOT NULL AUTO_INCREMENT UNIQUE
    , unidad_de_medida VARCHAR(15)
    , PRIMARY KEY (id_unidad_medida)
);

DROP TABLE IF EXISTS tipos_de_documentos;
CREATE TABLE IF NOT EXISTS tipos_de_documentos (
	id_tipo_documento INT NOT NULL AUTO_INCREMENT UNIQUE
    , tipo_documento VARCHAR(4)
);

DROP TABLE IF EXISTS clientes;
CREATE TABLE IF NOT EXISTS clientes (
	id_cliente INT NOT NULL AUTO_INCREMENT UNIQUE
    , id_tipo_documento INT NOT NULL
	, documento VARCHAR(15)
    , nombre VARCHAR(50) NOT NULL
    , apellido VARCHAR(50)
    , PRIMARY KEY (id_cliente)
    , FOREIGN KEY (id_tipo_documento) REFERENCES tipos_de_documentos (id_tipo_documento)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

DROP TABLE IF EXISTS productos;
CREATE TABLE IF NOT EXISTS productos (
	id_producto INT NOT NULL AUTO_INCREMENT UNIQUE
	, nombre_producto VARCHAR(35) NOT NULL
	, PRIMARY KEY (id_producto)
);

DROP TABLE IF EXISTS colores;
CREATE TABLE IF NOT EXISTS colores (
	id_color INT NOT NULL AUTO_INCREMENT UNIQUE
    , color VARCHAR(25) NOT NULL
    , PRIMARY KEY(id_color)
);

DROP TABLE IF EXISTS choferes;
CREATE TABLE IF NOT EXISTS choferes (
	id_chofer INT NOT NULL AUTO_INCREMENT UNIQUE
    , nombre VARCHAR(15) NOT NULL
    , apellido VARCHAR(15)
    , PRIMARY KEY (id_chofer)
);

DROP TABLE IF EXISTS tipos_de_empleados;
CREATE TABLE IF NOT EXISTS tipos_de_empleados (
	id_tipo_empleado INT NOT NULL AUTO_INCREMENT UNIQUE
    , tipo_de_empleado VARCHAR(15) NOT NULL
    , PRIMARY KEY (id_tipo_empleado)
);

DROP TABLE IF EXISTS empleados;
CREATE TABLE IF NOT EXISTS empleados (
	id_empleado INT NOT NULL AUTO_INCREMENT UNIQUE
    , id_tipo_empleado INT NOT NULL
    , nombre VARCHAR(15) NOT NULL
    , dni INT(15) NOT NULL
    , sueldo DECIMAL(12)
    , PRIMARY KEY (id_empleado)
    , FOREIGN KEY (id_tipo_empleado) REFERENCES tipos_de_empleados (id_tipo_empleado)
);

DROP TABLE IF EXISTS proveedores;
CREATE TABLE IF NOT EXISTS proveedores (
	id_proveedor INT NOT NULL AUTO_INCREMENT UNIQUE
    , nombre VARCHAR(15) NOT NULL
    , PRIMARY KEY (id_proveedor)
);

DROP TABLE IF EXISTS materiales;
CREATE TABLE IF NOT EXISTS materiales (
	id_material INT NOT NULL AUTO_INCREMENT UNIQUE
    , id_proveedor INT NOT NULL
    , nombre_material VARCHAR(30) NOT NULL
    , PRIMARY KEY (id_material)
    , FOREIGN KEY (id_proveedor) REFERENCES proveedores (id_proveedor)
);

DROP TABLE IF EXISTS pedidos_proveedores;
CREATE TABLE IF NOT EXISTS pedidos_proveedores (
	id_pedido_proveedor INT NOT NULL AUTO_INCREMENT UNIQUE
    , id_proveedor INT NOT NULL
    , id_empleado INT NOT NULL
    , fecha DATE NOT NULL
    , PRIMARY KEY (id_pedido_proveedor)
    , FOREIGN KEY (id_proveedor) REFERENCES proveedores (id_proveedor)
    , FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado)
);

DROP TABLE IF EXISTS detalle_pedido_proveedor;
CREATE TABLE IF NOT EXISTS detalle_pedido_proveedor (
	id_detalle INT NOT NULL AUTO_INCREMENT UNIQUE
    , id_pedido_proveedor INT NOT NULL
    , id_material INT NOT NULL
    , id_unidad_medida INT NOT NULL
    , cantidad INT NOT NULL
    , PRIMARY KEY (id_detalle)
    , FOREIGN KEY (id_pedido_proveedor) REFERENCES pedidos_proveedores (id_pedido_proveedor)
    , FOREIGN KEY (id_material) REFERENCES materiales (id_material)
    , FOREIGN KEY (id_unidad_medida) REFERENCES unidades_medida (id_unidad_medida)
);

DROP TABLE IF EXISTS telefonos;
CREATE TABLE IF NOT EXISTS telefonos (
	id_telefono INT NOT NULL AUTO_INCREMENT UNIQUE
    , id_proveedor INT
    , id_empleado INT
    , id_chofer INT
    , id_cliente INT
    , telefono INT(15) NOT NULL
    , PRIMARY KEY (id_telefono)
    , FOREIGN KEY (id_proveedor) REFERENCES proveedores (id_proveedor)
    , FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado)
    , FOREIGN KEY (id_chofer) REFERENCES choferes (id_chofer)
    , FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

DROP TABLE IF EXISTS emails;
CREATE TABLE IF NOT EXISTS emails (
	id_email INT NOT NULL AUTO_INCREMENT UNIQUE
    , id_proveedor INT 
    , id_empleado INT 
    , id_cliente INT 
    , email VARCHAR(120) NOT NULL
    , PRIMARY KEY (id_email)
    , FOREIGN KEY (id_proveedor) REFERENCES proveedores (id_proveedor)
    , FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado)
    , FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

DROP TABLE IF EXISTS direcciones;
CREATE TABLE IF NOT EXISTS direcciones (
	id_direccion INT NOT NULL AUTO_INCREMENT UNIQUE
    , id_proveedor INT
    , id_empleado INT
    , id_cliente INT
    , direccion VARCHAR(255) NOT NULL
    , provincia VARCHAR(40) NOT NULL
    , ciudad VARCHAR(40) NOT NULL
    , cp INT(5)
    , PRIMARY KEY (id_direccion)
    , FOREIGN KEY (id_proveedor) REFERENCES proveedores (id_proveedor)
    , FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado)
    , FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

DROP TABLE IF EXISTS facturas;
CREATE TABLE IF NOT EXISTS facturas (
	id_factura INT NOT NULL AUTO_INCREMENT UNIQUE
    , id_cliente INT NOT NULL
    , id_empleado INT NOT NULL
    , fecha DATE NOT NULL
    , total DECIMAL(11,2) NOT NULL
    , PRIMARY KEY (id_factura)
    , FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
    , FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado)
);

DROP TABLE IF EXISTS detalle_factura;
CREATE TABLE IF NOT EXISTS detalle_factura (
	id_detalle_factura INT NOT NULL AUTO_INCREMENT UNIQUE
	, id_factura INT NOT NULL
    , id_producto INT NOT NULL
    , id_color INT NOT NULL
    , cantidad INT NOT NULL
    , precio DECIMAL(11,2) NOT NULL
    , PRIMARY KEY (id_detalle_factura)
    , FOREIGN KEY (id_factura) REFERENCES facturas (id_factura)
    , FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
    , FOREIGN KEY (id_color) REFERENCES colores (id_color)
);

DROP TABLE IF EXISTS formulas;
CREATE TABLE IF NOT EXISTS formulas (
	id_formula INT NOT NULL AUTO_INCREMENT UNIQUE
    , id_producto INT NOT NULL
    , nombre VARCHAR(20) NOT NULL
    , PRIMARY KEY (id_formula)
    , FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);

DROP TABLE IF EXISTS detalle_formulas;
CREATE TABLE IF NOT EXISTS detalle_formulas (
	id_detalle_formula INT NOT NULL AUTO_INCREMENT UNIQUE
    , id_formula INT NOT NULL
    , id_material INT NOT NULL
    , id_unidad_medida INT NOT NULL
    , cantidad DECIMAL(11,2)
    , PRIMARY KEY (id_detalle_formula)
    , FOREIGN KEY (id_unidad_medida) REFERENCES unidades_medida (id_unidad_medida)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

DROP TABLE IF EXISTS log_nuevo_cliente;
CREATE TABLE IF NOT EXISTS log_nuevo_cliente (
	id_log_cliente INT NOT NULL AUTO_INCREMENT UNIQUE
	, id_cliente INT NOT NULL
    , nombre VARCHAR(20) NOT NULL
    , apellido VARCHAR(25)
    , fecha_hora DATETIME NOT NULL
    , usuario VARCHAR(25) NOT NULL
    , PRIMARY KEY (id_log_cliente)
    );
    
DROP TABLE IF EXISTS log_eliminacion_cliente;
CREATE TABLE IF NOT EXISTS log_eliminacion_cliente(
	id_eliminacion_cliente INT NOT NULL AUTO_INCREMENT UNIQUE
    , id_cliente INT NOT NULL
    , nombre VARCHAR(20) NOT NULL
    , apellido VARCHAR(25)
    , fecha_hora DATETIME NOT NULL
    , usuario VARCHAR(25) NOT NULL
    , PRIMARY KEY (id_eliminacion_cliente)
);

DROP TABLE IF EXISTS log_nuevo_producto;
CREATE TABLE IF NOT EXISTS log_nuevo_producto (
	id_log_producto INT NOT NULL AUTO_INCREMENT UNIQUE
    , id_producto INT NOT NULL
	, nombre_producto VARCHAR(35)
    , fecha_hora DATETIME NOT NULL
    , usuario VARCHAR(25) NOT NULL
    , PRIMARY KEY (id_log_producto)
);

DROP TABLE IF EXISTS log_eliminacion_producto;
CREATE TABLE IF NOT EXISTS log_eliminacion_productos (
	id_eliminacion_producto INT NOT NULL AUTO_INCREMENT UNIQUE
    , id_producto INT NOT NULL
	, nombre_producto VARCHAR(35)
    , fecha_hora DATETIME NOT NULL
    , usuario VARCHAR(25) NOT NULL
    , PRIMARY KEY (id_eliminacion_producto)
);

-- Vista que da una lista de clientes que se encuentran dentro de CABA Buenos Aires
CREATE OR REPLACE VIEW clientes_caba_vw AS (
	SELECT nombre,apellido,direccion
	FROM clientes AS c
	JOIN direcciones AS d
	ON c.id_cliente = d.id_cliente
	WHERE ciudad LIKE "%CABA%"
);

-- Vista que muestra los clientes que han hecho compras superiores a los $100000
CREATE OR REPLACE VIEW clientes_mayor_compra_vw AS (
	SELECT DISTINCT nombre,apellido,telefono AS 'Datos cliente'
	FROM clientes AS c
	JOIN facturas AS f
	ON c.id_cliente = f.id_cliente
	JOIN telefonos AS t
	ON c.id_cliente = t.id_cliente
	WHERE f.total >= 100000.00);

-- Vista que da como resultado un resumen de la formula de cada producto
CREATE OR REPLACE VIEW formulas_detalladas_vw AS (
	SELECT CONCAT(f.nombre,' = ',m.nombre_material,' ',df.cantidad,' ',unidad_de_medida) AS "Formula con medidas"
    FROM formulas AS f
    JOIN detalle_formulas AS df
    ON f.id_formula = df.id_formula
    JOIN unidades_medida AS um
    ON df.id_unidad_medida = um.id_unidad_medida
    JOIN materiales AS m
    ON df.id_material = m.id_material
);

-- Vista que muestra los los datos de los proveedores
CREATE OR REPLACE VIEW datos_proveedores_vw AS (
	SELECT p.nombre,nombre_material,t.telefono,e.email
	FROM proveedores AS p
	JOIN materiales AS m
	ON p.id_proveedor = m.id_proveedor
	JOIN telefonos AS t
	ON p.id_proveedor = t.id_proveedor
	JOIN emails AS e
	ON p.id_proveedor = e.id_proveedor
);

-- Vista muestra los choferes con su numero de contacto y disponibilidad
CREATE OR REPLACE VIEW datos_choferes_vw AS (
	SELECT ch.nombre, t.telefono
    FROM choferes AS ch
    JOIN telefonos AS t
    ON ch.id_chofer = t.id_chofer
);

-- Vista que muestra los productos más vendidos
CREATE OR REPLACE VIEW productos_mas_vendidos_vw AS (
	SELECT p.nombre_producto AS Nombre, SUM(df.cantidad) AS Cantidad
	FROM productos AS p
	JOIN detalle_factura AS df
	ON p.id_producto = df.id_producto
	GROUP BY p.nombre_producto
	ORDER BY Cantidad DESC
);

DELIMITER $$

CREATE FUNCTION calc_litros_pintura (ancho INT, alto INT, manos INT) 
RETURNS DECIMAL
NO SQL
BEGIN
	-- Declaracion de variables
	DECLARE resultado DECIMAL;
	DECLARE litro_x_m2 DECIMAL;
	-- Seteo de variables
	SET litro_x_m2 = 0.10;
	SET resultado = ((ancho * alto) * manos) * litro_x_m2;
	-- Retorno resultado
	RETURN resultado;
END$$

-- Funcion que determina el pago de un chofer en base a los kilometros recorridos
CREATE FUNCTION pago_chofer (precio_x_km INT,km_recorridos INT)
RETURNS INT
DETERMINISTIC
BEGIN
	-- Declaracion de variables
    DECLARE pago_total INT;
    -- Seteo de variables
    SET pago_total = precio_x_km * km_recorridos;
    -- Retorno de resultado
    RETURN pago_total;
END$$

# SP que ordena de manera ascendente o descendente una lista de productos
# campo = nombre de la columna a ordenar de la tabla productos
# orden = orden ASC o DESC

CREATE PROCEDURE sp_orden_productos (IN campo VARCHAR(20), IN orden VARCHAR(4))
BEGIN
	# Si los parametros vienen con datos
	IF campo <> '' 
    AND orden <> '' THEN
		SET @orden_productos = CONCAT(' ORDER BY ', campo, ' ', orden);
	# Si ambos parametros están vacios
	ELSE
		SET @orden_productos = CONCAT (' ORDER BY', ' id_producto', ' ASC');
    END IF;
    
    SET @lista = CONCAT('SELECT * FROM fabrica_de_pinturas.productos', @orden_productos);
    
    PREPARE conjunto FROM @lista;
    EXECUTE conjunto;
    DEALLOCATE PREPARE conjunto;
END$$

# SP que ingresa empleados en la tabla de empleados
CREATE PROCEDURE sp_ingreso_empleado (IN id_tipo_empleado INT, IN nombre VARCHAR(25), IN dni INT(15), IN sueldo DECIMAL(12,0))
BEGIN
	INSERT INTO empleados(id_tipo_empleado,nombre,dni,sueldo) VALUES
    (id_tipo_empleado,nombre,dni,sueldo);
END$$

DELIMITER ;

# Trigger que almacena en tabla de bitacora la inserción de un nuevo cliente
CREATE TRIGGER tr_nuevo_cliente
AFTER INSERT ON clientes
FOR EACH ROW
INSERT INTO log_nuevo_cliente (id_cliente,nombre,apellido,fecha_hora,usuario)
VALUES (NEW.id_cliente,NEW.nombre,NEW.apellido,NOW(),USER());

# Trigger que registra en tabla de bitacora la eliminación de un cliente
CREATE TRIGGER tr_eliminar_cliente
BEFORE DELETE ON clientes
FOR EACH ROW
INSERT INTO log_nuevo_cliente (id_cliente,nombre,apellido,fecha_hora,usuario)
VALUES (OLD.id_cliente,OLD.nombre,OLD.apellido,NOW(),USER());

# Trigger que almacena en tabla de bitacora la inserción de un nuevo producto
CREATE TRIGGER tr_nuevo_producto
AFTER INSERT ON productos
FOR EACH ROW
INSERT INTO log_nuevo_producto(id_producto,nombre_producto,fecha_hora,usuario)
VALUES (NEW.id_producto,NEW.nombre_producto,NOW(),USER());

# Trigger que registra en tabla de bitacora la eliminación de un producto
CREATE TRIGGER tr_eliminacion_producto
BEFORE DELETE ON productos
FOR EACH ROW
INSERT INTO log_eliminacion_productos(id_producto,nombre_producto,fecha_hora,usuario)
VALUES (OLD.id_producto,OLD.nombre_producto,NOW(),USER());