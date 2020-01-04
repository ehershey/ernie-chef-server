#!/bin/bash
set -o errexit
set -o nounset
set -o xtrace

client_version=15.6.10

# Install Chef Infra Client
if ! rpm -q chef-$client_version >/dev/null 2>&1
then
	sudo rpm -Uvh https://packages.chef.io/files/stable/chef/$client_version/el/7/chef-$client_version-1.el7.x86_64.rpm
fi

if ! test -d chef-repo-ernie
then
	git clone --recurse-submodules git@github.com:ehershey/chef-repo-ernie.git
fi

sudo chef-solo --json-attributes chef-server.json --chef-license accept --config solo.rb
