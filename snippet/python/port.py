#!/usr/bin/env python

import base64
import io
import sys
import tempfile
import zipfile

main = ""  # main needs to be a b64 encoded string of the script to embed
data = io.BytesIO(base64.b64decode(main))
zf = zipfile.ZipFile(data)

with tempfile.TemporaryDirectory() as temp_path:
    zf.extractall(temp_path)

    sys.path.insert(0, temp_path)

    # see above comment regarding this example:
    ##
    ## from swaj.app import main
    ## main()
