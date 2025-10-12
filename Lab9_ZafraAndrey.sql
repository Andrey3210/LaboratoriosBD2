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

-- Paquete employee
CREATE OR REPLACE PACKAGE pkg_employee IS

  -- CRUD
  PROCEDURE create_employee(
    p_employee_id    IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    p_first_name     IN EMPLOYEES.FIRST_NAME%TYPE,
    p_last_name      IN EMPLOYEES.LAST_NAME%TYPE,
    p_email          IN EMPLOYEES.EMAIL%TYPE,
    p_phone_number   IN EMPLOYEES.PHONE_NUMBER%TYPE,
    p_hire_date      IN EMPLOYEES.HIRE_DATE%TYPE,
    p_job_id         IN EMPLOYEES.JOB_ID%TYPE,
    p_salary         IN EMPLOYEES.SALARY%TYPE,
    p_commission_pct IN EMPLOYEES.COMMISSION_PCT%TYPE,
    p_manager_id     IN EMPLOYEES.MANAGER_ID%TYPE,
    p_department_id  IN EMPLOYEES.DEPARTMENT_ID%TYPE
  );

  PROCEDURE update_employee(
    p_employee_id    IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    p_first_name     IN EMPLOYEES.FIRST_NAME%TYPE,
    p_last_name      IN EMPLOYEES.LAST_NAME%TYPE,
    p_email          IN EMPLOYEES.EMAIL%TYPE,
    p_phone_number   IN EMPLOYEES.PHONE_NUMBER%TYPE,
    p_hire_date      IN EMPLOYEES.HIRE_DATE%TYPE,
    p_job_id         IN EMPLOYEES.JOB_ID%TYPE,
    p_salary         IN EMPLOYEES.SALARY%TYPE,
    p_commission_pct IN EMPLOYEES.COMMISSION_PCT%TYPE,
    p_manager_id     IN EMPLOYEES.MANAGER_ID%TYPE,
    p_department_id  IN EMPLOYEES.DEPARTMENT_ID%TYPE
  );

  PROCEDURE delete_employee(p_employee_id IN EMPLOYEES.EMPLOYEE_ID%TYPE);

  FUNCTION get_employee(p_employee_id IN EMPLOYEES.EMPLOYEE_ID%TYPE)
    RETURN SYS_REFCURSOR;

  FUNCTION list_employees RETURN SYS_REFCURSOR;

  -- 3.1.1: Procedimiento: 4 empleados que más han rotado de puesto
  PROCEDURE top4_mas_rotacion;

  -- 3.1.2: Función: resumen estadístico promedio de contrataciones por mes
  -- Muestra (DBMS_OUTPUT) el listado (NombreMes, PromedioContrataciones)
  -- Devuelve el total de meses considerados (NUMBER)
  FUNCTION promedio_contrataciones_por_mes RETURN NUMBER;

  -- 3.1.3: Procedimiento: gastos en salario y estadística por región
  PROCEDURE gasto_salario_por_region;

  -- 3.1.4: Función: calcula tiempo de servicio y vacaciones.
  -- Muestra por empleado (DBMS_OUTPUT) y devuelve el monto total empleado para las vacaciones.
  FUNCTION monto_total_vacaciones RETURN NUMBER;

END pkg_employee;
/

CREATE OR REPLACE PACKAGE BODY pkg_employee IS

  ----------------------------------------------------------------
  -- CRUD
  PROCEDURE create_employee(
    p_employee_id    IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    p_first_name     IN EMPLOYEES.FIRST_NAME%TYPE,
    p_last_name      IN EMPLOYEES.LAST_NAME%TYPE,
    p_email          IN EMPLOYEES.EMAIL%TYPE,
    p_phone_number   IN EMPLOYEES.PHONE_NUMBER%TYPE,
    p_hire_date      IN EMPLOYEES.HIRE_DATE%TYPE,
    p_job_id         IN EMPLOYEES.JOB_ID%TYPE,
    p_salary         IN EMPLOYEES.SALARY%TYPE,
    p_commission_pct IN EMPLOYEES.COMMISSION_PCT%TYPE,
    p_manager_id     IN EMPLOYEES.MANAGER_ID%TYPE,
    p_department_id  IN EMPLOYEES.DEPARTMENT_ID%TYPE
  ) IS
  BEGIN
    INSERT INTO EMPLOYEES(
      EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
      HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
    ) VALUES (
      p_employee_id, p_first_name, p_last_name, p_email, p_phone_number,
      p_hire_date, p_job_id, p_salary, p_commission_pct, p_manager_id, p_department_id
    );
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END create_employee;

  PROCEDURE update_employee(
    p_employee_id    IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    p_first_name     IN EMPLOYEES.FIRST_NAME%TYPE,
    p_last_name      IN EMPLOYEES.LAST_NAME%TYPE,
    p_email          IN EMPLOYEES.EMAIL%TYPE,
    p_phone_number   IN EMPLOYEES.PHONE_NUMBER%TYPE,
    p_hire_date      IN EMPLOYEES.HIRE_DATE%TYPE,
    p_job_id         IN EMPLOYEES.JOB_ID%TYPE,
    p_salary         IN EMPLOYEES.SALARY%TYPE,
    p_commission_pct IN EMPLOYEES.COMMISSION_PCT%TYPE,
    p_manager_id     IN EMPLOYEES.MANAGER_ID%TYPE,
    p_department_id  IN EMPLOYEES.DEPARTMENT_ID%TYPE
  ) IS
  BEGIN
    UPDATE EMPLOYEES
    SET FIRST_NAME = p_first_name,
        LAST_NAME  = p_last_name,
        EMAIL      = p_email,
        PHONE_NUMBER = p_phone_number,
        HIRE_DATE  = p_hire_date,
        JOB_ID     = p_job_id,
        SALARY     = p_salary,
        COMMISSION_PCT = p_commission_pct,
        MANAGER_ID = p_manager_id,
        DEPARTMENT_ID = p_department_id
    WHERE EMPLOYEE_ID = p_employee_id;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END update_employee;

  PROCEDURE delete_employee(p_employee_id IN EMPLOYEES.EMPLOYEE_ID%TYPE) IS
  BEGIN
    DELETE FROM EMPLOYEES WHERE EMPLOYEE_ID = p_employee_id;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END delete_employee;

  FUNCTION get_employee(p_employee_id IN EMPLOYEES.EMPLOYEE_ID%TYPE)
    RETURN SYS_REFCURSOR IS
    rc SYS_REFCURSOR;
  BEGIN
    OPEN rc FOR
      SELECT e.* FROM EMPLOYEES e WHERE e.EMPLOYEE_ID = p_employee_id;
    RETURN rc;
  END get_employee;

  FUNCTION list_employees RETURN SYS_REFCURSOR IS
    rc SYS_REFCURSOR;
  BEGIN
    OPEN rc FOR
      SELECT e.*, j.JOB_TITLE, d.DEPARTMENT_NAME
      FROM EMPLOYEES e
      LEFT JOIN JOBS j ON e.JOB_ID = j.JOB_ID
      LEFT JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
      ORDER BY e.EMPLOYEE_ID;
    RETURN rc;
  END list_employees;

  ----------------------------------------------------------------
  -- 3.1.1
  PROCEDURE top4_mas_rotacion IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('EMP_ID | APELLIDO | NOMBRE | JOB_ID_ACTUAL | JOB_TITLE_ACTUAL | NUM_CAMBIOS');
    FOR r IN (
      SELECT *
      FROM (
        SELECT e.EMPLOYEE_ID,
               e.LAST_NAME,
               e.FIRST_NAME,
               e.JOB_ID AS CURRENT_JOB_ID,
               j.JOB_TITLE AS CURRENT_JOB_TITLE,
               NVL(h.cnt_changes,0) AS num_cambios
        FROM EMPLOYEES e
        LEFT JOIN JOBS j ON e.JOB_ID = j.JOB_ID
        LEFT JOIN (
          SELECT EMPLOYEE_ID, COUNT(*) AS cnt_changes
          FROM JOB_HISTORY
          GROUP BY EMPLOYEE_ID
        ) h ON e.EMPLOYEE_ID = h.EMPLOYEE_ID
        ORDER BY NVL(h.cnt_changes,0) DESC, e.EMPLOYEE_ID
      )
      WHERE ROWNUM <= 4
    ) LOOP
      DBMS_OUTPUT.PUT_LINE(
        r.EMPLOYEE_ID || ' | ' ||
        r.LAST_NAME || ' | ' ||
        NVL(r.FIRST_NAME,'') || ' | ' ||
        NVL(r.CURRENT_JOB_ID,'-') || ' | ' ||
        NVL(r.CURRENT_JOB_TITLE,'-') || ' | ' ||
        r.num_cambios
      );
    END LOOP;
  END top4_mas_rotacion;

  ----------------------------------------------------------------
  -- 3.1.2
  FUNCTION promedio_contrataciones_por_mes RETURN NUMBER IS
    v_years_count NUMBER;
    v_total_months_considered NUMBER := 0;
    v_hires NUMBER;
  BEGIN
    SELECT COUNT(DISTINCT EXTRACT(YEAR FROM HIRE_DATE))
    INTO v_years_count
    FROM EMPLOYEES
    WHERE HIRE_DATE IS NOT NULL;

    IF v_years_count IS NULL OR v_years_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('No hay años con información de contrataciones.');
      RETURN 0;
    END IF;

    DBMS_OUTPUT.PUT_LINE('MES | PROMEDIO_CONTRATACIONES');

    FOR r IN (
      SELECT TO_CHAR(HIRE_DATE,'MM') AS mth,
             TO_CHAR(TO_DATE(TO_CHAR(HIRE_DATE,'MM'),'MM'),'TMMonth','NLS_DATE_LANGUAGE=SPANISH') AS month_name,
             COUNT(*) AS hires
      FROM EMPLOYEES
      GROUP BY TO_CHAR(HIRE_DATE,'MM')
      ORDER BY mth
    ) LOOP
      v_hires := r.hires;
      DBMS_OUTPUT.PUT_LINE(
        RTRIM(r.month_name) || ' | ' ||
        TO_CHAR(v_hires / v_years_count, 'FM9999990.00')
      );
      IF v_hires > 0 THEN
        v_total_months_considered := v_total_months_considered + 1;
      END IF;
    END LOOP;

    RETURN v_total_months_considered;
  END promedio_contrataciones_por_mes;

  ----------------------------------------------------------------
  -- 3.1.3
  PROCEDURE gasto_salario_por_region IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('REGION | SUMA_SALARIOS | CANT_EMPLEADOS | FECHA_INGRESO_MAS_ANTIGUA');
    FOR r IN (
      SELECT rg.REGION_NAME,
             SUM(NVL(e.SALARY,0)) AS suma_salarios,
             COUNT(e.EMPLOYEE_ID) AS cant_empleados,
             MIN(e.HIRE_DATE) AS fecha_ingreso_mas_antigua
      FROM REGIONS rg
      LEFT JOIN COUNTRIES c ON rg.REGION_ID = c.REGION_ID
      LEFT JOIN LOCATIONS l ON c.COUNTRY_ID = l.COUNTRY_ID
      LEFT JOIN DEPARTMENTS d ON l.LOCATION_ID = d.LOCATION_ID
      LEFT JOIN EMPLOYEES e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
      GROUP BY rg.REGION_NAME
      ORDER BY rg.REGION_NAME
    ) LOOP
      DBMS_OUTPUT.PUT_LINE(
        NVL(r.REGION_NAME,'-') || ' | ' ||
        TO_CHAR(NVL(r.suma_salarios,0),'FM999G999G990D00') || ' | ' ||
        r.cant_empleados || ' | ' ||
        NVL(TO_CHAR(r.fecha_ingreso_mas_antigua,'YYYY-MM-DD'),'-')
      );
    END LOOP;
  END gasto_salario_por_region;

  ----------------------------------------------------------------
  -- 3.1.4
  FUNCTION monto_total_vacaciones RETURN NUMBER IS
    v_total_monto NUMBER := 0;
    v_years_service NUMBER;
    v_vacation_months NUMBER;
    v_vacation_amount NUMBER;
  BEGIN
    DBMS_OUTPUT.PUT_LINE('EMP_ID | APELLIDO | HIRE_DATE | AÑOS_SERVICIO | MESES_VACACIONES | MONTO_VACACIONES');
    FOR r IN (
      SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY
      FROM EMPLOYEES
      ORDER BY EMPLOYEE_ID
    ) LOOP
      IF r.HIRE_DATE IS NOT NULL THEN
        v_years_service := FLOOR(MONTHS_BETWEEN(TRUNC(SYSDATE), TRUNC(r.HIRE_DATE)) / 12);
        IF v_years_service < 0 THEN
          v_years_service := 0;
        END IF;
        v_vacation_months := v_years_service;
        v_vacation_amount := NVL(r.SALARY,0) * v_vacation_months;
      ELSE
        v_years_service := 0;
        v_vacation_months := 0;
        v_vacation_amount := 0;
      END IF;

      DBMS_OUTPUT.PUT_LINE(
        r.EMPLOYEE_ID || ' | ' ||
        NVL(r.LAST_NAME,'-') || ' | ' ||
        NVL(TO_CHAR(r.HIRE_DATE,'YYYY-MM-DD'),'-') || ' | ' ||
        v_years_service || ' | ' ||
        v_vacation_months || ' | ' ||
        TO_CHAR(v_vacation_amount,'FM999G999G990D00')
      );

      v_total_monto := v_total_monto + v_vacation_amount;
    END LOOP;

    RETURN v_total_monto;
  END monto_total_vacaciones;

END pkg_employee;
/

SELECT text
FROM user_source
WHERE name = 'PKG_EMPLOYEE'
ORDER BY line;

-- ------------------------------------------------------------------------------------------------------
-- --------------------------------------------PRUEBAS---------------------------------------------------

SET SERVEROUTPUT ON;

BEGIN
  PKG_EMPLOYEE.create_employee(
    301,
    'Ana',
    'Diaz',
    'ADIAZ',
    '555-2222',
    SYSDATE,
    'SA_REP',
    2500,
    0.1,
    NULL,
    90
  );
END;
/

BEGIN
  PKG_EMPLOYEE.update_employee(
    301,
    'Ana Maria',
    'Diaz',
    'AMARIA',
    '555-3333',
    SYSDATE,
    'SA_REP',
    2700,
    0.15,
    NULL,
    90
  );
END;
/

DECLARE
  rc SYS_REFCURSOR;
  v_emp EMPLOYEES%ROWTYPE;
BEGIN
  rc := PKG_EMPLOYEE.get_employee(301);
  LOOP
    FETCH rc INTO v_emp;
    EXIT WHEN rc%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(
      v_emp.EMPLOYEE_ID || ' ' ||
      v_emp.FIRST_NAME || ' ' ||
      v_emp.LAST_NAME || ' ' ||
      v_emp.EMAIL || ' ' ||
      v_emp.SALARY
    );
  END LOOP;
  CLOSE rc;
END;
/

DECLARE
  rc SYS_REFCURSOR;
  v_emp EMPLOYEES%ROWTYPE;
BEGIN
  rc := PKG_EMPLOYEE.list_employees;
  FETCH rc INTO v_emp;
  IF rc%FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Listado de empleados disponible.');
  END IF;
  CLOSE rc;
END;
/

BEGIN
  PKG_EMPLOYEE.top4_mas_rotacion;
END;
/

DECLARE
  v_total NUMBER;
BEGIN
  v_total := PKG_EMPLOYEE.promedio_contrataciones_por_mes;
  DBMS_OUTPUT.PUT_LINE('Total meses considerados: ' || v_total);
END;
/

BEGIN
  PKG_EMPLOYEE.gasto_salario_por_region;
END;
/

DECLARE
  v_total_vac NUMBER;
BEGIN
  v_total_vac := PKG_EMPLOYEE.monto_total_vacaciones;
  DBMS_OUTPUT.PUT_LINE('Monto total de vacaciones: ' || v_total_vac);
END;
/

BEGIN
  PKG_EMPLOYEE.delete_employee(301);
END;
/

-- ------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------

-- ============================================================
-- CREACIÓN DE TABLAS NUEVAS
-- ============================================================

CREATE TABLE HORARIO (
  ID_HORARIO     NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  DIA_SEMANA     VARCHAR2(15) NOT NULL,
  TURNO          VARCHAR2(15) NOT NULL,
  HORA_INICIO    DATE NOT NULL,
  HORA_TERMINO   DATE NOT NULL
) TABLESPACE EsquemaS7;

CREATE TABLE EMPLEADO_HORARIO (
  ID_EMPHOR      NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  ID_HORARIO     NUMBER NOT NULL,
  EMPLOYEE_ID    NUMBER(6) NOT NULL,
  
  CONSTRAINT fk_emp_hor_hor FOREIGN KEY (ID_HORARIO)
      REFERENCES HORARIO (ID_HORARIO),
  CONSTRAINT fk_emp_hor_emp FOREIGN KEY (EMPLOYEE_ID)
      REFERENCES EMPLOYEES (EMPLOYEE_ID)
) TABLESPACE EsquemaS7;

CREATE TABLE ASISTENCIA_EMPLEADO (
  ID_ASIS          NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  EMPLOYEE_ID      NUMBER(6) NOT NULL,
  ID_HORARIO       NUMBER,
  FECHA_REAL       DATE NOT NULL,
  HORA_INICIO_REAL DATE,
  HORA_TERMINO_REAL DATE,
  
  CONSTRAINT fk_asist_emp FOREIGN KEY (EMPLOYEE_ID)
      REFERENCES EMPLOYEES (EMPLOYEE_ID),
  CONSTRAINT fk_asist_hor FOREIGN KEY (ID_HORARIO)
      REFERENCES HORARIO (ID_HORARIO)
) TABLESPACE EsquemaS7;

-- ============================================================
-- INSERCIÓN DE REGISTROS DE PRUEBA (10 por tabla)
-- ============================================================

INSERT INTO HORARIO (DIA_SEMANA, TURNO, HORA_INICIO, HORA_TERMINO)
VALUES ('Lunes', 'Mañana', TO_DATE('08:00', 'HH24:MI'), TO_DATE('16:00', 'HH24:MI'));
INSERT INTO HORARIO VALUES (DEFAULT, 'Martes', 'Mañana', TO_DATE('08:00', 'HH24:MI'), TO_DATE('16:00', 'HH24:MI'));
INSERT INTO HORARIO VALUES (DEFAULT, 'Miércoles', 'Mañana', TO_DATE('08:00', 'HH24:MI'), TO_DATE('16:00', 'HH24:MI'));
INSERT INTO HORARIO VALUES (DEFAULT, 'Jueves', 'Mañana', TO_DATE('08:00', 'HH24:MI'), TO_DATE('16:00', 'HH24:MI'));
INSERT INTO HORARIO VALUES (DEFAULT, 'Viernes', 'Mañana', TO_DATE('08:00', 'HH24:MI'), TO_DATE('16:00', 'HH24:MI'));
INSERT INTO HORARIO VALUES (DEFAULT, 'Lunes', 'Tarde', TO_DATE('16:00', 'HH24:MI'), TO_DATE('00:00', 'HH24:MI'));
INSERT INTO HORARIO VALUES (DEFAULT, 'Martes', 'Tarde', TO_DATE('16:00', 'HH24:MI'), TO_DATE('00:00', 'HH24:MI'));
INSERT INTO HORARIO VALUES (DEFAULT, 'Miércoles', 'Tarde', TO_DATE('16:00', 'HH24:MI'), TO_DATE('00:00', 'HH24:MI'));
INSERT INTO HORARIO VALUES (DEFAULT, 'Jueves', 'Tarde', TO_DATE('16:00', 'HH24:MI'), TO_DATE('00:00', 'HH24:MI'));
INSERT INTO HORARIO VALUES (DEFAULT, 'Viernes', 'Tarde', TO_DATE('16:00', 'HH24:MI'), TO_DATE('00:00', 'HH24:MI'));

INSERT INTO EMPLEADO_HORARIO (ID_HORARIO, EMPLOYEE_ID) VALUES (1, 100);
INSERT INTO EMPLEADO_HORARIO VALUES (DEFAULT, 2, 100);
INSERT INTO EMPLEADO_HORARIO VALUES (DEFAULT, 3, 100);
INSERT INTO EMPLEADO_HORARIO VALUES (DEFAULT, 4, 100);
INSERT INTO EMPLEADO_HORARIO VALUES (DEFAULT, 5, 100);
INSERT INTO EMPLEADO_HORARIO VALUES (DEFAULT, 6, 101);
INSERT INTO EMPLEADO_HORARIO VALUES (DEFAULT, 7, 101);
INSERT INTO EMPLEADO_HORARIO VALUES (DEFAULT, 8, 101);
INSERT INTO EMPLEADO_HORARIO VALUES (DEFAULT, 9, 101);
INSERT INTO EMPLEADO_HORARIO VALUES (DEFAULT, 10, 101);

INSERT INTO ASISTENCIA_EMPLEADO (EMPLOYEE_ID, ID_HORARIO, FECHA_REAL, HORA_INICIO_REAL, HORA_TERMINO_REAL)
VALUES (100, 1, TO_DATE('2025-10-06','YYYY-MM-DD'), TO_DATE('08:05','HH24:MI'), TO_DATE('16:02','HH24:MI'));
INSERT INTO ASISTENCIA_EMPLEADO VALUES (DEFAULT, 100, 2, TO_DATE('2025-10-07','YYYY-MM-DD'), TO_DATE('08:00','HH24:MI'), TO_DATE('16:00','HH24:MI'));
INSERT INTO ASISTENCIA_EMPLEADO VALUES (DEFAULT, 100, 3, TO_DATE('2025-10-08','YYYY-MM-DD'), TO_DATE('08:10','HH24:MI'), TO_DATE('15:50','HH24:MI'));
INSERT INTO ASISTENCIA_EMPLEADO VALUES (DEFAULT, 100, 4, TO_DATE('2025-10-09','YYYY-MM-DD'), TO_DATE('08:00','HH24:MI'), TO_DATE('16:00','HH24:MI'));
INSERT INTO ASISTENCIA_EMPLEADO VALUES (DEFAULT, 100, 5, TO_DATE('2025-10-10','YYYY-MM-DD'), TO_DATE('08:00','HH24:MI'), TO_DATE('16:00','HH24:MI'));
INSERT INTO ASISTENCIA_EMPLEADO VALUES (DEFAULT, 101, 6, TO_DATE('2025-10-06','YYYY-MM-DD'), TO_DATE('16:00','HH24:MI'), TO_DATE('00:00','HH24:MI'));
INSERT INTO ASISTENCIA_EMPLEADO VALUES (DEFAULT, 101, 7, TO_DATE('2025-10-07','YYYY-MM-DD'), TO_DATE('16:10','HH24:MI'), TO_DATE('23:50','HH24:MI'));
INSERT INTO ASISTENCIA_EMPLEADO VALUES (DEFAULT, 101, 8, TO_DATE('2025-10-08','YYYY-MM-DD'), NULL, NULL);
INSERT INTO ASISTENCIA_EMPLEADO VALUES (DEFAULT, 101, 9, TO_DATE('2025-10-09','YYYY-MM-DD'), TO_DATE('16:05','HH24:MI'), TO_DATE('00:00','HH24:MI'));
INSERT INTO ASISTENCIA_EMPLEADO VALUES (DEFAULT, 101, 10, TO_DATE('2025-10-10','YYYY-MM-DD'), TO_DATE('16:00','HH24:MI'), TO_DATE('00:00','HH24:MI'));

COMMIT;

-- ============================================================
-- 3.1.5 FUNCIÓN HORAS_LABORADAS
-- ============================================================

CREATE OR REPLACE FUNCTION HORAS_LABORADAS(p_emp_id NUMBER, p_mes NUMBER, p_anio NUMBER)
RETURN NUMBER IS
  v_horas NUMBER := 0;
BEGIN
  SELECT NVL(SUM((HORA_TERMINO_REAL - HORA_INICIO_REAL) * 24), 0)
  INTO v_horas
  FROM ASISTENCIA_EMPLEADO
  WHERE EMPLOYEE_ID = p_emp_id
    AND EXTRACT(MONTH FROM FECHA_REAL) = p_mes
    AND EXTRACT(YEAR FROM FECHA_REAL) = p_anio
    AND HORA_INICIO_REAL IS NOT NULL
    AND HORA_TERMINO_REAL IS NOT NULL;
    
  RETURN v_horas;
END;
/

-- ============================================================
-- 3.1.6 FUNCIÓN HORAS_FALTA
-- ============================================================

CREATE OR REPLACE FUNCTION HORAS_FALTA(p_emp_id NUMBER, p_mes NUMBER, p_anio NUMBER)
RETURN NUMBER IS
  v_horas_laboradas NUMBER;
  v_horas_planificadas NUMBER := 0;
  v_faltas NUMBER;
BEGIN
  SELECT COUNT(*) * 8
  INTO v_horas_planificadas
  FROM EMPLEADO_HORARIO
  WHERE EMPLOYEE_ID = p_emp_id;
  
  v_horas_laboradas := HORAS_LABORADAS(p_emp_id, p_mes, p_anio);
  v_faltas := v_horas_planificadas - v_horas_laboradas;
  
  IF v_faltas < 0 THEN v_faltas := 0; END IF;
  RETURN v_faltas;
END;
/

-- ============================================================
-- 3.1.7 PROCEDIMIENTO REPORTE_SALARIO_MENSUAL
-- ============================================================

CREATE OR REPLACE PROCEDURE REPORTE_SALARIO_MENSUAL(p_mes NUMBER, p_anio NUMBER) IS
  CURSOR c_emp IS SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY FROM EMPLOYEES;
  v_horas_lab NUMBER;
  v_horas_falta NUMBER;
  v_salario_mes NUMBER;
  v_total_horas NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('NOMBRE | APELLIDO | SALARIO MENSUAL');
  DBMS_OUTPUT.PUT_LINE('----------------------------------------');
  
  FOR r IN c_emp LOOP
    v_horas_lab := HORAS_LABORADAS(r.EMPLOYEE_ID, p_mes, p_anio);
    v_horas_falta := HORAS_FALTA(r.EMPLOYEE_ID, p_mes, p_anio);
    v_total_horas := v_horas_lab + v_horas_falta;

    IF v_total_horas = 0 THEN
      v_salario_mes := 0;
    ELSE
      v_salario_mes := r.SALARY * (v_horas_lab / v_total_horas);
    END IF;

    DBMS_OUTPUT.PUT_LINE(r.FIRST_NAME || ' | ' || r.LAST_NAME || ' | ' || TO_CHAR(v_salario_mes, '9999.99'));
  END LOOP;
END;
/


-- ============================================================
-- PRUEBA FINAL
-- ============================================================

BEGIN
  REPORTE_SALARIO_MENSUAL(10, 2025);
END;
/

-- ------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------

-- ============================================================
-- 1) TABLAS: CAPACITACION y EMPLEADOCAPACITACION (tablespace EsquemaS7)
-- ============================================================

CREATE TABLE CAPACITACION (
  COD_CAPACITACION   NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  NOMBRE_CAPACITACION VARCHAR2(100) NOT NULL,
  HORAS_CAPACITACION  NUMBER(6,2) NOT NULL,
  DESCRIPCION         VARCHAR2(4000)
) TABLESPACE EsquemaS7;

CREATE TABLE EMPLEADOCAPACITACION (
  ID_EMP_CAP      NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  EMPLOYEE_ID     NUMBER(6) NOT NULL,
  COD_CAPACITACION NUMBER NOT NULL,
  CONSTRAINT fk_empcap_emp FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES (EMPLOYEE_ID),
  CONSTRAINT fk_empcap_cap FOREIGN KEY (COD_CAPACITACION) REFERENCES CAPACITACION (COD_CAPACITACION)
) TABLESPACE EsquemaS7;

-- ============================================================
-- 2) INSERCIONES: 10 registros en cada tabla
-- ============================================================

INSERT INTO CAPACITACION (NOMBRE_CAPACITACION, HORAS_CAPACITACION, DESCRIPCION) VALUES ('Introducción a SQL', 16, 'Fundamentos de SQL y consultas');
INSERT INTO CAPACITACION (NOMBRE_CAPACITACION, HORAS_CAPACITACION, DESCRIPCION) VALUES ('PL/SQL Básico', 20, 'Estructuras PL/SQL y procedimientos');
INSERT INTO CAPACITACION (NOMBRE_CAPACITACION, HORAS_CAPACITACION, DESCRIPCION) VALUES ('Modelado de Datos', 12, 'Diseño conceptual y lógico');
INSERT INTO CAPACITACION (NOMBRE_CAPACITACION, HORAS_CAPACITACION, DESCRIPCION) VALUES ('Control de Versiones', 8, 'Uso de git y flujo de trabajo');
INSERT INTO CAPACITACION (NOMBRE_CAPACITACION, HORAS_CAPACITACION, DESCRIPCION) VALUES ('Pruebas Unitarias', 10, 'Mocks, stubs y frameworks de prueba');
INSERT INTO CAPACITACION (NOMBRE_CAPACITACION, HORAS_CAPACITACION, DESCRIPCION) VALUES ('Seguridad en BD', 12, 'Autenticación, roles y encriptación');
INSERT INTO CAPACITACION (NOMBRE_CAPACITACION, HORAS_CAPACITACION, DESCRIPCION) VALUES ('Optimización de Consultas', 14, 'Tunning y plan de ejecución');
INSERT INTO CAPACITACION (NOMBRE_CAPACITACION, HORAS_CAPACITACION, DESCRIPCION) VALUES ('Administración Oracle', 24, 'Tareas básicas de DBA');
INSERT INTO CAPACITACION (NOMBRE_CAPACITACION, HORAS_CAPACITACION, DESCRIPCION) VALUES ('DevOps & CI/CD', 16, 'Pipelines y despliegues automáticos');
INSERT INTO CAPACITACION (NOMBRE_CAPACITACION, HORAS_CAPACITACION, DESCRIPCION) VALUES ('Calidad de Software', 10, 'Buenas prácticas y métricas');

COMMIT;

-- Para insertar registros en EMPLEADOCAPACITACION voy a asociar empleados con IDs 100..109 (asegúrate que existan)
INSERT INTO EMPLEADOCAPACITACION (EMPLOYEE_ID, COD_CAPACITACION) VALUES (100, 1);
INSERT INTO EMPLEADOCAPACITACION (EMPLOYEE_ID, COD_CAPACITACION) VALUES (100, 2);
INSERT INTO EMPLEADOCAPACITACION (EMPLOYEE_ID, COD_CAPACITACION) VALUES (101, 2);
INSERT INTO EMPLEADOCAPACITACION (EMPLOYEE_ID, COD_CAPACITACION) VALUES (101, 3);
INSERT INTO EMPLEADOCAPACITACION (EMPLOYEE_ID, COD_CAPACITACION) VALUES (102, 1);
INSERT INTO EMPLEADOCAPACITACION (EMPLOYEE_ID, COD_CAPACITACION) VALUES (103, 4);
INSERT INTO EMPLEADOCAPACITACION (EMPLOYEE_ID, COD_CAPACITACION) VALUES (104, 5);
INSERT INTO EMPLEADOCAPACITACION (EMPLOYEE_ID, COD_CAPACITACION) VALUES (105, 6);
INSERT INTO EMPLEADOCAPACITACION (EMPLOYEE_ID, COD_CAPACITACION) VALUES (106, 7);
INSERT INTO EMPLEADOCAPACITACION (EMPLOYEE_ID, COD_CAPACITACION) VALUES (107, 8);

COMMIT;

-- ============================================================
-- 3) FUNCIÓN 3.1.1: HORAS TOTALES POR EMPLEADO (SUMA de horas de capacitaciones)
-- ============================================================
CREATE OR REPLACE FUNCTION HORAS_CAPACITADO_EMP(p_emp_id NUMBER)
RETURN NUMBER IS
  v_total NUMBER := 0;
BEGIN
  SELECT NVL(SUM(c.HORAS_CAPACITACION),0)
  INTO v_total
  FROM EMPLEADOCAPACITACION ec
  JOIN CAPACITACION c ON ec.COD_CAPACITACION = c.COD_CAPACITACION
  WHERE ec.EMPLOYEE_ID = p_emp_id;

  RETURN v_total;
END;
/

-- ============================================================
-- 4) PROCEDIMIENTO 3.1.2: LISTAR CAPACITACIONES Y HORAS POR EMPLEADO (ordenado por total horas por empleado)
-- ============================================================
CREATE OR REPLACE PROCEDURE LISTAR_CAPACITACIONES_CON_HORAS IS
  CURSOR c_emp_cap IS
    SELECT c.COD_CAPACITACION, c.NOMBRE_CAPACITACION, ec.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME,
           SUM(c.HORAS_CAPACITACION) OVER (PARTITION BY ec.EMPLOYEE_ID) AS TOTAL_HORAS_EMPLEADO,
           SUM(c.HORAS_CAPACITACION) AS HORAS_POR_CAP
    FROM EMPLEADOCAPACITACION ec
    JOIN CAPACITACION c ON ec.COD_CAPACITACION = c.COD_CAPACITACION
    LEFT JOIN EMPLOYEES e ON ec.EMPLOYEE_ID = e.EMPLOYEE_ID
    GROUP BY c.COD_CAPACITACION, c.NOMBRE_CAPACITACION, ec.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME
    ORDER BY TOTAL_HORAS_EMPLEADO DESC, ec.EMPLOYEE_ID;
BEGIN
  DBMS_OUTPUT.PUT_LINE('CAP_ID | NOMBRE_CAP | EMP_ID | NOMBRE | APELLIDO | HORAS_CAP | TOTAL_HORAS_EMPLEADO');
  FOR r IN c_emp_cap LOOP
    DBMS_OUTPUT.PUT_LINE(
      r.COD_CAPACITACION || ' | ' ||
      NVL(r.NOMBRE_CAPACITACION,'-') || ' | ' ||
      r.EMPLOYEE_ID || ' | ' ||
      NVL(r.FIRST_NAME,'-') || ' | ' ||
      NVL(r.LAST_NAME,'-') || ' | ' ||
      TO_CHAR(r.HORAS_POR_CAP,'FM9990.00') || ' | ' ||
      TO_CHAR(r.TOTAL_HORAS_EMPLEADO,'FM9990.00')
    );
  END LOOP;
END;
/

-- ============================================================
-- 5) TRIGGER 3.2 + 3.4: TRG_ASISTENCIA_CHECK (BEFORE INSERT OR UPDATE)
-- - Verifica que FECHA_REAL concuerde con DIA_SEMANA del HORARIO (si ID_HORARIO presente)
-- - Verifica HORA_INICIO_REAL y HORA_TERMINO_REAL estén dentro de HORA_INICIO..HORA_TERMINO (si no, RAISE)
-- - Si HORA_INICIO_REAL está fuera de HORA_INICIO ± 30 minutos -> marca inasistencia (pone NULL en horas reales)
-- ============================================================

CREATE OR REPLACE TRIGGER TRG_ASISTENCIA_CHECK
BEFORE INSERT OR UPDATE ON ASISTENCIA_EMPLEADO
FOR EACH ROW
DECLARE
  v_dia_horario VARCHAR2(30);
  v_hora_inicio DATE;
  v_hora_termino DATE;
  v_fecha_day_str VARCHAR2(30);
  -- helper: minutes since midnight
  FUNCTION minutes_of_day(d DATE) RETURN NUMBER IS
  BEGIN
    RETURN TO_NUMBER(TO_CHAR(d,'HH24'))*60 + TO_NUMBER(TO_CHAR(d,'MI'));
  END;
  v_sched_start_min NUMBER;
  v_sched_end_min NUMBER;
  v_real_start_min NUMBER;
  v_real_end_min NUMBER;
  v_tol NUMBER := 30; -- 30 minutos de tolerancia
BEGIN
  -- Si no hay ID_HORARIO, no hacemos validaciones (se asume libre). Si existe, validamos.
  IF :NEW.ID_HORARIO IS NOT NULL THEN
    SELECT DIA_SEMANA, HORA_INICIO, HORA_TERMINO
      INTO v_dia_horario, v_hora_inicio, v_hora_termino
    FROM HORARIO
    WHERE ID_HORARIO = :NEW.ID_HORARIO;

    -- 1) FECHA_REAL corresponde al DIA_SEMANA
    v_fecha_day_str := INITCAP(TRIM(TO_CHAR(:NEW.FECHA_REAL, 'FMDAY', 'NLS_DATE_LANGUAGE=SPANISH')));
    IF TRANSLATE(v_fecha_day_str, 'ÁÉÍÓÚÀÈÌÒÙ', 'AEIOUAEIOU') != TRANSLATE(INITCAP(v_dia_horario), 'ÁÉÍÓÚÀÈÌÒÙ', 'AEIOUAEIOU') THEN
      RAISE_APPLICATION_ERROR(-20001, 'FECHA_REAL no corresponde con DIA_SEMANA del HORARIO asociado.');
    END IF;

    -- Si no hay horas reales registradas (NULL) -> nada más (podría ser inasistencia)
    IF :NEW.HORA_INICIO_REAL IS NULL OR :NEW.HORA_TERMINO_REAL IS NULL THEN
      -- Permitir; pero para 3.4 la idea es marcar inasistencia (dejamos NULL silenciosamente)
      :NEW.HORA_INICIO_REAL := NULL;
      :NEW.HORA_TERMINO_REAL := NULL;
      RETURN;
    END IF;

    -- 2) Convertir a minutos y comparar
    v_sched_start_min := minutes_of_day(v_hora_inicio);
    v_sched_end_min   := minutes_of_day(v_hora_termino);
    v_real_start_min  := minutes_of_day(:NEW.HORA_INICIO_REAL);
    v_real_end_min    := minutes_of_day(:NEW.HORA_TERMINO_REAL);

    -- Manejo rango nocturno (ej. 16:00 - 00:00) -> si end < start sumamos 24*60 al end y a real_end cuando necesario
    IF v_sched_end_min <= v_sched_start_min THEN
      v_sched_end_min := v_sched_end_min + 24*60;
      IF v_real_end_min <= v_real_start_min THEN
        v_real_end_min := v_real_end_min + 24*60;
      END IF;
    END IF;

    -- 3) Regla de media hora antes o después: si el inicio real está fuera de [start - tol, start + tol] -> marcar inasistencia (silenciosamente)
    IF v_real_start_min < (v_sched_start_min - v_tol) OR v_real_start_min > (v_sched_start_min + v_tol) THEN
      -- marcar inasistencia sin notificar: anulamos horas reales
      :NEW.HORA_INICIO_REAL := NULL;
      :NEW.HORA_TERMINO_REAL := NULL;
      RETURN;
    END IF;

    -- 4) Verificar que las horas reales estén dentro del horario programado (start <= real_start < real_end <= end)
    IF NOT (v_real_start_min >= v_sched_start_min AND v_real_end_min <= v_sched_end_min AND v_real_end_min > v_real_start_min) THEN
      RAISE_APPLICATION_ERROR(-20002, 'Horas reales fuera del horario programado.');
    END IF;
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20003, 'ID_HORARIO no existe en HORARIO.');
END;
/

-- ============================================================
-- 6) TRIGGER 3.3: Validar que SALARY esté dentro de MIN/MAX de JOBS
-- ============================================================
CREATE OR REPLACE TRIGGER TRG_EMP_SALARY_CHECK
BEFORE INSERT OR UPDATE ON EMPLOYEES
FOR EACH ROW
DECLARE
  v_min NUMBER;
  v_max NUMBER;
BEGIN
  IF :NEW.JOB_ID IS NOT NULL THEN
    SELECT MIN_SALARY, MAX_SALARY INTO v_min, v_max FROM JOBS WHERE JOB_ID = :NEW.JOB_ID;
    IF v_min IS NOT NULL AND :NEW.SALARY IS NOT NULL AND :NEW.SALARY < v_min THEN
      RAISE_APPLICATION_ERROR(-20010, 'SALARIO inferior al MIN_SALARY definido para el puesto.');
    END IF;
    IF v_max IS NOT NULL AND :NEW.SALARY IS NOT NULL AND :NEW.SALARY > v_max THEN
      RAISE_APPLICATION_ERROR(-20011, 'SALARIO superior al MAX_SALARY definido para el puesto.');
    END IF;
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    NULL; -- Si JOB_ID no existe en JOBS, dejamos pasar (o podrías bloquear con error)
END;
/

-- ============================================================
-- 7) PRUEBAS RÁPIDAS
-- - Calcular horas por un empleado (función)
-- - Ejecutar procedimiento listador
-- ============================================================

-- Ejemplo: horas totales de capacitación del empleado 100
SET SERVEROUTPUT ON;
DECLARE
  v_h NUMERIC;
BEGIN
  v_h := HORAS_CAPACITADO_EMP(100);
  DBMS_OUTPUT.PUT_LINE('Horas totales capacitadas empleado 100: ' || v_h);
END;
/

-- Listar capacitaciones y empleados con horas (ordenado por total horas por empleado)
BEGIN
  LISTAR_CAPACITACIONES_CON_HORAS;
END;
/

