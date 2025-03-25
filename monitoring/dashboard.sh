#!/bin/bash
# Real-time monitoring dashboard

watch -n 1 -c '
    echo "=== TURU SYSTEM STATUS ==="
    echo "CPU: $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk "{print 100 - \$1}")%"
    echo "MEM: $(free -m | awk "/Mem/ {print $3}")MB Used"
    echo "TEMP: $(vcgencmd measure_temp | cut -d= -f2)"
    echo "AI REQUESTS: $(journalctl -u turu-ai | grep "Processed request" | wc -l)"
    echo "ACTIVE MODE: $(pgrep -a main_module | grep -oP "Entering \K\w+")"
'