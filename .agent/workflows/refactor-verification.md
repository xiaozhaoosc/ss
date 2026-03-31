---
description: Verify project refactoring integrity through build, package, and string scanning
---

# Project Refactoring Verification Workflow

This workflow ensures that a project renaming or major refactoring (like RuoYi -> SmallSteps) hasn't broken the build or left behind stale references.

## 1. Automated String Scan
Search for the old project name to find missed occurrences in comments, config files, or documentation.

```powershell
# // turbo: true
git grep -i "ruoyi"
```

## 2. Verify Compilation
Run a standard install to ensure all modules compile and artifacts are installed to the local repository.

```powershell
mvn clean install -DskipTests
```

## 3. Verify Packaging (Deep Check)
Run `package` to ensure that jarring, shading, and resource bundling work correctly. This often catches missing dependencies that `install` might miss if they aren't required for pure compilation.

```powershell
mvn clean package -DskipTests
```

## 4. Frontend Scan
Ensure frontend code is clean.

```powershell
# // turbo: true
grep -r "ruoyi" projects/smallsteps-ui/src
```

## 5. Automated Cleanup Script (Optional)
If leftovers are found, use a Python script to batch replace them.

```python
# scripts/clean_leftovers.py
import os

REPLACEMENTS = {
    "OldName": "NewName",
}

# ... (See script implementation in brain/task.md history)
```
