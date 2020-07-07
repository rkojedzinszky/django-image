FROM alpine:3.12.0

LABEL maintainer="Richard Kojedzinszky"
LABEL org="Euronet Zrt"

# Install python3 and frequent packages
RUN apk add --no-cache tzdata python3 py3-psycopg2 libstdc++ && \
    ln -sf python3 /usr/bin/python && ln -sf pip3 /usr/bin/pip && \
    apk add --no-cache -t .build-deps python3-dev gcc g++ make libffi-dev && \
    pip install -U \
        --no-binary grpcio,protobuf grpcio protobuf \
        'django<2.3' \
	django-atomic-migrations \
	django-dbconn-retry \
	django-tastypie && \
    find /usr/lib -name '*.so' -print0 | xargs -r0 strip -s ; \
    apk del .build-deps && \
    rm -rf /root/.cache
