#!/bin/bash
set -e

echo "=== Makefiler Test Suite ==="

run_test() {
    cmd="$1"
    desc="$2"
    echo -e "\n[TEST] $desc"
    # Capture output and stderr, run command. Check strict exit code 0.
    if eval "$cmd" > /dev/null 2>&1; then
        echo "  [PASS] '$cmd' succeeded."
    else
        echo "  [FAIL] '$cmd' failed."
        exit 1
    fi
}

run_fail_test() {
    cmd="$1"
    desc="$2"
    echo -e "\n[TEST] $desc (Expect Failure)"
    # Expect failure (non-zero exit code)
    if eval "$cmd" > /dev/null 2>&1; then
        echo "  [FAIL] '$cmd' unexpectedly succeeded."
        exit 1
    else
        echo "  [PASS] '$cmd' correctly failed."
    fi
}

# 1. Verify Help
# Check if new targets appear in help output
echo -e "\n[TEST] Checking Help Output"
help_output=$(make help)
for target in docker-up git-sync db-migrate echo-args app-install; do
    if echo "$help_output" | grep -q "$target"; then
        echo "  [PASS] Target '$target' found in help."
    else
        echo "  [FAIL] Target '$target' MISSING from help."
        exit 1
    fi
done

# 2. Functional Tests (Simulations)
run_test "make docker-up" "Docker Up"
run_test "make git-status" "Git Status"
run_test "make db-migrate" "DB Migrate"
run_test "make app-lint" "App Lint"

# 3. Argument Passing
echo -e "\n[TEST] Argument Passing"
# We check stdout for this one
arg_output=$(make -s echo-args arg1 arg2)
if echo "$arg_output" | grep -q "arg1" && echo "$arg_output" | grep -q "arg2"; then
     echo "  [PASS] Arguments passed correctly."
else
     echo "  [FAIL] Arguments NOT passed correctly. Output: $arg_output"
     exit 1
fi

# 4. Error Handling (Typos)
run_fail_test "make typo_target" "Typo Target"

echo -e "\n=== All Tests Passed ==="
