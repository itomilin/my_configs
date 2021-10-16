#!/usr/bin/python2.7

from subprocess import Popen, PIPE
import time

def is_charging():
    with open("/sys/class/power_supply/BAT0/status") as f:
        return True if f.read().strip('\n') == "Charging" else False

while True:
    with open("/sys/class/power_supply/BAT0/energy_now") as f:
        charge_now = float(f.read())
    with open("/sys/class/power_supply/BAT0/energy_full") as f:
        charge_full = float(f.read())

    percent = 100*charge_now/charge_full

    msg = "!!BATTERY LOW!!"
    if percent < 10 and not is_charging():
        while not is_charging():
            p = Popen(['osd_cat', '-A', 'center', '-p', 'middle', '-f', \
                       '-*-*-bold-*-*-*-96-120-*-*-*-*-*-*', '-cred', '-s', '5'], stdin=PIPE)
            p.communicate(input=msg)
            p.wait()

    time.sleep(60)
