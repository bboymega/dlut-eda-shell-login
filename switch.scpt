tell application "Terminal"
	do script "networksetup -setairportnetwork en0 DLUT-EDA"
	delay 3
	do script "eda"
	activate
	tell application "System Events"
		key code 12 using command down
	end tell
end tell
