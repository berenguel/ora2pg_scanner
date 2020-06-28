Assessments at Scale using ORA2PG_SCANNER
---

**Introduction**

In this tutorial you will learn how to run ora2pg for assessments at scale/global assessments.
The process is very simple. I hope you enjoy it.


* 1: Running ora2pg_scanner

* 2: Building the repository


  

**Objectives**

At the end of this tutorial, you will be able to:

* *Demonstrate to customers how to run a global assessment* 

* *Build and query a repository that contains the assessment results*

* *Derive insights on where to begin for a large transformation of an oracle estate into Azure Database for PostgreSQL*

  

###  Exercise 1: Running ora2pg_scanner ###

The steps in this exercise will demonstrate how to configure the Oracle databases, the input ora2pg_scanner file and run the assessment command.


1. Let's create our Oracle user in the Oracle databases


       
     ~~~
     cd c:\ora2pg
     ~~~
     ~~~
     ora2pg --project_base c:\ts303 -c ora2pg_hr.conf –-init_project 		hr_migration
     ~~~

2. Run the assessment:

  - [x] Task:

     - On "**cmd**", navigate to the hr_migration folder
     - Run the following sequence of assessment commands

~~~
cd c:\ts303\hr_migration
~~~
~~~
ora2pg -t SHOW_REPORT -c c:\ora2pg\ora2pg_hr.conf --dump_as_html --estimate_cost > c:\ts303\hr_migration\reports\report.html
~~~
~~~
ora2pg -t SHOW_TABLE -c c:\ora2pg\ora2pg_hr.conf > c:\ts303\hr_migration\reports\tables.txt
~~~
~~~
ora2pg -t SHOW_COLUMN -c c:\ora2pg\ora2pg_hr.conf > c:\ts303\hr_migration\reports\columns.txt
~~~
~~~
ora2pg -t SHOW_REPORT -c c:\ora2pg\ora2pg_hr.conf –-cost_unit_value 10 --dump_as_html --estimate_cost > c:\ts303\hr_migration\reports\report2.html 
~~~



3. Check the report results:

- [x] Task:

   - Navigate to **c:\ts303\hr_migration\reports\**  via windows folders (UI)

   - Double click on **report.html** to open the report in your browser

     

~~~
Migration levels:

        A - Migration that might be run automatically

        B - Migration with code rewrite and a human-days cost up to 5 days

        C - Migration with code rewrite and a human-days cost above 5 days

    Technical levels:

        1 = trivial: no stored functions and no triggers

        2 = easy: no stored functions but with triggers, no manual rewriting

        3 = simple: stored functions and/or triggers, no manual rewriting

        4 = manual: no stored functions but with triggers or views with code rewriting

        5 = difficult: stored functions and/or triggers with code rewriting
~~~



**Summary:** In this exercise, you learnt how to assess an Oracle schema and understood how to articulate the migration complexity of a migration to Azure Database for PostgreSQL.



### Exercise 2: Migrate an Oracle schema to Azure Database for PostgreSQL ###

The steps in this exercise will demonstrate how to migrate an Oracle database to Azure Database for PostgreSQL. The attendees are going to export the Oracle database objects and code using ora2pg, fix some common migration problems and import the fixed objects and data into Azure Database for PostgreSQL. This exercise should take no longer than 25 min.

1. Let's setup the Azure Database for PostgreSQL service

   - [x] Task:

   - In your LAB environment, go to **RESOURCES**

   - Go to portal.azure.com (inside your lab environment) via Internet Explorer

   - Use the **username** and password and show in the **RESOURCES** tab and login to your subscription

     

     ![1549997262279](https://raw.githubusercontent.com/berenguel/lab303/master/IMG/im1.png)

   

   

   - Navigate to "**All Resources**"

   - Click in the **PostgreSQL** resource 

     

     ![1549997262279](https://raw.githubusercontent.com/berenguel/lab303/master/IMG/im2.png)



- Go to the "**Connection Security**" blade make sure the "**Firewall rules**" are properly set, as following:

  ​	Enforce SSL Connection DISABLED

  

- Click "Save"

  

  ![1549832443872](https://raw.githubusercontent.com/berenguel/lab303/master/IMG/im3.png)

  

  Close your browser and go back to **cmd**

  


2. Oracle Database Objects export:

- [x] Task:

- Go back to Windows **cmd** in your lab environment
- Export all the objects categories by running the following commands:

~~~
cd c:\ora2pg
~~~
~~~
ora2pg -p -t PROCEDURE -o procs.sql -b C:\ts303\hr_migration\schema\procedures -c C:\ora2pg\ora2pg_hr.conf
~~~
~~~
ora2pg -t SEQUENCE -o sequences.sql -b C:\ts303\hr_migration\schema\sequences -c C:\ora2pg\ora2pg_hr.conf
~~~
~~~
ora2pg -t TABLE -o table.sql -b C:\ts303\hr_migration\schema\tables -c C:\ora2pg\ora2pg_hr.conf
~~~
~~~
ora2pg -p -t TRIGGER -o triggers.sql -b C:\ts303\hr_migration\schema\triggers -c C:\ora2pg\ora2pg_hr.conf
~~~
~~~
ora2pg -p -t VIEW -o views.sql -b C:\ts303\hr_migration\schema\views -c C:\ora2pg\ora2pg_hr.conf
~~~



3. Let's create the Azure Database for PostgreSQL **lab303** database:

- [x] Task:

  Run the following commands to configure the target **lab303** PostgreSQL database:

  **DON'T FORGET** : Edit the PostgreSQL server (labXXXX.postgresql.database.azure.com) in the psql command to reflect your lab environment, also in the username string:  pgadmin@labXXXX 

```
cd C:\Program Files (x86)\pgAdmin 4\v4\Runtime
```
```
psql -h lab8381412.postgres.database.azure.com -p 5432 -U pgadmin@lab8381412 -d postgres 
```

Enter the Password when prompted. The password is: **LabAdmin303**

```
CREATE DATABASE lab303;
CREATE ROLE HR LOGIN PASSWORD 'test303';
GRANT CONNECT ON DATABASE lab303 TO HR;
GRANT ALL PRIVILEGES ON DATABASE lab303 TO HR;
```

```
\c lab303
```

```
CREATE SCHEMA HR;
GRANT USAGE ON SCHEMA HR TO HR;
GRANT HR TO pgadmin;
ALTER SCHEMA HR OWNER TO HR;
```
~~~
\q
~~~

After configuring the Azure Database for PostgreSQL equivalent of the Oracle environment, lets export the Oracle schema.

5. **Import HR Schema** into Azure Database for PosgreSQL

- [x] Task:

**DON'T FORGET** : Edit the PostgreSQL server (labXXXX.postgresql.database.azure.com) in the psql command to reflect your lab environment, also in the username string:  pgadmin@labXXXX 

~~~
psql -h lab8381412.postgres.database.azure.com -p 5432 -U hr@lab8381412 -d lab303
~~~
Password is **test303**
~~~
\o 'C:/ts303/hr_migration/schema/tables/create_table.log'
~~~
~~~
\i 'C:/ts303/hr_migration/schema/tables/table.sql'
~~~
~~~
\o 'C:/ts303/hr_migration/schema/sequences/create_sequences.log'
~~~
~~~
\i 'C:/ts303/hr_migration/schema/sequences/sequences.sql'
~~~
~~~
\o 'C:/ts303/hr_migration/schema/procedures/create_procs.log'
~~~
~~~
\i 'C:/ts303/hr_migration/schema/procedures/procs.sql'
~~~
~~~
\o 'C:/ts303/hr_migration/schema/triggers/create_triggers.log'
~~~
~~~
\i 'C:/ts303/hr_migration/schema/triggers/triggers.sql'
~~~
~~~
\o 'C:/ts303/hr_migration/schema/views/create_views.log'
~~~
~~~
\i 'C:/ts303/hr_migration/schema/views/views.sql'
~~~
~~~
\q
~~~

6. Run the Data Migration

- [x] Task:

Before you run the data migration task, you need to edit the config_hr.dist file with your postgreSQL server:

Navigate to C:\ora2pg using Windows Folders

Right-Click in the ora2pg_hr.conf file to open it with Notepad++

![1549997262279](https://raw.githubusercontent.com/berenguel/lab303/master/IMG/im4.PNG)









Edit the configuration as follow:

Edit PG_USER and PG_DSN to reflect your postgreSQL server details

![1549997262279](https://raw.githubusercontent.com/berenguel/lab303/master/IMG/im5.PNG)



Now, go to back to **CMD** and run:

```
ora2pg -t COPY -o data.sql -b C:\ts303\hr_migration\data -c C:\ora2pg\ora2pg_hr.conf
```



7. Fix the Data Migration error
~~~
psql -h lab8381412.postgres.database.azure.com -p 5432 -U hr@lab8381412 -d lab303
~~~
Password is **test303** 

~~~
ALTER TABLE hr.employees ALTER COLUMN SALARY3 TYPE NUMERIC(20,4); 
TRUNCATE TABLE HR.COUNTRIES;
TRUNCATE TABLE HR.DEPARTMENTS;
TRUNCATE TABLE HR.EMPLOYEES;
TRUNCATE TABLE HR.JOB_HISTORY;
TRUNCATE TABLE HR.JOBS;
TRUNCATE TABLE HR.LOCATIONS;
TRUNCATE TABLE HR.REGIONS;
~~~
~~~
\q
~~~

   

8. Re-Run Data Migration

- [x] Task:

```
ora2pg -t COPY -o data.sql -b C:\ts303\hr_migration\data -c C:\ora2pg\ora2pg_hr.conf
```

**Summary:** In this exercise, you learnt how to deploy the migration of data and schema from
Oracle to Azure Database for PostgreSQL. 

  

###  Exercise 3: Test the Migration ###



```
ora2pg -t TEST -c C:\ora2pg\ora2pg_hr.conf > c:\ts303\hr_migration\migration_diff.txt
```



**Summary**: In this exercise, you learnt how to test the migration from Oracle to Azure Database for PostgreSQL using ora2pg.
