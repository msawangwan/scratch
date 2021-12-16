#!/usr/bin/env python


class TableFormatter:
    "TableFormatter pretty-prints table column headers and row data."

    def __init__(self, *spec):
        """spec is a list of 0 or more tuples
        where:
            pos 1: header value
            pos 2: column format string
            pos 3: cell max length
        """
        self.headers = [str(s[0]) if len(s) > 1 else "" for s in spec]
        self.fmt = " | ".join([str(s[1]) if len(s) > 1 else "" for s in spec])

    def columns(self):
        return self.fmt % tuple(self.headers)

    def row(self, *values):
        return self.fmt % values

    def sep(self):
        s = ""
        for c in self.columns():
            s += "+" if c == "|" else "-"
        return s


if __name__ == "__main__":
    p = TableFormatter(("Genre", "%10s"), ("Title", "%10s"))

    print(p.columns())
    print(p.sep())
    print(p.row("RnB", "Zed is Dead"))
    print(p.row("Classical", "E Minor Prelude"))
