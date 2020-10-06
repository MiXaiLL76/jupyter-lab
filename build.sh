#/bin/bash

# очистить все докеры без тегов или имен
while [ 1 ]
do
    none_tags=$(docker images | grep none | awk '{print $3}')
    if [ ${#none_tags} -gt 0 ]
    then
        docker rmi ${none_tags} --force
    else
        break
    fi
done

# очистить то, что уже завершено
exited=$(docker ps -qa --no-trunc --filter "status=exited")
if [ ${#exited} -gt 0 ]
then
    docker rm ${exited}
fi

NODE_VERSION_FILE="node.latest"
NODE_LATEST_VERSION=$(curl -s -X GET https://nodejs.org/dist/latest/ | grep linux-x64.tar.gz | sed 's/<\/*[^>]*>//g' | awk '{print $1}' | awk -F "-" '{print $2}')

NODE_DOWNLOAD="YES"
if test -f "${NODE_VERSION_FILE}"; then
    if [ ${NODE_LATEST_VERSION} = $(cat ${NODE_VERSION_FILE}) ]; then
        echo "Обновление не требуется."
        NODE_DOWNLOAD="NO"
    else
        echo "Требуется обновление до ${NODE_LATEST_VERSION}"
    fi
fi

if test -f "node.tar.gz"; then
    echo "Файл node.tar.gz существует."
else
    NODE_DOWNLOAD="YES"
fi

echo https://nodejs.org/dist/${NODE_LATEST_VERSION}/node-${NODE_LATEST_VERSION}-linux-x64.tar.gz

if [ ${NODE_DOWNLOAD} = "YES" ]; then
    echo "Загружаю nodejs"
    curl -s -X GET https://nodejs.org/dist/${NODE_LATEST_VERSION}/node-${NODE_LATEST_VERSION}-linux-x64.tar.gz -o node.tar.gz
    echo ${NODE_LATEST_VERSION} > ${NODE_VERSION_FILE}
fi

NODE_VERSION=$(cat ${NODE_VERSION_FILE})

# Собрать родительский контейнер с JupyterLab
#DOCKER_BUILDKIT=1 
docker build -t mixaill76/jupyter-lab --build-arg NODE_VER=${NODE_LATEST_VERSION} .