#!/bin/bash

# Chameleon MirrorMail Guntroide Release Packaging Script
# This script packages all necessary files for deployment

set -e  # Exit on error

echo "========================================"
echo "Chameleon MirrorMail Release Packager"
echo "========================================"
echo ""

# Get the version from package.json
VERSION=$(node -p "require('./package.json').version")
RELEASE_NAME="chameleon-mirrormail-v${VERSION}"
RELEASE_DIR="releases/${RELEASE_NAME}"

echo "📦 Packaging release: ${RELEASE_NAME}"
echo ""

# Clean up any existing release directory
if [ -d "${RELEASE_DIR}" ]; then
    echo "🧹 Cleaning up existing release directory..."
    rm -rf "${RELEASE_DIR}"
fi

# Create release directory structure
echo "📁 Creating release directory structure..."
mkdir -p "${RELEASE_DIR}"

# Step 1: Build the client
echo ""
echo "🔨 Building client (production)..."
npm run build:client

# Step 2: Copy all required files and directories
echo ""
echo "📋 Copying files and directories..."

# Copy root-level files
cp .dockerignore "${RELEASE_DIR}/"
cp .gitignore "${RELEASE_DIR}/"
cp LICENSE "${RELEASE_DIR}/"
cp README.md "${RELEASE_DIR}/"
cp DEPLOYMENT.md "${RELEASE_DIR}/"
cp docker-compose.yml "${RELEASE_DIR}/"
cp package.json "${RELEASE_DIR}/"

# Copy directories
echo "  - Copying .github directory..."
cp -r .github "${RELEASE_DIR}/"

echo "  - Copying client directory..."
cp -r client "${RELEASE_DIR}/"

echo "  - Copying server directory..."
cp -r server "${RELEASE_DIR}/"

echo "  - Copying releases directory..."
mkdir -p "${RELEASE_DIR}/releases"
cp releases/*.md "${RELEASE_DIR}/releases/" 2>/dev/null || true

# Step 3: Clean up unnecessary files from the release package
echo ""
echo "🧹 Cleaning up development files from release package..."

# Remove node_modules from the package (users should run npm install)
find "${RELEASE_DIR}" -type d -name "node_modules" -exec rm -rf {} \; 2>/dev/null || true

# Remove build artifacts that shouldn't be in source distribution
find "${RELEASE_DIR}" -type d -name "coverage" -exec rm -rf {} \; 2>/dev/null || true
find "${RELEASE_DIR}" -type f -name "*.log" -delete 2>/dev/null || true

# Remove package-lock files (can be regenerated)
find "${RELEASE_DIR}" -type f -name "package-lock.json" -delete 2>/dev/null || true

# Step 4: Create release archive
echo ""
echo "📦 Creating release archive..."
mkdir -p releases
cd releases
tar -czf "${RELEASE_NAME}.tar.gz" "${RELEASE_NAME}/"
zip -r -q "${RELEASE_NAME}.zip" "${RELEASE_NAME}/"
cd ..

# Step 5: Generate checksums
echo ""
echo "🔐 Generating checksums..."
mkdir -p releases
cd releases
sha256sum "${RELEASE_NAME}.tar.gz" > "${RELEASE_NAME}.tar.gz.sha256"
sha256sum "${RELEASE_NAME}.zip" > "${RELEASE_NAME}.zip.sha256"
cd ..

# Step 6: Display summary
echo ""
echo "========================================"
echo "✅ Release packaging complete!"
echo "========================================"
echo ""
echo "Release Details:"
echo "  Version: ${VERSION}"
echo "  Directory: ${RELEASE_DIR}"
echo ""
echo "Archives created:"
echo "  - releases/${RELEASE_NAME}.tar.gz"
echo "  - releases/${RELEASE_NAME}.tar.gz.sha256"
echo "  - releases/${RELEASE_NAME}.zip"
echo "  - releases/${RELEASE_NAME}.zip.sha256"
echo ""
echo "Contents include:"
echo "  ✓ .dockerignore"
echo "  ✓ .gitignore"
echo "  ✓ LICENSE"
echo "  ✓ README.md"
echo "  ✓ DEPLOYMENT.md"
echo "  ✓ docker-compose.yml"
echo "  ✓ package.json"
echo "  ✓ .github/ (CI/CD workflows)"
echo "  ✓ client/ (React frontend with production build)"
echo "  ✓ server/ (Express backend)"
echo "  ✓ releases/ (Release notes)"
echo ""
echo "📝 Note: Users should run 'npm install' after extracting to install dependencies."
echo ""
