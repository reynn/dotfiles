FROM python:3.7

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get autoclean

ARG GIT_REPO=Yiff.party-Image-Scraper
ARG GIT_OWNER=Xealeph

ADD https://github.com/$GIT_OWNER/$GIT_REPO/archive/master.tar.gz /tmp/master.tar.gz

RUN mkdir /app \
  && tar xfv /tmp/master.tar.gz --directory /app \
  && pip install -r /app/$GIT_REPO-master/requirements.txt

ENTRYPOINT [ "python", "/app/Yiff.party-Image-Scraper-master/yiff_image_scraper.py" ]
