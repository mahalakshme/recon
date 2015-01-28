FROM ubuntu:trusty

ENV RAILS_ENV production
EXPOSE 3000
CMD ["/app/docker/start"]

COPY docker/provision /root/provision
RUN /root/provision

COPY Gemfile /app/
COPY Gemfile.lock /app/
RUN cd /app && \
    bundle install --jobs 4 --retry 3 --deployment --no-cache --frozen --no-prune --without development test && \
    rm -Rf vendor/ruby/2.2.0/cache

COPY . /app/
WORKDIR /app
