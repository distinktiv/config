export PYTHON=/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home
export PATH=$PATH://Users/distinktiv/Projects/play/activator-1.3.2-minimal:/usr/local/Cellar/maven/3.3.9

alias mysql=/usr/local/mysql/bin/mysql
alias distinktiv-prod="jump distinktiv-prod1"
alias distinktiv-sftp="jump distinktiv-sftp"
alias ll="ls -la"
 
jump() {
    display_usage=false
    server_not_found=true

    servers=()
    #servers+=("<server shortcut>|<command to connect to the server>")
    servers+=("distinktiv-prod1|ssh spierre@159.203.9.49") #digitalocean
    servers+=("distinktiv-sftp|sftp spierre@159.203.9.49") #digitalocean
    servers+=("distinktiv-staging|") #cloudatcost
        #servers+=("prod-polopoly1|")

    #If an argument is passed to the funcion
    if [[ -n $1 ]]; then
        #Check the argument value in the servers array and execute the corresponding command
        for i in "${!servers[@]}"; do
            key=${servers[$i]%|*}
            cmd=${servers[$i]#*|}
            if [[ $key == $1 ]]; then
                server_not_found=false
                echo -e "${C_PURPLE}jumping to: ${C_YELLOW}${cmd}${C_RESET}"
                eval $cmd
            fi
        done
        #If server key is not found, print some help
        if $server_not_found ; then
            echo -e "${C_RED}$1 is not found.${C_RESET}"
            display_usage=true
        fi
    else
        display_usage=true
    fi

    #If no argument are passed, print some help
    if $display_usage ; then
        echo "${FUNCNAME[0]} [server]"
        echo "This function allow you to connect to the following remote servers."
        echo "Available servers: "
        for i in "${!servers[@]}"; do
            key=${servers[$i]%|*}
            cmd=${servers[$i]##*|}
            printf "  %-15s: ${cmd}\n" $key #To add padding change -15
        done
        echo " "
        echo "Example:"
        echo "  ${FUNCNAME[0]} $key"
    fi
}

