#!/bin/bash

set -x

CFICFG=/etc/cfi/cfi.cfg

CLUSTER=$(grep 'gpfs_cluster' ${CFICFG} | awk '{print($3)}')
METRIC=$(grep 'influx_metric' ${CFICFG} | awk '{print($3)}')
FILEDIR=$(grep 'influx_output' ${CFICFG} | awk '{print($3)}')
FILES="${FILEDIR}/${CLUSTER}.${METRIC}"
#echo "* ${CLUSTER} * ${METRIC} * ${FILEDIR} * ${FILES} *"

for F in $(ls ${FILES}*)
    do chmod +x ${F}
    #echo ${F}

    # Make a copy to send to set-analytics-2
    cat ${F} | sed -e 's/set-analytics.ncsa.illinois.edu/set-analytics-2.ncsa.illinois.edu/g' > ${F}.2
    chmod +x ${F}.2

    # Send the file to set-analytics
    ${F}
    RC=$?
    if [ ${RC} -gt 0 ] ; then
       echo "Error: ${RC} on ${F}"
    else
       rm -f ${F}
    fi

    # Send the file to set-analytics-2
    ${F}.2
    RC=$?
    if [ ${RC} -gt 0 ] ; then
       echo "Error: ${RC} on ${F}.2"
    else
       rm -f ${F}.2
    fi
done

