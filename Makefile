help:

	@echo "Possible targets:"
	@echo "  test - build all test suites"
	@exit 0

test-update-required-modules:

	@make test-ensure-required-modules
	@cd tests/modules/stdlib && git pull origin master
	@cd tests/modules/concat && git pull origin master

test-ensure-required-modules:

	@if [ ! -d tests/modules ]; then mkdir tests/modules; fi
	@if [ ! -d tests/modules/stdlib ]; then cd tests/modules; wget -q https://forgeapi.puppetlabs.com/v3/files/puppetlabs-stdlib-4.1.0.tar.gz && tar -zxf puppetlabs-stdlib-* && rm puppetlabs-stdlib-*.tar.gz && mv puppetlabs-stdlib-* stdlib; cd ../../; fi
	@if [ ! -d tests/modules/concat ]; then cd tests/modules; wget -q https://forgeapi.puppetlabs.com/v3/files/puppetlabs-concat-1.0.2.tar.gz && tar -zxf puppetlabs-concat-* && rm puppetlabs-concat-*.tar.gz && mv puppetlabs-concat-* concat; cd ../../; fi
	@if [ ! -d tests/modules/nginx ]; then cd tests/modules; mkdir nginx; cd ../../; fi
	@if [ ! -L tests/modules/nginx/Modulefile ]; then cd tests/modules/nginx; ln -s ../../../Modulefile .; cd ../../../; fi
	@if [ ! -L tests/modules/nginx/manifests ]; then cd tests/modules/nginx; ln -s ../../../manifests .; cd ../../../; fi
	@if [ ! -L tests/modules/nginx/templates ]; then cd tests/modules/nginx; ln -s ../../../templates .; cd ../../../; fi

test:

	@echo "Execute all Tests"
	@make test-ensure-required-modules
	sudo ./bin/run_tests_unix

puppet-lint:

	@echo "Validate with puppet-lint"
	rake lint

validate-puppet:

	@echo "Validate with puppet parser"
	puppet parser validate `find . | grep '.pp$$'`

.PHONY: test help

# vim: ts=4:sw=4:noexpandtab!:
