FROM stackbrew/ubuntu:13.10

RUN sed -i 's/main$/main universe/' /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q supervisor
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q openssh-server
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q curl

# GitLab dependencies (from installation manual)
RUN DEBIAN_FRONTEND=noninteractive sudo apt-get install -y -q build-essential zlib1g-dev libyaml-dev libssl-dev libgdbm-dev libreadline-dev libncurses5-dev libffi-dev redis-server checkinstall libxml2-dev libxslt-dev libcurl4-openssl-dev libicu-dev logrotate
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q git
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q ruby2.0 ruby2.0-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q libpq-dev 

# GitLab user
RUN sudo adduser --disabled-login --gecos 'GitLab' git

# GitLab shell
RUN sudo -u git -H curl -L https://github.com/gitlabhq/gitlab-shell/archive/v1.8.0.tar.gz | sudo -u git -H tar xzf - -C /home/git/
ADD config.yml /home/git/gitlab-shell-1.8.0/config.yml
RUN cd /home/git/gitlab-shell-1.8.0/ && sudo -u git -H ./bin/install

# GitLab HQ
RUN sudo -u git -H curl -L https://github.com/gitlabhq/gitlabhq/archive/v6.5.1.tar.gz | sudo -u git -H tar xzf - -C /home/git/
RUN mv /home/git/gitlabhq-6.5.1 /home/git/gitlab
ADD gitlab.yml /home/git/gitlab/config/gitlab.yml
ADD unicorn.rb /home/git/gitlab/config/unicorn.rb

# Make sure GitLab can write to the log/ and tmp/ directories
RUN chmod -R u+rwX /home/git/gitlab/log/
RUN chmod -R u+rwX /home/git/gitlab/tmp/

# Create directory for satellites
RUN sudo -u git -H mkdir /home/git/gitlab-satellites

# Create directories for sockets/pids and make sure GitLab can write to them
RUN sudo -u git -H mkdir /home/git/gitlab/tmp/pids/
RUN sudo -u git -H mkdir /home/git/gitlab/tmp/sockets/
RUN sudo chmod -R u+rwX  /home/git/gitlab/tmp/pids/
RUN sudo chmod -R u+rwX  /home/git/gitlab/tmp/sockets/

# Create public/uploads directory otherwise backup will fail
RUN sudo -u git -H mkdir /home/git/gitlab/public/uploads
RUN sudo chmod -R u+rwX  /home/git/gitlab/public/uploads

# Copy the example Rack attack config
RUN sudo -u git -H cp /home/git/gitlab/config/initializers/rack_attack.rb.example /home/git/gitlab/config/initializers/rack_attack.rb

# Configure Git global settings for git user, useful when editing via web
RUN sudo -u git -H git config --global user.name "GitLab"
RUN sudo -u git -H git config --global user.email "gitlab@drugis.org"
RUN sudo -u git -H git config --global core.autocrlf input

# Database config
ADD database.yml /home/git/gitlab/config/database.yml
RUN chown git.git /home/git/gitlab/config/database.yml
RUN chmod o-rwx /home/git/gitlab/config/database.yml

# Install
RUN sudo gem install bundler --no-ri --no-rdoc
RUN cd /home/git/gitlab && sudo -u git -H bundle install --deployment --without development test mysql aws

ADD supervisord.conf /etc/supervisor/supervisord.conf
RUN mkdir -p /var/run/supervisor
