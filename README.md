## Team -5 CampusLink Examination Centre - Linux support Case Study

Business Purpose

To ensure reliable and secure student check-in data collection by validating Linux operations, TCP receiver connectivity, incident handling, evidence preservation, and automated reporting in a controlled training environment.


Team members

- Member 1 – Mukul Raj: Linux workspace & permissions (folder hierarchy, starter files, hidden note, ownership and disk usage)
- Member 2 – Sarabojan Muthunathan: TCP networking & connectivity (host/IP, route, DNS basics, listener, port and process evidence)
- Member 3 – Saru Dharshini: Operations data & filtering (CSV statistics, status filtering, exceptions and cross-checks)
- Member 4 – Sanjay Rajamanickam: Incident investigation & evidence (controlled failures, receiver log, root causes and recovery)
- Member 5 – Shamini Balachandran: Bash scripts & final handover (availability check, operations report, failures and summary presentation)

Receiver configuration

- Host: 127.0.0.1
- Port: 9105

Incident summary

- EXM-901 (Check-in receiver stopped): with the listener stopped, a connection to 127.0.0.1:9105 failed with "Connection refused"; restarting the receiver restored the connection. Resolved.
- EXM-902 (Incorrect port configured): 127.0.0.1:9105 succeeded while 127.0.0.1:9150 was refused. Cause: configured-port mismatch (approved port is 9105). Resolved by using 9105.
- EXM-903 (Seat assignment conflict): Lab-A seat A01 is allocated to both STU-101 (T301) and STU-106 (T306). Open: STU-106 needs a different seat.
- EXM-904 (Evidence visibility): the hidden file .operations-note (shown with ls -la) says to use loopback networking only, preserve original evidence before troubleshooting, and not change real infrastructure or production data. Resolved.

Deliverables

Evidence, receiver log, two trainee-written shell scripts, final shift report.
 
