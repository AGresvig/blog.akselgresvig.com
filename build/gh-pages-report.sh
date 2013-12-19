export REPO="$(pwd | sed s,^/home/travis/build/,,g)"
echo -e "Current Repo:$REPO --- Travis Branch:$TRAVIS_BRANCH"
 
TEST_PAGE="http://agresvig.github.io/blog.akselgresvig.com/"
LATEST_SHA=$(git rev-parse HEAD)

echo "STATUS"
git status
git branch -a
ls -al

if [ "$TRAVIS_BRANCH" == "master" ]; then
    git fetch origin gh-pages
    git checkout gh-pages
    ps -eo pcpu,pid,user,args
    sleep 1m
    phantomjs src/loadreport.js ${TEST_PAGE} performance json $LATEST_SHA
    phantomjs src/speedreport.js ${TEST_PAGE} $LATEST_SHA
    git add -f reports/.
    git add -f speedreports/.
    git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
    git push https://${GH_TOKEN}@github.com/${REPO} gh-pages > /dev/null
fi