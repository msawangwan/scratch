#!/usr/bin/env bash -e

declare logger_args

logger_args="logger -s -t "SYS-LOG-PRINTER""

put() {
	eval "$logger_args $@"
}

out() {
	#printf "%-12b\n" "$*"
	printf "%b\n" "$*"
	return 0
}

info() {
	out "[info]" "${1}"
	return 0
}

error() {
	out "[error]" "${1}" >&2
	return 1
}

cleanup() {
	info "cleaning up ${1}"
}

#trap 'error "an unexpected error occured"' ERR

main() {
#	trap 'cleanup "$(ls -alr)"' RETURN ERR
	#trap 'error "an unexpected error occured"' ERR
	local some_var=12345
	#logger ${logger_args} "| DEBUG | ${some_var}"
	put $some_var
	return 0
}

main
