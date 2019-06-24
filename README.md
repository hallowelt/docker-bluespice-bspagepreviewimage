## Docker Image for PjantomJS wrapper service

All-in-one container for BlueSpice Article Preview Capture.

### Short brief
Image provides nginx, php-fpm phantomjs binary and render.js.

### Usage

After cloning the repository enter the directory of repository.

    build -t bsaip .
    docker container create --name=bsaip -p {$YOURPORT}:80 bsaip
    docker container start bsaip