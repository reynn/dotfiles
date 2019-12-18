FROM php:7.4-buster

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get autoclean

ADD https://github.com/itskenny0/dumpia/archive/master.tar.gz /tmp/dumpia.tar.gz

RUN mkdir /app \
  && tar xfv /tmp/dumpia.tar.gz -C /app

ENTRYPOINT [ "php", "/app/dumpia-master/dumpia.php" ]
