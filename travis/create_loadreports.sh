TEST_PAGE="http://blog.akselgresvig.com/"
LATEST_SHA=$(git rev-parse HEAD)

git fetch --all
git branch -a
git checkout master

#Run report scripts using PhantomJS
echo -e "*** Running speed-report on $TEST_PAGE for revision $LATEST_SHA"
phantomjs travis/loadreport/speedreport.js ${TEST_PAGE} $LATEST_SHA

echo -e "*** Running load-report"
phantomjs travis/loadreport/loadreport.js ${TEST_PAGE} filmstrip $LATEST_SHA

echo -e "*** Generating reports/index.html"

#Create index.html of reports in report-dir
./travis/generate-index.sh reports > reports/index.html

#Add the resulting reports to the gh-branch (so its available on site)
git checkout gh-pages
git pull 
echo "Adding reports"
git add reports/.

git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
git push https://${GH_TOKEN}@github.com/${GH_REPO} gh-pages > /dev/null