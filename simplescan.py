#!/bin/python3

import argparse
import subprocess

def scan_ports(ip, ports):
    GREEN = '\033[92m'
    BOLD = '\033[1m'
    RESET = '\033[0m'
    if '-' in ports:
        start_port, end_port = ports.split('-')
        port_range = range(int(start_port), int(end_port) + 1)
    elif ',' in ports:
        port_range = [int(port) for port in ports.split(',')]
    else:
        port_range = [int(ports)]
    
    for port in port_range:
        result = subprocess.run(['proxychains', 'nc', '-zv','-w 1', ip, str(port)], capture_output=True, text=True)
        if 'OK' in result.stderr:
            print(f"{GREEN}{BOLD}Port {port} is open on {ip}{RESET}")
        else:
            print(f"Port {port} is closed on {ip}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="A simple port scanning tool using netcat over proxychains.")
    parser.add_argument("ip", help="The destination IP address to scan.")
    parser.add_argument("ports", help="The port(s) to scan (e.g., 80, 1-10, 22).")
    
    args = parser.parse_args()
    scan_ports(args.ip, args.ports)
