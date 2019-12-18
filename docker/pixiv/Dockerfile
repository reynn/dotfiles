FROM python:3.7

RUN apt update \
  && apt upgrade -y \
  && apt install -y ffmpeg

RUN pip install https://github.com/Nandaka/PixivUtil2/archive/master.tar.gz
