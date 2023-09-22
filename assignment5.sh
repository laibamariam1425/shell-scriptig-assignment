#!/bin/bash

# Define the file paths for storing metrics and statistics
metrics_file="metrics.txt"
stats_file="statistics.txt"

# Create or clear the metrics file
> "$metrics_file"

# Function to collect and record CPU and memory metrics
collect_metrics() {
    while true; do
        # Get the current date and time
        timestamp=$(date "+%d %b %Y %I:%M%p")

        # Collect CPU and memory utilization values
        memory_utilization=$(free | awk '/Mem/{print int($3/$2*100)}')
        cpu_utilization=$(top -bn1 | awk '/%Cpu/{print int($2)}')

        # Append metrics to the metrics file
        echo "$timestamp Memory:$memory_utilization% CPU:$cpu_utilization%" >> "$metrics_file"

        # Sleep for 5 minutes before the next measurement
        sleep 300
    done
}

# Function to calculate and record statistics
calculate_statistics() {
    while true; do
        # Get the current date and time
        start_time=$(date "+%d %b %Y %I:%M%p")

        # Sleep for 30 minutes (to accumulate enough data for statistics)
        sleep 1800

        # Get the end time for statistics
        end_time=$(date "+%I:%M%p")

        # Calculate statistics for memory utilization
        memory_average=$(awk '{sum += $4} END {print sum/NR}' RS="[ %\n]" "$metrics_file")
        memory_min=$(awk -v min=100 '{if ($4 < min) min = $4} END {print min}' RS="[ %\n]" "$metrics_file")
        memory_max=$(awk -v max=0 '{if ($4 > max) max = $4} END {print max}' RS="[ %\n]" "$metrics_file")

        # Calculate statistics for CPU utilization
        cpu_average=$(awk '{sum += $6} END {print sum/NR}' RS="[ %\n]" "$metrics_file")
        cpu_min=$(awk -v min=100 '{if ($6 < min) min = $6} END {print min}' RS="[ %\n]" "$metrics_file")
        cpu_max=$(awk -v max=0 '{if ($6 > max) max = $6} END {print max}' RS="[ %\n]" "$metrics_file")

        # Append statistics to the statistics file
        echo "$start_time - $end_time Memory-Average-Utilization:$memory_average% Memory-Min-Utilization:$memory_min% Memory-Max-Utilization:$memory_max% CPU-Average-Utilization:$cpu_average% CPU-Min-Utilization:$cpu_min% CPU-Max-Utilization:$cpu_max%" >> "$stats_file"
    done
}

# Run both functions in the background
collect_metrics &
calculate_statistics &

# Wait for user to interrupt (e.g., with Ctrl+C)
echo "Monitoring metrics... Press Ctrl+C to stop."
wait 
