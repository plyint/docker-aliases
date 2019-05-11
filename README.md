# docker-aliases
Use Bash alias to run commands inside docker containers to avoid having to install programs and their dependencies into your main OS. The aliases are saved into the file called "aliases.sh".

## Concept
The main idea is to run a comand using its docker image.
```
$ docker run --rm -v $(pwd):/directory -w /directory node node
```

By aliasing this command, we can provide the same experience as if the command was running locally...
```
$ alias node='docker run --rm -v $(pwd):/directory -w /directory node node'
$ node --version
Unable to find image 'node:latest' locally
latest: Pulling from library/node
c5e155d5a1d1: Already exists 
221d80d00ae9: Already exists 
4250b3117dca: Already exists 
3b7ca19181b2: Already exists 
425d7b2a5bcc: Already exists 
69df12c70287: Already exists 
9b754a1bcda7: Pull complete 
74b273083e97: Pull complete 
Digest: sha256:3d4411d1933dc93e78b9e0de556a22178269952b98cbbea7ca935d890527ae27
Status: Downloaded newer image for node:latest
v12.2.0
```

You'll notice that in this case we didn't have the image downloaded intially.  Since, the alias uses "docker run", then we also get the benefit of automatically downloading the image the first time the command is run if the image doesn't exist.

If the image exists or the command is run subsequent times, then your local version of the image will be used.
```
$ node --version
v12.2.0
```

The aliases.sh contains helper functions to make the construction of these aliases easy and simple to maintain.  You can easily extend the capabilities of aliases.sh by adding your own functions or modifying the existing ones.

## Requirements
* Docker
* Bash

## Usage
1. Download the aliases.sh file or clone the repo
2. Source the aliases.sh file within ~/.bash_profile or ~/.bashrc:
```
    source <path_to_file>/aliases.sh
```
3. Reload your terminal using ". ~/.bashrc" or open a fresh terminal and the commands are ready to use.

## Recommendations
While you can alias any docker image (including the official images on Docker Hub), it is recommended for security reasons to build the images yourself. By doing so, you can ensure that there is no malicious software contained in the image.
