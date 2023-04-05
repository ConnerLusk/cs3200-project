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
    PRIMARY KEY (tutorID),

    CONSTRAINT skill CHECK (skill BETWEEN 0 AND 5)
);

CREATE TABLE Department
(
    departmentID INTEGER AUTO_INCREMENT NOT NULL,
    budget       BIGINT                 NOT NULL,
    descrip      TEXT,
    PRIMARY KEY (departmentID)
);

CREATE TABLE Player
(
    playerID  INTEGER AUTO_INCREMENT NOT NULL,
    isPremium boolean                NOT NULL,
    f_name    varchar(50)            NOT NULL,
    l_name    varchar(50)            NOT NULL,
    email     varchar(50)            NOT NULL,
    birthday  DATE,
    PRIMARY KEY (playerID)
);

CREATE TABLE Project
(
    projectCodeName varchar(50) NOT NULL UNIQUE,
    dueDate         DATE,
    budget          BIGINT,
    PRIMARY KEY (projectCodeName)
);

CREATE TABLE GameType
(
    gameName    varchar(50) NOT NULL UNIQUE,
    rules       varchar(255),
    descrip     varchar(255),
    PRIMARY KEY (gameName)
);


CREATE TABLE Engineer
(
    employeeId      INTEGER AUTO_INCREMENT NOT NULL,
    projectCodeName varchar(50)            NOT NULL,
    departmentID    INTEGER                NOT NULL,
    title           varchar(50),
    f_name          varchar(50)            NOT NULL,
    l_name          varchar(50)            NOT NULL,
    salary          int                    NOT NULL,
    PRIMARY KEY (employeeId),
    CONSTRAINT FOREIGN KEY (projectCodeName) REFERENCES Project (projectCodeName) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (departmentID) REFERENCES Department (departmentID) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE Game
(
    gameId          INTEGER AUTO_INCREMENT NOT NULL,
    gameName        varchar(100)           NOT NULL UNIQUE,
    projectCodeName varchar(50)            NOT NULL,
    difficulty      INT,
    PRIMARY KEY (gameId, gameName),
    CONSTRAINT FOREIGN KEY (projectCodeName) REFERENCES Project (projectCodeName) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (gameName) REFERENCES GameType (gameName) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT difficulty CHECK (difficulty BETWEEN 1 AND 5)
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
    CONSTRAINT FOREIGN KEY (gameId) REFERENCES Game (gameId) ON UPDATE CASCADE ON DELETE RESTRICT ,
    CONSTRAINT FOREIGN KEY (playerID) REFERENCES Player (playerID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE TutorSession
(
    sessionID INTEGER AUTO_INCREMENT NOT NULL,
    tutorID   INTEGER                NOT NULL UNIQUE,
    playerID  INTEGER                NOT NULL UNIQUE,
    hours     INT                    NOT NULL,
    rate      FLOAT                  NOT NULL,
    totalPay  FLOAT                  NOT NULL,
    notes     varchar(500),
    PRIMARY KEY (sessionID, tutorID),
    CONSTRAINT FOREIGN KEY (tutorID) REFERENCES Tutor (tutorID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (playerID) REFERENCES Player (playerID) ON UPDATE CASCADE ON DELETE CASCADE

);

CREATE TABLE Submission
(
    submissionNumber INTEGER     NOT NULL,
    attemptId        INTEGER     NOT NULL UNIQUE,
    numIncorrect     INTEGER     NOT NULL,
    PRIMARY KEY (attemptId, submissionNumber),
    CONSTRAINT FOREIGN KEY (attemptId) REFERENCES GameAttempt (attemptId) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE Guesses
(
    attemptId        INTEGER NOT NULL,
    submissionNumber INTEGER     NOT NULL,
    valueRow         INTEGER NOT NULL,
    valueColumn      INTEGER NOT NULL,
    charValue        char(1),
    PRIMARY KEY (attemptId, valueRow, valueColumn),
    CONSTRAINT FOREIGN KEY (attemptId, submissionNumber) REFERENCES Submission (attemptId, submissionNumber) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE BackgroundCheck
(
    employeeId    INTEGER     NOT NULL UNIQUE,
    isFelon       BOOLEAN     NOT NULL,
    isAdaEligible BOOLEAN,
    isVeteran     BOOLEAN,
    SSN           varchar(10) UNIQUE,
    PRIMARY KEY (employeeId),
    CONSTRAINT FOREIGN KEY (employeeId) REFERENCES Engineer (employeeId) ON UPDATE CASCADE
);

CREATE TABLE Engineer_GameAttempt
(
    employeeId INTEGER NOT NULL,
    attemptId  INTEGER NOT NULL,
    notes      MEDIUMTEXT,
    PRIMARY KEY (employeeId, attemptId),
    CONSTRAINT FOREIGN KEY (employeeId) REFERENCES Engineer (employeeId) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (attemptId) REFERENCES GameAttempt (attemptId) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Answers
(
    gameId      INTEGER      NOT NULL,
    gameName    varchar(100) NOT NULL,
    valueRow    INT          NOT NULL,
    valueColumn INT          NOT NULL,
    charValue   char(1),
    PRIMARY KEY (gameId, gameName, valueRow, valueColumn),
    CONSTRAINT FOREIGN KEY (gameId) REFERENCES Game (gameId) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (gameName) REFERENCES Game (gameName) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Hints
(
    hint     varchar(100) NOT NULL UNIQUE,
    gameId   INTEGER      NOT NULL,
    gameName varchar(100) NOT NULL,
    valueRow    INT          NOT NULL,
    valueColumn INT          NOT NULL,
    PRIMARY KEY (hint),
    CONSTRAINT FOREIGN KEY (gameId) REFERENCES Game (gameId) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (gameName) REFERENCES Game (gameName) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Clues
(
    gameId   INTEGER      NOT NULL,
    valueRow    INT       NOT NULL,
    valueColumn INT       NOT NULL,
    clue     varchar(100),
    isDown   BOOLEAN      NOT NULL,

    PRIMARY KEY (gameID, valueRow, valueColumn, isDown),
    CONSTRAINT FOREIGN KEY (gameId) REFERENCES Game (gameId) ON UPDATE CASCADE ON DELETE CASCADE
);