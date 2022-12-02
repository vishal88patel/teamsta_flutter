#!/bin/bash

# run bash get_ci_setup.sh
# READ .env file
ENV_DOC="$(cat env.json | jq .)"
# Prepare key value list
MAP_KEYS="$(echo $ENV_DOC | jq -r 'keys | .[]')"
KEY_ARRAY=()
KEY_ARRAY+=($MAP_KEYS)

DEFINITION_ARRAY=()

for (( i=0; i< "${#KEY_ARRAY[@]}"; i++ ))
do
  KEY="${KEY_ARRAY[$i]}"
  RESPONSE='--dart-define='"$(echo ${KEY})"'=$'"$(echo ${KEY})"
  DEFINITION_ARRAY+=($RESPONSE)
done

echo "${DEFINITION_ARRAY[@]}"
