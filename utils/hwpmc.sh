CAS_COUNT=false

function set_counter()
{
    space=$1

    # MSR (PMU counter)
    if [ $(lsmod | grep -w msr | wc -l) -eq 0 ];then
        sudo modprobe msr
    fi
    if [ $space == "u" ];then
        sudo /usr/sbin/wrmsr -a 0x38d 0x022;
        sudo /usr/sbin/wrmsr -a 0x186 0x4201A2;
    elif [ $space == "k" ];then
        sudo /usr/sbin/wrmsr -a 0x38d 0x011;
        sudo /usr/sbin/wrmsr -a 0x186 0x4101A2;
    elif [ $space == "ku" ] || [ $space == "uk" ] || [ $space == "" ] || [ -z $space ];then
        sudo /usr/sbin/wrmsr -a 0x38d 0x033;
        sudo /usr/sbin/wrmsr -a 0x186 0x4301A2;
    fi

    if $CAS_COUNT; then
        # (Controller, Channel)=(0,0)
        sudo setpci -d *:6fb0 D8.l=0x400304; sudo setpci -d *:6fb0 DC.l=0x400c04;
        # (Controller, Channel)=(0,1)
        sudo setpci -d *:6fb1 D8.l=0x400304; sudo setpci -d *:6fb1 DC.l=0x400c04;
        # (Controller, Channel)=(1,0)
        sudo setpci -d *:6fd0 D8.l=0x400304; sudo setpci -d *:6fd0 DC.l=0x400c04;
        # (Controller, Channel)=(1,1)
        sudo setpci -d *:6fd1 D8.l=0x400304; sudo setpci -d *:6fd1 DC.l=0x400c04;
    fi
}

function unset_counter()
{
    # MSR (PMU counter)
    sudo /usr/sbin/wrmsr -a 0x38d 0x0;
    sudo /usr/sbin/wrmsr -a 0x186 0x0;

    if $CAS_COUNT; then
	    # (Controller, Channel)=(0,0)
        sudo setpci -d *:6fb0 D8.l=0x0; sudo setpci -d *:6fb0 DC.l=0x0;
        # (Controller, Channel)=(0,1)
        sudo setpci -d *:6fb1 D8.l=0x0; sudo setpci -d *:6fb1 DC.l=0x0;
        # (Controller, Channel)=(1,0)
        sudo setpci -d *:6fd0 D8.l=0x0; sudo setpci -d *:6fd0 DC.l=0x0;
        # (Controller, Channel)=(1,1)
        sudo setpci -d *:6fd1 D8.l=0x0; sudo setpci -d *:6fd1 DC.l=0x0;
    fi
}

function init_counter()
{
    # MSR (PMU counter)
    sudo /usr/sbin/wrmsr -a 0x309 0x0; sudo /usr/sbin/wrmsr -a 0x30a 0x0;
    sudo /usr/sbin/wrmsr -a 0xc1 0x0; 

    if $CAS_COUNT; then
        # (Controller, Channel)=(0,0)
        sudo setpci -d *:6fb0 A0.l=0x0; sudo setpci -d *:6fb0 A4.l=0x0; sudo setpci -d *:6fb0 A8.l=0x0; sudo setpci -d *:6fb0 AC.l=0x0;
        # (Controller, Channel)=(0,1)
        sudo setpci -d *:6fb1 A4.l=0x0; sudo setpci -d *:6fb1 A0.l=0x0; sudo setpci -d *:6fb1 A8.l=0x0; sudo setpci -d *:6fb1 AC.l=0x0;
        # (Controller, Channel)=(1,0)
        sudo setpci -d *:6fd0 A0.l=0x0; sudo setpci -d *:6fd0 A4.l=0x0; sudo setpci -d *:6fd0 A8.l=0x0; sudo setpci -d *:6fd0 AC.l=0x0;
        # (Controller, Channel)=(1,1)
        sudo setpci -d *:6fd1 A0.l=0x0; sudo setpci -d *:6fd1 A4.l=0x0; sudo setpci -d *:6fd1 A8.l=0x0; sudo setpci -d *:6fd1 AC.l=0x0;
    fi
}
