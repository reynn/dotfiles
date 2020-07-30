#!/usr/bin/env fish

function docker.container.list -d "Show a list of containers with minimal information"
    docker container ls -a --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'
end
