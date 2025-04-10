 #!/bin/bash
# Real-time monitoring dashboard

use std::fs::OpenOptions;
use std::io::Write;

pub fn log_event(message: &str) {
    let mut file = OpenOptions::new()
        .create(true)
        .append(true)
        .open("system_log.txt")
        .unwrap();
    writeln!(file, "{}", message).unwrap();
}

watch -n 1 -c '
    echo "=== TURU SYSTEM STATUS ==="
    echo "CPU: $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk "{print 100 - \$1}")%"
    echo "MEM: $(free -m | awk "/Mem/ {print $3}")MB Used"
    echo "TEMP: $(vcgencmd measure_temp | cut -d= -f2)"
    echo "AI REQUESTS: $(journalctl -u turu-ai | grep "Processed request" | wc -l)"
    echo "ACTIVE MODE: $(pgrep -a main_module | grep -oP "Entering \K\w+")"
'