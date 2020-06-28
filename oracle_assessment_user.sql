create user ms_scan_user
identified by ora12345
default tablespace USERS
temporary tablespace TEMP;


grant dba to ms_scan_user;