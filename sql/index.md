# SQL

## Postgres

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
1. kubectl exec -it -n namespace pod -- bash

2. echo 'SELECT ... ' > /tmp/my-query.sql

# -c is not required, it is just to show case how to specify both path and container
3. kubectl cp -n namespace -c container  /tmp/my-query.sql pod:/tmp/my-query

4. psql -p 5432 --username dbusername --dbname whatevername -h thehost.com < /tmp/my-query > /tmp/query_output.txt

5. kubectl cp -n namespace -c container  pod:/tmp/query_output.txt /tmp/query_output.txt
```

### Drop by user

drops schemas and tables -> do not do this if you need some of the schemas

```text
DROP OWNED by <username>;
```
