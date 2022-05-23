-- Gets the 48-bit time part of the ULID and returns a timestamp

CREATE FUNCTION ulid_to_timestamp(ulid UUID)
RETURNS TIMESTAMP WITH TIME ZONE
AS $$
  SELECT TO_TIMESTAMP(timepart::BIT(48)::BIGINT::DOUBLE PRECISION / 1000.0)
  FROM (
    SELECT ('x' || lpad((substring (u from 1 for 8) || substring (u from 10 for 4)), 12, '0')) AS timepart
    FROM (values (ulid::TEXT)) s (u)
  ) s;
$$
LANGUAGE sql
IMMUTABLE;
