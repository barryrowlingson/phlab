FROM rocker/geospatial

WORKDIR /app

ADD . /app

RUN git clone https://github.com/barryrowlingson/phlabr.git

CMD ["./run.sh"]

