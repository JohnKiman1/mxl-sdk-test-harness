# MXL SDK Test Harness

&#x20; &#x20;

---

## 📋 Overview

The **MXL SDK Test Harness** is a production-grade Android QA framework designed for **SDK validation, automation, and CI/CD enforcement**. It establishes a scalable foundation for validating SDK integrations across environments using deterministic, repeatable tests.

This repository reflects **senior-level QA engineering practices**, including:

- Shift-left testing strategy
- CI-driven validation gates
- Automated reporting and observability
- Reproducible test environments

---

## 🎯 Objectives

This project was designed to:

- Enforce **automated SDK validation on every code change**
- Provide **fast feedback loops** via CI
- Ensure **test reliability through emulator-based execution**
- Deliver **actionable insights via coverage + reporting**

---

## 🚀 Key Capabilities

### CI/CD Automation

- Triggered on `main`, `fix/**`, and pull requests
- Fully automated test execution pipeline
- Deterministic builds using Gradle caching

### Test Execution Layer

- Emulator-based instrumentation testing (API 34)
- Headless execution for CI efficiency
- Boot validation and stability checks

### Observability & Reporting

- Code coverage via Jacoco
- Allure-ready reporting pipeline
- GitHub Pages deployment for visibility
- Artifact retention for debugging

---

## 🧪 Test Strategy

### Test Layers

| Layer                 | Type     | Purpose                              |
| --------------------- | -------- | ------------------------------------ |
| Unit Tests            | JVM      | Fast logic validation                |
| Instrumentation Tests | Emulator | SDK + Android integration validation |
| Smoke Tests           | Emulator | Environment sanity checks            |

### Current Test Coverage

**Instrumentation Tests**

- `useAppContext()`

  - Validates runtime context
  - Ensures correct package binding

- `sdk_smoke_test()`

  - Verifies execution pipeline
  - Confirms test environment integrity

---

## ⚙️ CI/CD Pipeline Architecture

### Pipeline Flow

1. **Checkout & Setup**

   - Source retrieval
   - Java 17 provisioning
   - Gradle dependency caching

2. **Environment Preparation**

   - KVM acceleration enabled
   - Emulator provisioning (Pixel 5, API 34)

3. **Execution Phase**

   - Emulator boot validation loop
   - Test execution via Gradle
   - Coverage generation

4. **Reporting Phase**

   - Allure report generation (fallback supported)
   - Artifact upload
   - GitHub Pages deployment

5. **Post-Processing**

   - Summary generation
   - Coverage validation

---

## 📊 Reporting

### GitHub Pages

- Public test report hosting
- Historical visibility (future Allure enhancement)

### Artifacts

- Allure report bundle
- Coverage reports
- Debug outputs

### Coverage

- Line-level execution visibility
- Identifies gaps in test coverage

---

## 🏗️ Project Structure

```
mxl-sdk-test-harness/
├── .github/workflows/
│   └── android-ci.yml
├── app/
│   ├── src/
│   │   ├── androidTest/
│   │   ├── main/
│   │   └── test/
├── gradle/
├── build.gradle.kts
├── settings.gradle.kts
└── README.md
```

---

## 🏃 Running Tests Locally

### Full Test Suite

```
./gradlew test connectedAndroidTest
```

### Instrumentation Only

```
./gradlew connectedAndroidTest
```

### Coverage

```
./gradlew clean connectedAndroidTest createDebugCoverageReport
```

---

## 🔍 Emulator Strategy

- Device: Pixel 5
- API Level: 34
- Mode: Headless
- GPU: SwiftShader

### Stability Enhancements

- Boot polling with retries
- Timeout handling
- ADB readiness checks

---

## 🧩 Engineering Decisions

### Why Emulator in CI?

- Ensures production-like runtime
- Validates SDK behavior under real Android conditions

### Why Headless Execution?

- Reduces CI overhead
- Improves execution speed

### Why GitHub Pages?

- Zero-cost reporting layer
- Easy sharing across teams

---

## ⚠️ Known Gaps

- Allure results not fully integrated from device layer
- Limited test coverage (intentional baseline)
- No flaky test mitigation yet

---

## 🚦 Roadmap

- Expand SDK test scenarios
- Integrate full Allure lifecycle
- Add retry logic for flaky tests
- Multi-device / multi-API execution
- iOS parity pipeline
- Performance benchmarking

---

## 🐛 Troubleshooting

### Emulator Issues

- Verify KVM is enabled
- Increase boot timeout

### Test Failures

- Inspect artifacts
- Review CI logs

### Coverage Missing

- Ensure debug coverage flags enabled

---

## 👤 Author

**John Kimani**\
GitHub: [https://github.com/JohnKiman1](https://github.com/JohnKiman1)

---

## 📌 Status

**Production Ready**\
CI/CD Pipeline: ✅ Operational\
Test Harness: ✅ Stable

---

## 📅 Last Updated

April 2026

