import re
import fileinput

pattern = re.compile(".*\*/ 0x(\w+), 0x(\w+), /*")
for l in fileinput.input():
    m = pattern.match(l)
    if m:
        g = m.groups()
        print " " + " ".join(g)
