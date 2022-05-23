#!/usr/bin/env python

import os
import os.path

user_plugins = os.path.expanduser("~/.plugin-sys") # arbitrary name
if os.path.exists(user_plugins):
    plugins = os.listdir(user_plugins)
    for plugin in plugins:
        __path__.append(os.path.join(user_plugins, plugin))
