#!/usr/bin/env python
"""See:
https://docs.python.org/3/howto/logging-cookbook.html#implementing-structured-logging
https://docs.python.org/3/library/logging.html#logging.LogRecord
https://stackoverflow.com/a/67953106/4844024
"""

import json
import logging


class Encoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, set):
            return tuple(o)
        elif isinstance(o, str):
            return o.encode('unicode_escape').decode('ascii')
        return super().default(o)


class StructuredMessage:
    def __init__(self, message, /, **kwargs):
        self.message = message
        self.kwargs = kwargs

    def __str__(self):
        s = Encoder().encode(self.kwargs)
        return f"{self.message} >>> {json.dumps(self.kwargs, default=str)}"


class BraceMessage:
    def __init__(self, fmt, /, *args, **kwargs):
        self.fmt = fmt
        self.args = args
        self.kwargs = kwargs

    def __str__(self):
        return self.fmt.format(*self.args, **self.kwargs)


class DollarMessage:
    def __init__(self, fmt, /, **kwargs):
        self.fmt = fmt
        self.kwargs = kwargs

    def __str__(self):
        from string import Template
        return Template(self.fmt).substitute(**self.kwargs)


_ = StructuredMessage  # optional, to improve readability


def main():
    logging.basicConfig(level=logging.INFO, format='%(message)s')
    logging.info(_("message 1", set_value={1, 2, 3}, snowman='\u2603'))


if __name__ == "__main__":
    main()
