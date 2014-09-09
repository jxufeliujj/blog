#!/bin/bash

# =======================================
# Settings
# =======================================

APP=blog
APP_DIR=/root/go/src/github.com/jxufeliujj/blog
LOG_DIR=/root/go/src/github.com/jxufeliujj/blog
PID_FILE=$APP_DIR/pid

# =======================================
# DO NOT CHANGE
# =======================================


# source function library
. /etc/rc.d/init.d/functions

RETVAL=0

start() {
    run_cmd="$APP_DIR/blog"
    taskset -c 0,15 nohup $run_cmd 2>&1 >> $LOG_DIR/stdout.log &
    echo $! > "$PID_FILE"
    success && echo "Starting $APP..."	
}

stop() {
   pid=$(cat $PID_FILE 2>/dev/null)
   if checkpid $pid; then
    kill "$pid" 2>/dev/null
    timeout=30
    while checkpid $pid; do
      if (( timeout-- == 0 )); then
        kill -KILL "$pid" 2>/dev/null
      fi
      sleep 1
    done
    success
  else
    failure
  fi
  echo "Stopping $APP..."
}

restart() {
  stop
  start
}

case "$1" in
  start)
  start
  ;;
  stop)
  stop
  ;;
  restart|force-reload|reload)
  restart
  ;;
  status)
  status -p $pid_file
  RETVAL=$?
  ;;
  *)
  echo $"Usage: $0 {start|stop|status|restart|reload|force-reload}"
  exit 1
esac

exit $RETVAL

