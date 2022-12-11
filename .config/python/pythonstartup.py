#!/usr/bin/env python3

import atexit
import readline
import os

xdg_cache_home = os.environ['XDG_CACHE_HOME']
history_path = os.path.join(xdg_cache_home, 'python')
os.makedirs(history_path, exist_ok=True)
history_file = os.path.join(history_path, '.python_history')

try:
    readline.read_history_file(history_file)
    readline.set_history_length(1000)
except FileNotFoundError:
    pass

atexit.register(readline.write_history_file, history_file)
