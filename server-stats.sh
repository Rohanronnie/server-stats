#!/bin/bash

DIVIDER="========================================"

echo "$DIVIDER"
echo "         SERVER PERFORMANCE STATS"
echo "$DIVIDER"

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage        : $CPU_USAGE%"

# Memory Usage
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
MEM_PCT=$(awk "BEGIN {printf \"%.1f\", ($MEM_USED/$MEM_TOTAL)*100}")
echo "Memory           : Total=${MEM_TOTAL}MB | Used=${MEM_USED}MB | Free=${MEM_FREE}MB | ${MEM_PCT}%"

# Disk Usage
DISK_TOTAL=$(df -h --total | grep "total" | awk '{print $2}')
DISK_USED=$(df -h --total | grep "total" | awk '{print $3}')
DISK_FREE=$(df -h --total | grep "total" | awk '{print $4}')
DISK_PCT=$(df -h --total | grep "total" | awk '{print $5}')
echo "Disk             : Total=$DISK_TOTAL | Used=$DISK_USED | Free=$DISK_FREE | $DISK_PCT"

# Stretch Goals
echo "OS Version       : $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '\"')"
echo "Uptime           : $(uptime -p)"
echo "Load Average     : $(uptime | awk -F'load average:' '{print $2}')"
echo "Logged-in Users  : $(who | wc -l)"
echo "Failed Logins    : $(grep 'Failed password' /var/log/auth.log 2>/dev/null | wc -l)"

echo "$DIVIDER"
echo "Top 5 Processes by CPU:"
ps aux --sort=-%cpu | awk 'NR>1 {printf "%-10s %-8s %-6s %s\n", $1, $2, $3, $11}' | head -5

echo "$DIVIDER"
echo "Top 5 Processes by Memory:"
ps aux --sort=-%mem | awk 'NR>1 {printf "%-10s %-8s %-6s %s\n", $1, $2, $4, $11}' | head -5

echo "$DIVIDER"
