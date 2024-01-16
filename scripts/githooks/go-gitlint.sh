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

run_go_gitlint() {
    local commit_msg_file="\$1"
    local go_gitlint_target="go-gitlint"
    local subject_regex="^(build|chore|ci|docs|feat|feature|fix|perf|refactor|revert|style|bot|test):\\\s?.*"
    local subject_maxlen=150
    local subject_minlen=10
    local commit_msg_file="$1"
    local go_gitlint_target="go-gitlint"
    local subject_regex="^(build|chore|ci|docs|feat|feature|fix|perf|refactor|revert|style|bot|test)(.*)?:\s?.*"
    local subject_maxlen=150
    local subject_minlen=10

    go-gitlint \
        --msg-file="$commit_msg_file" \
        --target="$go_gitlint_target" \
        --subject-regex="$subject_regex" \
        --subject-maxlen="$subject_maxlen" \
        --subject-minlen="$subject_minlen"

    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo "Error: Failed to execute go-gitlint. Please fix your commit message to match the required format."
        exit $exit_code
    fi
}

run_go_gitlint "$1"
