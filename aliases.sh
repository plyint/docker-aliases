#!/usr/bin/env bash
source encpass.sh

function docker_alias() {
	if [ "$1" = "NULL" ]; then
		docker run -it --rm --user $(id $2 -u -u) \
					${@:3}
	else
		docker run -it --rm --user $(id $2 -u -u) \
					-v $(pwd):$1 -w $1 \
					${@:3}
	fi
}

function docker_alias_ssh() {
	docker run -it --rm --user $(id $2 -u -u) \
        -v ~/.ssh/id_rsa_plyint_nonprod:/root/.ssh/id_rsa_plyint_nonprod \
        -v $(pwd):$1 -w $1 \
        ${@:3}
}

alias ansible='docker_alias_ssh /directory root plyint/ansible ansible'
alias ansible-playbook='docker_alias_ssh /directory root plyint/ansible ansible-playbook'
alias packer='docker_alias_ssh /directory root plyint/packer:light'
alias terraform='docker_alias_ssh /directory root plyint/terraform terraform'
alias vault='docker_alias_ssh /directory root --cap-add=IPC_LOCK plyint/vault vault'
alias skaffold='docker_alias_ssh /directory root plyint/skaffold:v1.7.0 skaffold'
alias helm='docker_alias /directory root -v ~/.kube:/root/.kube -v ~/.helm:/root/.helm -v ~/.config/helm:/root/.config/helm \
    -v ~/.cache/helm:/root/.cache/helm -v ~/.minikube:$HOME/.minikube plyint/helm:3.1.1'
alias doctl='docker_alias NULL root -v ~/.config:/root/.config plyint/doctl:1.41.0 -t $(get_secret plyint.ops~digitalocean token)'
