FROM rocker/geospatial

WORKDIR /app

ADD . /app

#RUN /bin/bash -c 'test -f phlabr && git clone https://github.com/barryrowlingson/phlabr.git'
RUN /bin/bash -c '(test -f phlabr && touch phlabr; exit 0)'

CMD ["./run.sh"]

