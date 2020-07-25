function docker.images.list -d "Show a list of images with minimal information"
    docker image ls -a --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" --filter "dangling=false"
end
