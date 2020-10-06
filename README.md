# jupyter-lab  
My vision for jupyter-lab for development. Access without password and token. 

## Included
- pandas 
- numpy 
- matplotlib

# How to start  
```
docker run -it -p 8888:8888 --name=jupyter_test mixaill76/jupyter-lab
```
# How to build  
> DOCKER_BUILDKIT=1  
```
./clean.sh && ./build.sh
```  
or  
```
DOCKER_BUILDKIT=1 docker build -t mixaill76/jupyter-lab .
```

# The size
|REPOSITORY|TAG|SIZE|
|----------|---|----|
|mixaill76/jupyter-lab|latest|815MB|
