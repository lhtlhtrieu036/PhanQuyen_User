alter session set "_ORACLE_SCRIPT" = true;
--PHAN NAY CHI DE THAM KHAO, KHONG PHAI TRONG DO AN CUA MINH
CREATE ROLE HR_MANAGER;
CREATE ROLE ACCOUNTING_MANAGER;
CREATE ROLE SPECIALIZE_MANAGER;
CREATE ROLE RECEPTIONIST;
CREATE ROLE FINANCE_STAFF;
CREATE ROLE ACCOUNTING_STAFF;
CREATE ROLE PHARMACIST;
CREATE ROLE DOCTOR;
CREATE ROLE PATIENT;
--PHAN NAY CHI DE THAM KHAO, KHONG PHAI TRONG DO AN CUA MINH
CREATE USER DIRECTOR IDENTIFIED BY DIRECTOR;
CREATE USER HR_MANAGER00 IDENTIFIED BY HR_MANAGER00;
---Chi nhanh 01
--PHAN NAY CHI DE THAM KHAO, KHONG PHAI TRONG DO AN CUA MINH
CREATE USER HR_MANAGER01 IDENTIFIED BY HR_MANAGER01;
CREATE USER ACCOUNTING_MANAGER01 IDENTIFIED BY ACCOUNTING_MANAGER01;
CREATE USER SPECIALIZE_MANAGER01 IDENTIFIED BY SPECIALIZE_MANAGER01;
CREATE USER RECEPTIONIST01 IDENTIFIED BY RECEPTIONIST01;
CREATE USER FINANCE_STAFF01 IDENTIFIED BY FINANCE_STAFF01;
CREATE USER ACCOUNTING_STAFF01 IDENTIFIED BY ACCOUNTING_STAFF01;
CREATE USER PHARMACIST01 IDENTIFIED BY PHARMACIST01;
CREATE USER DOCTOR01 IDENTIFIED BY DOCTOR01;
CREATE USER PATIENT01 IDENTIFIED BY PATIENT01;

---Chi nhanh 02
--PHAN NAY CHI DE THAM KHAO, KHONG PHAI TRONG DO AN CUA MINH
CREATE USER HR_MANAGER03 IDENTIFIED BY HR_MANAGER03;
CREATE USER ACCOUNTING_MANAGER03 IDENTIFIED BY ACCOUNTING_MANAGER03;
CREATE USER SPECIALIZE_MANAGER03 IDENTIFIED BY SPECIALIZE_MANAGER03;
CREATE USER RECEPTIONIST03 IDENTIFIED BY RECEPTIONIST03;
CREATE USER FINANCE_STAFF03 IDENTIFIED BY FINANCE_STAFF03;
CREATE USER ACCOUNTING_STAFF03 IDENTIFIED BY ACCOUNTING_STAFF03;
CREATE USER PHARMACIST03 IDENTIFIED BY PHARMACIST03;
CREATE USER DOCTOR04 IDENTIFIED BY DOCTOR04;











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
        WHERE GRANTEE = 'SUPERADMIN';

    END;
/


--variable cur_test 
--exec ROLES_SELECT(:cur_test)
--print cur_test;
--alter session set "_ORACLE_SCRIPT"=true




--Proc tao user
CREATE OR REPLACE PROCEDURE ADD_USER(userName IN varchar2, pass IN varchar2) 
AUTHID CURRENT_USER IS
    BEGIN 
    EXECUTE IMMEDIATE 'alter session set "_ORACLE_SCRIPT"=true';
    EXECUTE IMMEDIATE
    'CREATE USER '||userName||' IDENTIFIED BY '||pass;
    END;

exec ADD_USER('test','223')

--Proc xoa User
CREATE OR REPLACE PROCEDURE DROP_USER(userName IN varchar2)
AUTHID CURRENT_USER IS
    BEGIN
    EXECUTE IMMEDIATE 'alter session set "_ORACLE_SCRIPT"=true';
    EXECUTE IMMEDIATE
    'DROP USER '||userName;
    END;

--Proc thay mat khau
CREATE OR REPLACE PROCEDURE USER_ALTER (name_user IN varchar2, new_pass IN varchar2)
AUTHID CURRENT_USER IS
    BEGIN
        EXECUTE IMMEDIATE 'alter session set "_ORACLE_SCRIPT"=true';
        EXECUTE IMMEDIATE
        'ALTER USER '|| name_user || ' IDENTIFIED BY ' || new_pass;
    END;
/


--exec DROP_USER('test')
--Proc tao role
CREATE OR REPLACE PROCEDURE ADD_ROLE(roleName IN varchar2)
AUTHID CURRENT_USER IS
    BEGIN
    EXECUTE IMMEDIATE 'alter session set "_ORACLE_SCRIPT"=true';
    EXECUTE IMMEDIATE
    'CREATE ROLE '||roleName;
    END;

--Proc xoa Role
CREATE OR REPLACE PROCEDURE DROP_ROLE(roleName IN varchar2)
AUTHID CURRENT_USER IS
    BEGIN
    EXECUTE IMMEDIATE 'alter session set "_ORACLE_SCRIPT"=true';
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
--KHONG SU DUNG--
CREATE OR REPLACE PROCEDURE GRANT_PRIVI(name IN VARCHAR2, tableName IN VARCHAR2, columnName IN VARCHAR2,
                                        se IN VARCHAR2, ins IN VARCHAR2, upd IN VARCHAR2, dele IN VARCHAR2,
                                        withg IN VARCHAR2)
AUTHID CURRENT_USER IS
    BEGIN
        EXECUTE IMMEDIATE 'alter session set "_ORACLE_SCRIPT"=true';
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

--GRANT UPDATE() ON PATIENT TO TEST20 WITH GRANT OPTION
--exec GRANT_PRIVI('DOCTOR04','HSBA','','','','UPDATE','','WITH GRANT OPTION');
--REVOKE all on patient from TEST11

--Proc thu hoi quyen
--KHONG SU DUNG--
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
--KHONG SU DUNG--
CREATE OR REPLACE PROCEDURE role2user(username IN VARCHAR2, rolename IN VARCHAR2)
AS
    BEGIN
        EXECUTE IMMEDIATE
        'GRANT '||rolename||' to '||username;
    END;



--grant roletest11 to test12
--exec  GRANT_PRIVI('ROLETEST11','PATIENT','','','','UPDATE','','');
--EXEC role2user('test12','roletest11')


Create table HSBA(
	Ma_HSBA number not null PRIMARY KEY,
Ma_BN number not null,
Ngay date,
Chan_Doan nvarchar2(40),
Ma_BS number not null,
Ma_Khoa number not null,
Ma_CSYT number not null,
Ket_Luan nvarchar2(40)
);
CONNECT TES10;
GRANT SELECT, INSERT, UPDATE, DELETE ON HSBA TO TES10;
grant update (Ma_BN) on HSBA to DOCTOR04;
REVOKE SELECT ON HSBA FROM DOCTOR04;
REVOKE QUANLY FROM TES10;
GRANT TESROLEE TO TES10;