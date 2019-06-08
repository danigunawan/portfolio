# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.

FROM phusion/passenger-full:0.9.14

# === 1 ===
# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Turn on the ssh server.
RUN rm -f /etc/service/sshd/down

# === 2 ===
# Installing basic stuff: wget, git, ruby
# These are dependencies for compiling gems with native extentions like Nokogiri

RUN apt-get update
RUN apt-get install -y make
RUN apt-get install -y gcc
RUN apt-get install -y libxslt-dev libxml2-dev
RUN apt-get install -y wget git-core

# Prepare folders
RUN mkdir /home/app/webapp
RUN mkdir /home/app/webapp/vendor
RUN mkdir /home/app/webapp/vendor/cache

# === 3 ====

ENV RAILS_ENV production

# Run Bundle in a cache efficient way
ADD ./vendor/cache /home/app/webapp/vendor/cache/
ADD Gemfile /home/app/webapp/
ADD Gemfile.lock /home/app/webapp/
WORKDIR /home/app/webapp
RUN bundle install --local

# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Add the nginx info
ADD config/container/nginx.conf /etc/nginx/sites-enabled/webapp.conf

# === 4 ===

# Add the rails app
ADD . /home/app/webapp

WORKDIR /home/app/webapp

RUN rake assets:clean
RUN rake assets:precompile

# === 5 ===
# Start Nginx / Passenger
RUN rm -f /etc/service/nginx/down
RUN passenger start -a 0.0.0.0 -p 80 -d -e production

RUN chown -R app /home/app/webapp

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Setup the ssh public keys to the instance for use with the docker-ssh cml tool.
ADD config/container/id_rsa.pub  /tmp/id_rsa.pub
RUN cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys && rm -f /tmp/id_rsa.pub
