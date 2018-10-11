
FROM alpine:latest

RUN set -ex; \
        \
        apk add --update --no-cache \
            git \
            python \
        ; \
        apk add --no-cache --virtual .build-deps \
            libffi-dev \
            openssl-dev \
            python-dev \
            py-pip \
            build-base \
        ; \
        pip install --upgrade pip; \
        pip install \
            git+https://github.com/ansible/ansible.git@devel \
            pywinrm pyvmomi boto boto3 pycrypto \
        ; \
        apk del .build-deps; \
        rm -rf \
            /var/cache/apk/* \
        ; \
        mkdir /workspace; \
        addgroup -S ansible && adduser -S -G ansible ansible;

USER ansible
