#!/bin/bash
case "$(curl -s --max-time 2 -I http://connectivitycheck.gstatic.com/generate_204 | sed 's/^[^ ]* *\([0-9]\).*/\1/; 1q')" in
[23]) exit ;;
5) $(dirname "$0")/dlut_eda_login.sh -u "" -p "" #fill the -u with username and -p with password
*) $(dirname "$0")/dlut_eda_login.sh -u "" -p "" #fill the -u with username and -p with password
esac
