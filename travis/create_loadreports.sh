TEST_PAGE="http://blog.akselgresvig.com/"
LATEST_SHA=$(git rev-parse HEAD)

#Set upstream remote
git remote add upstream https://${GH_TOKEN}@github.com/${GH_REPO}.git > /dev/null

git fetch -qn upstream > /dev/null

#Run report scripts using PhantomJS
echo -e "*** Running speed-report on $TEST_PAGE for revision $LATEST_SHA"
phantomjs travis/loadreport/speedreport.js ${TEST_PAGE} $LATEST_SHA
echo -e "*** Running load-report"
phantomjs travis/loadreport/loadreport.js ${TEST_PAGE} filmstrip $LATEST_SHA

echo -e "*** Generating reports/index.html"
#Create index.html of reports in report-dir
./travis/generate-index.sh reports > reports/index.html

git checkout --track upstream/gh-pages

#Add the resulting reports to the gh-branch (so its available on site)
echo "Adding reports"
git add -f reports/.

git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
git push -q # gh-pages > /dev/null
