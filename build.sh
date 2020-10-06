#/bin/bash

# Собрать родительский контейнер с JupyterLab
DOCKER_BUILDKIT=1 docker build -t mixaill76/jupyter-lab .