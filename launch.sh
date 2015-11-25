#!/bin/sh
# The below will load the configuration (haystack.hs) from the current dir
stack exec haystack -- --dyre-debug

# The below will load the configuration (haystack.hs) from the system config dir
# On my system - ~/.config/haystack/haystack.hs
# stack exec haystack
