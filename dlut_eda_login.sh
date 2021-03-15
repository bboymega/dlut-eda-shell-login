#!/bin/bash
logout=2
while getopts u:p:o flag
do
    case "${flag}" in
        u) username=${OPTARG} && logout=0;;
        p) password=${OPTARG} && logout=0;;
        o) logout=1;;
    esac
done

auth()
{
    echo "Trying  to login as username: ${username}"
    curl -s --connect-timeout 10 --header "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9" --compressed --header "Accept-Language: en-US,en;q=0.9" --header "Cache-Control: max-age=0" --header "Connection: keep-alive" --header "Origin: http://172.20.20.1:801" --header "Referer: http://172.20.20.1:801/srun_portal_pc.php?ac_id=3&" --header "Upgrade-Insecure-Requests: 1" --user-agent "Mozilla/5.0 (Windows; U; Windows NT 4.0) AppleWebKit/533.43.4 (KHTML, like Gecko) Version/4.0.5 Safari/533.43.4" --data-binary "action=login&ac_id=3&user_ip=&nas_ip=&user_mac=&url=&username=${username}&password=${password}" "http://172.20.20.1:801/srun_portal_pc.php?ac_id=3&" > /dev/null

    echo "Checking Internet connection..."
    stat_code=0
    stat_code=$(curl -s -w %{http_code} --connect-timeout 5 "https://www.google.cn/generate_204")
    if [ "${stat_code}" -eq "204" ]; then echo "Internet connected."
        else echo "Failed to connect to the Internet. Please check the username and password and try again."
    fi
}

unauth()
{
    stat_code=$(curl -s --connect-timeout 5 --compressed --header "Accept-Language: en-US,en;q=0.9" --header "Connection: keep-alive" --header "Origin: http://172.20.20.1:801" --header "Referer: http://172.20.20.1:801/srun_portal_pc.php?ac_id=3&" --user-agent "Mozilla/5.0 (Windows; U; Windows NT 4.0) AppleWebKit/533.43.4 (KHTML, like Gecko) Version/4.0.5 Safari/533.43.4" --header "X-Requested-With: XMLHttpRequest" --data-binary "action=logout&username=&password=&ajax=1" "http://172.20.20.1:801/include/auth_action.php")
    if [ "${stat_code}" ==  "网络已断开" ]; then
    echo "Successfully logged out."
  else if [ "${stat_code}" ==  "您似乎未曾连接到网络..." ]; then
      echo "You're not logged in. Logout failed."
    else echo "Couldn't establish a connection to the authentication server. Logout failed."
      fi
    fi
}

if [ ${logout} -eq 0 ]; then auth
  else if [ ${logout} -eq 1 ]; then unauth
  else echo "Missing Parameters."
  fi
fi
