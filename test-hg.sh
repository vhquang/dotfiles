hg init hg-repo
git init git-repo

cd hg-repo
hg --version > version.txt && hg add . && hg commit -m 'hg init'

hg branch branch-a
echo a >> a.txt && hg add . && hg commit -m 'commit a'

hg up default
echo b >> b.txt && hg add . && hg commit -m 'commit b'

hg up branch-a && hg merge default && hg commit -m 'pull update from default'

hg up default && hg merge branch-a && hg commit -m 'merge branch a'
echo c >> c.txt && hg add . && hg commit -m 'commit c'
