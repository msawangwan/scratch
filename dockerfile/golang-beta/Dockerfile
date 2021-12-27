# syntax=docker/dockerfile:1.3-labs

FROM golang:latest

RUN apt update && apt install -y vim
RUN go install golang.org/dl/go1.18beta1@latest
RUN go1.18beta1 download

RUN <<EOF
        echo "syntax on" >> /root/.vimrc
        echo "set number" >> /root/.vimrc
        echo "set noexpandtab" >> /root/.vimrc
        echo "set sw=4" >> /root/.vimrc
        echo "set ts=4" >> /root/.vimrc
        echo "set sts=4" >> /root/.vimrc
        echo "set tw=120" >> /root/.vimrc
EOF

RUN <<EOF
        echo "export GOPATH=/go" >> /root/.bashrc
        echo "export GOROOT=/go" >> /root/.bashrc
        echo "export PATH=/go/bin:\$PATH" >> /root/.bashrc
        echo "alias go=/go/bin/go1.18beta1" >> /root/.bashrc
        echo "alias l=\"ls -1\"" >> /root/.bashrc
EOF
