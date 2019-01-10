FROM node:0.10.38-slim

WORKDIR /home/node/app

# ENV NODE_ENV=production

RUN apt-get update && apt-get install -yq \
  python3-pip

RUN pip3 install "setuptools>=20.2"
RUN pip3 install b2

ARG B2=0017d55e6d4e86f0000000003
ARG B2_RG

RUN echo "Oh dang ${B2} ${B2_RG}."
RUN b2 authorize-account $B2 $B2_RG

COPY . .

RUN tar -zxvf node_modules.tar.gz

RUN npm run compile
