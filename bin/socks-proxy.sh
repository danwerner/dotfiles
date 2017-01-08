#!/bin/sh
# Creates a new SOCKS5 proxy on the local port specified by -D, and
# forwards all connections to the specified host and port.
host=$1
shift

ssh -D 8080 $host -p 443 -N
