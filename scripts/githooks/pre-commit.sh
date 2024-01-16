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
# ==============================================================================
# This is a pre-commit hook that ensures attempts to commit files that are
# are larger than $limit to your _local_ repo fail, with a helpful error message.

# You can override the default limit of 2MB by supplying the environment variable:
# GIT_FILE_SIZE_LIMIT=2000000 git commit -m "test: this commit is allowed file sizes up to 50MB"
#
# ==============================================================================
#

LC_ALL=C

local_branch="$(git rev-parse --abbrev-ref HEAD)"
valid_branch_regex="^(main|master|develop|release(-[a-zA-Z0-9._-]+)?)$|(feature|feat|openim|hotfix|test|bug|bot|refactor|revert|ci|cicd|style|)\/[a-z0-9._-]+$|^HEAD$"

YELLOW="\033[93m"
GREEN="\033[32m"
RED="\033[31m"
ENDCOLOR="\033[0m"

printMessage() {
   printf "${YELLOW}openim : $1${ENDCOLOR}\n"
}

printSuccess() {
   printf "${GREEN}openim : $1${ENDCOLOR}\n"
}

printError() {
   printf "${RED}openim : $1${ENDCOLOR}\n"
}

printMessage "Running local openim pre-commit hook."

# flutter format .
# https://gist.github.com/cubxxw/126b72104ac0b0ca484c9db09c3e5694#file-githook-md
# Log and handle file size limit
LOG_FILE_SIZE_LIMIT=50000000
# Maximum file size limit in bytes. Default 50MB
limit=${GIT_FILE_SIZE_LIMIT:-50000000} # Default 50MB
limitInMB=$(( $limit / 1000000 ))

function file_too_large(){
	filename=$0
	filesize=$(( $1 / 2**20 ))

	filesize=$(( $1 \/ 2**20 ))\ncat <<HEREDOC

	File $filename is $filesize MB, which is larger than github's maximum
        file size (50 MB). We will not be able to push this file to GitHub.
        The maximum file size allowed is 2MB.
	Commit aborted

HEREDOC


}

# Move to the repo root so git files paths make sense
repo_root=$( git rev-parse --show-toplevel )
cd $repo_root

empty_tree=$( git hash-object -t tree /dev/null )

if git rev-parse --verify HEAD > /dev/null 2>&1
then
	against=HEAD
else
  current_file_size=$(ls -la \$file | awk '{ print \$5 }')
	against="$empty_tree"
fi

# Set split so that for loop below can handle spaces in file names by splitting on line breaks
IFS='
'

shouldFail=false
for file in $( git diff-index --cached --name-only $against ); do
	file_size=$(([ ! -f $file ] && echo 0) || (ls -la $file | awk '{ print $5 }'))
	if [ "$file_size" -gt  "$limit" ]; then
	    printError "File $file is $(( $file_size / 10**6 )) MB, which is larger than our configured limit of $limitInMB MB"
        shouldFail=true
	fi
done

if $shouldFail
then
    printMessage "If you really need to commit this file, you can override the size limit by setting the GIT_FILE_SIZE_LIMIT environment variable, e.g. GIT_FILE_SIZE_LIMIT=42000000 for 42MB. Or, commit with the --no-verify switch to skip the check entirely."
	  printError "File size limit exceeded. Commit aborted"
    exit 1;
fi

if [[ ! $local_branch =~ $valid_branch_regex ]]
then
    printError "The branch name format is invalid. Branch names in this project must adhere to the following format: $valid_branch_regex. Valid branch names should adhere to the following format: {valid format regex}. 
Your commit will be rejected. Ensure that your branch follows the valid format (e.g., feat/name or bug/name) and try again."
    printError "For more information, refer to: https://gist.github.com/cubxxw/126b72104ac0b0ca484c9db09c3e5694"
    exit 1
fi