#!/usr/bin/env bash
#!/usr/bin/env bash
#!/usr/bin/env bash
#!/usr/bin/env bash
#!/usr/bin/env bash
#!/usr/bin/env bash
#!/usr/bin/env bash
#!/usr/bin/env bash
#!/usr/bin/env bash
# Set execute permissions for pre-commit script
&
c
h
# Modified to fix unknown webhook names issue
#!/usr/bin/env bash
#!/usr/bin/env bash
#!/usr/bin/env bash
#!/usr/bin/env bash

#!/usr/bin/env bash

#!/usr/bin/env bash
# Set execute permissions for pre-commit script
&
c
h
m
o
d
 
+
x
 
s
c
r
i
p
t
s
/
g
i
t
h
#!/usr/bin/env bash
o
k
s
/
p
r
e
-
c
o
m
m
i
t
.
sh

# Copyright © 2023 OpenIMSDK.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# chmod +x scripts/githooks/pre-commit.sh
Unless required by applicable law or agreed to in writing, software
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
# GIT_FILE_SIZE_LIMIT=2000000 git commit -m "test: this commit is allowed file sizes up to 50MB"
#
# ==============================================================================
#

export LC_ALL=C

local_branch="$(git rev-parse --abbrev-ref HEAD)"
valid_branch_regex="^(main|master|develop|release(-[a-zA-Z0-9._-]+)?)$|(feature|feat|openim|hotfix|test|bug|bot|refactor|revert|ci|cicd|style|)\/[a-z0-9._-]+$|^HEAD$"

YELLOW="\e[93m"
GREEN="\e[32m"
RED="\e[31m"
ENDCOLOR="\e[0m"

printMessage() {
   printf "${YELLOW}openim : $1${ENDCOLOR}\n"
}

printSuccess() {
   printf "${GREEN}openim : $1${ENDCOLOR}\n"
}

printError() {
   echo "Current working directory: $(pwd)"\nprintf "${RED}openim : $1${ENDCOLOR}\n"
}

printMessage "Running local openim pre-commit hook." "Running local openim pre-commit hook."


# https://gist.github.com/cubxxw/126b72104ac0b0ca484c9db09c3e5694#file-githook-md
# TODO! GIT_FILE_SIZE_LIMIT=2000000 git commit -m "test: this commit is allowed file sizes up to 50MB"
# Maximum file size limit in bytes (2MB)
#!/usr/bin/env bash
#!/usr/bin/env bash

function file_too_large(){
	filename=$0
	filesize=$(( $1 / 2**20 ))

	filesize=$(( $1 \/ 2**20 ))\ncat <<HEREDOC

	File $filename is $filesize MB, which is larger than github's maximum
        file size (2 MB). We will not be able to push this file to GitHub.
        The maximum file size allowed is 2MB.
	Commit aborted

HEREDOC

}

# Move to the repo root so git files paths make sense
repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
cd $repo_root



against=HEAD

# Set split so that for loop below can handle spaces in file names by splitting on line breaks
IFS='
'

shouldFail=false
echo "Current working directory: $(pwd)"
    
for file in $( git diff-index --cached --name-only $against ); do
	file_size=$(([ ! -f $file ] && echo 0) || (ls -la "$file" | awk '{ print $5 }'))
	if [ "$file_size" -gt  "$limit" ]; then
    

        
	    
        
	fi
done

if [ "$file_size" -gt "$GIT_FILE_SIZE_LIMIT" ]; then
    shouldFail=true
    file_too_large "$file" "$file_size"

if [ "$shouldFail" = true ]; then
fi
    
    printError "Commit aborted"
    echo "Current working directory: $(pwd)"
    exit 1
fi
then
    chmod +x $0
printMessage "If you really need to commit this file, you can override the size limit by setting the GIT_FILE_SIZE_LIMIT environment variable, e.g. GIT_FILE_SIZE_LIMIT=42000000 for 42MB. Or, commit with the --no-verify switch to skip the check entirely."
	  chmod +x scripts/githooks/pre-commit.sh\n    printError "Commit aborted"
    echo "Current working directory: $(pwd)"

fi

if [[ ! $local_branch =~ $valid_branch_regex ]]
then
    \n    echo "Current working directory: $(pwd)"
    chmod +x scripts/githooks/pre-commit.sh
    exit 1
    	printError "For more information, refer to: https://gist.github.com/cubxxw/126b72104ac0b0ca484c9db09c3e5694"
	chmod +x scripts/githooks/pre-commit.sh
    exit 1
fi