all: build
.PHONY: all

SOURCE_GIT_TAG=v1.0.0+$(shell git rev-parse --short=7 HEAD)

GO_BUILD_PACKAGES=.
GOLINT=golangci-lint run

# Include the library makefile
include $(addprefix ./vendor/github.com/openshift/build-machinery-go/make/, \
	golang.mk \
)

vendor:
	go mod tidy
	go mod vendor
.PHONY: vendor

validate-vendor: vendor
	git status -s ./vendor/ go.mod go.sum
	test -z "$$(git status -s ./vendor/ go.mod go.sum | grep -v vendor/modules.txt)"
.PHONY: validate-vendor

lint: verify-golint

sonar-reports:
	go test ./... -coverprofile=coverage.out -covermode=count -json > report.json
	golangci-lint run ./... --verbose --no-config --out-format checkstyle --issues-exit-code 0 > golangci-lint.out
.PHONY: sonar-reports

clean-reports:
	rm -f report.json coverage.out golangci-lint.out
.PHONY: clean-reports

clean: clean-reports
.PHONY: clean
