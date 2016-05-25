# Some bash functions to manage swapping back and forth between
# docker-machine and docker for mac
# Install via "source ./path/docker-machine.sh"

# Sets environment variables set for docker-machine
# so I can run docker commands via my docker-machine

declare -a docker_machine_variables

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

function getenv() {
    get_docker_machine_variables
    
    if [ "${#docker_machine_variables[@]}" -eq 0 ]; then
	echo 
	echo "  No docker-machine environment variables have been set."
	echo
	
	return 1
    fi

    echo
    echo "  Current docker-machine environment variables:"

    for variable in "${docker_machine_variables[@]}"
    do
        echo "    $variable = $(printenv $variable)"
    done

    echo
    
    return 0
}


# Unsets environment variables set for docker-machine
# so I can quickly swap back to docker for mac
function unsetenv() {
    get_docker_machine_variables    

    if [ "${#docker_machine_variables[@]}" -eq 0 ]; then
	echo 
	echo "  No docker-machine environment variables have been set."
	echo
	
	return 1
    fi

    echo
    echo "  Unsetting ${#docker_machine_variables[@]} docker-machine environment variables:"
    
    for variable in "${docker_machine_variables[@]}"
    do
        echo "    unsetting $variable ..."
	unset $variable
    done

    echo
    
    return 0
}

# Returns an array of environment
function get_docker_machine_variables() {
    docker_machine_variables=($(env | cut -d'=' -f1 | grep "DOCKER_"))
}

export -f setenv
export -f getenv
export -f unsetenv
