#!/bin/bash


#setup local thread spawn for testing 
export CHPL_COMM=gasnet
export CHPL_COMM_DEBUG=on
export CHPL_COMM_SUBSTRATE=udp
export GASNET_SPAWNFN=L
export GASNET_VERBOSEENV=1


#if using the UDP conduit
export CHPL_COMM_SUBSTRATE=udp
export GASNET_SSH_OPTIONS="-o LogLevel=Error"
export GASNET_QUIET=yes


#make chapel 
make
make check
