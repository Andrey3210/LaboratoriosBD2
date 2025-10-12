CREATE TABLESPACE EsquemaS8
DATAFILE 'C:\APP\ANDRE\PRODUCT\21C\ORADATA\XE\XEPDB1\EsquemaS8.DBF'
SIZE 128M
AUTOEXTEND ON NEXT 64M MAXSIZE 2048M
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;

CREATE TEMPORARY TABLESPACE TempEsquemaS8
TEMPFILE 'C:\APP\ANDRE\PRODUCT\21C\ORADATA\XE\XEPDB1\TempEsquemaS8.DBF'
SIZE 128M

-- ------------------------------------------------------------------------------------------------------
-- -----------------------------CREACIÓN DE TABLAS-------------------------------------------------------

CREATE TABLE S(
  S#        CHAR(4) NOT NULL PRIMARY KEY,
  SNAME     VARCHAR2(25),
  STATUS    NUMBER,
  CITY      VARCHAR2(25)
) TABLESPACE EsquemaS8;

CREATE TABLE P(
  P#        CHAR(4) NOT NULL PRIMARY KEY,
  PNAME     VARCHAR2(25),
  COLOR     VARCHAR2(25),
  WEIGHT    NUMBER,
  CITY      VARCHAR2(25)
) TABLESPACE EsquemaS8;

CREATE TABLE SP(
  S#        CHAR(4) NOT NULL,
  P#        CHAR(4) NOT NULL,
  QTY       NUMBER,
  CONSTRAINT pk_SP PRIMARY KEY (S#, P#),
  CONSTRAINT fk_SP_S   FOREIGN KEY (S#)  REFERENCES S (S#),
  CONSTRAINT fk_SP_P   FOREIGN KEY (P#)  REFERENCES P (P#)
) TABLESPACE EsquemaS8;

CREATE TABLE J(
  J#        CHAR(4) NOT NULL PRIMARY KEY,
  JNAME     VARCHAR2(25),
  CITY      VARCHAR2(25)
) TABLESPACE EsquemaS8;

CREATE TABLE SPJ(
  S#        CHAR(4) NOT NULL,
  P#        CHAR(4) NOT NULL,
  J#        CHAR(4) NOT NULL,
  QTY       NUMBER,
  CONSTRAINT pk_SPJ PRIMARY KEY (S#, P#, J#),
  CONSTRAINT fk_SPJ_S   FOREIGN KEY (S#)  REFERENCES S (S#),
  CONSTRAINT fk_SPJ_P   FOREIGN KEY (P#)  REFERENCES P (P#),
  CONSTRAINT fk_SPJ_J   FOREIGN KEY (J#)  REFERENCES J (J#)
) TABLESPACE EsquemaS8;

-- ------------------------------------------------------------------------------------------------------
-- ---------------------------INSERCIÓN DE REGISTROS-----------------------------------------------------

INSERT INTO S VALUES ('S1', 'Carlos Gomez', 20, 'Lima');
INSERT INTO S VALUES ('S2', 'Ana Torres', 10, 'Arequipa');
INSERT INTO S VALUES ('S3', 'Luis Fernandez', 30, 'Trujillo');
INSERT INTO S VALUES ('S4', 'Maria Rojas', 40, 'Cusco');
INSERT INTO S VALUES ('S5', 'Pedro Castillo', 10, 'Chiclayo');
INSERT INTO S VALUES ('S6', 'Rosa Vargas', 15, 'Piura');
INSERT INTO S VALUES ('S7', 'Jorge Soto', 25, 'Huancayo');
INSERT INTO S VALUES ('S8', 'Elena Ramos', 30, 'Iquitos');
INSERT INTO S VALUES ('S9', 'Raul Mendoza', 35, 'Tacna');
INSERT INTO S VALUES ('S10', 'Lucia Paredes', 20, 'Lima');
INSERT INTO S VALUES ('S11', 'Sofia Alvarez', 18, 'New York');
INSERT INTO S VALUES ('S12', 'Miguel Blanco', 22, 'London');
INSERT INTO S VALUES ('S13', 'Claudia Jimenez', 27, 'Tokyo');
INSERT INTO S VALUES ('S14', 'Fernando Diaz', 33, 'Paris');
INSERT INTO S VALUES ('S15', 'Isabel Cruz', 19, 'Berlin');
INSERT INTO S VALUES ('S16', 'Ricardo Vargas', 21, 'Sydney');
INSERT INTO S VALUES ('S17', 'Patricia Molina', 26, 'Dubai');
INSERT INTO S VALUES ('S18', 'Javier Castro', 24, 'Toronto');
INSERT INTO S VALUES ('S19', 'Veronica Leon', 28, 'Moscow');
INSERT INTO S VALUES ('S20', 'Alberto Ramos', 30, 'Rome');

INSERT INTO P VALUES ('P1', 'Tornillo', 'Plata', 12, 'Lima');
INSERT INTO P VALUES ('P2', 'Tuerca', 'Negro', 8, 'Arequipa');
INSERT INTO P VALUES ('P3', 'Engranaje', 'Rojo', 50, 'Trujillo');
INSERT INTO P VALUES ('P4', 'Eje', 'Gris', 80, 'Lima');
INSERT INTO P VALUES ('P5', 'Rueda', 'Negro', 120, 'Cusco');
INSERT INTO P VALUES ('P6', 'Motor', 'Azul', 250, 'Chiclayo');
INSERT INTO P VALUES ('P7', 'Cable', 'Blanco', 5, 'Piura');
INSERT INTO P VALUES ('P8', 'Placa', 'Verde', 45, 'Iquitos');
INSERT INTO P VALUES ('P9', 'Ventilador', 'Negro', 100, 'Tacna');
INSERT INTO P VALUES ('P10', 'Buje', 'Plateado', 15, 'Huancayo');
INSERT INTO P VALUES ('P11', 'Resorte', 'Rojo', 10, 'New York');
INSERT INTO P VALUES ('P12', 'Tuerca Especial', 'Dorado', 20, 'London');
INSERT INTO P VALUES ('P13', 'Piñon', 'Plateado', 35, 'Tokyo');
INSERT INTO P VALUES ('P14', 'Rodamiento', 'Negro', 50, 'Paris');
INSERT INTO P VALUES ('P15', 'Chasis', 'Gris', 150, 'Berlin');
INSERT INTO P VALUES ('P16', 'Palanca', 'Azul', 25, 'Sydney');
INSERT INTO P VALUES ('P17', 'Biela', 'Verde', 40, 'Dubai');
INSERT INTO P VALUES ('P18', 'Correa', 'Negro', 12, 'Toronto');
INSERT INTO P VALUES ('P19', 'Tubo', 'Plateado', 30, 'Moscow');
INSERT INTO P VALUES ('P20', 'Eje Principal', 'Rojo', 80, 'Rome');

INSERT INTO SP VALUES ('S1', 'P1', 500);
INSERT INTO SP VALUES ('S1', 'P2', 200);
INSERT INTO SP VALUES ('S1', 'P3', 150);
INSERT INTO SP VALUES ('S2', 'P2', 300);
INSERT INTO SP VALUES ('S2', 'P5', 100);
INSERT INTO SP VALUES ('S2', 'P7', 400);
INSERT INTO SP VALUES ('S3', 'P4', 350);
INSERT INTO SP VALUES ('S3', 'P8', 180);
INSERT INTO SP VALUES ('S3', 'P9', 60);
INSERT INTO SP VALUES ('S4', 'P1', 220);
INSERT INTO SP VALUES ('S4', 'P5', 90);
INSERT INTO SP VALUES ('S4', 'P10', 500);
INSERT INTO SP VALUES ('S5', 'P3', 75);
INSERT INTO SP VALUES ('S5', 'P4', 210);
INSERT INTO SP VALUES ('S5', 'P6', 40);
INSERT INTO SP VALUES ('S6', 'P2', 320);
INSERT INTO SP VALUES ('S6', 'P7', 90);
INSERT INTO SP VALUES ('S7', 'P9', 180);
INSERT INTO SP VALUES ('S7', 'P10', 220);
INSERT INTO SP VALUES ('S8', 'P8', 150);
INSERT INTO SP VALUES ('S9', 'P1', 100);
INSERT INTO SP VALUES ('S9', 'P3', 70);
INSERT INTO SP VALUES ('S9', 'P5', 60);
INSERT INTO SP VALUES ('S10', 'P6', 200);
INSERT INTO SP VALUES ('S10', 'P7', 400);
INSERT INTO SP VALUES ('S10', 'P9', 80);
INSERT INTO SP VALUES ('S11', 'P11', 150);
INSERT INTO SP VALUES ('S11', 'P12', 90);
INSERT INTO SP VALUES ('S12', 'P13', 200);
INSERT INTO SP VALUES ('S12', 'P14', 120);
INSERT INTO SP VALUES ('S13', 'P15', 80);
INSERT INTO SP VALUES ('S13', 'P16', 110);
INSERT INTO SP VALUES ('S14', 'P17', 90);
INSERT INTO SP VALUES ('S14', 'P18', 100);
INSERT INTO SP VALUES ('S15', 'P19', 130);
INSERT INTO SP VALUES ('S15', 'P20', 70);
INSERT INTO SP VALUES ('S16', 'P11', 140);
INSERT INTO SP VALUES ('S16', 'P12', 120);
INSERT INTO SP VALUES ('S17', 'P13', 160);
INSERT INTO SP VALUES ('S17', 'P14', 150);
INSERT INTO SP VALUES ('S18', 'P15', 100);
INSERT INTO SP VALUES ('S18', 'P16', 90);
INSERT INTO SP VALUES ('S19', 'P17', 120);
INSERT INTO SP VALUES ('S19', 'P18', 110);
INSERT INTO SP VALUES ('S20', 'P19', 140);
INSERT INTO SP VALUES ('S20', 'P20', 160);

INSERT INTO J VALUES ('J1', 'Puente Central', 'Lima');
INSERT INTO J VALUES ('J2', 'Carretera Sur', 'Arequipa');
INSERT INTO J VALUES ('J3', 'Edificio Andino', 'Cusco');
INSERT INTO J VALUES ('J4', 'Puerto Norte', 'Trujillo');
INSERT INTO J VALUES ('J5', 'Torre del Sol', 'Chiclayo');
INSERT INTO J VALUES ('J6', 'Fábrica Industrial', 'Piura');
INSERT INTO J VALUES ('J7', 'Central Hidroelectrica', 'Iquitos');
INSERT INTO J VALUES ('J8', 'Estadio Nacional', 'Lima');
INSERT INTO J VALUES ('J9', 'Hospital Regional', 'Tacna');
INSERT INTO J VALUES ('J10', 'Universidad del Sur', 'Arequipa');
INSERT INTO J VALUES ('J11', 'Sky Tower', 'New York');
INSERT INTO J VALUES ('J12', 'London Bridge', 'London');
INSERT INTO J VALUES ('J13', 'Tokyo Dome', 'Tokyo');
INSERT INTO J VALUES ('J14', 'Eiffel Tower Renovation', 'Paris');
INSERT INTO J VALUES ('J15', 'Berlin Wall Memorial', 'Berlin');
INSERT INTO J VALUES ('J16', 'Sydney Opera House', 'Sydney');
INSERT INTO J VALUES ('J17', 'Burj Khalifa Expansion', 'Dubai');
INSERT INTO J VALUES ('J18', 'CN Tower Upgrade', 'Toronto');
INSERT INTO J VALUES ('J19', 'Moscow Metro', 'Moscow');
INSERT INTO J VALUES ('J20', 'Colosseum Restoration', 'Rome');

INSERT INTO SPJ VALUES ('S1', 'P1', 'J1', 300);
INSERT INTO SPJ VALUES ('S1', 'P2', 'J1', 150);
INSERT INTO SPJ VALUES ('S1', 'P3', 'J4', 200);
INSERT INTO SPJ VALUES ('S2', 'P2', 'J2', 100);
INSERT INTO SPJ VALUES ('S2', 'P5', 'J3', 80);
INSERT INTO SPJ VALUES ('S2', 'P7', 'J6', 150);
INSERT INTO SPJ VALUES ('S3', 'P4', 'J4', 200);
INSERT INTO SPJ VALUES ('S3', 'P8', 'J7', 120);
INSERT INTO SPJ VALUES ('S3', 'P9', 'J9', 70);
INSERT INTO SPJ VALUES ('S4', 'P1', 'J1', 100);
INSERT INTO SPJ VALUES ('S4', 'P5', 'J5', 50);
INSERT INTO SPJ VALUES ('S4', 'P10', 'J8', 180);
INSERT INTO SPJ VALUES ('S5', 'P3', 'J4', 90);
INSERT INTO SPJ VALUES ('S5', 'P6', 'J6', 30);
INSERT INTO SPJ VALUES ('S5', 'P4', 'J9', 120);
INSERT INTO SPJ VALUES ('S6', 'P7', 'J7', 60);
INSERT INTO SPJ VALUES ('S6', 'P2', 'J3', 200);
INSERT INTO SPJ VALUES ('S7', 'P10', 'J10', 140);
INSERT INTO SPJ VALUES ('S7', 'P9', 'J9', 100);
INSERT INTO SPJ VALUES ('S8', 'P8', 'J7', 70);
INSERT INTO SPJ VALUES ('S9', 'P3', 'J5', 90);
INSERT INTO SPJ VALUES ('S9', 'P5', 'J8', 60);
INSERT INTO SPJ VALUES ('S10', 'P6', 'J6', 150);
INSERT INTO SPJ VALUES ('S10', 'P9', 'J9', 80);
INSERT INTO SPJ VALUES ('S10', 'P7', 'J10', 200);
INSERT INTO SPJ VALUES ('S11', 'P11', 'J11', 100);
INSERT INTO SPJ VALUES ('S11', 'P12', 'J12', 150);
INSERT INTO SPJ VALUES ('S12', 'P13', 'J13', 180);
INSERT INTO SPJ VALUES ('S12', 'P14', 'J14', 120);
INSERT INTO SPJ VALUES ('S13', 'P15', 'J15', 90);
INSERT INTO SPJ VALUES ('S13', 'P16', 'J16', 70);
INSERT INTO SPJ VALUES ('S14', 'P17', 'J17', 80);
INSERT INTO SPJ VALUES ('S14', 'P18', 'J18', 60);
INSERT INTO SPJ VALUES ('S15', 'P19', 'J19', 130);
INSERT INTO SPJ VALUES ('S15', 'P20', 'J20', 70);
INSERT INTO SPJ VALUES ('S16', 'P11', 'J11', 140);
INSERT INTO SPJ VALUES ('S16', 'P12', 'J12', 120);
INSERT INTO SPJ VALUES ('S17', 'P13', 'J13', 160);
INSERT INTO SPJ VALUES ('S17', 'P14', 'J14', 150);
INSERT INTO SPJ VALUES ('S18', 'P15', 'J15', 100);
INSERT INTO SPJ VALUES ('S18', 'P16', 'J16', 90);
INSERT INTO SPJ VALUES ('S19', 'P17', 'J17', 120);
INSERT INTO SPJ VALUES ('S19', 'P18', 'J18', 110);
INSERT INTO SPJ VALUES ('S20', 'P19', 'J19', 140);
INSERT INTO SPJ VALUES ('S20', 'P20', 'J20', 160);
INSERT INTO SPJ VALUES ('S1', 'P4', 'J8', 100);
INSERT INTO SPJ VALUES ('S3', 'P5', 'J2', 110);
INSERT INTO SPJ VALUES ('S4', 'P2', 'J4', 90);
INSERT INTO SPJ VALUES ('S5', 'P8', 'J7', 70);
INSERT INTO SPJ VALUES ('S6', 'P9', 'J9', 60);

-- ------------------------------------------------------------------------------------------------------
-- ---------------------------PROCEDIMIENTOS Y FUNCIONES-------------------------------------------------

--- 4.1.1 ---
CREATE OR REPLACE PROCEDURE partes_no_paris IS
BEGIN
  FOR rec IN (
    SELECT COLOR, CITY
    FROM P
    WHERE CITY != 'Paris' AND WEIGHT > 10
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Color: ' || rec.COLOR || ', Ciudad: ' || rec.CITY);
  END LOOP;
END;
/
-- Prueba
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- 4.1.1 ---');
  partes_no_paris;
END;
/

--- 4.1.2 ---
CREATE OR REPLACE PROCEDURE partes_en_gramos IS
BEGIN
  FOR rec IN (
    SELECT P#, WEIGHT * 453.592 AS PESO_GR
    FROM P
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Parte: ' || rec.P# || ', Peso (g): ' || rec.PESO_GR || ' g');
  END LOOP;
END;
/
-- Prueba
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- 4.1.2 ---');
  partes_en_gramos;
END;
/

--- 4.1.3 ---
CREATE OR REPLACE PROCEDURE detalle_proveedores IS
BEGIN
  FOR rec IN (SELECT * FROM S) LOOP
    DBMS_OUTPUT.PUT_LINE('S#: ' || rec.S# || ', Nombre: ' || rec.SNAME || 
                         ', Estado: ' || rec.STATUS || ', Ciudad: ' || rec.CITY);
  END LOOP;
END;
/
-- Prueba
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- 4.1.3 ---');
  detalle_proveedores;
END;
/

--- 4.1.4 ---
CREATE OR REPLACE PROCEDURE proveedores_partes_colocalizados IS
BEGIN
  FOR rec IN (
    SELECT S.S#, P.P#
    FROM S JOIN P ON S.CITY = P.CITY
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Proveedor: ' || rec.S# || ', Parte: ' || rec.P#);
  END LOOP;
END;
/
-- Prueba
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- 4.1.4 ---');
  proveedores_partes_colocalizados;
END;
/

--- 4.1.5 ---
CREATE OR REPLACE PROCEDURE pares_ciudades IS
BEGIN
  FOR rec IN (
    SELECT DISTINCT S.CITY AS ciudad_prov, P.CITY AS ciudad_parte
    FROM S JOIN SP ON S.S# = SP.S#
           JOIN P ON SP.P# = P.P#
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Proveedor: ' || rec.ciudad_prov || ', Parte: ' || rec.ciudad_parte);
  END LOOP;
END;
/
-- Prueba
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- 4.1.5 ---');
  pares_ciudades;
END;
/

--- 4.1.6 ---
CREATE OR REPLACE PROCEDURE proveedores_colocalizados IS
BEGIN
  FOR rec IN (
    SELECT A.S# AS S1, B.S# AS S2
    FROM S A, S B
    WHERE A.CITY = B.CITY AND A.S# < B.S#
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('S1: ' || rec.S1 || ', S2: ' || rec.S2);
  END LOOP;
END;
/
-- Prueba
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- 4.1.6 ---');
  proveedores_colocalizados;
END;
/

--- 4.1.7 ---
CREATE OR REPLACE FUNCTION total_proveedores RETURN NUMBER IS
  total NUMBER;
BEGIN
  SELECT COUNT(*) INTO total FROM S;
  RETURN total;
END;
/
-- Prueba
DECLARE
  total NUMBER;
BEGIN
  total := total_proveedores;
  DBMS_OUTPUT.PUT_LINE('--- 4.1.7 ---');
  DBMS_OUTPUT.PUT_LINE('Total proveedores: ' || total);
END;
/

--- 4.1.8 ---
CREATE OR REPLACE PROCEDURE min_max_P2 IS
  min_qty NUMBER;
  max_qty NUMBER;
BEGIN
  SELECT MIN(QTY), MAX(QTY) INTO min_qty, max_qty
  FROM SP
  WHERE P# = 'P2';
  DBMS_OUTPUT.PUT_LINE('Cantidad mínima: ' || min_qty || ', máxima: ' || max_qty);
END;
/
-- Prueba
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- 4.1.8 ---');
  min_max_P2;
END;
/

--- 4.1.9 ---
CREATE OR REPLACE PROCEDURE total_despachado IS
BEGIN
  FOR rec IN (
    SELECT P#, SUM(QTY) AS total
    FROM SP
    GROUP BY P#
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Parte: ' || rec.P# || ', Total despachado: ' || rec.total);
  END LOOP;
END;
/
-- Prueba
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- 4.1.9 ---');
  total_despachado;
END;
/

--- 4.1.10 ---
CREATE OR REPLACE PROCEDURE partes_varios_proveedores IS
BEGIN
  FOR rec IN (
    SELECT P#
    FROM SP
    GROUP BY P#
    HAVING COUNT(DISTINCT S#) > 1
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Parte: ' || rec.P#);
  END LOOP;
END;
/
-- Prueba
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- 4.1.10 ---');
  partes_varios_proveedores;
END;
/

--- 4.1.11 ---
CREATE OR REPLACE PROCEDURE proveedores_P2 IS
BEGIN
  FOR rec IN (
    SELECT SNAME
    FROM S JOIN SP ON S.S# = SP.S#
    WHERE SP.P# = 'P2'
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Proveedor: ' || rec.SNAME);
  END LOOP;
END;
/
-- Prueba
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- 4.1.11 ---');
  proveedores_P2;
END;
/

--- 4.1.12 ---
CREATE OR REPLACE PROCEDURE proveedores_al_menos_una IS
BEGIN
  FOR rec IN (
    SELECT DISTINCT SNAME
    FROM S JOIN SP ON S.S# = SP.S#
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Proveedor: ' || rec.SNAME);
  END LOOP;
END;
/
-- Prueba
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- 4.1.12 ---');
  proveedores_al_menos_una;
END;
/

--- 4.1.13 ---
CREATE OR REPLACE PROCEDURE proveedores_estado_menor_max IS
  max_estado NUMBER;
BEGIN
  SELECT MAX(STATUS) INTO max_estado FROM S;
  FOR rec IN (
    SELECT S# FROM S WHERE STATUS < max_estado
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Proveedor: ' || rec.S#);
  END LOOP;
END;
/
-- Prueba
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- 4.1.13 ---');
  proveedores_estado_menor_max;
END;
/

--- 4.1.14 ---
CREATE OR REPLACE PROCEDURE proveedores_P2_exists IS
BEGIN
  FOR rec IN (
    SELECT SNAME
    FROM S
    WHERE EXISTS (
      SELECT 1 FROM SP WHERE SP.S# = S.S# AND P# = 'P2'
    )
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Proveedor: ' || rec.SNAME);
  END LOOP;
END;
/
-- Prueba
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- 4.1.14 ---');
  proveedores_P2_exists;
END;
/

--- 4.1.15 ---
CREATE OR REPLACE PROCEDURE proveedores_no_P2 IS
BEGIN
  FOR rec IN (
    SELECT SNAME
    FROM S
    WHERE S# NOT IN (
      SELECT S# FROM SP WHERE P# = 'P2'
    )
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Proveedor: ' || rec.SNAME);
  END LOOP;
END;
/
-- Prueba
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- 4.1.15 ---');
  proveedores_no_P2;
END;
/

--- 4.1.16 ---
CREATE OR REPLACE PROCEDURE proveedores_todas_partes IS
  total_partes NUMBER;
BEGIN
  SELECT COUNT(*) INTO total_partes FROM P;
  FOR rec IN (
    SELECT S#
    FROM SP
    GROUP BY S#
    HAVING COUNT(DISTINCT P#) = total_partes
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Proveedor: ' || rec.S#);
  END LOOP;
END;
/
-- Prueba
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- 4.1.16 ---');
  proveedores_todas_partes;
END;
/

--- 4.1.17 ---
CREATE OR REPLACE PROCEDURE partes_peso_o_S2 IS
BEGIN
  FOR rec IN (
    SELECT DISTINCT P.P#
    FROM P LEFT JOIN SP ON P.P# = SP.P#
    WHERE P.WEIGHT > 16 OR SP.S# = 'S2'
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Parte: ' || rec.P#);
  END LOOP;
END;
/
-- Prueba
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- 4.1.17 ---');
  partes_peso_o_S2;
END;
/
