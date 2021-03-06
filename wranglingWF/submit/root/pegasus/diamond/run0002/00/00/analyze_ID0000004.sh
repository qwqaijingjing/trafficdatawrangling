#!/bin/bash
set -e
pegasus_lite_version_major="4"
pegasus_lite_version_minor="8"
pegasus_lite_version_patch="2"
pegasus_lite_enforce_strict_wp_check="true"
pegasus_lite_version_allow_wp_auto_download="true"

. pegasus-lite-common.sh

pegasus_lite_init

# cleanup in case of failures
trap pegasus_lite_signal_int INT
trap pegasus_lite_signal_term TERM
trap pegasus_lite_unexpected_exit EXIT

echo -e "\n########################[Pegasus Lite] Setting up workdir ########################"  1>&2
# work dir
export pegasus_lite_work_dir=$PWD
pegasus_lite_setup_work_dir

echo -e "\n##############[Pegasus Lite] Figuring out the worker package to use ##############"  1>&2
# figure out the worker package to use
pegasus_lite_worker_package

set +e
job_ec=0
echo -e "\n######################[Pegasus Lite] Executing the user task ######################"  1>&2
pegasus-kickstart -n analyze -N ID0000004 -R condorpool  -L diamond -T 2018-06-15T18:45:43+01:00 /home/qh/Diamond/bin/analyze -i f.c1 -i f.c2 -o f.d
job_ec=$?

set -e


# clear the trap, and exit cleanly
trap - EXIT
pegasus_lite_final_exit

