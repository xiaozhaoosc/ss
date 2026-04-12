# Project: SmallSteps - Automated Testing Framework (SATS) Design

## 1. Goal
Design and implement a comprehensive, fully automated testing framework for the SmallSteps ecosystem (API, UI, App, and ESP32), integrating the "Superpowers" testing skills.

## 2. Framework Components
The framework, named **SATS (SmallSteps Automated Testing Suite)**, consists of:
- **SATS-API**: Java/Spring Boot API tests using JUnit 5, RestAssured, and Allure.
- **SATS-UI**: Playwright (TS) for Web-based admin UI testing.
- **SATS-App**: Playwright (for H5) and UniApp Automator (for App-specific components).
- **SATS-System**: Docker-orchestrated E2E integration tests.
- **SATS-Reporting**: Aggregated Allure reports and coverage metrics.

## 3. Deliverables in `autotestdocs/`
We will create the following documents to define the framework:
1.  `autotestdocs/STRATEGY.md`: High-level architecture, technical stack, and data flow.
2.  `autotestdocs/API_TESTING.md`: Standards and implementation guide for backend automation.
3.  `autotestdocs/UI_APP_TESTING.md`: Standards and implementation guide for frontend (Web/App) automation.
4.  `autotestdocs/INTEGRATION_CICD.md`: CI/CD pipeline configuration (GitHub Actions/Docker) and reporting setup.
5.  `autotestdocs/SUPERPOWERS_WORKFLOW.md`: Explicit instructions on integrating `test-driven-development` and `verification-before-completion` into the dev cycle.

## 4. Technical Stack
- **API**: JUnit 5, Mockito, RestAssured, JaCoCo, Allure.
- **UI/App**: Playwright, Vitest, Vue Test Utils, UniApp Automator.
- **System**: Docker Compose, PostgreSQL (Test Data), Redis (Test Data).
- **Environment**: GitHub Actions (Workflow), Docker Hub (Images).

## 5. Superpowers Integration
- **TDD**: Mandated for all new features.
- **Verification**: Mandatory "Red-Green-Refactor" cycles for critical paths.
- **Systematic Debugging**: Used for automated failure analysis in CI.

## 6. Execution Steps
1.  Create `autotestdocs/` directory.
2.  Draft `STRATEGY.md` with the finalized architecture.
3.  Draft detailed guides for API, UI, and App testing.
4.  Define CI/CD and Reporting configurations.
5.  Integrate Superpowers into the team's testing workflow documentation.
