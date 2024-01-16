=======================================================================
# This is a pre-commit hook that ensures attempts to commit files that are
# are larger than $limit to your _local_ repo fail, with a helpful error message.

# You can override the default limit of 2MB by supplying the environment variable:
# GIT_FILE_SIZE_LIMIT=2000000 git commit -m "test: this commit is allowed file sizes up to 50MB"
# GIT_FILE_SIZE_LIMIT=2000000 git commit -m "test: this commit is allowed file sizes up to 50MB"
#
# ==============================================================================\nchmod 755 scripts/githooks/pre-commit.sh
#
=======
new line(s) to replace
new line(s) to append to snippet 0
# flutter format .
# flutter format .


# This is a pre-commit hook that ensures attempts to commit files that are
# are larger than $limit to your _local_ repo fail, with a helpful error message.

# You can override the default limit of 2MB by supplying the environment variable:
# GIT_FILE_SIZE_LIMIT=2000000 git commit -m "test: this commit is allowed file sizes up to 50MB"
# GIT_FILE_SIZE_LIMIT=2000000 git commit -m "test: this commit is allowed file sizes up to 50MB"
#
# ==============================================================================
#




local_branch="$(git rev-parse --abbrev-ref HEAD)"
valid_branch_regex="^(main|master|develop|release(-[a-zA-Z0-9._-]+)?)$|(feature|feat|openim|hotfix|test|bug|bot|refactor|revert|ci|cicd|style|)\/[a-z0-9._-]+$|^HEAD$"







   
}


   
}
 

   
}



# flutter format .




limitInMB=$(( $limit / 1000000 ))

function file_too_large(){
	chmod 755 $0
filename=$0
#!/bin/bash
	filesize=$(( $1 / 2**20 ))

	filesize=$(( $1 \/ 2**20 ))\ncat <<HEREDOC# flutter format .
# flutter format .
# flutter format .
# flutter format .
# flutter format .
# flutter format .
# flutter format .
new line(s) to replace