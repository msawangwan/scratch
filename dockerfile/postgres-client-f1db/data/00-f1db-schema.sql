create table if not exists status (
    statusId integer primary key,
    status   text
);

create table if not exists seasons (
    "year" integer primary key,
    url    text
);

create table if not exists circuits (
    circuitId   integer primary key,
    circuitRef  text,
    name        text,
    location    text,
    country     text,
    lat         real,
    lng         real,
    alt         integer,
    url         text unique
);

create table if not exists races (
    raceId    integer primary key,
    "year"    integer,
    "round"   integer,
    circuitId integer references circuits(circuitId),
    name      text,
    date      date,
    time      time,
    url       text unique
);

create table if not exists drivers (
    driverId    integer primary key,
    driverRef   text,
    "number"    integer,
    code        text,
    forename    text,
    surname     text,
    dob         date,
    nationality text,
    url         text
);

create table if not exists constructors (
    constructorId   integer primary key,
    constructorRef  text,
    name            text unique,
    nationality     text,
    url             text
);

create table if not exists constructor_results (
    constructorResultsId integer primary key,
    raceId               integer references races(raceId),
    constructorId        integer references constructors(constructorId),
    points               real,
    status               text
);

create table if not exists constructor_standings (
    constructorStandingsId integer primary key,
    raceId                 integer references races(raceId),
    constructorId          integer references constructors(constructorId),
    points                 real,
    position               integer,
    positionText           text,
    wins                   integer
);

create table if not exists driver_standings (
    driverStandingsId integer primary key,
    raceId            integer references races(raceId),
    driverId          integer references drivers(driverId),
    points            real,
    position          integer,
    positionText      text,
    wins              integer
);

create table if not exists lap_times (
    raceId       integer references races(raceId),
    driverId     integer references drivers(driverId),
    lap          integer,
    position     integer,
    time         text,
    milliseconds integer,
    constraint   unique_lap_time unique (raceId, driverId, lap)
);

create table if not exists pit_stops (
    raceId       integer references races(raceId),
    driverId     integer references drivers(driverId),
    stop         integer,
    lap          integer,
    time         time,
    duration     text,
    milliseconds integer,
    constraint   unique_pit_stop unique (raceId, driverId, stop)
);

create table if not exists qualifying (
    qualifyId     integer primary key,
    raceId        integer references races(raceId),
    driverId      integer references drivers(driverId),
    constructorId integer references constructors(constructorId),
    "number"      integer,
    position      integer,
    q1            text,
    q2            text,
    q3            text
);

create table if not exists results (
    resultId        integer primary key,
    raceId          integer references races(raceId),
    driverId        integer references drivers(driverId),
    constructorId   integer references constructors(constructorId),
    "number"        integer,
    grid            integer,
    position        integer,
    positionText    text,
    positionOrder   integer,
    points          real,
    laps            integer,
    time            text,
    milliseconds    integer,
    fastestLap      integer,
    "rank"          integer,
    fastestLapTime  text,
    fastestLapSpeed text,
    statusId        integer references status(statusId)
);
