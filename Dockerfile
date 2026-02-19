FROM ubuntu:latest
LABEL authors="oussa"

ENTRYPOINT ["top", "-b"]