#!/usr/bin/env bash
set -euo pipefail

SUBMODULE_PATH="thanos-operator"
MANIFEST_DIR="manifests"
PKG_VERSION_PREFIX="0.1.0"

# Validate submodule is checked out
if [ ! -d "$SUBMODULE_PATH/config" ]; then
  echo "❌ Cannot find Thanos Operator source in $SUBMODULE_PATH. Did you run update-submodule.sh?"
  exit 1
fi

COMMIT_SHA=$(git -C "$SUBMODULE_PATH" rev-parse --short HEAD)
DATE=$(date +%Y%m%d)
PKG_VERSION="${PKG_VERSION_PREFIX}-${DATE}-${COMMIT_SHA}"

echo "📦 Generating manifests from $SUBMODULE_PATH..."
mkdir -p "$MANIFEST_DIR"

# Concatenate CRDs
cat "$SUBMODULE_PATH"/config/crd/bases/*.yaml > "$MANIFEST_DIR/00-crds.yaml"

# Render all non-CRD manifests from custom overlay
kustomize build overlays/no-crds > "$MANIFEST_DIR/10-controller.yaml"

# Commit the manifest changes
git add "$MANIFEST_DIR"
git commit -m "🚀 Sync manifests from thanos-operator@${COMMIT_SHA} (v${PKG_VERSION})"

echo "✅ Manifests committed and tagged as v${PKG_VERSION}"
