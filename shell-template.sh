#! /usr/bin/env bash
#
# Author: Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
#/ Usage: SCRIPTNAME [OPTIONS]... [ARGUMENTS]...
#/
#/ 
#/ OPTIONS
#/   -h, --help
#/                Print this help message
#/
#/ EXAMPLES
#/  


#{{{ Bash settings
# abort on nonzero exitstatus>
set -o errexit
# abort on unbound variable>
set -o nounset
# don't hide errors within pipes
set -o pipefail
#}}}
#{{{ Variables
readonly script_name=$(basename "${0}")
readonly script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
IFS=$'\t\n'   # Split on newlines and tabs (but not on spaces)

#}}}

main() {
 while getopts ":h" option; do
    case $option in
        h) 
            echo 'hold'
            exit;;
        
    esac
 done
}

#{{{ Helper functions



#}}}

main "${@}"

# cursor: 33 del