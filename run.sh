#!/usr/bin/env bash

function run {
    local command=$1;

    case ${command} in
        resize)
            ./resize.sh ${@:2}
            ;;
    esac
}

run $@