# python-docker

Contains different images of Python 3.

### Base images

##### Images
```
customergauge-python3:3.6
customergauge-python3:3.7
customergauge-python3:3.8
```

Bare-bones Docker images of different Python versions (i.e: 3.6, 3.7, 3.8)
They include the interpreter and its respective pip version.
They also include `build-essentials` and `git` as `ONBUILD` hook.

##### Python 3.6
```
$ docker run -it customergauge/python3:3.6
root@f88fde87b653:/# python --version
Python 3.6.9
root@f88fde87b653:/# pip --version
pip 20.0.2 from /usr/local/lib/python3.6/dist-packages/pip (python 3.6)
```
##### Python 3.7
```
$ docker run -it customergauge/python3:3.7
root@6653cd54cd10:/# python --version
Python 3.7.5
root@6653cd54cd10:/# pip --version
pip 20.0.2 from /usr/local/lib/python3.7/dist-packages/pip (python 3.7)
```
##### Python 3.8
```
$ docker run -it customergauge/python3:3.8
root@1558be4c4786:/# python --version
Python 3.8.0
root@1558be4c4786:/# pip --version
pip 20.0.2 from /usr/local/lib/python3.8/dist-packages/pip (python 3.8)
```

### Base images
They include `Nginx` and `MySQL`

### Data images
Comes with `Numpy`, `Pandas` and `Cython`
 
