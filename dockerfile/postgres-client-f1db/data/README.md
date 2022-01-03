# f1db

* * *

A dataset based on `formula1`.

Load into `postgres` by:

- creating the directory `local/`
- un-zipping all csvs into the directory `local/`
- prepare and run `.sql` scripts in order
  - find and replace all occurences of `\N` with ``
  - the first will create tables in the target db
  - the second loads them
