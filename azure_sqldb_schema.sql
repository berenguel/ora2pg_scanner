create table dbo.ora2pg_scale_assessment(
	id 			numeric(10),
	instance 	varchar(200),
	version 	varchar(200),
	schema_rpt 		varchar(200),
	size_rpt		varchar(200),
	cost_assessment varchar(200),
	migration_type 	varchar(200),
	database_link_rpt	 	varchar(200),
	directory_rpt	 		varchar(200),
	function_rpt 			varchar(200),
	index_rpt 				varchar(200),
	job_rpt	 				varchar(200),
	materialized_view_rpt	 	varchar(200),
	package_body_rpt	 		varchar(200),
	procedure_rpt 				varchar(200),
	query_rpt	 				varchar(200),
	sequence_rpt 				varchar(200),
	synonym_rpt					varchar(200),
	table_rpt	 				varchar(200),
	table_partition_rpt	 		varchar(200),
	table_subpartition_rpt	 	varchar(200),
	trigger_rpt					varchar(200),
	type_rpt	 				varchar(200),
	view_rpt	 				varchar(200),
	total_assessment 			varchar(200)
) 


create table dbo.ora2pg_scale_assessment_detail(
	id numeric(10),
	ora2pg_scale_assessment_id  numeric(10),
	database_link_qty	 		NUMERIC(10),
	database_link_inv	 		NUMERIC(10),	
	database_link_cost	 		NUMERIC(10,2),	
	directory_qty	 			NUMERIC(10),
	directory_inv	 			NUMERIC(10),
	directory_cost	 			NUMERIC(10,2),		
	function_qty 				NUMERIC(10),
	function_inv 				NUMERIC(10),
	function_cost 				NUMERIC(10,2),	
	index_qty 					NUMERIC(10),
	index_inv 					NUMERIC(10),
	index_cost 					NUMERIC(10,2),	
	job_qty	 					NUMERIC(10),
	job_inv	 					NUMERIC(10),
	job_cost	 				NUMERIC(10,2),	
	materialized_view_qty	 	NUMERIC(10),
	materialized_view_inv	 	NUMERIC(10),
	materialized_view_cost	 	NUMERIC(10,2),	
	package_body_qty	 		NUMERIC(10),
	package_body_inv	 		NUMERIC(10),
	package_body_cost	 		NUMERIC(10,2),		
	procedure_qty 				NUMERIC(10),
	procedure_inv 				NUMERIC(10),
	procedure_cost 				NUMERIC(10,2),		
	query_qty	 				NUMERIC(10),
	query_inv	 				NUMERIC(10),
	query_cost	 				NUMERIC(10,2),	
	sequence_qty 				NUMERIC(10),
	sequence_inv 				NUMERIC(10),
	sequence_cost 				NUMERIC(10,2),		
	synonym_qty					NUMERIC(10),
	synonym_inv					NUMERIC(10),
	synonym_cost				NUMERIC(10,2),		
	table_qty	 				NUMERIC(10),
	table_inv	 				NUMERIC(10),
	table_cost	 				NUMERIC(10,2),		
	table_partition_qty	 		NUMERIC(10),
	table_partition_inv	 		NUMERIC(10),
	table_partition_cost	 	NUMERIC(10,2),		
	table_subpartition_qty	 	NUMERIC(10),
	table_subpartition_inv	 	NUMERIC(10),
	table_subpartition_cost	 	NUMERIC(10,2),		
	trigger_qty					NUMERIC(10),
	trigger_inv					NUMERIC(10),
	trigger_cost				NUMERIC(10,2),		
	type_qty	 				NUMERIC(10),
	type_inv	 				NUMERIC(10),
	type_cost	 				NUMERIC(10,2),	
	view_qty	 				NUMERIC(10),
	view_inv	 				NUMERIC(10),	
	view_cost	 				NUMERIC(10,2),
	assessment_total_qty		NUMERIC(10),
	assessment_total_inv		NUMERIC(10),
	assessment_total_cost		NUMERIC(10,2),
);
	
CREATE SEQUENCE dbo.sq_schema_ass 
    START WITH 1  
    INCREMENT BY 1

CREATE SEQUENCE dbo.sq_schema_ass_detail
	start with 1
	increment by 1;
	
--SELECT NEXT VALUE FOR dbo.sq_schema_ass 




