#!/bin/bash

source "${BASH_SOURCE%/*}/constants.sh"
source "${BASH_SOURCE%/*}/functions.sh"

FILEPATH='G:\123\456'
escapeWindowsPath "$FILEPATH"

createGitBranch "/g/Github/CVS" "Hello World"