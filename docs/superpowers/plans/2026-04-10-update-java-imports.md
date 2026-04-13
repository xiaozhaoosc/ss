# Update Java Imports and References Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Update all Java imports and MyBatis Mapper XML references for classes moved to `com.kenzhao.smallsteps.common.ss.domain` (and subpackages `bo` and `vo`). Finally, remove old class files.

**Architecture:** Use a surgical Python script for bulk package updates in Java and XML files.

**Tech Stack:** Python 3 (for replacement script).

---

### Task 1: Research and Verify Files

- [ ] **Step 1: List all files with old references to be updated**
- [ ] **Step 2: Verify the new locations exist (done)**

### Task 2: Create and Run Update Script

- [ ] **Step 1: Create `update_imports.py` to perform the replacements**
- [ ] **Step 2: Run the script to update files in `smallsteps-api` (excluding target/generated)**
- [ ] **Step 3: Verify some files were updated correctly**

### Task 3: Remove Old Class Files

- [ ] **Step 1: Remove the 6 classes from `smallsteps-api/smallsteps-modules/smallsteps-child/src/main/java/com/kenzhao/smallsteps/child/domain/`**
- [ ] **Step 2: Remove `ParentTaskBo.java` from `smallsteps-api/smallsteps-modules/smallsteps-child/src/main/java/com/kenzhao/smallsteps/child/domain/bo/`**
- [ ] **Step 3: Remove the 4 classes from `smallsteps-api/smallsteps-modules/smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/domain/`**
- [ ] **Step 4: Remove the 4 BO classes from `smallsteps-api/smallsteps-modules/smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/domain/bo/`**
- [ ] **Step 5: Remove the 4 VO classes from `smallsteps-api/smallsteps-modules/smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/domain/vo/`**
- [ ] **Step 6: Remove `ParentTaskVo.java` from `smallsteps-api/smallsteps-common/smallsteps-common-core/src/main/java/com/kenzhao/smallsteps/common/core/domain/vo/`**

---
