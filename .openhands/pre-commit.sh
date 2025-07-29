#!/bin/bash
# Run tests
sg test --skip-snapshot-tests
if [ $? -ne 0 ]; then
  echo "tests failed. Please fix the issues before committing."
  exit 1
fi

exit 0
