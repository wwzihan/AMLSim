#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "Usage: sh $0 [ConfJSON]"
    exit 1
fi

MIN_HEAP=${AMLSIM_MIN_HEAP:-8g}
MAX_HEAP=${AMLSIM_MAX_HEAP:-32g}

CONF_JSON=$1

if ! command -v mvn >/dev/null 2>&1
then
    echo 'maven not installed. proceeding.'
    java -Xms${MIN_HEAP} -Xmx${MAX_HEAP} -cp "jars/*:target/classes/" amlsim.AMLSim "${CONF_JSON}"
    exit
else
    echo 'maven is installed. proceeding'
    mvn exec:java -Dexec.mainClass=amlsim.AMLSim -Dexec.args="${CONF_JSON}"
fi

# Cleanup temporal outputs of AMLSim
rm -f outputs/_*.csv outputs/_*.txt outputs/summary.csv
