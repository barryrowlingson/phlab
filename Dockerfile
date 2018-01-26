FROM rocker/geospatial

WORKDIR /app

ADD . /app

CMD ["./run.sh"]

