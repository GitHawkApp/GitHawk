if [[ ! -z "${DISABLE_APOLLO}" ]]; then
  echo "Stopping Task: Remove 'DISABLE_APOLLO' env variable to continue."
  exit
fi

PATH="$(npm bin):$PATH"

APOLLO_FRAMEWORK_PATH="$(eval find $FRAMEWORK_SEARCH_PATHS -name \"Apollo.framework\" -maxdepth 1)"

if [ -z "$APOLLO_FRAMEWORK_PATH" ]; then
echo "error: Couldn't find Apollo.framework in FRAMEWORK_SEARCH_PATHS; make sure to add the framework to your project."
exit 1
fi

cd "${SRCROOT}/gql"
$APOLLO_FRAMEWORK_PATH/check-and-run-apollo-cli.sh codegen:generate --queries="$(find . -name '*.graphql')" --schema=schema.json API.swift
