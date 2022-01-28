#!/bin/bash

SLACK_API=""
ENABLE_SLACK_ALARM=true

function slack_start_record() {
    if $ENABLE_SLACK_ALARM ; then
        slack_msg=$1
        curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"${slack_msg}\"}" $SLACK_API >/dev/null 2>/dev/null
    fi
}
