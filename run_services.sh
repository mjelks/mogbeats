echo "Enter your password so that subsequent sudo commands work"
sudo clear

ps -ef |grep "exec spork" | grep -v grep | awk '{print $2}' | xargs kill -9
ps -ef |grep "bin/spork" | grep -v grep | awk '{print $2}' | xargs kill -9
ps -ef |grep "exec guard" | grep -v grep | awk '{print $2}' | xargs kill -9
ps -ef |grep "fsevent_watch_guard" | grep -v grep | awk '{print $2}' | xargs kill -9
ps -ef |grep "bin/guard" | grep -v grep | awk '{print $2}' | xargs kill -9
ps -ef |grep "bin/rspec" | grep -v grep | awk '{print $2}' | xargs kill -9
ps -ef |grep "spork cucumber" | grep -v grep | awk '{print $2}' | xargs sudo kill -9
pg_ctl -D /usr/local/var/postgres stop -s -m fast

rm -Rf log/*.log
touch log/spork.log log/development.log log/memcached.log log/redis.log log/resque.log

RACK_ENV=development rails server &

pg_ctl -D /usr/local/var/postgres -l log/db.log start

tail -f log/spork.log log/development.log log/memcached.log log/redis.log log/resque.log
