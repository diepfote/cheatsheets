# SQL

## Postgres

### List structures in Postgres

`\dt` ... list tables  
`\df` ... list functions  
`\ds` ... list sequences  
`\dn` ... list schemas  

### Run statements from a file while in prompt

```text
\i /path/to/file
```

If you want to redirect stdout (e.g. so you can save generated statements):

```text
\o /path/to/drop.sql \i /path/to/gen-drop.sql
```

### Drop all tables

snatched parts from <https://stackoverflow.com/a/3327326>

```text
$ cat /tmp/gen-drop.sql
select 'drop table if exists "' || tablename || '" cascade;' from pg_tables;

$ psql -p PORT -U USERNAME  --dbname DB_NAME -hHOSTNAME < /tmp/gen-drop.sql > /tmp/drop.sql
$ psql -p PORT -U USERNAME  --dbname DB_NAME -hHOSTNAME < /tmp/drop.sql
```

### Run sql query on kubernetes pod

And then fetch the result

```text
1. echo 'SELECT ... ' > /tmp/my-query.sql

# -c is not required, it is just to show case how to specify both path and container
2. kubectl cp -n namespace -c container  /tmp/my-query.sql pod:/tmp/my-query

3. kubectl exec -it -n namespace pod -- bash

4. psql -p 5432 --username dbusername --dbname whatevername -h thehost.com < /tmp/my-query > /tmp/query_output.txt

5. kubectl cp -n namespace -c container  pod:/tmp/query_output.txt /tmp/query_output.txt
```

### Drop by user

drops schemas and tables -> do not do this if you need some of the schemas

```text
DROP OWNED by <username>;
```

### Drop Schema

```text
drop SCHEMA <name> cascade;
```

### Create Schema

```text
create SCHEMA <schema_name>;
GRANT USAGE ON SCHEMA <schema_name> to <user>;
```
