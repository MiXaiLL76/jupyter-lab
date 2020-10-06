FROM ubuntu:latest
LABEL maintainer="mike.milos@yandex.ru"

WORKDIR /tmp

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

RUN apt update
RUN apt install sudo python3 python3-pip git curl -y

# Устанавливаем NODEJS
COPY install_latest_node.sh install_latest_node.sh
RUN ./install_latest_node.sh
ENV PATH=/usr/local/lib/nodejs/node-latest-linux-x64/bin:$PATH

# Создаем пользователя
ARG JUP_USER
ENV JUP_USER "lab_user"
RUN useradd -m -u 1000 ${JUP_USER}
ENV PATH=/home/${JUP_USER}/.local/bin:$PATH

RUN echo "${JUP_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


# Устанавливаем jupyterlab
RUN python3 -m pip install --no-cache-dir jupyterlab 

# Доп. либы
RUN python3 -m pip install --no-cache-dir pandas numpy matplotlib

# Переключаемся на пользователя
USER ${JUP_USER}

# Создаем файлы настройки jupyterlab
RUN jupyter notebook --generate-config
ENV JUP_CONFIG "/home/${JUP_USER}/.jupyter/jupyter_notebook_config.py"
COPY jupyter_notebook_config.py ${JUP_CONFIG}

# Настраиваем jupyterlab
RUN sudo mkdir -m777 -p /app
RUN sudo chown -R ${JUP_USER}:${JUP_USER} /app

# Настройка файла запуска jupyterlab
ENV JUP_START "/usr/local/bin/jupyter-lab-starter"
COPY jupyter-lab-starter ${JUP_START}

# Открытие порта для jupyter
EXPOSE 8888

# clear tmp
RUN sudo rm -rf /tmp/*

# Запуск jupyterlab
ENTRYPOINT ${JUP_START}