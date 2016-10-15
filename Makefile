.PHONY: test

VERSION := `node -e "console.log(require('./package.json').version)"`
FOLDERS := `ls`

test:
	echo "\0033[1mTesting v$(VERSION)\0033[22m"
	node js/echomd -h > test/js-echomd
	perl perl/echomd -h > test/perl-echomd
	diff test/js-echomd test/perl-echomd || exit 1;
	diff test/js-echomd test/demo-echomd || exit 1;

