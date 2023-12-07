# SQL

## Postgres

### Drop all tables

snatched parts from <https://stackoverflow.com/a/3327326>

```
$ cat /tmp/gen-drop.sql
select 'drop table if exists "' || tablename || '" cascade;' from pg_tables;

$ psql -p PORT -U USERNAME  --dbname DB_NAME -hHOSTNAME < /tmp/gen-drop.sql > /tmp/drop.sql
$ psql -p PORT -U USERNAME  --dbname DB_NAME -hHOSTNAME < /tmp/drop.sql
```

### Drop by user

drops schemas and tables -> do not do this if you need some of the schemas

```
DROP OWNED by <username>;
```
