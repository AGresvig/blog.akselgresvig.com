TEST_PAGE="http://blog.akselgresvig.com/"
LATEST_SHA=$(git rev-parse HEAD)

echo -e "*** Running load- and speed-reports on $TEST_PAGE for revision $LATEST_SHA"

git branch -a
git checkout master

#Run report scripts using PhantomJS
phantomjs travis/loadreport/loadreport.js ${TEST_PAGE} filmstrip $LATEST_SHA
phantomjs travis/loadreport/speedreport.js ${TEST_PAGE} $LATEST_SHA

#Add the resulting reports to the gh-branch (so its available on site)
git checkout gh-pages
git pull 
echo "Adding reports"
git add reports/.

git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
git push https://${GH_TOKEN}@github.com/${REPO} gh-pages > /dev/null