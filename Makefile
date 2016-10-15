.PHONY: aur test

VERSION := `node -e "console.log(require('./package.json').version)"`
FOLDERS := `ls`

test:
	echo "\0033[1mTesting v$(VERSION)\0033[22m"
	node js/echomd -h > test/js-echomd
	perl perl/echomd -h > test/perl-echomd
	diff test/js-echomd test/perl-echomd || exit 1;
	diff test/js-echomd test/demo-echomd || exit 1;
aur:
	cp {LICENSE,PKGBUILD} ~/code/aur/echomd
	mv .SRCINFO ~/code/aur/echomd
	mv *.tar.*z ~/code/aur/echomd
	echo "$(VERSION)" > ~/code/aur/echomd/version
	git add .
	git commit -m "Updating to $(VERSION)"
	git push
	git checkout gh-pages
	mkdir -p archive
	mv ~/code/aur/echomd/*.tar.*z archive/
	mv ~/code/aur/echomd/version ./
	git add .
	git commit -m "Update `cat version`"
	git push
	git checkout master

