PYLINT_FILES=$(shell /bin/ls *.py  | grep -v bottle.py | grep -v app_wsgi.py)

all:
	@echo verify syntax and then restart
	make pylint
	make touch

check:
	make pylint
	make pytest


touch:
	touch tmp/restart.txt

pylint:
	pylint $(PYLINT_FILES)

# These are used by the CI pipeline:
install-dependencies:
	if [ -r requirements.txt ]; then pip3 install --user -r requirements.txt ; fi

pytest:
	pytest .

coverage:
	pytest --debug -v --cov=. --cov-report=xml tests/ || echo pytest failed

clean:
	find . -name '*~' -exec rm {} \;
