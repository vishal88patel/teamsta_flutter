#!/bin/bash

# run bash get_ci_setup.sh
# READ .env file
ENV_DOC="$(cat env.json | jq .)"
# Prepare key value list
MAP_KEYS="$(echo $ENV_DOC | jq -r 'keys | .[]')"
KEY_ARRAY=()
KEY_ARRAY+=($MAP_KEYS)

# Append key value pairs to build definitions
DEFINITION_ARRAY=()

for (( i=0; i< "${#KEY_ARRAY[@]}"; i++ ))
do
  KEY="${KEY_ARRAY[$i]}"
  VALUE="$(jq '.["'"$(echo $KEY)"'"]' env.json)"
  LENGTH=${#VALUE}
  LENGTH="$(($LENGTH-2))"
  VALUE=${VALUE:1:LENGTH}
  KEY="$(echo -e $KEY)"
  VALUE=$(echo -e $VALUE)
  RESPONSE='--dart-define='"${KEY}"'='"${VALUE}"
  DEFINITION_ARRAY+=($RESPONSE)
done
# generate appbundle
ARGS="$(echo -e ${DEFINITION_ARRAY[@]})"
"$(echo -e flutter build appbundle ${ARGS})"

