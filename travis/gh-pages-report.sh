export REPO="$(pwd | sed s,^/home/travis/build/,,g)"
echo -e "*** Current Repo: $REPO --- Travis Branch:$TRAVIS_BRANCH"
 
TEST_PAGE="http://blog.akselgresvig.com/"
LATEST_SHA=$(git rev-parse HEAD)

echo "*** Git status:"
git status
echo "*** Git branches:"
git branch -a

if [ "$TRAVIS_BRANCH" == "master" ]; then
    git fetch old master
    git checkout old/master
    cd travis/loadreport
    echo "*** Contents of 'travis/loadreport':"
    ls -al
    #sleep 1m
    phantomjs loadreport.js ${TEST_PAGE} filmstrip $LATEST_SHA
    phantomjs speedreport.js ${TEST_PAGE} $LATEST_SHA
    git add -f reports/.
    echo "*** Contents of 'travis/loadreport/reports':"
    ls -al reports
    git commit -m "Travis build $TRAVIS_BUILD_NUMBER" # pushed to gh-pages"
    git push https://${GH_TOKEN}@github.com/${REPO} master > /dev/null #gh-pages > /dev/null
fi