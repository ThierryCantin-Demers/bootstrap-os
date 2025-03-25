#!/bin/bash

check_env_var() {
    for var in "$@"; do
        if [ -z "${!var}" ]; then
            echo -e "${RED}$var is not set${NOCOLOR}"
            exit 1
        fi
    done
}
