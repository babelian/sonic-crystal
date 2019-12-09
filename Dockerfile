FROM crystallang/crystal:0.31.1

RUN cd /tmp \
    && git clone https://github.com/f/guardian.git \
    && cd guardian \
    && crystal build src/guardian.cr --release \
    && cp guardian /usr/local/bin \
    && cd .. \
    && rm -fr guardian

RUN mkdir -p /app
WORKDIR /app
COPY shard.yml shard.lock /app/
RUN shards install
COPY . /app