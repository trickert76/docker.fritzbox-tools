# docker.fritzbox-tools

This project creates a simple docker image to handle fb-tools (https://www.mengelke.de/Projekte/FritzBox-Tools) 
by using a docker image instead of installing it manually on a local system (avoids any dependency and keeps the system clean).

You can run it with

    docker compose build
    docker compose up -d
    docker compose fbtools exec fb-tools -h

Havve fun!