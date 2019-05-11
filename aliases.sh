#!/usr/bin/env bash
function docker_alias() {
	docker run -it --rm --user $(id $2 -u -u) \
        -v $(pwd):$1 -w $1 \
        ${@:3}
}

function docker_alias_ssh() {
	docker run -it --rm --user $(id $2 -u -u) \
        -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
        -v $(pwd):$1 -w $1 \
        ${@:3}
}

alias hygen='docker_alias /directory $USER plyint/hygen hygen'
alias ansible='docker_alias_ssh /directory root plyint/ansible ansible'
alias ansible-playbook='docker_alias_ssh /directory root plyint/ansible ansible-playbook'
