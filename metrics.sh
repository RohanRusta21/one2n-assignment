#!/bin/bash
NODE_EXPORTER_URL=${NODE_EXPORTER_URL:-"http://$(minikube ip):9100/metrics"}
OUTPUT_DIR=${OUTPUT_DIR:-"/data/metrics"}
mkdir -p "$OUTPUT_DIR"
timestamp=$(date +"%Y%m%d%H%M%S") # In UTC
output_file="$OUTPUT_DIR/metrics_$timestamp.txt"
curl -s "$NODE_EXPORTER_URL" | grep -E "node_cpu_seconds_total|node_memory_Mem|node_disk" > "$output_file"
{
    echo "### CPU Metrics ###"
    grep "node_cpu_seconds_total" "$output_file"
    echo ""
    echo "### Memory Metrics ###"
    grep "node_memory_Mem" "$output_file"
    echo ""
    echo "### Disk Metrics ###"
    grep "node_disk" "$output_file"
} > temp_file && mv temp_file "$output_file"
echo "Metrics written to $output_file"