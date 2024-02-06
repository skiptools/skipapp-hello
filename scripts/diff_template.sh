#!/bin/sh
DIR=${1:-"skipapp-hello"}
AGAINST=${2:-"skipapp-hello"}

skip init --no-build --appid=skip.hello.App --version 1.0.0 ${DIR} HelloSkip

# make sure that the repo exactly matches the template,
# allowing for changes in some files, as well as
# dependency versions
diff --exclude=README.md --exclude=.build --exclude=.git --exclude=scripts --exclude=.github --exclude=.gitignore --exclude=Package.resolved --exclude=Skip.env --exclude=project.xcworkspace --exclude=proguard-rules.pro -I 'url: "https://source.skip.tools/' -r ${DIR} ${AGAINST}

