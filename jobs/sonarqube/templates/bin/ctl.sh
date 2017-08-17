#!/bin/bash

APP_NAME=sonarqube
APP_DIR=/var/vcap/sys/run/${APP_NAME}
LOG_DIR=/var/vcap/sys/log/${APP_NAME}
PIDFILE=${APP_DIR}/pid
RUN_USER=vcap

case $1 in

    start)
        mkdir -p $APP_DIR $LOG_DIR
        chown -R $RUN_USER:$RUN_USER $APP_DIR $LOG_DIR

        echo $$ > $PIDFILE

        cd /var/vcap/packages/${APP_NAME}

        exec /var/vcap/packages/${APP_NAME}/bin/${APP_NAME} \
             >>  $LOG_DIR/${APP_NAME}.stdout.log \
             2>> $LOG_DIR/${APP_NAME}.stderr.log

        ;;

    stop)
        kill -9 `cat $PIDFILE` && rm -f $PIDFILE
        ;;

    *)
        echo "Usage: ctl {start|stop}" ;;
        
    esac
