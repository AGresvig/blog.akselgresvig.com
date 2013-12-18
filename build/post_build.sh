export REPO="$(pwd | sed s,^/home/travis/build/,,g)"
echo -e "Current Repo:$REPO --- Travis Branch:$TRAVIS_BRANCH"
 
#Set git user
git config --global user.email "aksel@agresvig.com"
git config --global user.name "Travis"
 
#Set upstream remote
git remote add upstream https://${GH_TOKEN}@github.com/AGresvig/blog.akselgresvig.com.git > /dev/null
git remote add live https://${GH_TOKEN}@github.com/AGresvig/blog.akselgresvig.com > /dev/null
 
mkdir $HOME/temp_akselgresvig
git clone https://${GH_TOKEN}@github.com/AGresvig/blog.akselgresvig.com $HOME/temp_akselgresvig
 
cp -rf _site/* $HOME/temp_akselgresvig/
 
cd $HOME/temp_akselgresvig
 
git add -f .
git commit -m "Blog updated"
git push https://${GH_TOKEN}@github.com/AGresvig/blog.akselgresvig.com master > /dev/null