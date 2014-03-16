help:

	@echo "Possible targets:"
	@echo "  test - build all test suites"
	@exit 0

test-update-required-modules:

	@make test-ensure-required-modules
	@cd tests/modules/stdlib && git pull origin master
	@cd tests/modules/concat && git pull origin master

test-ensure-required-modules:

	@if [ ! -d tests/modules/stdlib ]; then git clone https://github.com/puppetlabs/puppetlabs-stdlib.git tests/modules/stdlib; fi
	@if [ ! -d tests/modules/concat ]; then git clone https://github.com/puppetlabs/puppetlabs-concat.git tests/modules/concat; fi

test:

	@echo "Execute all Tests"
	@make test-ensure-required-modules
	sudo ./bin/run_tests_unix

.PHONY: test help

# vim: ts=4:sw=4:noexpandtab!:
