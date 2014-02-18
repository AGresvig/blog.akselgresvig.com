export REPO="$(pwd | sed s,^/home/travis/build/,,g)"
echo -e "Current Repo:$REPO --- Travis Branch:$TRAVIS_BRANCH"
echo -e "Setting up git configuration"

git config --global user.email "aksel@agresvig.com"
git config --global user.name "Travis"
git config --global push.default simple
git config remote.origin.url "https://$GH_TOKEN@github.com/$GH_REPO.git"