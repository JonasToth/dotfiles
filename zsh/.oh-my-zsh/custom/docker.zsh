alias drhere="docker run --rm -it --user $(id -u):$(id -g) -v \"$(pwd)\":/project"
alias drhereroot="docker run --rm -it -v \"$(pwd)\":/project"
