FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN DEBIAN_FRONTEND=noninteractive apt -y update && apt -y install dialog apt-utils build-essential
RUN apt-get -y install wget gdebi-core gfortran perl rsync vim unar
RUN ln -fns /usr/share/zoneinfoAmerica/New_York /etc/localtime && echo "America/New_York" > /etc/timezone && DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get -y install ncbi-blast+ && rm -rf /var/lib/apt/lists/* # buildkit

RUN wget http://ekhidna2.biocenter.helsinki.fi/dali/DaliLite.v5.tar.gz
RUN unar DaliLite.v5.tar.gz
RUN rm DaliLite.v5.tar.gz

WORKDIR /DaliLite.v5/bin

RUN make clean && make

WORKDIR /
RUN chmod -R 777 DaliLite.v5
