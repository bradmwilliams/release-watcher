FROM registry.ci.openshift.org/openshift/centos:stream9
LABEL maintainer="openshift-continuous-release-tooling@redhat.com"
ADD release-watcher /usr/bin/release-watcher
ENTRYPOINT ["/usr/bin/release-watcher"]
EXPOSE 8080
