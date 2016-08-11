# Commands to build and run the docker image necessary to

function sdv() {
    if [[ -z $1 ]]; then
	echo
	echo " Usage: sdv {build|run}"
	echo

	return 1
    fi

    case "$1" in
        build)
	    echo
	    echo " Building AutoSDV UI Docker Container ..."
	    echo
            build
            ;;
        run)
	    echo
	    echo " Running 'latest' AutoSDV UI Docker Container ..."
	    echo
            run
            ;;
        *)
	    echo
            echo " Unknown command '$1'"
            echo " Usage: sdv {build|run}"
	    echo
            return 1
    esac
}

function build() {
    cd /Users/brian/invio/dev/autosdv-ui
    npm run prod
    docker build --no-cache -t autosdv-ui:latest .
}

function run() {
    open http://localhost
    docker run --rm -e "NGINX_HOST=localhost" -e "NGINX_PORT=80" -p 80:80 autosdv-ui:latest
}

export -f sdv
