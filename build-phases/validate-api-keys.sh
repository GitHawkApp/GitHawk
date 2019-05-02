FAILED=false

if [ -z "${BUDDYBUILD_BUILD_NUMBER}" ]; then
  echo "Script is not being run on CI"
  exit 0
fi

if [ -z "${GITHUB_CLIENT_ID}" ]; then
  echo "${SRCROOT}/Classes/Systems/Secrets.swift:14:1: warning: Missing GitHub Client ID"
  FAILED=true
fi

if [ -z "${GITHUB_CLIENT_SECRET}" ]; then
  echo "${SRCROOT}/Classes/Systems/Secrets.swift:15:1: warning: Missing GitHub Client Secret"
  FAILED=true
fi

if [ -z "${IMGUR_CLIENT_ID}" ]; then
  echo "${SRCROOT}/Classes/Systems/Secrets.swift:16:1: warning: Missing Imgur Client ID"
  FAILED=true
fi

sed -i ".tmp" "s|{GITHUBID}|${GITHUB_CLIENT_ID}|g; s|{GITHUBSECRET}|${GITHUB_CLIENT_SECRET}|g; s|{IMGURID}|${IMGUR_CLIENT_ID}|g" "${SRCROOT}/Classes/Systems/Secrets.swift"

if [ "$FAILED" = true ]; then
  exit 1
fi

echo "All env values found!"
