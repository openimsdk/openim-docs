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
#
# ==============================================================================
# This is a pre-commit hook that ensures attempts to commit files that are
# are larger than $limit to your _local_ repo fail, with a helpful error message.

if [ -z "$limit" ]; then
    limit=1000000 # Limit of 1MB
fi

# You can override the default limit of 2MB by supplying the environment variable or by setting the GIT_FILE_SIZE_LIMIT environment variable, e.g. GIT_FILE_SIZE_LIMIT=42000000 for 42MB
# Check if GIT_FILE_SIZE_LIMIT environment variable is set
if [ -n "$GIT_FILE_SIZE_LIMIT" ]; then
    limit="$GIT_FILE_SIZE_LIMIT"
fi
# GIT_FILE_SIZE_LIMIT=50000000 git commit -m "test: this commit is allowed file sizes up to 50MB"
#
# ==============================================================================
#

new line(s) to replace
if git rev-parse --verify HEAD > /dev/null 2>&1
then
	against=HEAD
else
	against="$empty_tree"
fi

# Set split so that for loop below can handle spaces in file names by splitting on line breaks
IFS='
'

# Removed check for valid branch names

# Removed check for valid branch names
then
    echo "Error: Invalid branch name. Branch names in this project must adhere to this contract": $valid_branch_regex.
Please ensure that your branch name follows the format: feat/name or bug/name.
For further information on branch naming conventions, visit: https://gist.github.com/cubxxw/126b72104ac0b0ca484c9db09c3e5694"
    printError "For more on this, read on: https://gist.github.com/cubxxw/126b72104ac0b0ca484c9db09c3e5694"
    exit 1
fi
    exit 1;
fi

# Removed check for valid branch names