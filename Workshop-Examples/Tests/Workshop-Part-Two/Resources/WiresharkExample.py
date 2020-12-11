import os
import time
import psutil
import pyshark
import subprocess

# The "Wireshark Lua Script" keyword below is based on Lua examples found here -> https://www.wireshark.org/docs/wsdg_html_chunked/wsluarm.html
#
# Also here are steps for manually setting up your own SSLKEYLOGFILE in MacOS. More information can be found here -> https://wiki.wireshark.org/TLS?action=show&redirect=SSL
# export SSLKEYLOGFILE="/path/to/your/wireshark-sslkeys.log"
# Open a Terminal window and run the following to check the environment variable...
# echo $SSLKEYLOGFILE
# Then open a Firefox browser from the Terminal. More information can be found here for multiple operating systems. -> https://developer.mozilla.org/en-US/docs/Mozilla/Command_Line_Options
# /Applications/Firefox.app/Contents/MacOS/firefox

class WiresharkExample:
    ROBOT_LIBRARY_SCOPE = 'TEST'

    def wireshark_live_interface_packet_capture(self, interface: str, packet_count: int, timeout: int, case_insensitive: bool = False):
        live_capture = pyshark.LiveCapture(interface=interface)
        live_capture.sniff(timeout=timeout)
        live_capture.close()
        print('Total amount: ', live_capture)
        for captured_packets in live_capture.sniff_continuously(packet_count=packet_count):
            print('Recently captured through the live interface: ', captured_packets)
            return captured_packets


    def wireshark_live_interface_capture_to_file(self, interface: str, timeout: int):
        current_working_directory = os.getcwd()
        packet_capture_output_file_path = os.path.join(current_working_directory, "Workshop-Examples", "Tests", "Workshop-Part-Two", "Resources", "wireshark-packets-captured.cap")
        packet_capture_file = pyshark.LiveCapture(interface=interface,output_file=packet_capture_output_file_path)
        packet_capture_file.sniff(timeout=timeout)
        packet_capture_file.close()

    def wireshark_lua_script(self, filename: str, amount: str):
        current_working_directory = os.getcwd()
        lua_script_file_path = os.path.join(current_working_directory, "Workshop-Examples", "Tests", "Workshop-Part-Two", "Resources", filename)
        lua_script_output = subprocess.run(['tshark', '-X', 'lua_script:' + lua_script_file_path, '-c ' + amount], stdout=subprocess.PIPE)
        return lua_script_output.stdout

    def wireshark_decrypt_captured_ssl_traffic(self, filename: str, amount: str):
        current_working_directory = os.getcwd()
        packet_capture_output_file_path = os.path.join(current_working_directory, "Workshop-Examples", "Tests", "Workshop-Part-Two", "Resources", filename)
        tls_ssl_key_log_file_path = os.path.join(current_working_directory, "Workshop-Examples", "Tests", "Workshop-Part-Two", "Resources", "wireshark-sslkeys.log")
        tls_ssl_traffic_decrypted_output = subprocess.run(['tshark', '-nr' + packet_capture_output_file_path, '-o', 'tls.keylog_file:' + tls_ssl_key_log_file_path, '-c ' + amount], stdout=subprocess.PIPE)
        return tls_ssl_traffic_decrypted_output.stdout

    def terminate_all_wireshark_processes(self):
        for processes in psutil.process_iter():
            if any(procstr in processes.name() for procstr in\
                ['tshark', 'Wireshark', 'Wireshark.app']):
                processes.kill()
        for process in psutil.process_iter():
            if process.name() == "tshark":
                process.kill()



