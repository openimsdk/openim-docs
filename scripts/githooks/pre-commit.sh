#!\/usr\/bin\/env bash
#!/usr/bin/env bash
chmod +x $0
chmod +x scripts/githooks/pre-commit.sh
#!/usr/bin/env bash
chmod +x scripts/githooks/pre-commit.sh
#!/usr/bin/env bash
chmod +x scripts/githooks/pre-commit.sh
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

YELLOW="\e[93m"
new line(s) to replace
# Removed unnecessary lines
# Removed unnecessary lines
        
	fi
done

if shouldFail
then
    printMessage "If you really need to commit this file, you can override the size limit by setting the GIT_FILE_SIZE_LIMIT environment variable, e.g. GIT_FILE_SIZE_LIMIT=42000000 for 42MB. Or, commit with the --no-verify switch to skip the check entirely."
	  printError "Commit aborted"
    exit 1;
fi

if [[ ! $local_branch =~ $valid_branch_regex ]]
then
    printError "The branch name format is invalid. Branch names in this project must adhere to the following format: $valid_branch_regex. Valid branch names should adhere to the following format: {valid format regex}.
Ensure that your branch follows the valid format (e.g., feat/name or bug/name) and try again.

For more information, refer to: https://gist.github.com/cubxxw/126b72104ac0b0ca484c9db09c3e5694"
    printError "For more information, refer to: https://gist.github.com/cubxxw/126b72104ac0b0ca484c9db09c3e5694"
    exit 1
fi