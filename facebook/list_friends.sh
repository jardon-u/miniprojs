lynx -dump "http://www.facebook.com/ajax/typeahead_friends.php?u=$1&__a=1" |gawk -F'"t":"' -v RS='",' 'RT{print }' | grep '"t"' | cut -d\" -f6