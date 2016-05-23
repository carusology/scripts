# Sets environment variables set for docker-machine
# so I can run docker commands via my docker-machine
function setenv() {
    if [[ -z $1 ]]; then
	echo
	echo "  Usage: setenv [machine-name]"
	echo

	return 1
    fi
    
    echo
    echo "  Initializing docker-machine '$1' ..."
    echo 
    
    eval $(docker-machine env $1)
}

# Unsets environment variables set for docker-machine
# so I can quickly swap back to docker for mac
function unsetenv() {
    local variables=($(env | cut -d'=' -f1 | grep "DOCKER_"))
    if [ "${#variables[@]}" -eq 0 ]; then
	echo 
	echo "  No docker-machine environment variables have been set."
	echo
	
	return 1
    fi

    echo
    echo "  Unsetting ${#variables[@]} docker-machine environment variables:"
    
    for variable in "${variables[@]}"
    do
        echo "    unsetting $variable ..."
	unset $variable
    done

    echo
    
    return 0
}

export -f setenv
export -f unsetenv
