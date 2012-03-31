# sadasant ][
# arch script
# alsa script

import os, time, string

def alsa():
  arr = []
  arr.append("amixer set Master 11% unmute")
  arr.append("speaker-test -c 2 -l 1")
  
  for i in arr:
    pop = os.popen(i)
    print(pop.read())

alsa()
