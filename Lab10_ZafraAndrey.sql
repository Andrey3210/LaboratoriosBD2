CREATE TABLESPACE EsquemaS7
DATAFILE 'C:\APP\ANDRE\PRODUCT\21C\ORADATA\XE\XEPDB1\EsquemaS7.DBF'
SIZE 128M
AUTOEXTEND ON NEXT 64M MAXSIZE 2048M
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;

CREATE TEMPORARY TABLESPACE TempEsquemaS7
TEMPFILE 'C:\APP\ANDRE\PRODUCT\21C\ORADATA\XE\XEPDB1\TempEsquemaS7.DBF'
SIZE 128M

-- ------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------

DROP TABLE REGIONS

CREATE TABLE REGIONS(
  REGION_ID      NUMBER NOT NULL PRIMARY KEY,
  REGION_NAME    VARCHAR2(25)
) TABLESPACE EsquemaS7;

CREATE TABLE COUNTRIES (
  COUNTRY_ID      CHAR(2) NOT NULL PRIMARY KEY,
  COUNTRY_NAME    VARCHAR2(40),
  REGION_ID       NUMBER,
  
  CONSTRAINT fk_region   FOREIGN KEY (REGION_ID)  REFERENCES REGIONS (REGION_ID)
) TABLESPACE EsquemaS7;

CREATE TABLE LOCATIONS (
  LOCATION_ID     NUMBER(4) NOT NULL PRIMARY KEY,
  STREET_ADDRESS  VARCHAR2(40),
  POSTAL_CODE     VARCHAR2(12),
  CITY            VARCHAR2(30) NOT NULL,
  STATE_PROVINCE  VARCHAR2(25),
  COUNTRY_ID      CHAR(2),
  
  CONSTRAINT fk_country_loc   FOREIGN KEY (COUNTRY_ID)  REFERENCES COUNTRIES (COUNTRY_ID)
) TABLESPACE EsquemaS7;

CREATE TABLE JOBS (
  JOB_ID          VARCHAR2(10) NOT NULL PRIMARY KEY,
  JOB_TITLE       VARCHAR2(35) NOT NULL,
  MIN_SALARY      NUMBER(6),
  MAX_SALARY      NUMBER(6)
) TABLESPACE EsquemaS7;

CREATE TABLE EMPLOYEES (
  EMPLOYEE_ID        NUMBER(6) NOT NULL PRIMARY KEY,
  FIRST_NAME         VARCHAR2(20),
  LAST_NAME          VARCHAR2(20) NOT NULL,
  EMAIL              VARCHAR2(25) NOT NULL,
  PHONE_NUMBER       VARCHAR2(20),
  HIRE_DATE          DATE NOT NULL,
  JOB_ID             VARCHAR2(10) NOT NULL,
  SALARY             NUMBER(8,2),
  COMMISSION_PCT     NUMBER(2,2),
  MANAGER_ID         NUMBER(6),
  DEPARTMENT_ID      NUMBER(4),
  
  CONSTRAINT fk_emp_job   FOREIGN KEY (JOB_ID)  REFERENCES JOBS (JOB_ID),
  CONSTRAINT fk_emp_mang  FOREIGN KEY (MANAGER_ID)  REFERENCES EMPLOYEES (EMPLOYEE_ID)
) TABLESPACE EsquemaS7;

CREATE TABLE DEPARTMENTS (
  DEPARTMENT_ID      NUMBER(4) NOT NULL PRIMARY KEY,
  DEPARTMENT_NAME    VARCHAR2(30) NOT NULL,
  MANAGER_ID         NUMBER(6),
  LOCATION_ID        NUMBER(4),
  
  CONSTRAINT fk_manager   FOREIGN KEY (MANAGER_ID)  REFERENCES EMPLOYEES (EMPLOYEE_ID),
  CONSTRAINT fk_location  FOREIGN KEY (LOCATION_ID)  REFERENCES LOCATIONS (LOCATION_ID)
) TABLESPACE EsquemaS7;

ALTER TABLE EMPLOYEES ADD CONSTRAINT fk_emp_dpt FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS (DEPARTMENT_ID);

CREATE TABLE JOB_HISTORY (
  EMPLOYEE_ID        NUMBER(6) NOT NULL,
  START_DATE         DATE NOT NULL,
  END_DATE           DATE NOT NULL,
  JOB_ID             VARCHAR2(10) NOT NULL,
  DEPARTMENT_ID      NUMBER(4),
  
  CONSTRAINT fk_joh_emp   FOREIGN KEY (EMPLOYEE_ID)  REFERENCES EMPLOYEES (EMPLOYEE_ID),
  CONSTRAINT fk_joh_job   FOREIGN KEY (JOB_ID)  REFERENCES JOBS (JOB_ID),
  CONSTRAINT fk_joh_dpt   FOREIGN KEY (DEPARTMENT_ID)  REFERENCES DEPARTMENTS (DEPARTMENT_ID)
) TABLESPACE EsquemaS7;

-- ------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------

INSERT INTO REGIONS VALUES (1, 'Europe');
INSERT INTO REGIONS VALUES (2, 'Americas');
INSERT INTO REGIONS VALUES (3, 'Asia');
INSERT INTO REGIONS VALUES (4, 'Middle East and Africa');
INSERT INTO REGIONS VALUES (5, 'Oceania');
INSERT INTO REGIONS VALUES (6, 'Antarctica');
INSERT INTO REGIONS VALUES (7, 'Caribbean');
INSERT INTO REGIONS VALUES (8, 'Central America');

INSERT INTO COUNTRIES VALUES ('UK', 'United Kingdom', 1);
INSERT INTO COUNTRIES VALUES ('DE', 'Germany', 1);
INSERT INTO COUNTRIES VALUES ('FR', 'France', 1);
INSERT INTO COUNTRIES VALUES ('ES', 'Spain', 1);
INSERT INTO COUNTRIES VALUES ('IT', 'Italy', 1);
INSERT INTO COUNTRIES VALUES ('US', 'United States', 2);
INSERT INTO COUNTRIES VALUES ('CA', 'Canada', 2);
INSERT INTO COUNTRIES VALUES ('MX', 'Mexico', 2);
INSERT INTO COUNTRIES VALUES ('BR', 'Brazil', 2);
INSERT INTO COUNTRIES VALUES ('AR', 'Argentina', 2);
INSERT INTO COUNTRIES VALUES ('JP', 'Japan', 3);
INSERT INTO COUNTRIES VALUES ('CN', 'China', 3);
INSERT INTO COUNTRIES VALUES ('IN', 'India', 3);
INSERT INTO COUNTRIES VALUES ('KR', 'South Korea', 3);
INSERT INTO COUNTRIES VALUES ('SG', 'Singapore', 3);
INSERT INTO COUNTRIES VALUES ('AE', 'United Arab Emirates', 4);
INSERT INTO COUNTRIES VALUES ('SA', 'Saudi Arabia', 4);
INSERT INTO COUNTRIES VALUES ('EG', 'Egypt', 4);
INSERT INTO COUNTRIES VALUES ('ZA', 'South Africa', 4);
INSERT INTO COUNTRIES VALUES ('NG', 'Nigeria', 4);
INSERT INTO COUNTRIES VALUES ('AU', 'Australia', 5);
INSERT INTO COUNTRIES VALUES ('NZ', 'New Zealand', 5);
INSERT INTO COUNTRIES VALUES ('CU', 'Cuba', 7);
INSERT INTO COUNTRIES VALUES ('DO', 'Dominican Republic', 7);
INSERT INTO COUNTRIES VALUES ('CR', 'Costa Rica', 8);
INSERT INTO COUNTRIES VALUES ('PA', 'Panama', 8);

INSERT INTO LOCATIONS VALUES (1000, 'Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');
INSERT INTO LOCATIONS VALUES (1001, 'Main St', '90210', 'Los Angeles', 'California', 'US');
INSERT INTO LOCATIONS VALUES (1100, 'Via Cola di Rie', '00989', 'Roma', NULL, 'IT');
INSERT INTO LOCATIONS VALUES (1101, 'Rue Lafayette', '75010', 'Paris', NULL, 'FR');
INSERT INTO LOCATIONS VALUES (1200, 'Calle Real', '2901', 'Toronto', 'Ontario', 'CA');
INSERT INTO LOCATIONS VALUES (1201, 'Gran Via 8', '28013', 'Madrid', NULL, 'ES');
INSERT INTO LOCATIONS VALUES (1300, 'Shinjuku Center', NULL, 'Tokyo', NULL, 'JP');
INSERT INTO LOCATIONS VALUES (1301, 'Gangnam Blvd', NULL, 'Seoul', NULL, 'KR');
INSERT INTO LOCATIONS VALUES (1400, 'Burj Avenue', NULL, 'Dubai', NULL, 'AE');
INSERT INTO LOCATIONS VALUES (1401, 'King Fahd Rd', NULL, 'Riyadh', NULL, 'SA');
INSERT INTO LOCATIONS VALUES (1500, 'Oxford Street', 'W1D 2LT', 'London', NULL, 'UK');
INSERT INTO LOCATIONS VALUES (1501, 'Alexanderplatz 1', '10178', 'Berlin', NULL, 'DE');
INSERT INTO LOCATIONS VALUES (1600, 'Great Wall Rd', NULL, 'Beijing', NULL, 'CN');
INSERT INTO LOCATIONS VALUES (1601, 'Mumbai Central', NULL, 'Mumbai', NULL, 'IN');
INSERT INTO LOCATIONS VALUES (1700, 'Nelson Mandela St', NULL, 'Johannesburg', NULL, 'ZA');
INSERT INTO LOCATIONS VALUES (1701, 'Cairo Plaza', NULL, 'Cairo', NULL, 'EG');
INSERT INTO LOCATIONS VALUES (1800, 'Opera House Ave', NULL, 'Sydney', NULL, 'AU');
INSERT INTO LOCATIONS VALUES (1801, 'Queen St', NULL, 'Auckland', NULL, 'NZ');
INSERT INTO LOCATIONS VALUES (1900, 'Malecon 2000', NULL, 'Havana', NULL, 'CU');
INSERT INTO LOCATIONS VALUES (1901, 'Zona Colonial', NULL, 'Santo Domingo', NULL, 'DO');

INSERT INTO JOBS VALUES ('AD_PRES', 'President', 20000, 40000);
INSERT INTO JOBS VALUES ('AD_VP', 'Vice President', 15000, 30000);
INSERT INTO JOBS VALUES ('AD_ASST', 'Administrative Assistant', 3000, 6000);
INSERT INTO JOBS VALUES ('IT_PROG', 'Programmer', 4000, 9000);
INSERT INTO JOBS VALUES ('IT_MGR', 'IT Manager', 9000, 15000);
INSERT INTO JOBS VALUES ('HR_REP', 'HR Representative', 4000, 8000);
INSERT INTO JOBS VALUES ('HR_MGR', 'HR Manager', 8000, 14000);
INSERT INTO JOBS VALUES ('SA_REP', 'Sales Representative', 3000, 10000);
INSERT INTO JOBS VALUES ('SA_MGR', 'Sales Manager', 7000, 16000);
INSERT INTO JOBS VALUES ('AC_ACCOUNT', 'Accountant', 3500, 9000);
INSERT INTO JOBS VALUES ('MK_MAN', 'Marketing Manager', 7000, 15000);
INSERT INTO JOBS VALUES ('MK_REP', 'Marketing Representative', 4000, 9000);
INSERT INTO JOBS VALUES ('PU_CLERK', 'Purchasing Clerk', 2500, 5500);
INSERT INTO JOBS VALUES ('PU_MAN', 'Purchasing Manager', 6500, 12000);
INSERT INTO JOBS VALUES ('FI_MGR', 'Finance Manager', 9000, 16000);
INSERT INTO JOBS VALUES ('FI_ANALYST', 'Financial Analyst', 5000, 10000);

INSERT INTO DEPARTMENTS VALUES (10, 'Administration', NULL, 1500);
INSERT INTO DEPARTMENTS VALUES (20, 'Marketing', NULL, 1500);
INSERT INTO DEPARTMENTS VALUES (30, 'Purchasing', NULL, 1501);
INSERT INTO DEPARTMENTS VALUES (40, 'Human Resources', NULL, 1200);
INSERT INTO DEPARTMENTS VALUES (50, 'Shipping', NULL, 1700);
INSERT INTO DEPARTMENTS VALUES (60, 'IT', NULL, 1300);
INSERT INTO DEPARTMENTS VALUES (70, 'Public Relations', NULL, 1500);
INSERT INTO DEPARTMENTS VALUES (80, 'Sales', NULL, 1000);
INSERT INTO DEPARTMENTS VALUES (90, 'Executive', NULL, 1000);
INSERT INTO DEPARTMENTS VALUES (100, 'Finance', NULL, 1600);
INSERT INTO DEPARTMENTS VALUES (110, 'Accounting', NULL, 1600);
INSERT INTO DEPARTMENTS VALUES (120, 'Support', NULL, 1201);
INSERT INTO DEPARTMENTS VALUES (130, 'Training', NULL, 1800);
INSERT INTO DEPARTMENTS VALUES (140, 'Legal', NULL, 1501);
INSERT INTO DEPARTMENTS VALUES (150, 'Projects', NULL, 1301);

INSERT INTO EMPLOYEES VALUES (100, 'Steven', 'King', 'SKING', '515.123.4567', SYSDATE-2000, 'AD_PRES', 24000, NULL, NULL, 90);
INSERT INTO EMPLOYEES VALUES (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', SYSDATE-1800, 'AD_VP', 17000, NULL, 100, 90);
INSERT INTO EMPLOYEES VALUES (102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', SYSDATE-1700, 'AD_VP', 17000, NULL, 100, 90);
INSERT INTO EMPLOYEES VALUES (200, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', SYSDATE-1500, 'MK_MAN', 13000, NULL, 100, 20);
INSERT INTO EMPLOYEES VALUES (201, 'Pat', 'Fay', 'PFAY', '515.123.5556', SYSDATE-1400, 'MK_REP', 6000, NULL, 200, 20);
INSERT INTO EMPLOYEES VALUES (202, 'Linda', 'Perez', 'LPEREZ', '515.123.5557', SYSDATE-1300, 'MK_REP', 6200, NULL, 200, 20);
INSERT INTO EMPLOYEES VALUES (203, 'Carlos', 'Lopez', 'CLOPEZ', '515.123.5558', SYSDATE-1200, 'MK_REP', 6400, NULL, 200, 20);
INSERT INTO EMPLOYEES VALUES (103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', SYSDATE-1600, 'IT_MGR', 9000, NULL, 102, 60);
INSERT INTO EMPLOYEES VALUES (104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', SYSDATE-1550, 'IT_PROG', 6000, NULL, 103, 60);
INSERT INTO EMPLOYEES VALUES (105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', SYSDATE-1500, 'IT_PROG', 4800, NULL, 103, 60);
INSERT INTO EMPLOYEES VALUES (106, 'Luis', 'Gomez', 'LGOMEZ', '590.423.4570', SYSDATE-1400, 'IT_PROG', 5000, NULL, 103, 60);
INSERT INTO EMPLOYEES VALUES (107, 'Julia', 'Chen', 'JCHEN', '590.423.4571', SYSDATE-1300, 'IT_PROG', 7500, NULL, 103, 60);
INSERT INTO EMPLOYEES VALUES (108, 'Susan', 'Mavris', 'SMAVRIS', '590.423.5555', SYSDATE-1400, 'HR_MGR', 9500, NULL, 101, 40);
INSERT INTO EMPLOYEES VALUES (109, 'Jose', 'Martinez', 'JMARTIN', '590.423.5556', SYSDATE-1300, 'HR_REP', 6000, NULL, 108, 40);
INSERT INTO EMPLOYEES VALUES (110, 'Diana', 'Vega', 'DVEGA', '590.423.5557', SYSDATE-1250, 'HR_REP', 6200, NULL, 108, 40);
INSERT INTO EMPLOYEES VALUES (111, 'Karen', 'Partners', 'KPARTNER', '590.423.6666', SYSDATE-1300, 'SA_MGR', 15000, 0.25, 102, 80);
INSERT INTO EMPLOYEES VALUES (112, 'John', 'Russell', 'JRUSSELL', '590.423.7777', SYSDATE-1200, 'SA_REP', 6200, 0.20, 111, 80);
INSERT INTO EMPLOYEES VALUES (113, 'Charles', 'Johnson', 'CJOHNSON', '590.423.8888', SYSDATE-1000, 'SA_REP', 6100, 0.15, 111, 80);
INSERT INTO EMPLOYEES VALUES (114, 'Maria', 'Santos', 'MSANTOS', '590.423.8899', SYSDATE-900, 'SA_REP', 6500, 0.18, 111, 80);
INSERT INTO EMPLOYEES VALUES (115, 'Ricardo', 'Garcia', 'RGARCIA', '590.423.8900', SYSDATE-800, 'SA_REP', 6400, 0.12, 111, 80);
INSERT INTO EMPLOYEES VALUES (116, 'Tatiana', 'Hernandez', 'THERN', '590.423.8901', SYSDATE-700, 'SA_REP', 6700, 0.16, 111, 80);
INSERT INTO EMPLOYEES VALUES (117, 'Nancy', 'Green', 'NGREEN', '590.423.1111', SYSDATE-1000, 'FI_MGR', 12000, NULL, 101, 100);
INSERT INTO EMPLOYEES VALUES (118, 'Ethan', 'Brown', 'EBROWN', '590.423.1112', SYSDATE-950, 'FI_ANALYST', 7000, NULL, 117, 100);
INSERT INTO EMPLOYEES VALUES (119, 'Oliver', 'Smith', 'OSMITH', '590.423.1113', SYSDATE-900, 'FI_ANALYST', 7200, NULL, 117, 100);
INSERT INTO EMPLOYEES VALUES (120, 'Liam', 'Taylor', 'LTAYLOR', '590.423.1114', SYSDATE-850, 'AC_ACCOUNT', 6500, NULL, 117, 110);
INSERT INTO EMPLOYEES VALUES (121, 'Sophia', 'White', 'SWHITE', '590.423.1115', SYSDATE-800, 'AC_ACCOUNT', 6700, NULL, 117, 110);

UPDATE DEPARTMENTS SET MANAGER_ID = 100 WHERE DEPARTMENT_ID = 90;
UPDATE DEPARTMENTS SET MANAGER_ID = 200 WHERE DEPARTMENT_ID = 20;
UPDATE DEPARTMENTS SET MANAGER_ID = 103 WHERE DEPARTMENT_ID = 60;
UPDATE DEPARTMENTS SET MANAGER_ID = 108 WHERE DEPARTMENT_ID = 40;
UPDATE DEPARTMENTS SET MANAGER_ID = 111 WHERE DEPARTMENT_ID = 80;
UPDATE DEPARTMENTS SET MANAGER_ID = 117 WHERE DEPARTMENT_ID = 100;
UPDATE DEPARTMENTS SET MANAGER_ID = 120 WHERE DEPARTMENT_ID = 110;

INSERT INTO JOB_HISTORY VALUES (104, SYSDATE-1000, SYSDATE-900, 'IT_PROG', 60);
INSERT INTO JOB_HISTORY VALUES (105, SYSDATE-900, SYSDATE-800, 'IT_PROG', 60);
INSERT INTO JOB_HISTORY VALUES (107, SYSDATE-800, SYSDATE-700, 'IT_PROG', 60);
INSERT INTO JOB_HISTORY VALUES (201, SYSDATE-600, SYSDATE-500, 'MK_REP', 20);
INSERT INTO JOB_HISTORY VALUES (112, SYSDATE-500, SYSDATE-400, 'SA_REP', 80);
INSERT INTO JOB_HISTORY VALUES (118, SYSDATE-400, SYSDATE-300, 'FI_ANALYST', 100);
INSERT INTO JOB_HISTORY VALUES (120, SYSDATE-350, SYSDATE-250, 'AC_ACCOUNT', 110);
INSERT INTO JOB_HISTORY VALUES (121, SYSDATE-200, SYSDATE-100, 'AC_ACCOUNT', 110);

COMMIT;

-- ------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------

SET SERVEROUTPUT ON;

-- Ejercicio 1
BEGIN
    UPDATE EMPLOYEES
    SET SALARY = SALARY * 1.10
    WHERE DEPARTMENT_ID = 90;
    
    DBMS_OUTPUT.PUT_LINE('Aumento del 10% aplicado al Departamento 90.');

    SAVEPOINT punto1;

    UPDATE EMPLOYEES
    SET SALARY = SALARY * 1.05
    WHERE DEPARTMENT_ID = 60;
    
    DBMS_OUTPUT.PUT_LINE('Aumento del 5% aplicado al Departamento 60.');

    ROLLBACK TO punto1;
    DBMS_OUTPUT.PUT_LINE('ROLLBACK realizado al SAVEPOINT punto1.');

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transacción confirmada con COMMIT.');
    -- a. ¿Qué departamento mantuvo los cambios?
    -- El departamento 90, porque su aumento del 10 % ocurrió antes del SAVEPOINT y se confirmó con el COMMIT
    -- b. ¿Qué efecto tuvo el ROLLBACK parcial?
    -- El ROLLBACK TO punto1 revirtió únicamente las modificaciones hechas después de crear el SAVEPOINT, es decir, el aumento del 5 % del departamento 60. No afectó los cambios anteriores (depto 90).
    -- c.¿Qué ocurriría si se ejecutara ROLLBACK sin especificar SAVEPOINT?
    -- Si se ejecutara ROLLBACK sin SAVEPOINT, se revertirían todos los cambios efectuados en la transacción.
END;
/

-- Ejercicio 2
UPDATE employees
SET salary = salary + 500
WHERE employee_id = 103;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 103;

ROLLBACK;
    -- a. ¿Por qué la segunda sesión quedó bloqueada?
    -- La segunda sesión quedó bloqueada porque la primera tenía un bloqueo exclusivo sobre el mismo registro al no haber ejecutado COMMIT ni ROLLBACK.
    -- b. ¿Qué comando libera los bloqueos?
    -- Los bloqueos se liberan al ejecutar COMMIT o ROLLBACK en la sesión que los generó.
    -- c.¿Qué vistas del diccionario permiten verificar sesiones bloqueadas?
    -- Las vistas del diccionario que permiten verificar sesiones bloqueadas son V$LOCK, V$SESSION, DBA_BLOCKERS y DBA_WAITERS.

-- Ejercicio 3
DECLARE
    v_emp_id        EMPLOYEES.EMPLOYEE_ID%TYPE := 104;
    v_old_dept_id   EMPLOYEES.DEPARTMENT_ID%TYPE;
    v_new_dept_id   DEPARTMENTS.DEPARTMENT_ID%TYPE := 110;
    v_job_id        EMPLOYEES.JOB_ID%TYPE;
    v_start_date    DATE;
BEGIN
    SELECT department_id, job_id, hire_date
    INTO v_old_dept_id, v_job_id, v_start_date
    FROM EMPLOYEES
    WHERE employee_id = v_emp_id;

    UPDATE EMPLOYEES
    SET department_id = v_new_dept_id
    WHERE employee_id = v_emp_id;

    INSERT INTO JOB_HISTORY (employee_id, start_date, end_date, job_id, department_id)
    VALUES (v_emp_id, v_start_date, SYSDATE, v_job_id, v_old_dept_id);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transferencia completada con éxito.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error en la transferencia: ' || SQLERRM);
END;
/
    -- a. ¿Por qué se debe garantizar la atomicidad entre las dos operaciones?
    -- Se debe garantizar la atomicidad porque ambas operaciones (actualización e inserción) forman parte de una misma transacción y deben realizarse o deshacerse juntas para mantener la coherencia de los datos.
    -- b. ¿Qué pasaría si se produce un error antes del COMMIT?
    -- Si se produce un error antes del COMMIT, el ROLLBACK revertirá todos los cambios, dejando la base de datos en su estado anterior.
    -- c.¿Cómo se asegura la integridad entre EMPLOYEES y JOB_HISTORY?
    -- La integridad entre EMPLOYEES y JOB_HISTORY se asegura mediante claves foráneas (FOREIGN KEY) que garantizan que solo se registren empleados y departamentos válidos.

-- Ejercicio 4
BEGIN
    UPDATE EMPLOYEES
    SET SALARY = SALARY * 1.08
    WHERE DEPARTMENT_ID = 100;
    DBMS_OUTPUT.PUT_LINE('Aumento del 8% aplicado al Departamento 100.');
    
    SAVEPOINT A;
    
    UPDATE EMPLOYEES
    SET SALARY = SALARY * 1.05
    WHERE DEPARTMENT_ID = 80;
    DBMS_OUTPUT.PUT_LINE('Aumento del 5% aplicado al Departamento 80.');
    
    SAVEPOINT B;
    
    DELETE FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 50;
    DBMS_OUTPUT.PUT_LINE('Empleados del Departamento 50 eliminados.');
    
    ROLLBACK TO B;
    DBMS_OUTPUT.PUT_LINE('Reversión parcial hasta SAVEPOINT B.');
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transacción confirmada con COMMIT.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error durante la transacción: ' || SQLERRM);
END;
/
    -- a. ¿Qué cambios quedan persistentes?
    -- Quedan persistentes los aumentos salariales del 8 % en el departamento 100 y del 5 % en el departamento 80, ya que ambos ocurrieron antes del ROLLBACK.
    -- b. ¿Qué sucede con las filas eliminadas?
    -- Las filas eliminadas del departamento 50 fueron restauradas, porque el ROLLBACK TO B deshizo esa operación.
    -- c.¿Cómo puedes verificar los cambios antes y después del COMMIT?
    -- Los cambios pueden verificarse con consultas SELECT sobre la tabla EMPLOYEES antes y después del COMMIT, o usando DBMS_OUTPUT.PUT_LINE para mostrar los valores temporales dentro del bloque.
