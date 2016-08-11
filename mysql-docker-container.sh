# Commands to manage a mysql docker container

function mydb() {
    if [[ -z $1 ]]; then
	echo
	echo " Usage: mydb start [MYSQL_ROOT_PASSWORD=password]"
	echo

	return 1
    fi

    case "$1" in
        start)
	    echo
	    echo " Starting MySQL Building AutoSDV UI Docker Container ..."
            start ${2:-"password"}
            ;;
        *)
	    echo
            echo " Unknown command '$1'"
            echo " Usage: mydb start [root_password]}"
	    echo
            return 1
    esac
}

function start() {
    local running_container=$(docker ps --filter "name=mysql" --quiet)
    if [[ ! -z "$running_container" ]]; then
        echo " Aborting; A 'mysql' container is already running ..."
	echo
        return 1
    fi

    local stopped_container=$(docker ps --filter "name=mysql" --all --quiet)
    if [[ ! -z "$stopped_container" ]]; then
        echo " Found stopped 'mysql' container; Resuming ..."
	echo
        docker start $stopped_container
        return 0
    fi

    echo " No pre-existing container found; starting new container"
    echo
    docker run -it -d --name mysql -e MYSQL_ROOT_PASSWORD=$1 -p 3306:3306 mysql:5.7.14
}

export -f mydb
