-- Run this with -> tshark -X lua_script:"/path/to/wireshark_lua_script.lua"
-- Also can be run with -> tshark -X lua_script:"/path/to/wireshark_lua_script.lua" -X lua_script1:"REPLACE_THIS_WITH_YOUR_TARGET_IP_ADDRESS"

do
     local args = {...}
     captured_packets = 0;
     local function count_captured_packets_for_a_given_ip_address()
         for i,v in ipairs(args) do
             print("IP Address in arg" .. i .. " is: " .. v)
             local ip_address = tostring(v);
         end
         -- The following does not work, and I'm trying to figure out why. I want to take an IP address from an argument passed through a Terminal window.
         -- local wireshark_listener = Listener.new("frame","ip.addr == " .. ip_address)
         local wireshark_listener = Listener.new("frame","ip.addr == REPLACE_THIS_WITH_YOUR_TARGET_IP_ADDRESS")
         function wireshark_listener.reset()
             captured_packets = 0;
         end
         function wireshark_listener.packet(pinfo,tvb,ip)
             captured_packets = captured_packets + 1
         end
         function wireshark_listener.draw()
             print("Number of packets captured for a given IP address: ",captured_packets)
         end
     end
     count_captured_packets_for_a_given_ip_address()
end