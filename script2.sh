git diff origin/main... --name-only
find $(git diff origin/main... --name-only) -name "*.html.erb" -type f -print0 | xargs -0 bundle exec htmlbeautifier
