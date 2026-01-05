#!/bin/bash
#Author: Alex Terranova 2026
#TITLE: Search All Android Termux

string=""
searchstringbefore=""
sdcardpath=""
internalpath=""
cd ~/storage
string="$(ls -la -l 2>&1)"
if [[ "$string" == *"external-1"* ]]; then
searchstringbefore=$(ls -la | grep -m1 -oP '[A-Z0-9+\-]{9}' )
fi
sdcardpath="/storage/$searchstringbefore"
internalpath="/storage/emulated/0"


tmux new-session -d -s work

# Split the right pane vertically
tmux split-window -v

#tmux send-keys -t $work:0.0 "q" C-m
tmux send-keys -t $work:0.0 "cd $internalpath" C-m
tmux send-keys -t $work:0.0 "fzf" C-m
#tmux send-keys -t $work:0.1 "q" C-m
tmux send-keys -t $work:0.1 "cd $sdcardpath" C-m
tmux send-keys -t $work:0.1 "fzf" C-m




# Attach to the session
tmux attach-session -t work



wait
read -n 1 -s -r -p