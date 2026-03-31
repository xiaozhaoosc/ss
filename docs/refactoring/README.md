# SmallSteps Project Refactoring Guide (Originally RuoYi-Vue-Plus)

This directory contains the history and scripts used to refactor the project from **RuoYi-Vue-Plus** to **Small Steps**.

## 🎯 Objective
Rename the entire project, including:
- **Project Structure**: `ruoyi-*` -> `smallsteps-*`
- **Package Name**: `com.ruoyi` / `org.dromara` -> `com.kenzhao.smallsteps`
- **Artifacts**: GroupID `org.dromara` -> `com.kenzhao.smallsteps`
- **Author**: `ruoyi` -> `kenzhao`

## 📂 Archived Scripts
The following Python scripts were developed to automate this process. They are archived in `scripts/`:

1.  **`refactor_project.py`**
    - **Function**: The "Heavy Lifter". Renames directories, moves package structures, and performs text replacement in file contents (`ruoyi` -> `smallsteps`).
    - **Usage**: Run first to handle the bulk of renaming.

2.  **`refactor_project_v2.py`**
    - **Function**: Handles the specific migration of `org.dromara` packages (which were missed by v1) to `com.kenzhao.smallsteps`. Also renames classes like `DromaraApplication` to `SmallStepsApplication`.
    - **Usage**: Run after v1 if you have `org.dromara` packages.

3.  **`fix_dependencies.py`**
    - **Function**: Corrects Maven dependency GroupIDs. The initial refactor might incorrectly rename 3rd party libs (e.g., `com.kenzhao.smallsteps.sms4j`). This script reverts them to `org.dromara.sms4j`.
    - **Usage**: Run if Maven cannot find dependencies.

4.  **`fix_imports.py`** & **`fix_fqn.py`**
    - **Function**: Fixes Java `import` statements and fully qualified names (FQN) in code. Reverts incorrect changes to libraries like `warm-flow`, `hutool`, `satoken`.
    - **Usage**: Run if you see compilation errors related to missing packages for 3rd party libraries.

5.  **`fix_base_entity.py`**
    - **Function**: Specific fix for `BaseEntity` location. Ensures `AiRoute` imports `BaseEntity` from the correct `mybatis` module.
    - **Usage**: Run if `smallsteps-common-ai` fails to compile.

6.  **`clean_leftovers.py`**
    - **Function**: The "Polisher". Scans for remaining strings (e.g., in `LICENSE`, `application.yml`, comments) and cleans them.
    - **Usage**: Run last to ensure branding consistency.

## 🚀 Refactoring Workflow (Reconstruction)

If we were to do this again, the sequence is:

```bash
# 1. Structural Rename
python docs/refactoring/scripts/refactor_project.py

# 2. Package Migration (if org.dromara exists)
python docs/refactoring/scripts/refactor_project_v2.py

# 3. Code Repair (Fix Broken Deps/Imports)
python docs/refactoring/scripts/fix_imports.py
python docs/refactoring/scripts/fix_fqn.py

# 4. Branding Cleanup
python docs/refactoring/scripts/clean_leftovers.py

# 5. Verification
mvn clean package -DskipTests
```

## ✅ Result
- **Backend**: Successfully acts as `com.kenzhao.smallsteps`.
- **Frontend**: References removed from `smallsteps-ui`.
- **Build**: `mvn clean package` passing (Exit Code 0).
