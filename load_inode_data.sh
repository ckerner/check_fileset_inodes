#!/bin/bash

CFICFG=/etc/cfi/cfi.cfg

CLUSTER=$(grep 'gpfs_cluster' ${CFICFG} | awk '{print($3)}')
METRIC=$(grep 'influx_metric' ${CFICFG} | awk '{print($3)}')
FILEDIR=$(grep 'influx_output' ${CFICFG} | awk '{print($3)}')
FILES="${FILEDIR}/${CLUSTER}.${METRIC}"
#echo "* ${CLUSTER} * ${METRIC} * ${FILEDIR} * ${FILES} *"

for F in $(ls ${FILES}*)
    do chmod +x ${F}
    #echo ${F}
    ${F}
    RC=$?
    if [ ${RC} -gt 0 ] ; then
       echo "Error: ${RC} on ${F}"
    else
       rm -f ${F}
    fi
done

