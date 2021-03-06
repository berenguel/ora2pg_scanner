import csv
import psycopg2

pghost = "mypgbeast1.postgres.database.azure.com"
pgdatabase = "HR"
pguser = "corp@mypgbeast1"
pgpassword = "XXXYYYYYY"
sslmode = "require"

conn_string = "host={0} user={1} dbname={2} password={3} sslmode={4}".format(pghost, pguser, pgdatabase, pgpassword, sslmode)

def read_csv(file_path):
    with open(file_path) as csv_file:
        scan_reader = csv.reader(csv_file, delimiter=';', quotechar='"')
        scan_reader = [item for item in scan_reader]
        return scan_reader[1:]

def run_inserts(file_path):
    rows = read_csv(file_path)
    print("Rows have {0} lines".format(len(rows)))

    with psycopg2.connect(conn_string) as conn:
        print("Connection established with SQL")

        for row in rows:
            values = "'" + "', '".join(row) + "'"

            conn.commit()


            insert = """ insert into public.ora2pg_scale_assessment(id, instance, version, schema_rpt,size_rpt,cost_assessment,migration_type,database_link_rpt,directory_rpt,
                          function_rpt,index_rpt,job_rpt,materialized_view_rpt,package_body_rpt,procedure_rpt,query_rpt,sequence_rpt,synonym_rpt,table_rpt,table_partition_rpt,
                          table_subpartition_rpt,trigger_rpt,type_rpt,view_rpt,total_assessment)
                          values (nextval('public.sq_schema_ass'), {0})""".format(values)

            conn.cursor().execute(insert)

            conn.commit()

            value_detail = []

            for value in row[-18:]:
                split_var = values.split("/")
                value_detail.extend(value.split("/"))


            values = "'" + "', '".join(value_detail) + "'"


            insert_detail = """ insert into public.ora2pg_scale_assessment_detail (id, ora2pg_scale_assessment_id,database_link_qty,database_link_inv,database_link_cost,directory_qty,
                                directory_inv,directory_cost,function_qty,function_inv,function_cost,index_qty,index_inv,index_cost,job_qty,job_inv,job_cost,materialized_view_qty,
                                materialized_view_inv,materialized_view_cost,package_body_qty,package_body_inv,package_body_cost,procedure_qty,procedure_inv,procedure_cost,query_qty,
                                query_inv,query_cost,sequence_qty,sequence_inv,sequence_cost,synonym_qty,synonym_inv,synonym_cost,table_qty,table_inv,table_cost,table_partition_qty,
                                table_partition_inv,table_partition_cost,table_subpartition_qty,table_subpartition_inv,table_subpartition_cost,trigger_qty,trigger_inv,trigger_cost,type_qty,
                                type_inv,type_cost,view_qty,view_inv,view_cost, assessment_total_qty, assessment_total_inv, assessment_total_cost) values (nextval('public.sq_schema_ass_detail'),
                                currval('public.sq_schema_ass'), {0})""".format(values)


            conn.cursor().execute(insert_detail)



if __name__ == '__main__':
    run_inserts('c:\dbs_scan.csv')
