#!/bin/bash

function mkdocs_start {
    mkdocs serve --quiet &> mkdocs.log &
    echo $! > mkdocs.pid
}

if [ $1 = "start" ]; then
     mkdocs_start
     echo "mkdocs started"
elif [ $1 = "stop" ]; then
    if [ -f mkdocs.pid ]; then
        kill -TERM $(cat mkdocs.pid)
        rm mkdocs.pid
        echo "mkdocs stopped"
    fi 
fi

