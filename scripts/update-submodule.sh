#!/usr/bin/env bash
set -euo pipefail

SUBMODULE_PATH="thanos-operator"
TARGET_REF="${1:-main}" # branch, tag, or commit SHA

echo "🔄 Updating submodule to $TARGET_REF..."

pushd "$SUBMODULE_PATH" > /dev/null
git fetch --tags origin
git checkout "origin/${TARGET_REF}"
COMMIT_SHA=$(git rev-parse --short HEAD)
popd > /dev/null

# Stage and commit the submodule update
git add "$SUBMODULE_PATH"
git commit -m "🔄 Update thanos-operator submodule to $TARGET_REF ($COMMIT_SHA)"

echo "✅ Submodule updated to $COMMIT_SHA"
