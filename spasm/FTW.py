import random
import subprocess
import time

random.seed(100)


keys = ['Left','Up','Down','Right','x','space', 'z'] 

time.sleep(5)
for i in xrange(10000):
    subprocess.call(["xdotool", "key", random.choice(keys)])
