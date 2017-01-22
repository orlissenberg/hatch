#!/bin/bash

function godoc_http_start {
    godoc -http=:6060 &
    echo $! > godoc.pid
}

if [ $1 = "start" ]; then
     godoc_http_start
     echo "godoc started"
elif [ $1 = "stop" ]; then
    if [ -f godoc.pid ]; then
        kill -TERM $(cat godoc.pid)
        rm godoc.pid
        echo "godoc stopped"
    fi 
fi

