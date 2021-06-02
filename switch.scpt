# DLUT-EDA login information
set user_name to "username"
set pass_word to "password"

# choose your favorite icon under icon_path
set icon_path to "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/"
set icon_local_path to "AlertStopIcon.icns"
# set icon_local_path to "BurningIcon.icns"
# set icon_local_path to "ConnectToIcon.icns"
# set icon_local_path to "com.apple.macbookpro-13-retina-display.icns"
# set icon_local_path to "com.apple.macmini-unibody.icns"
# set icon_local_path to "com.apple.macpro-2019.icns"
# set icon_local_path to "com.apple.macpro-cylinder.icns"
# set icon_local_path to "com.apple.pro-display-xdr.icns"
# set icon_local_path to "ExecutableBinaryIcon.icns"

# run shell script
set network_adapter to do shell script "networksetup -listallhardwareports | grep Wi-Fi -A 1 | grep Device | awk '{print $2}'"
do shell script "networksetup -setairportnetwork " & network_adapter & " DLUT-EDA"
delay 3
set curr_SSID to do shell script "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'"
if curr_SSID = "DLUT-EDA" then
	# tell application "Terminal"
	do shell script ("curl -s --connect-timeout 10 --header \"Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9\" --compressed --header \"Accept-Language: en-US,en;q=0.9\" --header \"Cache-Control: max-age=0\" --header \"Connection: keep-alive\" --header \"Origin: http://172.20.20.1:801\" --header \"Referer: http://172.20.20.1:801/srun_portal_pc.php?ac_id=3&\" --header \"Upgrade-Insecure-Requests: 1\" --user-agent \"Mozilla/5.0 (Windows; U; Windows NT 4.0) AppleWebKit/533.43.4 (KHTML, like Gecko) Version/4.0.5 Safari/533.43.4\" --data-binary \"action=login&ac_id=3&user_ip=&nas_ip=&user_mac=&url=&username=" & user_name & "&password=" & pass_word & "\" \"http://172.20.20.1:801/srun_portal_pc.php?ac_id=3&\" > /dev/null")
	# end tell
	set state_code to do shell script "curl -s -w %{http_code} --connect-timeout 5 \"https://www.google.cn/generate_204\""
	# tell application "Terminal"
	# 	do script "curl -s -w %{http_code} --connect-timeout 5 \"https://www.google.cn/generate_204\""
	# end tell
	# set state_code to 204
	if state_code as number is equal to 204 then
		display notification "Successfully connected to DLUT-EDA"
	else
		display dialog ("Failed to connect to the Internet.
Please check the username and password and try again.") with icon POSIX file (icon_path & icon_local_path)
	end if
else
	display dialog ("Cannot switch to DLUT-EDA network" & "
" & "Please try again or check if Wi-Fi is available") with icon POSIX file (icon_path & icon_local_path)
end if
