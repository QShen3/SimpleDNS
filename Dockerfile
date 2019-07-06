FROM python:3-alpine

WORKDIR /app

COPY . /app

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U \
    && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && apk add --no-cache --virtual .build-deps gcc musl-dev \
    && python setup.py install \
    && apk del .build-deps gcc musl-dev

EXPOSE 53/udp
EXPOSE 53/tcp

ENTRYPOINT ["simpledns"]