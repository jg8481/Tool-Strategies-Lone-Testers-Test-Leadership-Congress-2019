import os
import time
import psutil
import requests

# Location of default Charles Proxy configuration on MacOS -> /Users/jgorospe/Library/Preferences
# This Charles Proxy library is already set up for a MacOS environment, but this could also work on Windows or Linux.

charles_proxy_application_path = "/Applications/Charles.app/Contents/MacOS/"
charles_proxy_configuration_file_path = "/REPLACE-THIS-WITH-YOUR-SPECIFIC-FILE-PATH/Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019/Workshop-Examples/Tests/Workshop-Part-Two/Resources/"
original_raw_charles_proxy_session_file_path = "/REPLACE-THIS-WITH-YOUR-SPECIFIC-FILE-PATH/Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019/Workshop-Examples/Tests/Workshop-Part-Two/Resources/"
converted_json_charles_proxy_session_file_path = "/REPLACE-THIS-WITH-YOUR-SPECIFIC-FILE-PATH/Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019/Workshop-Examples/Tests/Workshop-Part-Two/Resources/"

local_machine_url_requests_proxy = {'http': 'http://0.0.0.0:8888/'}
charles_proxy_start_recording_url = "http://control.charles/recording/start"
charles_proxy_stop_recording_url = "http://control.charles/recording/stop"
charles_proxy_download_recording_url = "http://control.charles/session/download"

def start_charles_proxy_in_headless_mode():
    os.system(charles_proxy_application_path + "Charles" + " -headless -config " + charles_proxy_configuration_file_path + "com.xk72.generic.charles.config" + " &")
    time.sleep(4)

def start_charles_proxy_session_recording():
    start = requests.get(charles_proxy_start_recording_url, proxies=local_machine_url_requests_proxy)
    return start

def stop_charles_proxy_session_recording():
    stop = requests.get(charles_proxy_stop_recording_url, proxies=local_machine_url_requests_proxy)
    return stop

def download_charles_proxy_session_recording():
    download = requests.get(charles_proxy_download_recording_url, proxies=local_machine_url_requests_proxy)
    open(original_raw_charles_proxy_session_file_path + "original-raw-session-file.chls", 'wb').write(download.content)

def convert_recorded_session_file():
    os.system(charles_proxy_application_path + "Charles" + " convert" + " " + original_raw_charles_proxy_session_file_path + "original-raw-session-file.chls" + " " + converted_json_charles_proxy_session_file_path + "new-json-session-file.chlsj")

def terminate_all_charles_proxy_sessions():
    for process in psutil.process_iter():
        if process.name() == "Charles":
            process.kill()
