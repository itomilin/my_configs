#!/bin/bash

echo "scale=3;`cat /sys/class/power_supply/BAT0/energy_full` / `cat /sys/class/power_supply/BAT0/energy_full_design` * 100" | bc -l
