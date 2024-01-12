#!/bin/bash

set -x
bundle exec rails db:migrate
bundle exec rake populate_schools
# add more shit here if need be
