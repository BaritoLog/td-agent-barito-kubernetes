#!/bin/bash -ex

td-agent-gem install --no-document fluent-plugin-kubernetes_metadata_filter
td-agent-gem install --no-document fluent-plugin-prometheus
td-agent-gem install --no-document fluent-plugin-barito
