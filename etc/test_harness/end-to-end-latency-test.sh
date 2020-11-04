#!/bin/sh

usage () {
   echo "usage: ./runEndToEndLatency.sh [NoOfLatencyTest] [ListOfSevers(, separated) in host:port format]"
}

if [[ $# -lt 2 ]]; then
 echo "EXPERIMENT FAILED: Specify number of producers to run"
 usage
 exit
fi

NO_OF_LATENCYTEST=$1
SERVER_LIST=$2
TOPIC="test-latency"

RESULTS_DIR=endToEndLatencyLog

if [ -d $RESULTS_DIR ]; then
 rm -rf $RESULTS_DIR
fi

mkdir -p $RESULTS_DIR

for i in `seq 1 $NO_OF_LATENCYTEST`;
do
    echo ""
    echo "Running EndToEndLatency : $i th"
    kafka-run-class kafka.tools.EndToEndLatency "$SERVER_LIST" "$TOPIC" 100000 1 254 > $RESULTS_DIR/eLog-$i.txt 2>&1 &
done;
