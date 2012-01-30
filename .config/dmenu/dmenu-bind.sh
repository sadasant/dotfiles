#!/bin/bash
exe=`dmenu_run -nb '#000000' -nf '#DDDDDD' -sb '#DDDDDD' -sf '#000000'` && eval "exec $exe"
