#!/bin/bash

cd /home/tehtri/some-gallery-with-some-script
ruby clean_g.rb
ruby main.rb
ruby create.rb
git add --all
git commit -m "Updating gallery"
git push origin master
ruby return_url_to_the_user.rb
