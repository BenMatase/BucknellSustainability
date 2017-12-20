root=$(pwd)

cd WebServer/

# chmod everthing for users
chmod o=r *.html
chmod o=r *.js
chmod o=r *.css

# set up all of linting
cd $root

pip install autopep8

# require apm
command -v apm >/dev/null 2>&1 || { echo >&2 "I require apm but it's not installed.  Aborting."; exit 1; }

apm install python-autopep8
