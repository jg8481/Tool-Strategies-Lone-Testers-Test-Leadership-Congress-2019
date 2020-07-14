import os
import time
import psutil
import requests

# Location of default Charles Proxy configuration on MacOS -> /Users/jgorospe/Library/Preferences
# This Charles Proxy library is already set up for a MacOS environment, but this could also work on Windows or Linux.

charles_proxy_application_path = "/Applications/Charles.app/Contents/MacOS/"

local_machine_url_requests_proxy = {'http': 'http://0.0.0.0:8888/'}
charles_proxy_start_recording_url = "http://control.charles/recording/start"
charles_proxy_stop_recording_url = "http://control.charles/recording/stop"
charles_proxy_download_recording_url = "http://control.charles/session/download"

def start_charles_proxy_in_headless_mode():
    current_working_directory = os.getcwd()
    charles_proxy_configuration_file_path = os.path.join(current_working_directory, "Workshop-Examples", "Tests", "Workshop-Part-Two", "Resources", "com.xk72.generic.charles.config")
    os.system(charles_proxy_application_path + "Charles" + " -headless -config " + charles_proxy_configuration_file_path + " &")
    time.sleep(4)

def start_charles_proxy_session_recording():
    start = requests.get(charles_proxy_start_recording_url, proxies=local_machine_url_requests_proxy)
    return start

def stop_charles_proxy_session_recording():
    stop = requests.get(charles_proxy_stop_recording_url, proxies=local_machine_url_requests_proxy)
    return stop

def download_charles_proxy_session_recording():
    current_working_directory = os.getcwd()
    original_raw_charles_proxy_session_file_path = os.path.join(current_working_directory, "Workshop-Examples", "Tests", "Workshop-Part-Two", "Resources", "original-raw-session-file.chls")
    download = requests.get(charles_proxy_download_recording_url, proxies=local_machine_url_requests_proxy)
    open(original_raw_charles_proxy_session_file_path, 'wb').write(download.content)

def convert_recorded_session_file():
    current_working_directory = os.getcwd()
    original_raw_charles_proxy_session_file_path = os.path.join(current_working_directory, "Workshop-Examples", "Tests", "Workshop-Part-Two", "Resources", "original-raw-session-file.chls")
    converted_json_charles_proxy_session_file_path = os.path.join(current_working_directory, "Workshop-Examples", "Tests", "Workshop-Part-Two", "Resources", "new-json-session-file.chlsj")
    os.system(charles_proxy_application_path + "Charles" + " convert" + " " + original_raw_charles_proxy_session_file_path + " " + converted_json_charles_proxy_session_file_path)

def terminate_all_charles_proxy_sessions():
    for process in psutil.process_iter():
        if process.name() == "Charles":
            process.kill()

