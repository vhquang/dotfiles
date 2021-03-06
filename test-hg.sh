rm -rf hg-repo && hg init hg-repo
rm -rf git-repo && git init git-repo

pushd hg-repo
hg --version | head -1 > version.txt && hg add . && hg commit -m 'hg init'

# branch-a
hg branch branch-a
echo a >> a.txt && hg add . && hg commit -m 'commit a'
echo a >> version.txt

# branch default
hg up default
echo b >> b.txt && hg add . && hg commit -m 'commit b'

hg up branch-a && hg merge default && hg commit -m 'pull update from default'

hg up default && hg merge branch-a && hg commit -m 'merge branch a'
echo c >> c.txt && hg add . && hg commit -m 'commit c'

# branch-d
hg branch branch-d
echo d >> d.txt
echo d >> a.txt && hg add . && hg commit -m 'commit d'
hg up default && hg merge branch-d && hg commit -m 'merge into default w/o update'

mkdir -p to-ignore
echo asdf >> to-ignore/foo.txt && hg add . && hg commit -m 'dump file to ignore'

# branch-unmerge
hg branch unmerge
echo working >> working.txt && hg add . && hg commit -m 'commit working.txt'

# branch default
hg up default

popd