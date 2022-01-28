function is_power_of_two () {
    declare -i n=$1
    (( n > 0 && (n & (n - 1)) == 0 ))
}

function log2 (){
    val=`echo "l($1)/l(2)" | bc -l`
    val=${val%%.*}

    echo $val
}