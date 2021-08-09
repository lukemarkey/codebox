###########################################################################
## INSTALL NODE AND NPM
###########################################################################

sudo apt-get install git-core curl build-essential openssl libssl-dev
sudo su
curl -sL https://deb.nodesource.com/setup_12.x | bash -
sudo apt install -y nodejs

## DJANGO NPM AUTOLOAD BROWSER SCRIPTS

npm install node-sass concurrently browser-sync --save-dev
---
"scripts": {
	"css-compile": "node-sass website/static/website/scss -o website/static/website/css",
	"css-watch": "node-sass website/static/website/scss -o website/static/website/css --watch",
	"browser-sync": "browser-sync start --files \"website/static/website/css/**/*.css, website/static/website/js/**/*.js, website/**/*.py, website/templates/website/**/*.html\" --proxy 127.0.0.1:8000 --reload-delay=300 --reload-debounce=500",
	"start": "concurrently --kill-others \"npm run css-watch\" \"python3 manage.py runserver\" \"npm run browser-sync\" ",
	"css-compile-member": "node-sass member/static/member/scss -o member/static/member/css",
    "css-watch-member": "node-sass member/static/member/scss -o member/static/member/css --watch",
    "browser-sync-member": "browser-sync start --files \"member/static/member/css/**/*.css, member/static/member/js/**/*.js, member/**/*.py, member/templates/member/**/*.html\" --proxy 127.0.0.1:8000 --reload-delay=300 --reload-debounce=500",
    "start-member": "concurrently --kill-others \"npm run css-watch-member\" \"python3 manage.py runserver\" \"npm run browser-sync-member\" "
},
---

npm run start
npm run start-member

## UBUNTU SETTINGS FOR NPM WATCHING FILES

echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
