#!/usr/bin/env sh
#
# Ping Identity DevOps - Docker Build Hooks
#
#- This script is used to import any configurations that are
#- needed after PingAccess starts

# shellcheck source=../../../../pingcommon/opt/staging/hooks/pingcommon.lib.sh
. "${HOOKS_DIR}/pingcommon.lib.sh"

if test "${OPERATIONAL_MODE}" = "CLUSTERED_CONSOLE" || test "${OPERATIONAL_MODE}" = "STANDALONE"
then
    echo "INFO: waiting for PingFederate to start before importing configuration"
    wait-for localhost:9999 -t 200 -- echo PingFederate is up
    test ${?} -ne 0 && kill 1
fi

if test "${OPERATIONAL_MODE}" = "CLUSTERED_CONSOLE"
then
    echo "Bringing eth0 back up..."
    ip link set eth0 up
fi
