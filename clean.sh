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