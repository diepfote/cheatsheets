select 'drop table if exists "' || tablename || '" cascade;' from pg_tables;
select 'drop sequence if exists ' || quote_ident(sequencename) || ' cascade;' from pg_sequences;
