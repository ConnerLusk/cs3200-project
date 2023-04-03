CREATE DATABASE KLMVGames;
USE KLMVGames;

CREATE TABLE Tutor (
    tutorID varchar(50) NOT NULL,
    f_name varchar(50) NOT NULL,
    l_name varchar(50) NOT NULL,
    manager varchar(50),
    email varchar(50) NOT NULL,
    background varchar(255) NOT NULL,
    skill varchar(50) NOT NULL,
    PRIMARY KEY (tutorID)
);

CREATE TABLE Department (
    departmentID varchar(50) NOT NULL,
    Budget BIGINT NOT NULL,
    numEmployees BIGINT NOT NULL,
    description varchar(255),
    PRIMARY KEY (departmentID)
);


