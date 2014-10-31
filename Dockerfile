FROM ubuntu:trusty

ENV RAILS_ENV production
EXPOSE 8080
CMD ["/app/docker/start"]

COPY docker/provision /root/provision
RUN /root/provision

COPY Gemfile /app/
COPY Gemfile.lock /app/
RUN cd /app && \
    bundle install --without development test cucumber --jobs 4 --path vendor/ && \
    rm -Rf vendor/ruby/2.1.0/cache

COPY . /app/
WORKDIR /app
