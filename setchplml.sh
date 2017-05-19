#!/bin/bash


#gasnet over ssh
export CHPL_COMM=gasnet
export CHPL_COMM_DEBUG=on
export GASNET_SPAWNFN=S
export GASNET_SSH_CMD=ssh
export GASNET_SSH_OPTIONS=-x
export GASNET_SSH_SERVERS="happymin@easley.cs.haverford.edu"
export GASNET_SSH_REMOTE_PATH="/ahome/happymin/chapel-1.14.0/examples"

#if using the UDP conduit
#export CHPL_COMM_SUBSTRATE=udp
#export CHPL_GASNET_SEGMENT=everything
export GASNET_SSH_OPTIONS="-o LogLevel=Error"
export GASNET_QUIET=yes


#make chapel 
make

