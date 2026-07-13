#!/bin/bash

csrf=$(browser-cookie --chromium leetcode.com csrftoken)
sess=$(browser-cookie --chromium leetcode.com LEETCODE_SESSION)

echo "csrftoken=$csrf;LEETCODE_SESSION=$sess" | xclip -selection clipboard

notify-send "LeetCode" "Cookies copied to clipboard"
