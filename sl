#!/bin/bash
# Search for files that match all of the arguments.
results="$(tracker-search --disable-snippets "$@" | tail -n +2 | head -n-1)"
	# --disable-snippets to give concise results
	# The tail command to filter out the "Files:" line that is prepended
	# The head command to filter out the newline that is appended

# Redirect the file paths to stdout. This can be redirected to sl-accept.
 # Take every third line of the results, because those show the paths. Cut out the file:// part. We're going to use this var to create symlinks. Also cut out the invisible weird characters at the end that would have caused problems later on.
echo "$results" | cut -c 15- | rev | cut -c 5- | rev | perl -pe 's/%([0-9A-F]{2})/pack"H2",$1/gei'
	# cut -c 15- to get rid of the file:// at the beginning
	# rev | cut -c 5- | rev to get rid of the harmful invisible characters at the end
	# The perl command to percent-decode the result
