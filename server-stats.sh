#!/bin/bash
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | sed 's/id,//')
cpu_usage=$(echo "100 - $cpu_idle" | bc)
echo "Total CPU Usage: $cpu_usage%"
 
mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_percent=$(echo "scale=2; $mem_used/$mem_total*100" | bc)
echo "Memory Usage: $mem_used/$mem_total MB ($mem_percent%)"

disk_used=$(df -h / | awk 'NR==2 {print $3}')
disk_total=$(df -h / | awk 'NR==2 {print $2}')
disk_percent=$(df -h / | awk 'NR==2 {print $5}')
echo "Disk Usage: $disk_used/$disk_total ($disk_percent)"

echo "Top 5 Processes by CPU:"
ps aux --sort=-%cpu | head -n 7

echo "Top 5 Processes by Memory:"
ps aux --sort=-%mem | head -n 6
