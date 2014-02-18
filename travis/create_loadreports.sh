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

#Add and stash the new reports. We will merge them with the previous ones next (they won't be commited on this branch)
git add reports
echo -e "Stashing newly generated reports:"
git stash

#Checkout the gh-pages branch, where we will commit this stuff
git checkout --track upstream/gh-pages

#Get the reports archive from our previous build (that was wiped by the recent "docpad deploy to gh-pages")
git checkout HEAD@1 -- reports/
ls -al reports

#And introduce our new reports
git stash pop
ls -al reports

#Get the "generate-index"-script from the master branch now, we need it..
git checkout master -- travis/generate-index.sh
ls -al reports

#Create updated index.html listing reports in report-dir
echo -e "*** Generating reports/index.html"
./travis/generate-index.sh reports > reports/index.html

#Add the resulting reports to the gh-branch (so its available on site)
echo "Adding new reports"
git status -s
git add -f reports/.

git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
git push -q > /dev/null
