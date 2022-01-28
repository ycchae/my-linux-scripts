
function make_user(){
    username=$1
    passwd=$2
    os=$(awk -F= '/^NAME/{print $2}' /etc/os-release)

    if ! id $username >/dev/null;then
        if [[ ${os,,} == *"ubuntu"* ]];then
            sudo apt-get install expect -y >/dev/null
            sudo expect -c "
            set timeout 1
            spawn sudo adduser $username
            expect \"New password: \"
            send \"$passwd\r\"
            expect \"Retype new password: \"
            send \"$passwd\r\"
            expect \"Full Name \[\]:\"
            send \"\r\"
            expect \"Room Number \[\]:\"
            send \"\r\"
            expect \"Work Phone \[\]:\"
            send \"\r\"
            expect \"Home Phone \[\]:\"
            send \"\r\"
            expect \"Other \[\]:\"
            send \"\r\"
            expect \"Is the information correct? \[Y/n\]\"
            send \"Y\r\"
            expect eof
            "
        fi
        if [[ ${os,,} == *"centos"* ]];then
            sudo yum install expect -y >/dev/null
            sudo expect -c "
            set timeout 1
            spawn sudo adduser $username
            expect \"Enter new UNIX password: \"
            send \"$passwd\r\"
            expect \"Retype new UNIX password: \"
            send \"$passwd\r\"
            expect \"Full Name \[\]:\"
            send \"\r\"
            expect \"Room Number \[\]:\"
            send \"\r\"
            expect \"Work Phone \[\]:\"
            send \"\r\"
            expect \"Home Phone \[\]:\"
            send \"\r\"
            expect \"Other \[\]:\"
            send \"\r\"
            expect \"Is the information correct? \[Y/n\]\"
            send \"Y\r\"
            expect eof
            "

        fi
    fi
}

