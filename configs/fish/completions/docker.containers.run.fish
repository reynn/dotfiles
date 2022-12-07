#!/usr/bin/env fish

# --- docker.containers.run ---

complete -c 'docker.containers.run' -d 'The Entrypoint for the docker container' -l 'entrypoint'
complete -c 'docker.containers.run' -d 'Add environment variables to the running container' -l 'env' -s 'e'
complete -c 'docker.containers.run' -d 'The image to use for the container' -l 'image' -s 'i'
complete -c 'docker.containers.run' -d 'Use a preset for launching the container' -l 'preset' -s 'p'
complete -c 'docker.containers.run' -d 'Mount volumes to the container' -l 'volume_path' -s 'V'
complete -c 'docker.containers.run' -d 'Port specifications' -l 'port'
complete -c 'docker.containers.run' -d 'Detach from the container so it runs in the background' -l 'detach' -s 'd'
complete -c 'docker.containers.run' -d 'Run the container in interactive mode' -l 'interactive'
