#!/bin/bash
set -e

format_errors=$(find . -name '*.go' -print0 | xargs -0 gofmt -l -e)
if [ "$format_errors" ]; then
    echo "=== misformatted files (run gofmt) ==="
    echo "$format_errors"
    exit 1
fi

bazel build //...
bazel test --test_arg=-test.v //...

# bazel-bin/client/test/go_default_test -test.repo "$(pwd)/deps/linux"
