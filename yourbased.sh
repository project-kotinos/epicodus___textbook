#!/usr/bin/env bash
set -ex
export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get install -y unzip chromium-chromedriver
gem install bundler -v 2.0.1
# before_install
gem update --system
gem install bundler
gem --version
wget http://chromedriver.storage.googleapis.com/2.37/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
rm chromedriver_linux64.zip
mv -f chromedriver /usr/local/bin/
chmod +x /usr/local/bin/chromedriver
google-chrome-stable --headless --no-sandbox
# install
bundle install --jobs=3 --retry=3
# before_script
bundle exec rake db:create db:schema:load
# script
rake
