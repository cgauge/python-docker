# python-docker

Contains different images of Python 3.

## Base images

### Images

- `customergauge-python3:3.6`
- `customergauge-python3:3.7`
- `customergauge-python3:3.8`

Bare-bones Docker images of different Python versions (i.e: 3.6, 3.7, 3.8)
They include the interpreter and its respective pip version.
They also include `build-essentials`, `git` and `mysql-client`.

#### Python 3.6

```console
$ docker run --rm -it customergauge/python3:3.6
root@f88fde87b653:/# python --version
Python 3.6.9
root@f88fde87b653:/# pip --version
pip 20.0.2 from /usr/local/lib/python3.6/dist-packages/pip (python 3.6)
```

#### Python 3.7

```console
$ docker run -it customergauge/python3:3.7
root@6653cd54cd10:/# python --version
Python 3.7.5
root@6653cd54cd10:/# pip --version
pip 20.0.2 from /usr/local/lib/python3.7/dist-packages/pip (python 3.7)
```

#### Python 3.8

```console
$ docker run -it customergauge/python3:3.8
root@1558be4c4786:/# python --version
Python 3.8.0
root@1558be4c4786:/# pip --version
pip 20.0.2 from /usr/local/lib/python3.8/dist-packages/pip (python 3.8)
```

## Generating the Dockerfiles

The Dockerfiles are generated from `Dockerfile.mustache`, which is a [mustache](http://mustache.github.io/) template. `Makefile` contains the recipes for generation, so after changing the template you can have the Dockerfiles updated with:

```console
make dockerfiles
```

You can also verify the Dockerfiles are building successfully with:

```console
make tests
```

You need `docker` and `make` installed on your machine to be able to generate the Dockerfiles.
