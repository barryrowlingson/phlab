FROM rocker/geospatial

WORKDIR /app

ADD . /app

RUN /bin/bash -c '(test -d phlabr || git clone https://github.com/barryrowlingson/phlabr.git) ; exit 0'

CMD ["./run.sh"]

