#!/usr/bin/env bash

# Copyright © 2023 OpenIMSDK.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

run_go_lint() {
    local message_file="$1"
    local lint_target="go-gitlint"
    local commit_regex="^(build|chore|ci|docs|feat|feature|fix|perf|refactor|revert|style|bot|test)(.*)?:\s?.*"
    local max_subject_len=150
    local min_subject_len=10

    go-gitlint \
        --msg-file="$commit_msg_file" \
        --target="$go_gitlint_target" \
        --subject-regex="$subject_regex" \
        --subject-maxlen="$subject_maxlen" \
        --subject-minlen="$subject_minlen"

    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo "Error: Error: The commit message does not match the required format. Please refer to the style guide for commit messages."
        exit $exit_code
    fi
}

run_go_gitlint "$1"
