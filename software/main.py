# import wifimgr
import clock
import wifimgr

wlan = wifimgr.get_connection()
if wlan:
    print("WiFi OK")
else:
    print("No WiFis")


# Main Code goes here, wlan is a working network.WLAN(STA_IF) instance.
print("ESP OK")

clock.start()
