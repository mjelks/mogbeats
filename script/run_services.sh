# local mgj dev stuff
# stop/start local postgres server
pg_ctl -D /usr/local/var/postgres stop -s -m fast
pg_ctl -D /usr/local/var/postgres -l log/db.log start