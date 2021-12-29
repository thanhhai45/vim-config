FROM madnight/docker-alpine-wkhtmltopdf as wkhtmltopdf_image
FROM ruby:3.0.0-alpine AS pre-builder

# ARG default to production settings
# For development docker-compose file overrides ARGS
ARG BUNDLE_WITHOUT="development:test"
ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}
ENV BUNDLER_VERSION=2.2.13

ARG RAILS_SERVE_STATIC_FILES=true
ENV RAILS_SERVE_STATIC_FILES ${RAILS_SERVE_STATIC_FILES}

ARG RAILS_ENV=production
ENV RAILS_ENV ${RAILS_ENV}

ENV BUNDLE_PATH="/gems"

RUN apk update \
  && apk add \
    openssl \
    tar \
    build-base \
    tzdata \
    mariadb-dev \
    nodejs \
    yarn \
    git \
    gcc \
    curl \
    ffmpeg \
  && mkdir -p /var/app \
  && gem install bundler:2.2.13

ENV MECAB_VERSION   0.996
ENV IPADIC_VERSION  2.7.0-20070801
ENV mecab_url       https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE
ENV ipadic_url      https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM
ENV MECAB_PATH      /usr/local/lib/libmecab.so

RUN set -x \
    && apk add --update --no-cache \
        bash \
        ca-certificates \
        libstdc++ \
        su-exec \
        wget \
    && apk --no-cache add --virtual .builddeps \
        build-base \
        curl \
        file \
        git \
        openssl \
        sudo \
    && CPUCOUNT=$(getconf _NPROCESSORS_ONLN)  \
    # Install MeCab
    && wget -q -O - ${mecab_url} \
        | tar -xzf - -C /tmp \
    && cd /tmp/mecab-[0-9]* \
    && ./configure --enable-utf8-only --with-charset=utf8 \
    && make  -j ${CPUCOUNT} \
    && make install \
    # Install IPA dic
    && wget -q -O - ${ipadic_url} \
        | tar -xzf - -C /tmp \
    && cd /tmp/mecab-ipadic-* \
    && ./configure --with-charset=utf8 \
    && make  -j ${CPUCOUNT} \
    && make install \
    # Install Neologd
    && cd /tmp \
    && git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git \
    && mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y \
    # Clean up
    && apk del .builddeps \
    && rm -rf \
        /tmp/mecab-[0-9]* \
        /tmp/mecab-ipadic-* \
        /tmp/mecab-ipadic-neologd \
    ## user/dir/permmsion
    && adduser -D  -g '' -s /sbin/nologin -u 1000 docker \
    && adduser -D  -g '' -s /sbin/nologin mecab

CMD mysql {mysql-client-options} < {sql.script}
RUN mkdir -p /shared
RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
COPY local_gems /app/local_gems

# Do not install development or test gems in production
RUN if [ "$RAILS_ENV" = "production" ]; then \
  bundle config set without 'development test'; bundle install -j 4 -r 3; \
  else bundle install -j 4 -r 3; \
  fi

COPY package.json yarn.lock ./
RUN yarn install

COPY . /app

# generate production assets if production environment
RUN if [ "$RAILS_ENV" = "production" ]; then \
  SECRET_KEY_BASE=precompile_placeholder RAILS_LOG_TO_STDOUT=enabled bundle exec rake assets:precompile; \
  fi

# final build stage
FROM ruby:3.0.0-alpine

ARG BUNDLE_WITHOUT="development:test"
ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}
ENV BUNDLER_VERSION=2.2.13

ARG EXECJS_RUNTIME="Disabled"
ENV EXECJS_RUNTIME ${EXECJS_RUNTIME}

ARG RAILS_SERVE_STATIC_FILES=true
ENV RAILS_SERVE_STATIC_FILES ${RAILS_SERVE_STATIC_FILES}

ARG RAILS_ENV=production
ENV RAILS_ENV ${RAILS_ENV}
ENV BUNDLE_PATH="/gems"

RUN apk add --update --no-cache \
    openssl \
    tzdata \
    mariadb-dev \
    imagemagick \
    curl \
    ffmpeg \
    yarn \
  && gem install bundler:2.2.13

ENV MECAB_VERSION   0.996
ENV IPADIC_VERSION  2.7.0-20070801
ENV mecab_url       https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE
ENV ipadic_url      https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM
ENV MECAB_PATH      /usr/local/lib/libmecab.so

RUN set -x \
    && apk add --update --no-cache \
        bash \
        ca-certificates \
        libstdc++ \
        su-exec \
        wget \
    && apk --no-cache add --virtual .builddeps \
        build-base \
        curl \
        file \
        git \
        openssl \
        sudo \
    && CPUCOUNT=$(getconf _NPROCESSORS_ONLN)  \
    # Install MeCab
    && wget -q -O - ${mecab_url} \
        | tar -xzf - -C /tmp \
    && cd /tmp/mecab-[0-9]* \
    && ./configure --enable-utf8-only --with-charset=utf8 \
    && make  -j ${CPUCOUNT} \
    && make install \
    # Install IPA dic
    && wget -q -O - ${ipadic_url} \
        | tar -xzf - -C /tmp \
    && cd /tmp/mecab-ipadic-* \
    && ./configure --with-charset=utf8 \
    && make  -j ${CPUCOUNT} \
    && make install \
    # Install Neologd
    && cd /tmp \
    && git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git \
    && mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y \
    # Clean up
    && apk del .builddeps \
    && rm -rf \
        /tmp/mecab-[0-9]* \
        /tmp/mecab-ipadic-* \
        /tmp/mecab-ipadic-neologd \
    ## user/dir/permmsion
    && adduser -D  -g '' -s /sbin/nologin -u 1000 docker \
    && adduser -D  -g '' -s /sbin/nologin mecab

RUN if [ "$RAILS_ENV" = "production" ]; then \
  rm -rf spec node_modules app/assets vendor/assets tmp/cache; \
  else apk add nodejs yarn; \
  fi

COPY --from=pre-builder /gems/ /gems/
COPY --from=pre-builder /app /app
COPY --from=pre-builder /app/local_gems /app/local_gems
COPY --from=wkhtmltopdf_image /bin/wkhtmltopdf /bin/

RUN rm -rf /gems/ruby/3.0.0/cache/*.gem \
  && find /gems/ruby/3.0.0/gems/ -name "*.c" -delete \
  && find /gems/ruby/3.0.0/gems/ -name "*.o" -delete
RUN mkdir -p /app/log

WORKDIR /app