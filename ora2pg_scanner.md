Assessments at Scale using ORA2PG_SCANNER
---

**Introduction**

In this tutorial you will learn how to run ora2pg for assessments at scale/global assessments.
The process is very simple. I hope you enjoy it.


* 1: Running ora2pg_scanner

* 2: Building the Assessment Repository


  

**Objectives**

At the end of this tutorial, you will be able to:

* *Demonstrate to customers how to run a global assessment* 

* *Build and query a repository that contains the assessment results*

* *Derive insights on where to begin for a large transformation of an oracle estate into Azure Database for PostgreSQL*

  

###  Running ora2pg_scanner ###

The steps in this exercise will demonstrate how to configure the Oracle databases, the input ora2pg_scanner file and run the assessment command.


1. Let's create the Oracle user for the assessment in the Oracle databases:


       
     ~~~
		create user ms_scan_user
		identified by ora12345
		default tablespace USERS
		temporary tablespace TEMP;
     ~~~
     ~~~
		grant dba to ms_scan_user;
	 
	 
The above script is a suggestion. There are options on what users can be used for this assessment such as schemas, system user or any other priviledged user or role.


2. Set up ora2pg_scanner list file

3. Run ora2pg_scanner
~~~
ora2pg_scanner -l global_assessment.csv -o assessment_results
~~~

**Summary:** In this exercise, you learnt how to run a global assessment using ora2pg_scanner



### Building the Assessment Repository ###

The steps in this exercise will demonstrate how build a queriable repository and have insights of the migration efforts into Azure Database for PostgreSQL

1.	Configure an Azure SQL instance
In this step you should either create an Azure SQL DB or MI or SQL Server instances.
If you already have one, just retrieve the following credentials:
hostname, port, database, username, password


2.	Run the Azure SQL DDL to create the base tables for the repository

Connect to the Azure SQL/SQL Server database via SSMS or similar and run:

** The user has to have create table and create sequence priviledges **

~~~
azure_sqldb_schema.sql
~~~

3.	Run a Python program that loads the html files into Azure SQL DB

~~~
python chew_assessment.py
~~~

4.	Query the repository

~~~
select b.* , a.* from ora2pg_scale_assessment_detail a
inner join ora2pg_scale_assessment b on a.ora2pg_scale_assessment_id = b.id
order by cost_assessment asc
~~~