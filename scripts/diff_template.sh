#!/bin/sh -e
PACKAGE=${1:-"skipapp-hello"}
AGAINST=${2:-"."}

TMPDIR=`mktemp -d`
cd ${TMPDIR}
skip init --no-build --zero --appid=skip.hello.App --version 1.0.0 ${PACKAGE} HelloSkip
cd -

# make sure that the repo exactly matches the template,
# allowing for changes in some files, as well as
# dependency versions
diff --ignore-space-change --exclude=README.md --exclude=.build --exclude=.git --exclude=scripts --exclude=.github --exclude=.DS_Store --exclude=.gitignore --exclude=Package.resolved --exclude=Skip.env --exclude=project.xcworkspace --exclude=proguard-rules.pro -I 'url: "https://source.skip.tools/' -r ${TMPDIR}/${PACKAGE} ${AGAINST}

