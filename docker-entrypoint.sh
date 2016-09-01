#!/bin/bash

set -e

# try and migrate the db

migrate () {

  until rake db:migrate ; do
    echo "Migrate failed - retrying in 5"
    sleep 5
  done

}

migrate

rails server -b 0.0.0.0 -p 8080
