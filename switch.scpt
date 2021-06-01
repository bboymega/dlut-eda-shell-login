do shell script "networksetup -setairportnetwork en0 DLUT-EDA"
delay 3
set user_name to "your username"
set pass_word to "your password"
do shell script ("
    curl -s --connect-timeout 10 --header \"Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9\" --compressed --header \"Accept-Language: en-US,en;q=0.9\" --header \"Cache-Control: max-age=0\" --header \"Connection: keep-alive\" --header \"Origin: http://172.20.20.1:801\" --header \"Referer: http://172.20.20.1:801/srun_portal_pc.php?ac_id=3&\" --header \"Upgrade-Insecure-Requests: 1\" --user-agent \"Mozilla/5.0 (Windows; U; Windows NT 4.0) AppleWebKit/533.43.4 (KHTML, like Gecko) Version/4.0.5 Safari/533.43.4\" --data-binary \"action=login&ac_id=3&user_ip=&nas_ip=&user_mac=&url=&username=" & user_name & "&password=" & pass_word & "\" \"http://172.20.20.1:801/srun_portal_pc.php?ac_id=3&\" > /dev/null
")
