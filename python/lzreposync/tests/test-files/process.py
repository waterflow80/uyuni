
import re

with open("available-packages-update-leap-15.txt", "r") as f:
    content = f.read()
    content = content.replace("\'", "\"")

with open("available-packages-update-leap-15.json", "w") as f:
    f.write(content)
