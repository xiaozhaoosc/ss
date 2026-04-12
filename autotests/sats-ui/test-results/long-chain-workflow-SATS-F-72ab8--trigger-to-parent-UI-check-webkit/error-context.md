# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: long-chain-workflow.spec.ts >> SATS Full-Cycle Workflow: Device to Parent UI >> should complete the full cycle from device trigger to parent UI check
- Location: tests\long-chain-workflow.spec.ts:8:7

# Error details

```
Error: apiRequestContext.post: connect ECONNREFUSED ::1:8080
Call log:
  - → POST http://localhost:8080/api/device/activation
    - user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.4 Safari/605.1.15
    - accept: */*
    - accept-encoding: gzip,deflate,br
    - Device-Id: AA:BB:CC:DD:EE:FF
    - content-type: application/json
    - content-length: 63

```