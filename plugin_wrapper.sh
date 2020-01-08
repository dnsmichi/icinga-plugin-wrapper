#!/usr/bin/env bash

# Usage
#
# See https://github.com/dnsmichi/icinga-plugin-wrapper

ARGS=$@

OUTPUT=$($ARGS)
STATUS=$?

# Search and change the output
WRAPPED_OUTPUT=$OUTPUT

# First test to see whether this wrapper works, uncomment the line below
#WRAPPED_OUTPUT="Wrapped output: $OUTPUT"

# You can add performance data parsed before.
# Reference: https://icinga.com/docs/icinga2/latest/doc/05-service-monitoring/#plugin-api
#PERFDATA_VALUE=5
#WRAPPED_OUTPUT = "$OUTPUT | 'key'=$PERFDATA_VALUE"


# Change the exit status if needed
WRAPPED_STATUS=$STATUS

echo $WRAPPED_OUTPUT
exit $WRAPPED_STATUS

