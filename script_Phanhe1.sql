alter session set "_ORACLE_SCRIPT" = true;
CREATE ROLE SYS_ADMIN;
--Tao Role SYS_ADMIN va cap cac quyen can thiet--
GRANT SELECT ON V_$sga TO SYS_ADMIN;
GRANT SELECT ON Dba_Roles TO SYS_ADMIN;
GRANT SELECT ON Dba_Users TO SYS_ADMIN;
GRANT SELECT ON Dba_Role_Privs TO SYS_ADMIN ;
GRANT DROP USER TO SYS_ADMIN WITH ADMIN OPTION;
GRANT GRANT ANY ROLE, GRANT ANY PRIVILEGE TO SYS_ADMIN WITH ADMIN OPTION;
GRANT CONNECT, RESOURCE, DBA TO SYS_ADMIN WITH ADMIN OPTION;

--Tao User SUPERADMIN va cap cho no cac quyen cung nhu gan role cho no la SYS_ADMIN--
CREATE USER SUPERADMIN IDENTIFIED BY 0201;
GRANT SELECT ON Dba_Role_Privs TO SUPERADMIN WITH GRANT OPTION;
GRANT CREATE SESSION TO SUPERADMIN WITH ADMIN OPTION;
GRANT UNLIMITED TABLESPACE TO SUPERADMIN WITH ADMIN OPTION;
GRANT SYS_ADMIN TO SUPERADMIN;
GRANT CREATE PROCEDURE TO SUPERADMIN;
GRANT EXECUTE ON DBMS_RLS TO SUPERADMIN;
GRANT EXEMPT ACCESS POLICY TO SUPERADMIN;
GRANT DROP ANY USER TO SUPERADMIN;
GRANT CREATE ANY USER TO SUPERADMIN;
GRANT ALTER ANY USER TO SUPERADMIN;

--CAP QUYEN DE THUC THI CAC STORED PROCEDURE, PHAN NAY KHA NANG CAO LA DU THUA--
GRANT EXECUTE ON USERS_SELECT TO SUPERADMIN;
GRANT EXECUTE ON ROLES_SELECT TO SUPERADMIN;
GRANT EXECUTE ON USER_PRIVI_SELECT TO SUPERADMIN;
GRANT EXECUTE ON ADD_USER TO SUPERADMIN;
GRANT EXECUTE ON DROP_USER TO SUPERADMIN;
GRANT EXECUTE ON USER_ALTER TO SUPERADMIN;
GRANT EXECUTE ON ADD_ROLE TO SUPERADMIN;
GRANT EXECUTE ON DROP_ROLE TO SUPERADMIN;
GRANT EXECUTE ON GRANT_PRIVI TO SUPERADMIN;
GRANT EXECUTE ON REVOKE_PRIVI TO SUPERADMIN;
GRANT EXECUTE ON role2user TO SUPERADMIN;


--Proc Xem danh sach nguoi dung trong he thong
--KHONG SU DUNG--
CREATE OR REPLACE PROCEDURE  USERS_SELECT(
V_CUR_USERS OUT SYS_REFCURSOR)
AS
    BEGIN
         OPEN V_CUR_USERS FOR
         SELECT * FROM DBA_USERS;
    END;
/


--Proc xem danh sach role trong he thong
--KHONG SU DUNG--
CREATE OR REPLACE PROCEDURE  ROLES_SELECT(
V_CUR_USERS OUT SYS_REFCURSOR)
AS
    BEGIN
         OPEN V_CUR_USERS FOR
         SELECT * FROM DBA_ROLES;
    END;
/

--Proc xem thong tin ve quyen cua user/role
--KHONG SU DUNG--
CREATE OR REPLACE PROCEDURE  USER_PRIVI_SELECT(name_user IN varchar2,
V_CUR_USERS OUT SYS_REFCURSOR)
AS
    BEGIN
         OPEN V_CUR_USERS FOR
         SELECT *
        FROM DBA_TAB_PRIVS
        WHERE GRANTEE = name_user;

    END;
/


--variable cur_test 
--exec ROLES_SELECT(:cur_test)
--print cur_test;
--alter session set "_ORACLE_SCRIPT"=true




--Proc tao user
--KHONG SU DUNG, DA CO BAN CHINH SUA O FILE SCRIPT_ADMIN_QUERRY.SQL
CREATE OR REPLACE PROCEDURE ADD_USER(userName IN varchar2, pass IN varchar2)
AS
    BEGIN 
    EXECUTE IMMEDIATE 'alter session set "_ORACLE_SCRIPT"=true';
    EXECUTE IMMEDIATE
    'CREATE USER '||userName||' IDENTIFIED BY '||pass;
    END;

--exec ADD_USER('test','223')

--Proc xoa User
--KHONG SU DUNG, DA CO BAN CHINH SUA O FILE SCRIPT_ADMIN_QUERRY.SQL
CREATE OR REPLACE PROCEDURE DROP_USER(userName IN varchar2)
AS
    BEGIN
    EXECUTE IMMEDIATE
    'DROP USER '||userName;
    END;

--Proc thay mat khau
--KHONG SU DUNG, DA CO BAN CHINH SUA O FILE SCRIPT_ADMIN_QUERRY.SQL
CREATE OR REPLACE PROCEDURE USER_ALTER (name_user IN varchar2, new_pass IN varchar2)
AS
    BEGIN
        EXECUTE IMMEDIATE
        'ALTER USER '|| name_user || ' IDENTIFIED BY ' || new_pass;
    END;
/


--exec DROP_USER('test')
--Proc tao role
--KHONG SU DUNG, DA CO BAN CHINH SUA O FILE SCRIPT_ADMIN_QUERRY.SQL
CREATE OR REPLACE PROCEDURE ADD_ROLE(roleName IN varchar2)
AS
    BEGIN
    EXECUTE IMMEDIATE 'alter session set "_ORACLE_SCRIPT"=true';
    EXECUTE IMMEDIATE
    'CREATE ROLE '||roleName;
    END;

--Proc xoa Role
--KHONG SU DUNG, DA CO BAN CHINH SUA O FILE SCRIPT_ADMIN_QUERRY.SQL
CREATE OR REPLACE PROCEDURE DROP_ROLE(roleName IN varchar2)
AS
    BEGIN
    EXECUTE IMMEDIATE
    'DROP ROLE '||roleName;
    END;
    
--exec DROP_ROLE('BACSI')
--create table PATIENT
--(
--    id_Pa number not null primary key,
--    name_Pa varchar2(20) not null,
--    dob_Pa date,
--    add_Pa varchar2(20),
--    tel_Pa varchar2(20)
--);

--Proc phan quyen
--KHONG SU DUNG
CREATE OR REPLACE PROCEDURE GRANT_PRIVI(name IN VARCHAR2, tableName IN VARCHAR2, columnName IN VARCHAR2,
                                        se IN VARCHAR2, ins IN VARCHAR2, upd IN VARCHAR2, dele IN VARCHAR2,
                                        withg IN VARCHAR2)
AS
    BEGIN
        IF se ='SELECT' THEN
            EXECUTE IMMEDIATE
            'GRANT '||se||' ON admin_system.'||tableName||' to '||name|| ' '||withg;
        END IF;
        IF ins ='INSERT' THEN
            EXECUTE IMMEDIATE
            'GRANT '||ins||' ON admin_system.'||tableName||' to '||name|| ' '||withg;
        END IF;
        IF upd ='UPDATE' THEN
            EXECUTE IMMEDIATE
            'GRANT '||upd||' ON admin_system.'||tableName||' to '||name|| ' '||withg;
        END IF;
        IF dele ='DELETE' THEN
            EXECUTE IMMEDIATE
            'GRANT '||dele||' ON admin_system.'||tableName||' to '||name|| ' '||withg;
        END IF;
    END;
exec GRANT_PRIVI('DOCTOR04','NHANVIEN','','','','UPDATE','','WITH GRANT OPTION');
--GRANT UPDATE() ON PATIENT TO TEST20 WITH GRANT OPTION
--exec  GRANT_PRIVI('TEST20','PATIENT','','','','UPDATE','','WITH GRANT OPTION');
--REVOKE all on patient from TEST11

--Proc thu hoi quyen
--KHONG SU DUNG
CREATE OR REPLACE PROCEDURE REVOKE_PRIVI(name IN VARCHAR2, tableName IN VARCHAR2, columnName IN VARCHAR2,
                                        se IN VARCHAR2, ins IN VARCHAR2, upd IN VARCHAR2, dele IN VARCHAR2)
AS
    BEGIN
        IF se ='SELECT' THEN
            EXECUTE IMMEDIATE
            'REVOKE '||se||' ON admin_system.'||tableName||' from '||name;
        END IF;
        
        IF ins ='INSERT' THEN
            EXECUTE IMMEDIATE
            'REVOKE '||ins||' ON admin_system.'||tableName||' from '||name;
        END IF;
        
        IF upd ='UPDATE' THEN
            EXECUTE IMMEDIATE
            'REVOKE '||upd||' ON admin_system.'||tableName||' from '||name;
        END IF;
        
        IF dele ='DELETE' THEN
            EXECUTE IMMEDIATE
            'REVOKE '||dele||' ON admin_system.'||tableName||' from '||name;
        END IF;
    END;
--exec REVOKE_PRIVI('test11','patient','','SELECT','','UPDATE','')

--Proc cap role cho user
--KHONG SU DUNG
CREATE OR REPLACE PROCEDURE role2user(username IN VARCHAR2, rolename IN VARCHAR2)
AS
    BEGIN
        EXECUTE IMMEDIATE
        'GRANT '||rolename||' to '||username;
    END;

SELECT * FROM DBA_SYS_PRIVS

--grant roletest11 to test12
--exec  GRANT_PRIVI('ROLETEST11','PATIENT','','','','UPDATE','','');
--EXEC role2user('test12','roletest11')