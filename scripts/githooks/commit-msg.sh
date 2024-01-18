#!/bin/bash
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
#


YELLOW="\e[93m"
GREEN="\e[32m"
RED="\e[31m"
ENDCOLOR="\e[0m"

printMessage() {
   printf "${YELLOW}OpenIM : $1${ENDCOLOR}\n"
}

printSuccess() {
   printf "${GREEN}OpenIM : $1${ENDCOLOR}\n"
}


   printf "${RED}OpenIM : $1${ENDCOLOR}\n"
}

printMessage "Running the OpenIM commit-msg hook."

# This example catches duplicate Signed-off-by lines.

test "" = "$(grep '^Signed-off-by: ' "$1" |
	 sort | uniq -c | sed -e '/^[ 	]*1[ 	]/d')" || {
	echo >&2 Duplicate Signed-off-by lines.
	exit 1
}

GITLINT_DIR="/path/to/correct/go-gitlint"

${GITLINT_DIR}/correct/go-gitlint --file $1 --subject-pattern="^(build|chore|ci|docs|feat|feature|fix|perf|refactor|revert|style|bot|test)(.*)?:\s?.*" --subject-max-length=150 --subject-min-length=10 --body-pattern=".*" --max-parents=1

if [ $? -ne 0 ]
then
    if ! command -v $GITLINT_DIR &>/dev/null; then
        printError "$GITLINT_DIR not found. Please run 'make tools' OR 'make tools.verify.go-gitlint' make verto install it."
    fi
    printError "Please fix your commit message to match kubecub coding standards"
    printError "https://gist.github.com/cubxxw/126b72104ac0b0ca484c9db09c3e5694#file-githook-md"
    exit 1
fi

### Add Sign-off-by line to the end of the commit message
# Get local git config
NAME=$(git config user.name)
EMAIL=$(git config user.email)

# Check if the commit message contains a sign-off line
grep -qs "^Signed-off-by: " "$1"
SIGNED_OFF_BY_EXISTS=$?

# Add "Signed-off-by" line if it doesn't exist
if [ $SIGNED_OFF_BY_EXISTS -ne 0 ]; then
  echo -e "\nSigned-off-by: $NAME <$EMAIL>" >> "$1"
fi