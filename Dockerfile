FROM ubuntu:14.04
MAINTAINER Gervasio Marchand <gmc@gmc.uy>
ENV build_date 2016-12-29

RUN apt-get update && \
    apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs npm phantomjs wget && \
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
    exec $SHELL && \
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build && \
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc && \
    npm install uglifycss -g && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    rm -rf /var/lib/apt/lists/*
RUN exec $SHELL && \
    ~/.rbenv/bin/rbenv install 2.4.0 && \
    ~/.rbenv/bin/rbenv global 2.4.0 && \
    ~/.rbenv/shims/gem install jekyll && \
    ~/.rbenv/shims/gem install jekyll-paginate && \
    ~/.rbenv/shims/gem install nokogiri && \
    ~/.rbenv/shims/gem install fastimage && \
    ~/.rbenv/shims/gem install octopress-minify-html

# Define mountable directories.
VOLUME ["/var/site-content"]
WORKDIR /var/site-content

CMD ["/root/.rbenv/shims/jekyll","build"]
