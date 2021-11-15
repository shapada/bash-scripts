#!/bin/sh

# fuzzy_cmd filters a command via fzf and launches it with lnch
# use it together with fuzzy_win like this: fuzzy_win fuzzy_cmd

compgen -c | sort -u | fzf