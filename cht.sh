#!/usr/bin/env bash
languages=`echo "golang lua typescript javascript nodejs" | tr ' ' '\n'`
core_utils=`echo "xargs find mv" | tr ' ' '\n'`

selected=`printf "$languages\n" | fzf`
read -p "query: " query

tmux neww bash -c "curl cht.sh/$selected/`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done"
