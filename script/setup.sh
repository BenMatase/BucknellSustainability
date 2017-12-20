root=$(pwd)

echo "Allowing all html/css/js files to be viewed by user"

cd WebServer/

# chmod everthing for users
chmod o=r *.html
chmod o=r *.js
chmod o=r *.css

cd WebServer/Style/css/
chmod o=r *.css 

# set up all of linting
echo "Setting up all linting"
cd $root

pip install autopep8

# require apm
command -v apm >/dev/null 2>&1 || { echo >&2 "I require apm but it's not installed.  Aborting."; exit 1; }

apm install python-autopep8
