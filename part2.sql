CREATE DATABASE KLMVGames;
USE KLMVGames;

CREATE TABLE Tutor
(
    tutorID    INTEGER AUTO_INCREMENT NOT NULL,
    f_name     varchar(50)            NOT NULL,
    l_name     varchar(50)            NOT NULL,
    email      varchar(50)            NOT NULL,
    background varchar(255),
    skill      INTEGER,
    PRIMARY KEY (tutorID)
);

CREATE TABLE Department
(
    departmentID INTEGER AUTO_INCREMENT NOT NULL,
    Budget       BIGINT                 NOT NULL,
    numEmployees BIGINT                 NOT NULL,
    description  varchar(255),
    PRIMARY KEY (departmentID)
);

CREATE TABLE Player
(
    playerID  INTEGER AUTO_INCREMENT NOT NULL,
    isPremium boolean                NOT NULL,
    email     varchar(50)            NOT NULL,
    f_name    varchar(50)            NOT NULL,
    l_name    varchar(50)            NOT NULL,
    birthday  DATETIME,
    PRIMARY KEY (playerID)
);

CREATE TABLE Project
(
    projectCodeName varchar(50) NOT NULL UNIQUE,
    dueDate         DATETIME,
    budget          BIGINT,
    PRIMARY KEY (projectCodeName)
);

CREATE TABLE GameType
(
    gameName    varchar(50) NOT NULL UNIQUE,
    rules       varchar(255), -- added rules here
    description varchar(255),
    PRIMARY KEY (gameName)
);


CREATE TABLE Engineer
(
    employeeId      INTEGER AUTO_INCREMENT NOT NULL,
    projectCodeName varchar(50)            NOT NULL,
    departmentID    INTEGER                NOT NULL,
    title           varchar(50),
    programingLangs varchar(255), -- added programming langs to match table
    f_name          varchar(50)            NOT NULL,
    l_name          varchar(50)            NOT NULL,
    salary          int                    NOT NULL,
    PRIMARY KEY (employeeId),
    FOREIGN KEY (projectCodeName) REFERENCES Project (projectCodeName) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (departmentID) REFERENCES Department (departmentID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- are we adding hints and clues
CREATE TABLE Game
(
    gameId          INTEGER AUTO_INCREMENT NOT NULL,
    gameName        varchar(100)           NOT NULL UNIQUE,
    projectCodeName varchar(50)            NOT NULL,
    difficulty      INT,
    PRIMARY KEY (gameId, gameName),
    FOREIGN KEY (projectCodeName) REFERENCES Project (projectCodeName) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (gameName) REFERENCES GameType (gameName) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE GameAttempt
(
    attemptId    INTEGER AUTO_INCREMENT NOT NULL,
    gameId       INTEGER                NOT NULL,
    playerID     INTEGER                NOT NULL,
    isInProgress BOOLEAN                NOT NULL,
    timeElapsed  BIGINT                 NOT NULL,
    score        INT,
    dateStarted  DATETIME               NOT NULL,
    PRIMARY KEY (attemptId),
    FOREIGN KEY (gameId) REFERENCES Game (gameId) ON UPDATE CASCADE ON DELETE CASCADE,      -- wouldnt this delete the game?
    FOREIGN KEY (playerID) REFERENCES Player (playerID) ON UPDATE CASCADE ON DELETE CASCADE -- don't want to delete the player?
);

CREATE TABLE TutorSession
(
    tutorID   INTEGER NOT NULL UNIQUE,
    attemptId INTEGER NOT NULL UNIQUE,
    hours     INT     NOT NULL,
    rate      FLOAT   NOT NULL,
    totalPay  FLOAT   NOT NULL,
    notes     varchar(500),
    PRIMARY KEY (tutorID, attemptId),
    FOREIGN KEY (tutorID) REFERENCES Tutor (tutorID) ON UPDATE CASCADE ON DELETE CASCADE,          -- idk if we should on have on delete
    FOREIGN KEY (attemptId) REFERENCES GameAttempt (attemptId) ON UPDATE CASCADE ON DELETE CASCADE -- do we need on delete here?

);

CREATE TABLE Submission
(
    attemptId        INTEGER NOT NULL UNIQUE,
    submissionNumber INT     NOT NULL UNIQUE,
    numIncorrect     INT     NOT NULL,
    PRIMARY KEY (attemptId, submissionNumber),
    FOREIGN KEY (attemptId) REFERENCES GameAttempt (attemptId) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE Guesses
(
    attemptId        INTEGER NOT NULL UNIQUE,
    submissionNumber INTEGER NOT NULL UNIQUE,
    valueRow         INTEGER NOT NULL,
    valueColumn      INTEGER NOT NULL,
    charValue        char(1) NOT NULL,
    PRIMARY KEY (attemptId, submissionNumber, valueRow, valueColumn),
    FOREIGN KEY (attemptId) REFERENCES Submission (attemptId) ON UPDATE CASCADE ON DELETE CASCADE, -- same delete thoughts here
    FOREIGN KEY (submissionNumber) REFERENCES Submission (submissionNumber) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE BackgroundCheck
(
    employeeId    INTEGER     NOT NULL UNIQUE,
    ethnicity     varchar(50) NOT NULL,
    isAdaEligible BOOLEAN,
    isVeteran     BOOLEAN,
    SSN           varchar(10),
    Orientation   varchar(25),
    PRIMARY KEY (employeeId),
    FOREIGN KEY (employeeId) REFERENCES Engineer (employeeId) ON UPDATE CASCADE ON DELETE CASCADE -- do we need delete?
);

CREATE TABLE Tutor_Player
(
    employeeId INTEGER NOT NULL,
    playerID   INTEGER NOT NULL,
    PRIMARY KEY (employeeId, playerID),
    FOREIGN KEY (employeeId) REFERENCES Engineer (employeeId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (playerID) REFERENCES Player (playerID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Engineer_GameAttempt
(
    employeeId INTEGER NOT NULL,
    attemptId  INTEGER NOT NULL,
    notes      MEDIUMTEXT,
    PRIMARY KEY (employeeId, attemptId),
    FOREIGN KEY (employeeId) REFERENCES Engineer (employeeId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (attemptId) REFERENCES GameAttempt (attemptId) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Answers
(
    gameId      INTEGER      NOT NULL,
    gameName    varchar(100) NOT NULL,
    valueRow    INT          NOT NULL,
    valueColumn INT          NOT NULL,
    charValue   char(1)      NOT NULL,
    PRIMARY KEY (gameId, gameName, valueRow, valueColumn),
    FOREIGN KEY (gameId) REFERENCES Game (gameId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (gameName) REFERENCES Game (gameName) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE Schedule
(
    scheduleID  INTEGER NOT NULL,
    tutorID     int     NOT NULL,
    timesBooked datetime,
    datesAvail  date,
    PRIMARY KEY (scheduleID, tutorID),
    FOREIGN KEY (tutorID) REFERENCES Tutor (tutorID) ON UPDATE CASCADE
);

CREATE TABLE Hints
(
    hint     varchar(100) NOT NULL UNIQUE,
    gameId   INTEGER      NOT NULL,
    gameName varchar(100) NOT NULL,
    PRIMARY KEY (hint),
    FOREIGN KEY (gameId) REFERENCES Game (gameId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (gameName) REFERENCES Game (gameName) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Clues
(
    clue     varchar(100) NOT NULL UNIQUE,
    gameId   INTEGER      NOT NULL,
    gameName varchar(100) NOT NULL,
    PRIMARY KEY (clue),
    FOREIGN KEY (gameId) REFERENCES Game (gameId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (gameName) REFERENCES Game (gameName) ON UPDATE CASCADE ON DELETE CASCADE
);
