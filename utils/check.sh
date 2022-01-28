##### User Input
function wait_yesno_with_msg(){
    _COLOR_RED="\033[31m"
    _COLOR_END="\033[0m"
    msg=$1
    read -p "$1 [y/n] "
    if [[ ! $REPLY =~ ^[Yy]$ ]];then
        echo -e "${_COLOR_RED}STOPPED${_COLOR_END}"
        exit 1
    fi
}

##### IP/Port
function check_port_open(){
	IP=$1
	PORT=$2
	bash -c "cat < /dev/null > /dev/tcp/$IP/$PORT" >/dev/null 2>&1
	if [ $? -eq 0 ];then
		return 0
	else
		return 1
	fi
}

function get_my_ip(){
    hostname -I | awk '{ print $1 }'
}


##### Time limit

function wait_until(){
    condition=$1
    if [ ! -z $2 ];then
        wait_sec=$2
    else
        wait_sec=$SKIP_WAIT_SEC
    fi
    if [ $wait_sec -eq 0 ];then
        wait_sec=36000
    fi
    
    echo -n "Waiting for $condition.."
    timeout=0
    until eval $condition; do
        echo -n "."
        sleep 1
        let timeout=$timeout+1
        if [ $timeout -gt $wait_sec ]; then
            echo -e ${Red}"TIMEOUT"${Color_off}
            return 1
        fi
    done
    echo ""
    return 0
}

##### Remote

function check_remote_file(){
    runner=$1
    filename=$2

    if ssh $runner "stat $filename >/dev/null 2>&1";then 
		return 0
    else
		return 1
    fi
}

##### H/W

function get_machine_spec(){
    hostname=$(hostname)
    cores=$(nproc)
    mem_size=$(printf %.0f $(free -h | awk 'NR==2 {print $2}' | sed 's/[^0-9.]//g'))

    os=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
    if [[ ${os,,} == *"ubuntu"* ]];then ptname=sda; elif [[ ${os,,} == *"centos"* ]];then ptname=vda; fi
    [ $(lsblk -d -o name,rota | grep $ptname | awk '{print $2}') == "0" ] && storage_type=SSD || storage_type=HDD
    
    echo ${hostname}-${cores}-${mem_size}-${storage_type}
}

######## PACKAGE MANAGE MODULE ########

function check_cmd_install_package(){
    command=$1
    package=$2

    os=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
    if [[ ${os,,} == *"ubuntu"* ]];then
        if dpkg -S `which $command` >/dev/null 2>/dev/null;then
            echo "Installing $package"; sudo apt-get install $package -y >/dev/null && echo "$package installed" && return 0
        fi
    elif [[ ${os,,} == *"centos"* ]];then
        if rpm -q `which $command` >/dev/null 2>/dev/null;then
            echo "Installing $package"; sudo yum install $package -y >/dev/null && echo "$package installed" && return 0
        fi
    fi
    return 1
}

function check_cmd_install_script(){
    command=$1
    script=$2

    which $command >/dev/null 2>/dev/null
    if [ $? -ne 0 ];then
        echo "Installing $command"; sudo bash $script >/dev/null && echo "$command installed" && return 0
    fi
    return 1
}

function check_file_install_script(){
    file=$1
    script=$2

    stat $file >/dev/null 2>/dev/null
    if [ $? -ne 0 ];then
        echo "Installing $file"; sudo bash $script >/dev/null && echo "$file installed" && return 0
    fi
    return 1
}
