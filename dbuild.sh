#!/usr/bin/env bash

push_flag_present=false

while getopts ":p" opt; do
    case "$opt" in
        p)
            push_flag_present=true
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done


# Build locally
docker build --tag brushes-webgl .

if [ "$push_flag_present" = true ]; then
    # Build for remote & push to server
    docker build --tag docker.swijnenburg.cc/brushes-webgl .
    docker push docker.swijnenburg.cc/brushes-webgl
fi

# Remove intermediate/untagged images
docker image prune -f