##### Local

function get_pids(){    
    process_name=$1

    ps -ef | grep $process_name | grep -v grep | awk '{print $2}' 2>/dev/null
}

function kill_process_nossh(){
    process_name=$1
    if [ -z $2 ];then
        signal=INT
    else
        signal=$2
    fi
    ssh $runner "kill -$signal \$(ps -ef | grep $process_name | grep -v grep | grep -v ssh | awk '{print \$2}') >/dev/null 2>&1"
    # pkill -$signal -ef $process_name >/dev/null && return 0
    # return 1
}

##### Remote

function get_remote_pids(){
    runner=$1
    process_name=$2

    ssh $runner "ps -ef | grep $process_name | grep -v grep | awk '{print \$2}'" 2>/dev/null
}

function get_remote_pids_except(){
    runner=$1
    process_name=$2
    except_pname=$3

    ssh $runner "ps -ef | grep $process_name | grep -v $except_pname | grep -v grep | awk '{print \$2}'" 2>/dev/null
}

function kill_remote_process_nossh(){
    runner=$1
    process_name=$2
    if [ -z $3 ];then
        signal=2
    else
        signal=$3
    fi
    ssh $runner "kill -$signal \$(ps -ef | grep $process_name | grep -v grep | grep -v ssh | awk '{print \$2}') >/dev/null 2>&1"
}
