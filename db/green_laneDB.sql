SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `green_lane` ;
CREATE SCHEMA IF NOT EXISTS `green_lane` DEFAULT CHARACTER SET latin1 ;

show databases;

use green_laneFinal;

create table Bikes (
    maintenanceStatus boolean not null,
    rideStatus boolean not null,
    type varchar(50) not null,
    location varchar(50) not null,
    bikeID int,
    primary key (bikeID)

);

create table City (
    cityID int,
    location varchar(50) not null ,
    numStations int not null ,
    numBikes int not null ,
    B_bikeID int,
    primary key (cityID),
    FOREIGN KEY (B_bikeID) REFERENCES Bikes(bikeID)


);

create table Users (
    userID int,
    lName varchar(50) not null,
    fName varchar(50) not null,
    dob date not null ,
    address varchar(50),
    email varchar(100) unique not null,
    primary key (userID)
);

create table DockingStation (
    stationID int,
    docks int not null ,
    location varchar(50),
    numBikes int not null ,
    B_bikeID int not null ,
    primary key (stationID),
    FOREIGN KEY (B_bikeID) REFERENCES Bikes(bikeID)
);

create table WorkOrders (
    reportID int,
    location varchar(50),
    timeResolved datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null ,
    timeReported datetime default CURRENT_TIMESTAMP not null ,
    reportType varchar(50),
    B_bikeID int,
    primary key (reportID),
    foreign key (B_bikeID) references Bikes(bikeID)

);

create table RepairCrew (
    employeeID int,
    location varchar(50),
    lName varchar(50),
    fName varchar(50),
    R_reportID int,
    primary key (employeeID),
    foreign key (R_reportID) references WorkOrders(reportID)
);

create table CurrentRide (
    B_bikeID int,
    U_userID int,
    rideID int,
    startTime datetime default CURRENT_TIMESTAMP,
    PRIMARY KEY (U_userID, B_bikeID),
    FOREIGN KEY (U_userID) REFERENCES Users(userID),
    FOREIGN KEY (B_bikeID) REFERENCES Bikes(bikeID)

);

ALTER TABLE CurrentRide ADD INDEX idx_rideID (rideID);

create table RideHistory (
    startTime datetime default CURRENT_TIMESTAMP,
    endTime datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    startLoc varchar(50),
    endLoc varchar(50),
    rating int CHECK (rating >= 1 AND rating <= 5),
    CR_rideID int,
    primary key (CR_rideID),
    foreign key (CR_rideID) references CurrentRide(rideID)
);


-- failed to add the foreign key constraint missing index for constraint 'RideHistroy_ibfk_1' in the referenced table CurrentRide
