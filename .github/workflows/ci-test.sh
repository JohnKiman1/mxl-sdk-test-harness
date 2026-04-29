#!/bin/bash
# ci-test.sh — companion script for android-ci.yml
#
# WHY THIS FILE EXISTS:
# reactivecircus/android-emulator-runner executes each line of an inline
# `script:` block as a separate `sh -c` call. This breaks:
#   - multi-line if/fi constructs (orphaned fi → syntax error)
#   - $? capture (each line is a new shell, so exit codes don't carry over)
# Running as a file-based script resolves both issues.

set -euo pipefail

echo "✅ Emulator ready"
adb wait-for-device
adb shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 5; done;'
adb shell input keyevent 82 || true

echo "🚀 Running instrumented tests..."

# Run tests — capture exit code without letting set -e abort early
./gradlew clean connectedAndroidTest createDebugCoverageReport \
  --no-daemon --stacktrace || TESTS_FAILED=true

# Always pull Allure results, even if tests failed —
# this is the whole point: get the report on failures too
echo "📥 Pulling Allure results from device..."
mkdir -p allure-results

# Location 1: external storage (works if app has WRITE_EXTERNAL_STORAGE
# and your AllureAndroidListener is configured to write there)
adb pull /sdcard/allure-results ./allure-results 2>/dev/null || true

# Location 2: app internal storage (replace com.your.app.package below
# with your actual applicationId from build.gradle)
# adb pull /data/data/com.your.app.package/files/allure-results ./allure-results 2>/dev/null || true

# Diagnostic: surface clearly if nothing was written
RESULT_COUNT=$(find allure-results -name "*.json" 2>/dev/null | wc -l)
echo "📊 Allure result files found: $RESULT_COUNT"

if [ "$RESULT_COUNT" -eq 0 ]; then
  echo ""
  echo "⚠️  WARNING: No Allure result files found."
  echo "   This usually means one of:"
  echo "   1. testInstrumentationRunner is not set to AllureAndroidJUnit4Runner"
  echo "   2. allure-kotlin-android dependency is missing from androidTest"
  echo "   3. Results are written to a different path on the device"
  echo "   Check your app/build.gradle and androidTest dependencies."
  echo ""
fi

echo "📂 allure-results contents:"
ls -la allure-results 2>/dev/null || echo "(empty)"

# Exit with original test result
if [ "${TESTS_FAILED:-}" = "true" ]; then
  echo "❌ Tests failed"
  exit 1
fi

echo "✅ All tests passed"
