#!/bin/bash
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CSV="$PROJECT_DIR/data/seat_checkins.csv"
REPORT="$PROJECT_DIR/reports/shift-report.txt"

if [ ! -f "$CSV" ]; then
    echo "ERROR: input file not found: $CSV" >&2
    echo "Shift report NOT generated." >&2
    exit 1
fi

mkdir -p "$PROJECT_DIR/reports"

total=$(tail -n +2 "$CSV" | grep -c .)
checked_in=$(awk -F, 'NR>1 && $5=="CHECKED_IN"' "$CSV" | wc -l)
pending=$(awk -F, 'NR>1 && $5=="PENDING"' "$CSV" | wc -l)
conflict=$(awk -F, 'NR>1 && $5=="CONFLICT"' "$CSV" | wc -l)
lab_a=$(awk -F, 'NR>1 && $2=="Lab-A"' "$CSV" | wc -l)
lab_b=$(awk -F, 'NR>1 && $2=="Lab-B"' "$CSV" | wc -l)
lab_c=$(awk -F, 'NR>1 && $2=="Lab-C"' "$CSV" | wc -l)

{
    echo "CampusLink Examination Center - Shift Readiness Report"
    echo "Generated: $(date '+%Y-%m-%d %H:%M:%S %z')"
    echo "Input file: $CSV"
    echo
    echo "Total check-in records (excluding header): $total"
    echo
    echo "Status totals:"
    echo "  CHECKED_IN: $checked_in"
    echo "  PENDING:    $pending"
    echo "  CONFLICT:   $conflict"
    echo
    echo "Records per lab:"
    echo "  Lab-A: $lab_a"
    echo "  Lab-B: $lab_b"
    echo "  Lab-C: $lab_c"
    echo
    echo "Duplicate lab-and-seat allocations:"
    dups=$(awk -F, 'NR>1 {k=$2","$3; c[k]++} END {for (k in c) if (c[k]>1) print k}' "$CSV")
    if [ -z "$dups" ]; then
        echo "  None found"
    else
        for key in $dups; do
            lab=${key%%,*}
            seat=${key##*,}
            echo "  Lab: $lab  Seat: $seat"
            awk -F, -v l="$lab" -v s="$seat" 'NR>1 && $2==l && $3==s {print "    Ticket " $1 "  Student " $4 "  Status " $5}' "$CSV"
        done
    fi
    echo
    echo "Disk usage of project directory:"
    echo "  Used:  $(du -sh "$PROJECT_DIR" | cut -f1)  ($PROJECT_DIR)"
    echo "  Free on filesystem: $(df -h "$PROJECT_DIR" | awk 'NR==2 {print $4}')"
} > "$REPORT"

echo "Report written to $REPORT"
exit 0
