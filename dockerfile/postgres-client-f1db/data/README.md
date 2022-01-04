# F1 DB

* * *

A `Formula 1` data set for `postgres`.

## Usage

- Build an image from the `Dockerfile`
- Spool up a `postgres` container if necessary
- Spool up an image of the previously built `Dockerfile`
- Run `.sql` scripts in the order given by filename, note that:
  - the first will create tables in the target db
  - the second loads them
