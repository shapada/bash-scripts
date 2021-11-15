function fjxe() { journalctl -xe | fzf }
function fhis() { exec $( history | fzf | awk '{print $2 }' ) }
fzf-git-checkout() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    local branch

    branch=$(fzf-git-branch)
    if [[ "$branch" = "" ]]; then
        echo "No branch selected."
        return
    fi

    # If branch name starts with 'remotes/' then it is a remote branch. By
    # using --track and a remote branch name, it is the same as:
    # git checkout -b branchName --track origin/branchName
    if [[ "$branch" = 'remotes/'* ]]; then
        git checkout --track $branch
    else
        git checkout $branch;
    fi
}
fzf-git-branch() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=-committerdate |
        grep -v HEAD |
        fzf --height 50% --ansi --no-multi --preview-window right:65% \
            --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
        sed "s/.* //"
}

function fuzzy-pass() {
  DIR=$(pwd)
  cd "${HOME}/.password-store"
  PASSFILE=$(tree -Ffi | grep '.gpg' | sed 's/.gpg$//g' | sed 's/^..//' | fzf)

  [ -z "$PASSFILE" ] && return 0

  PASSDATA="$(pass ${PASSFILE})"
  PASS="$(echo "${PASSDATA}" | head -n 1)"
  LOGIN="$(echo "${PASSDATA}" | egrep -i "login:|username:|user:" | head -n 1 | cut -d' ' -f2-)"
  if [ -z "${LOGIN}" ] && [ -n "${PASS}" ]; then
    LOGIN=${PASSFILE##*/}
  fi
  EMAIL="$(echo "${PASSDATA}" | egrep -i "email:" | head -n 1 | cut -d' ' -f2-)"
  URL="$(echo "${PASSDATA}" | egrep -i "url:" | cut -d' ' -f2-)"
  if [ -z "${URL}" ]; then
    URL="$(basename $(dirname "${PASSFILE}"))"
    URL="$(echo "${URL}" | grep "\.")"
  fi

  cd ${DIR}

  ACTIONS="Edit\nFile"

  if [ -n "${URL}" ]; then
    ACTIONS="Url\n${ACTIONS}"
  fi
  if [ -n "${EMAIL}" ]; then
    ACTIONS="Email\n${ACTIONS}"
  fi
  if [ -n "${PASS}" ]; then
    ACTIONS="Password\n${ACTIONS}"
  fi
  if [ -n "${LOGIN}" ]; then
    ACTIONS="Login\n${ACTIONS}"
  fi

  CONTINUE=true

  while ${CONTINUE}; do
    ACTION=$(echo "${ACTIONS}" \
      | fzf --height 10 --border --header "Pass file ${PASSFILE}")
    case ${ACTION} in
      Login)
        echo "${LOGIN}" | clipcopy
        echo "Copied Login '${LOGIN}' to clipboard"
        ;;
      Password)
        pass --clip "${PASSFILE}" 1>/dev/null
        echo "Copied Password to clipboard (clear in 45 seconds)"
        ;;
      Url)
        echo "${URL}" | clipcopy
        echo "Copied Url '${URL}' to clipboard"
        ;;
      File)
        pass "${PASSFILE}"
        ;;
      Email)
        echo "${EMAIL}" | clipcopy
        echo "Copied Email '${EMAIL}' to clipboard"
        ;;
      Edit)
        pass edit "${PASSFILE}"
        ;;
      *)
        CONTINUE=false
        ;;
    esac
  done
}

# Same as above, but with previews and works correctly with man pages in different sections.
function fman() {
    man -k . | fzf -q "$1" --prompt='man> '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}
