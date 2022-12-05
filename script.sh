find . -name "*.html.erb" -type f -print0 | xargs -0 bundle exec htmlbeautifier
