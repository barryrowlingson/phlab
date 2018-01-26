FROM rocker/geospatial

WORKDIR /app

ADD . /app

RUN rm -rf phlabr && git clone https://github.com/barryrowlingson/phlabr.git

CMD ["./run.sh"]

