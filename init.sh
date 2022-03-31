#!/bin/bash

jackd --name scjack -d dummy &
dbus-run-session sclang /opt/booter.scd &
#dbus-run-session scsynth -t 58009 -a 1022 -i 0 -o 2 -B 0.0.0.0 -H "scjack:supercollider" -R 0 -l 10 -B 0.0.0.0 &
darkice 
