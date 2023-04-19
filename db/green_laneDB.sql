SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `green_lane` ;
CREATE SCHEMA IF NOT EXISTS `green_lane` DEFAULT CHARACTER SET latin1 ;

show databases;

use green_lane;

create table Bikes (
    bikeID int not null AUTO_INCREMENT,
    maintenanceStatus boolean,
    rideStatus boolean,
    bikeType varchar(50),
    DS_stationID int not null,
    C_cityID int not null,
    primary key (bikeID),
    Constraint fk_1 FOREIGN KEY (DS_stationID) REFERENCES DockingStation(stationID),
    Constraint fk_2 FOREIGN KEY (C_cityID) REFERENCES City(cityID)

);

create table City (
    cityID int not null AUTO_INCREMENT,
    cityName varchar(50),
    numStations int,
    numBikes int,
    B_bikeID int,
    primary key (cityID),
    Constraint fk_3 FOREIGN KEY (B_bikeID) REFERENCES Bikes(bikeID)


);

create table Users (
    userID int not null AUTO_INCREMENT,
    lName varchar(50) not null,
    fName varchar(50) not null,
    dob date,
    address varchar(50),
    email varchar(100) unique not null,
    CR_rideID int,
    primary key (userID),
    Constraint fk_4 FOREIGN KEY (CR_rideID) references CurrentRide(rideID)
);

create table DockingStation (
    stationID int not null AUTO_INCREMENT,
    docks int,
    loc varchar(50),
    numBikes int,
    C_cityID int not null,
    primary key (stationID),
    Constraint fk_5 FOREIGN KEY (C_cityID) REFERENCES City(cityID)
);

create table WorkOrders (
    reportID int not null AUTO_INCREMENT,
    loc varchar(50),
    timeResolved datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    timeReported datetime default CURRENT_TIMESTAMP,
    reportType varchar(50),
    B_bikeID int,
    E_employeeID int,
    primary key (reportID),
    Constraint fk_6 foreign key (B_bikeID) references Bikes(bikeID),
    Constraint fk_7 foreign key (E_employeeID) references RepairCrew(employeeID)

);

create table RepairCrew (
    employeeID int not null AUTO_INCREMENT,
    loc varchar(50),
    lName varchar(50),
    fName varchar(50),
    R_reportID int,
    primary key (employeeID),
    Constraint fk_8 foreign key (R_reportID) references WorkOrders(reportID)
);

create table CurrentRide (
    rideID int not null AUTO_INCREMENT,
    B_bikeID int,
    U_userID int,
    startTime datetime default CURRENT_TIMESTAMP,
    PRIMARY KEY (rideID),
    Constraint fk_9 FOREIGN KEY (U_userID) REFERENCES Users(userID),
    Constraint fk_10 FOREIGN KEY (B_bikeID) REFERENCES Bikes(bikeID)

);

create table RideHistory (
    historyID int not null AUTO_INCREMENT,
    startTime datetime default CURRENT_TIMESTAMP,
    endTime datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    startLoc varchar(50),
    endLoc varchar(50),
    rating int CHECK (rating >= 1 AND rating <= 5),
    CR_rideID int,
    primary key (historyID),
    Constraint fk_11 foreign key (CR_rideID) references CurrentRide(rideID)



);

create table lookupReport (
    typeOfReport varchar(50),
    reportTypeID int not null
);

insert into lookupReport
values ('electrical', '1');
insert into lookupReport
values ('physical', '2');
insert into lookupReport
values ('systems', '3');
insert into lookupReport
values ('gps', '4');
insert into lookupReport
values ('software', '5');

create table lookupBikeType (
    bikeType varchar(50),
    bikeTypeID int not null
);

insert into lookupBikeType
values ('pedal bike', '1');
insert into lookupBikeType
values ('electric motor', '2');

INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (1,false,false,2,19,7);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (2,true,false,1,34,5);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (3,true,true,1,27,1);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (4,true,true,2,5,3);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (5,false,true,2,15,4);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (6,false,true,2,33,8);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (7,true,true,1,14,10);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (8,true,true,1,13,7);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (9,false,false,1,21,6);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (10,true,true,1,9,2);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (11,false,true,1,32,8);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (12,true,true,2,29,7);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (13,false,true,2,5,6);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (14,true,true,2,45,3);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (15,true,true,1,6,4);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (16,false,true,2,7,3);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (17,false,true,2,46,7);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (18,false,false,1,29,1);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (19,true,false,1,25,9);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (20,true,false,1,41,5);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (21,false,false,2,24,6);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (22,false,false,2,12,7);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (23,false,false,2,26,9);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (24,false,false,1,31,4);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (25,true,false,1,47,8);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (26,true,true,2,2,2);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (27,true,true,1,48,1);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (28,true,false,2,44,3);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (29,false,true,1,21,8);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (30,true,true,2,12,5);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (31,true,false,1,17,8);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (32,true,false,1,39,3);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (33,false,true,2,47,2);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (34,false,true,1,22,5);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (35,false,true,1,41,1);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (36,false,true,2,19,8);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (37,true,true,2,45,9);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (38,true,true,1,6,10);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (39,false,false,2,5,4);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (40,false,true,2,39,6);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (41,false,true,1,43,1);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (42,false,false,1,34,9);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (43,false,true,1,12,2);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (44,true,false,1,33,7);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (45,false,false,1,31,10);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (46,true,true,2,33,4);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (47,false,true,2,2,7);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (48,true,false,1,23,2);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (49,false,false,2,11,3);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (50,true,false,2,43,10);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (51,false,false,2,30,4);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (52,true,true,2,11,10);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (53,false,false,2,6,1);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (54,false,true,2,10,5);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (55,true,true,1,42,3);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (56,true,false,1,2,2);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (57,false,true,1,13,10);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (58,false,true,2,39,5);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (59,true,false,1,29,6);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (60,true,true,1,42,3);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (61,false,true,1,1,1);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (62,true,false,2,11,5);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (63,true,true,2,40,6);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (64,true,false,2,7,3);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (65,false,true,2,15,9);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (66,true,true,1,6,6);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (67,true,true,1,10,7);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (68,true,false,2,41,5);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (69,false,false,2,20,8);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (70,true,true,2,11,1);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (71,false,true,2,10,8);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (72,true,false,1,34,1);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (73,true,false,1,17,10);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (74,true,false,2,23,3);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (75,true,true,2,50,7);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (76,false,true,1,16,3);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (77,true,true,1,42,7);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (78,true,true,1,46,2);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (79,false,true,2,25,1);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (80,false,true,2,29,9);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (81,false,true,1,48,6);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (82,false,false,1,19,9);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (83,false,false,1,33,2);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (84,false,false,2,37,4);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (85,false,true,2,14,10);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (86,true,true,2,5,9);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (87,false,false,1,39,10);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (88,true,false,2,20,4);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (89,false,true,2,40,1);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (90,false,false,1,48,7);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (91,true,true,1,42,7);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (92,false,false,1,40,9);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (93,false,true,2,43,5);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (94,false,true,2,20,3);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (95,false,true,1,27,1);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (96,true,false,1,10,6);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (97,false,false,1,6,8);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (98,true,false,2,47,4);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (99,false,true,2,20,9);
INSERT INTO Bikes(bikeID,maintenanceStatus,rideStatus,bikeType,DS_stationID,C_cityID) VALUES (100,true,false,2,13,7);

INSERT INTO City(cityID,cityName,numStations,numBikes) VALUES (1,'Shōbu',69,883);
INSERT INTO City(cityID,cityName,numStations,numBikes) VALUES (2,'Dongping',49,751);
INSERT INTO City(cityID,cityName,numStations,numBikes) VALUES (3,'Turku',99,718);
INSERT INTO City(cityID,cityName,numStations,numBikes) VALUES (4,'Danidehe',84,499);
INSERT INTO City(cityID,cityName,numStations,numBikes) VALUES (5,'Guder',69,632);
INSERT INTO City(cityID,cityName,numStations,numBikes) VALUES (6,'Anshan',40,34);
INSERT INTO Bikes(cityID,cityName,numStations,numBikes) VALUES (7,'Marugame',27,658);
INSERT INTO Bikes(cityID,cityName,numStations,numBikes) VALUES (8,'Binucayan',16,996);
INSERT INTO Bikes(cityID,cityName,numStations,numBikes) VALUES (9,'Nancaicun',8,330);
INSERT INTO Bikes(cityID,cityName,numStations,numBikes) VALUES (10,'Aqaba',23,58);

INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (1,'2023-03-17 19:33:11',1);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (2,'2022-08-09 08:16:52',2);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (3,'2022-08-27 02:39:47',3);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (4,'2022-07-03 10:50:02',4);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (5,'2022-07-30 04:13:25',5);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (6,'2022-06-11 08:12:41',6);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (7,'2023-01-04 16:23:31',7);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (8,'2022-07-27 16:23:24',8);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (9,'2022-05-02 14:33:14',9);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (10,'2023-01-30 08:58:17',10);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (11,'2023-01-26 22:55:37',11);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (12,'2023-02-28 19:27:21',12);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (13,'2023-04-12 05:02:01',13);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (14,'2022-09-01 17:35:36',14);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (15,'2022-06-12 23:55:37',15);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (16,'2023-01-21 12:01:11',16);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (17,'2022-06-14 17:52:24',17);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (18,'2022-09-08 11:50:25',18);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (19,'2023-03-25 21:08:09',19);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (20,'2022-06-16 10:42:17',20);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (21,'2022-07-31 11:42:23',21);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (22,'2022-06-01 21:03:24',22);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (23,'2022-10-06 06:07:51',23);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (24,'2023-02-23 02:46:48',24);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (25,'2023-03-13 12:02:00',25);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (26,'2023-03-04 13:57:00',26);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (27,'2023-04-16 10:07:44',27);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (28,'2023-04-07 01:01:58',28);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (29,'2022-11-20 20:20:23',29);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (30,'2022-06-12 17:58:50',30);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (31,'2022-07-20 10:02:50',31);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (32,'2022-06-23 17:31:09',32);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (33,'2023-03-28 16:15:25',33);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (34,'2023-02-22 11:53:13',34);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (35,'2022-09-26 16:13:41',35);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (36,'2023-03-19 13:20:42',36);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (37,'2023-01-03 11:06:58',37);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (38,'2022-12-21 22:03:04',38);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (39,'2022-11-20 21:40:15',39);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (40,'2022-12-15 07:45:42',40);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (41,'2023-02-24 16:38:21',41);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (42,'2023-04-09 05:27:54',42);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (43,'2023-02-28 07:06:08',43);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (44,'2022-06-26 16:56:41',44);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (45,'2022-10-10 00:31:18',45);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (46,'2022-11-09 03:13:09',46);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (47,'2023-03-04 18:55:57',47);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (48,'2023-02-10 11:34:40',48);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (49,'2022-10-08 00:02:40',49);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (50,'2022-04-28 01:36:25',50);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (51,'2023-03-05 01:35:11',51);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (52,'2022-06-19 20:22:31',52);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (53,'2022-09-16 20:07:04',53);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (54,'2022-07-18 16:10:17',54);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (55,'2022-11-15 08:11:56',55);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (56,'2022-07-18 20:07:18',56);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (57,'2023-03-06 13:13:13',57);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (58,'2022-07-16 15:20:48',58);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (59,'2023-04-02 20:46:43',59);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (60,'2022-09-30 13:27:25',60);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (61,'2022-11-28 10:20:58',61);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (62,'2022-05-15 10:41:38',62);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (63,'2023-04-05 02:46:15',63);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (64,'2023-03-16 11:43:00',64);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (65,'2022-09-26 17:05:06',65);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (66,'2022-10-10 21:31:07',66);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (67,'2023-03-05 12:38:57',67);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (68,'2022-05-26 00:44:20',68);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (69,'2023-01-12 22:28:49',69);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (70,'2023-01-08 00:33:36',70);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (71,'2022-08-16 11:01:05',71);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (72,'2023-02-19 23:13:48',72);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (73,'2022-09-29 11:32:52',73);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (74,'2023-04-13 15:53:30',74);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (75,'2023-04-04 17:16:33',75);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (76,'2023-01-19 08:07:35',76);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (77,'2023-03-21 20:11:56',77);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (78,'2022-08-03 08:19:59',78);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (79,'2022-12-19 06:30:18',79);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (80,'2022-10-30 05:49:26',80);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (81,'2022-11-25 00:49:53',81);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (82,'2023-04-05 22:14:50',82);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (83,'2022-10-06 07:24:52',83);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (84,'2023-01-22 18:52:14',84);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (85,'2022-11-11 21:45:03',85);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (86,'2022-10-12 12:27:58',86);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (87,'2022-07-23 10:44:31',87);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (88,'2022-12-22 04:54:43',88);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (89,'2022-07-06 09:46:18',89);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (90,'2022-06-03 14:13:39',90);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (91,'2022-05-01 04:21:33',91);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (92,'2022-10-31 10:28:38',92);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (93,'2022-09-17 04:35:59',93);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (94,'2022-10-07 09:18:38',94);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (95,'2023-01-17 17:16:28',95);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (96,'2022-09-30 22:14:04',96);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (97,'2022-07-04 11:52:18',97);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (98,'2023-03-30 20:32:59',98);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (99,'2022-08-03 00:45:39',99);
INSERT INTO CurrentRide(rideID,startTime,B_bikeID) VALUES (100,'2023-01-23 09:52:30',100);

INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (1,48,6,31);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (2,10,8,31);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (3,72,2,6);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (4,14,7,40);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (5,59,1,6);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (6,83,9,32);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (7,88,8,8);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (8,75,3,7);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (9,100,4,19);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (10,98,6,42);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (11,80,2,32);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (12,15,8,47);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (13,9,8,10);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (14,32,5,1);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (15,11,9,7);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (16,58,2,13);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (17,56,8,15);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (18,86,5,1);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (19,28,6,33);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (20,46,2,32);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (21,43,1,23);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (22,27,4,49);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (23,99,3,16);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (24,2,5,36);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (25,55,10,12);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (26,9,1,1);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (27,65,9,18);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (28,53,8,30);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (29,39,3,6);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (30,39,5,25);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (31,64,8,37);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (32,46,6,23);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (33,11,1,39);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (34,91,10,2);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (35,46,2,21);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (36,1,10,41);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (37,5,8,44);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (38,35,6,13);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (39,25,1,50);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (40,78,4,19);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (41,50,9,37);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (42,85,2,37);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (43,87,5,42);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (44,77,10,4);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (45,85,7,4);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (46,26,3,6);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (47,38,6,41);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (48,79,8,4);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (49,30,9,23);
INSERT INTO DockingStation(stationID,docks,cityID,numBikes) VALUES (50,26,1,4);

INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (1,'Turku','Bartalot','Rosa',1);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (2,'Dongping','Dumbare','Fairfax',2);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (3,'Binucayan','Dameisele','Lauritz',3);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (4,'Shōbu','Oolahan','Adler',4);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (5,'Danidehe','Tayt','Mag',5);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (6,'Guder','Arons','Hedi',6);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (7,'Aqaba','Gannaway','Monti',7);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (8,'Shōbu','Forsdicke','Selena',8);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (9,'Turku','Ingray','Alley',9);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (10,'Binucayan','Eskrick','Elden',10);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (11,'Danidehe','Eminson','Gayla',11);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (12,'Aqaba','Gilgryst','Amil',12);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (13,'Nancaicun','Ravenhill','Husain',13);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (14,'Turku','Jumeau','Aleece',14);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (15,'Binucayan','Ouldred','Lyle',15);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (16,'Turku','Wybrew','Joaquin',16);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (17,'Dongping','Burras','Hall',17);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (18,'Anshan','Jacobowicz','Kiersten',18);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (19,'Marugame','Kenworthey','Clair',19);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (20,'Shōbu','Watson','Thea',20);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (21,'Danidehe','Putland','Ange',21);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (22,'Marugame','Whittleton','Katinka',22);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (23,'Guder','Maric','Efrem',23);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (24,'Aqaba','Middlemiss','Hurleigh',24);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (25,'Turku','Bussy','Ruby',25);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (26,'Anshan','Matfield','Ram',26);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (27,'Aqaba','Tease','Marsha',27);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (28,'Shōbu','Chatel','Leodora',28);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (29,'Marugame','Dellar','Kerianne',29);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (30,'Danidehe','Mathissen','Binnie',30);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (31,'Dongping','Laidlaw','Jerald',31);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (32,'Shōbu','Nutkins','Kin',32);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (33,'Danidehe','Mugg','Ephrayim',33);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (34,'Guder','Cobby','Roxane',34);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (35,'Marugame','Bosher','Marcia',35);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (36,'Marugame','Cearley','Tallie',36);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (37,'Dongping','Maycock','Edd',37);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (38,'Nancaicun','Rayment','Marne',38);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (39,'Guder','Lissett','Jacklin',39);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (40,'Anshan','Bewfield','Guinna',40);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (41,'Binucayan','Cromblehome','Agneta',41);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (42,'Anshan','Nucci','Rogers',42);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (43,'Turku','Hannon','Carmina',43);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (44,'Shōbu','Friend','Dotty',44);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (45,'Dongping','Couchman','Liuka',45);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (46,'Turku','Cauldfield','Ferris',46);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (47,'Aqaba','Ellul','Cello',47);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (48,'Anshan','Brennand','Livia',48);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (49,'Shōbu','Wandtke','Christalle',49);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (50,'Nancaicun','Bartleet','Betteanne',50);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (51,'Turku','Sedgeman','Neill',51);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (52,'Marugame','Kettlestringe','Hodge',52);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (53,'Nancaicun','Levesley','Bev',53);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (54,'Dongping','O''Duggan','Eldridge',54);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (55,'Anshan','Prestland','Lillian',55);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (56,'Danidehe','Malimoe','Imogen',56);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (57,'Guder','Cassella','Olympe',57);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (58,'Nancaicun','Le Estut','Alina',58);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (59,'Binucayan','Daffey','Cletis',59);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (60,'Marugame','Gashion','Janifer',60);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (61,'Danidehe','Wilcockes','Angele',61);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (62,'Aqaba','Blundell','Willette',62);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (63,'Marugame','Matiasek','Stefa',63);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (64,'Shōbu','Aherne','Gaye',64);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (65,'Binucayan','Grose','Kev',65);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (66,'Nancaicun','Filipov','Dorrie',66);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (67,'Turku','Longo','Silvain',67);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (68,'Shōbu','Caseri','Kiley',68);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (69,'Marugame','Millbank','Ardisj',69);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (70,'Dongping','Hessing','Dominik',70);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (71,'Anshan','Gillis','Suzy',71);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (72,'Binucayan','Lias','Raul',72);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (73,'Turku','Bertouloume','Klemens',73);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (74,'Dongping','Southon','Oran',74);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (75,'Nancaicun','Postles','Carolin',75);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (76,'Binucayan','Evesque','Barty',76);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (77,'Nancaicun','D''Elia','Forster',77);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (78,'Aqaba','Ecles','Mariya',78);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (79,'Danidehe','Tinan','Maureene',79);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (80,'Anshan','Litt','Patrice',80);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (81,'Aqaba','Oxtoby','Obidiah',81);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (82,'Shōbu','Kinney','Ricki',82);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (83,'Turku','Phlippi','Kelley',83);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (84,'Binucayan','Luebbert','Junia',84);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (85,'Marugame','Hurcombe','Hanni',85);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (86,'Shōbu','Cheers','Garvy',86);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (87,'Dongping','Kunisch','Edik',87);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (88,'Danidehe','Villaron','Nefen',88);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (89,'Anshan','Castagneri','Skye',89);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (90,'Turku','Beardwood','Grannie',90);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (91,'Turku','Reddish','Dick',91);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (92,'Danidehe','Asals','Zea',92);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (93,'Guder','Snowman','Josephina',93);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (94,'Binucayan','Trusler','Loralee',94);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (95,'Marugame','Exeter','Frankie',95);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (96,'Danidehe','Rosenkrantz','Rosemarie',96);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (97,'Guder','Sincock','Jeanine',97);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (98,'Nancaicun','Callendar','Daffi',98);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (99,'Turku','Matelyunas','Maureen',99);
INSERT INTO RepairCrew(employeeID,loc,lName,fName,R_reportID) VALUES (100,'Dongping','Martina','Ario',100);

INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (1,'10:23 AM','3:08 AM','1 Hudson Street','2 Dapin Alley',2,94);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (2,'10:44 AM','9:25 PM','836 Trailsway Way','6 Hintze Court',2,7);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (3,'7:45 AM','1:54 PM','26363 Blaine Place','4695 Chive Pass',4,1);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (4,'7:38 AM','9:11 AM','340 Brown Alley','73603 Basil Plaza',2,48);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (5,'10:18 AM','1:50 PM','6 Del Sol Park','5260 Dawn Way',2,77);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (6,'7:18 AM','5:59 AM','596 Lake View Hill','89789 Manley Hill',2,15);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (7,'12:41 AM','8:34 PM','70951 Carberry Way','02287 Pennsylvania Park',2,36);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (8,'11:15 AM','3:28 AM','64 Shasta Place','057 Sherman Center',2,18);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (9,'12:35 AM','9:37 PM','3 Twin Pines Circle','44968 Heath Hill',1,52);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (10,'10:08 AM','5:22 PM','55611 Longview Hill','6882 Haas Terrace',3,22);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (11,'6:08 AM','5:22 AM','94 Victoria Plaza','84948 Pine View Avenue',2,29);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (12,'12:06 AM','3:24 PM','61 Golden Leaf Road','352 Shopko Trail',1,34);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (13,'1:24 AM','10:08 AM','9 Sutherland Plaza','210 Onsgard Trail',4,88);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (14,'4:39 AM','7:37 AM','1595 Esch Park','3940 Northridge Center',4,7);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (15,'9:20 AM','1:28 PM','77 Russell Point','92 Old Shore Way',5,11);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (16,'12:16 AM','12:52 PM','372 Prairieview Point','858 Vera Lane',3,11);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (17,'1:22 AM','8:53 AM','3048 Springview Junction','40 Forest Run Center',3,72);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (18,'4:49 AM','11:53 PM','8 Reinke Alley','4419 Welch Trail',5,55);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (19,'1:45 AM','2:36 AM','94 Bayside Trail','80292 Tennessee Center',3,44);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (20,'7:07 AM','7:22 AM','99737 Mccormick Place','9951 Bayside Way',5,57);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (21,'1:47 AM','9:54 PM','72149 Rockefeller Lane','750 Lerdahl Trail',1,99);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (22,'9:21 AM','5:31 PM','29219 Ryan Parkway','03309 Westridge Park',3,96);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (23,'7:50 AM','4:54 AM','8646 Garrison Alley','45 Fordem Way',1,59);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (24,'8:35 AM','8:40 PM','3722 Oneill Trail','6 Bartillon Crossing',2,33);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (25,'12:48 AM','3:18 PM','7 Old Shore Way','7450 East Trail',2,12);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (26,'1:10 AM','2:08 PM','0140 Mitchell Place','1519 Parkside Junction',2,4);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (27,'1:29 AM','8:55 PM','78916 Prairie Rose Pass','5222 Longview Terrace',2,8);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (28,'3:57 AM','11:04 PM','26 Reinke Street','2 Green Ridge Plaza',3,29);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (29,'7:33 AM','4:11 PM','63 Starling Street','551 Claremont Plaza',4,31);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (30,'2:04 AM','11:15 AM','843 Drewry Lane','73 Dixon Pass',4,3);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (31,'1:34 AM','2:28 PM','46333 Pine View Lane','68 Corry Alley',1,62);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (32,'4:50 AM','3:37 PM','7 Cody Street','7574 American Ash Way',3,84);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (33,'12:14 AM','2:07 AM','0432 Memorial Center','38816 Becker Pass',3,82);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (34,'10:08 AM','8:08 PM','1 Mcbride Way','2237 Buell Court',4,80);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (35,'5:44 AM','2:57 PM','9 Mitchell Pass','5 Ryan Lane',1,77);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (36,'5:10 AM','3:40 PM','97 Merchant Avenue','03 Arkansas Circle',5,42);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (37,'12:40 AM','7:29 PM','3 Northridge Circle','5552 Lakewood Gardens Crossing',2,8);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (38,'1:20 AM','5:43 PM','0500 Twin Pines Avenue','24746 Briar Crest Junction',4,53);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (39,'9:07 AM','1:07 PM','84133 Chinook Center','58325 Northridge Park',4,10);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (40,'7:46 AM','9:27 PM','9 Farwell Plaza','0 Elmside Point',1,96);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (41,'5:53 AM','5:43 PM','434 Mitchell Hill','0 Sunbrook Terrace',2,84);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (42,'10:07 AM','5:54 PM','8126 Maple Parkway','692 Daystar Place',2,96);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (43,'4:48 AM','8:43 PM','57 Elka Center','38969 1st Place',2,44);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (44,'7:32 AM','10:41 PM','4 Rieder Crossing','0630 Hansons Drive',1,27);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (45,'7:27 AM','7:58 PM','02 Atwood Lane','38757 Quincy Crossing',1,12);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (46,'9:01 AM','10:05 PM','9 Elka Place','669 Bayside Court',5,22);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (47,'7:57 AM','8:52 AM','545 Schmedeman Place','76 Rockefeller Alley',3,31);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (48,'11:49 AM','6:30 AM','18 International Court','5082 Hansons Court',3,61);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (49,'6:14 AM','8:16 PM','4621 Arapahoe Place','23574 Summit Terrace',5,66);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (50,'6:03 AM','6:21 PM','268 Dorton Junction','34905 Sundown Junction',2,60);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (51,'2:00 AM','11:46 PM','3 Pankratz Way','6579 Paget Junction',1,5);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (52,'1:12 AM','8:13 PM','48714 Pierstorff Terrace','3212 Schurz Court',2,32);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (53,'1:19 AM','9:07 AM','77360 Springs Place','1104 Sachs Park',5,31);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (54,'6:32 AM','12:21 PM','24277 Homewood Park','75 Kropf Point',5,26);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (55,'6:28 AM','9:25 PM','21870 Gina Way','6 Victoria Place',4,21);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (56,'6:32 AM','8:28 PM','86 Lakeland Alley','18313 Lawn Terrace',3,8);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (57,'2:51 AM','7:38 AM','85063 Sutteridge Lane','6 Longview Circle',2,12);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (58,'1:51 AM','7:33 PM','426 Algoma Road','52925 Huxley Alley',2,17);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (59,'7:35 AM','6:26 PM','44872 Alpine Parkway','14 Bluejay Place',4,89);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (60,'12:01 AM','12:25 PM','76699 Redwing Junction','8726 Kipling Parkway',1,16);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (61,'10:25 AM','11:55 AM','77474 Gulseth Park','9126 Aberg Court',2,66);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (62,'1:14 AM','6:32 AM','2 Mandrake Point','94 Utah Plaza',1,68);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (63,'12:46 AM','5:18 PM','659 Sutteridge Junction','62 Bay Court',2,39);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (64,'11:06 AM','11:24 AM','8081 Mayer Circle','9 3rd Point',5,63);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (65,'9:20 AM','3:04 AM','87 Towne Parkway','26 Steensland Road',5,25);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (66,'1:12 AM','12:05 PM','79269 Lotheville Road','3 Bobwhite Junction',2,13);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (67,'3:08 AM','12:19 AM','93676 Rowland Hill','21 Eagle Crest Center',1,49);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (68,'12:07 AM','9:20 PM','8 International Trail','7859 Hintze Crossing',5,80);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (69,'10:25 AM','11:53 AM','3275 Amoth Park','118 Ramsey Pass',3,6);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (70,'6:39 AM','2:19 AM','341 Ruskin Pass','557 Fremont Hill',3,63);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (71,'10:57 AM','1:54 PM','34 Mcguire Trail','4367 Linden Crossing',1,38);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (72,'11:44 AM','1:15 AM','7 Briar Crest Trail','1152 Mesta Avenue',1,12);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (73,'11:18 AM','7:20 PM','91 1st Trail','2811 Shelley Court',5,54);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (74,'9:08 AM','12:45 AM','3 Merry Plaza','935 Sauthoff Road',2,25);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (75,'12:42 AM','2:33 PM','49704 Del Mar Point','6 Sage Junction',1,56);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (76,'2:15 AM','11:37 PM','0107 Summit Point','2979 Oak Plaza',2,26);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (77,'12:49 AM','2:00 PM','52100 Parkside Terrace','831 Fisk Way',3,1);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (78,'2:45 AM','5:22 PM','67512 Forest Run Pass','6 Rusk Avenue',3,9);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (79,'10:43 AM','11:06 AM','87210 Meadow Ridge Hill','92224 Mosinee Hill',1,98);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (80,'1:01 AM','3:21 PM','774 Merchant Place','3448 Forster Drive',2,68);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (81,'9:58 AM','7:34 AM','0 Pawling Crossing','057 Vidon Parkway',3,52);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (82,'8:14 AM','7:43 PM','2 Clove Park','9 1st Hill',5,14);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (83,'7:16 AM','10:33 AM','2205 Ridgeway Way','3 Thierer Junction',5,10);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (84,'10:41 AM','4:25 AM','2753 Lakewood Gardens Junction','6 Dorton Plaza',2,73);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (85,'5:33 AM','10:13 AM','07 Schurz Lane','53015 Old Shore Terrace',2,17);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (86,'9:49 AM','3:21 AM','0683 Macpherson Lane','0 Hoffman Junction',4,79);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (87,'8:47 AM','2:40 PM','14570 Graceland Avenue','66 Morrow Trail',5,5);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (88,'4:41 AM','6:56 PM','245 Arrowood Crossing','654 Meadow Vale Alley',4,33);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (89,'10:13 AM','2:36 PM','18 Caliangt Circle','68 Barby Road',3,81);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (90,'5:00 AM','4:59 AM','9545 Kenwood Circle','50618 Cascade Circle',1,61);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (91,'11:55 AM','2:24 PM','759 Ronald Regan Alley','072 Dixon Alley',5,35);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (92,'10:39 AM','10:47 AM','91469 Prairie Rose Hill','028 Menomonie Plaza',2,24);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (93,'9:13 AM','10:11 AM','67017 Rigney Road','78068 Vera Way',3,94);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (94,'8:06 AM','2:05 AM','25 Stone Corner Alley','3 Sycamore Point',5,52);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (95,'10:31 AM','1:27 AM','5 Pond Lane','856 Portage Court',2,56);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (96,'5:34 AM','8:48 AM','0752 Ohio Hill','4 Sutteridge Place',5,17);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (97,'10:59 AM','11:24 PM','62 Steensland Center','0086 Mesta Hill',3,27);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (98,'12:15 AM','9:35 PM','70 Anniversary Lane','256 Golf Course Street',4,47);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (99,'12:32 AM','8:34 PM','393 4th Hill','925 Holmberg Point',3,69);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (100,'6:33 AM','5:38 AM','460 Division Crossing','332 Eastlawn Court',4,94);

INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (1,'Milena','Westman','8/21/1958','6484 Anniversary Place','mwestman0@dailymail.co.uk',1);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (2,'Remington','Pollins','2/4/1923','0 Pleasure Terrace','rpollins1@jimdo.com',2);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (3,'Charmian','Flack','12/29/1969','2 Tomscot Street','cflack2@sun.com',3);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (4,'Maible','Niven','6/11/1961','24268 Farragut Street','mniven3@alibaba.com',4);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (5,'Trenton','Geroldi','3/10/1900','855 Sutherland Street','tgeroldi4@plala.or.jp',5);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (6,'Brigham','Basterfield','12/30/1972','8 Glendale Lane','bbasterfield5@examiner.com',6);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (7,'Berkeley','Jemmison','5/24/1938','57763 Susan Plaza','bjemmison6@feedburner.com',7);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (8,'Dorey','Joberne','12/29/1976','88 Dawn Place','djoberne7@gmpg.org',8);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (9,'Ignacio','O''Longain','7/3/1976','7145 Nelson Junction','iolongain8@csmonitor.com',9);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (10,'Arley','Kingham','1/18/2012','72 Maywood Street','akingham9@yahoo.com',10);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (11,'Kinnie','Oles','5/7/2020','2 Sugar Junction','kolesa@desdev.cn',11);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (12,'Charlena','Byfield','6/29/1967','0 Northport Circle','cbyfieldb@cbslocal.com',12);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (13,'Evelina','Sumner','9/1/2016','4 Mcguire Road','esumnerc@addtoany.com',13);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (14,'Bond','Petrushkevich','10/17/1989','62 Prairie Rose Pass','bpetrushkevichd@barnesandnoble.com',14);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (15,'Jyoti','Crow','9/13/1936','42 Nelson Way','jcrowe@blogspot.com',15);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (16,'Thurstan','Balcon','2/16/2011','08766 Hallows Point','tbalconf@army.mil',16);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (17,'Lucina','Spurr','10/13/1931','610 Continental Street','lspurrg@discuz.net',17);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (18,'Vinita','Bellison','8/23/2022','959 Maywood Hill','vbellisonh@sphinn.com',18);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (19,'Bevvy','Cawdery','6/2/2018','30 Melody Place','bcawderyi@cam.ac.uk',19);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (20,'Chicky','Tring','6/5/1989','234 Birchwood Circle','ctringj@macromedia.com',20);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (21,'Clarie','Nannizzi','5/11/1904','63 Cardinal Trail','cnannizzik@studiopress.com',21);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (22,'Kalina','Ellcome','12/19/2009','9 Ilene Plaza','kellcomel@themeforest.net',22);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (23,'Staci','Camplejohn','9/28/1941','51 Farmco Way','scamplejohnm@mapquest.com',23);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (24,'Germaine','Brognot','7/5/1960','111 Burrows Hill','gbrognotn@sogou.com',24);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (25,'Erinna','Smither','5/29/2011','5 Badeau Trail','esmithero@sitemeter.com',25);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (26,'Erminia','Densun','10/8/1923','72 Portage Place','edensunp@sina.com.cn',26);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (27,'Cairistiona','Eastbrook','10/20/1909','08406 Melody Drive','ceastbrookq@google.com.br',27);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (28,'Meta','Chanders','3/24/1915','3660 Sachs Terrace','mchandersr@google.ru',28);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (29,'Edythe','Mort','1/5/1940','86 Sullivan Crossing','emorts@japanpost.jp',29);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (30,'Danice','Longland','10/4/1944','5794 Eggendart Way','dlonglandt@umich.edu',30);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (31,'Jozef','Jaye','11/14/1915','198 Blaine Point','jjayeu@drupal.org',31);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (32,'Andrey','Spencook','2/4/1969','69 Lakewood Alley','aspencookv@ezinearticles.com',32);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (33,'Taddeusz','Hornig','5/24/1985','5120 Coleman Place','thornigw@phpbb.com',33);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (34,'Ray','Maria','12/26/2012','321 Nelson Drive','rmariax@discuz.net',34);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (35,'Scarface','Glowach','10/25/1950','232 Del Mar Circle','sglowachy@patch.com',35);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (36,'Immanuel','Glinde','8/15/1984','7 Eastlawn Park','iglindez@nsw.gov.au',36);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (37,'Lucais','Marquiss','2/17/1960','1180 Toban Alley','lmarquiss10@parallels.com',37);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (38,'Dun','Swale','9/23/2006','9448 Maryland Court','dswale11@wired.com',38);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (39,'Frank','Drepp','7/16/2019','5 Bay Drive','fdrepp12@independent.co.uk',39);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (40,'Dona','Klauber','9/13/2019','47 Arizona Drive','dklauber13@uol.com.br',40);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (41,'Terrance','Petrelli','2/7/2021','8709 Moose Point','tpetrelli14@hc360.com',41);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (42,'Edmund','Inglesfield','1/30/1941','4345 Weeping Birch Drive','einglesfield15@pagesperso-orange.fr',42);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (43,'Guglielmo','Valero','10/18/1984','2 Buena Vista Pass','gvalero16@fema.gov',43);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (44,'Tim','Hastelow','8/29/1979','07575 Mendota Terrace','thastelow17@digg.com',44);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (45,'Euell','Espley','7/28/2016','2964 Hanson Center','eespley18@wordpress.com',45);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (46,'Carina','Varlow','9/30/1905','5876 Moulton Park','cvarlow19@bigcartel.com',46);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (47,'Carmelia','Mapletoft','12/19/2000','16 Jay Court','cmapletoft1a@foxnews.com',47);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (48,'Gabriele','Middlehurst','1/24/1912','8 Westend Crossing','gmiddlehurst1b@ebay.co.uk',48);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (49,'Kristal','Gilmour','7/1/1909','4 Tennessee Road','kgilmour1c@yale.edu',49);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (50,'Jaime','Groveham','1/23/1983','2 Sloan Drive','jgroveham1d@shop-pro.jp',50);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (51,'Way','Pragnell','12/22/1908','9781 Ramsey Alley','wpragnell1e@icq.com',51);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (52,'Den','Mitchley','3/23/1976','3 Pine View Point','dmitchley1f@free.fr',52);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (53,'Raffaello','Perillo','10/23/1981','4203 Ramsey Alley','rperillo1g@meetup.com',53);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (54,'Barney','Wittman','5/18/1952','6 Ilene Place','bwittman1h@aol.com',54);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (55,'Rosabelle','Wreford','1/28/1900','79923 Veith Parkway','rwreford1i@omniture.com',55);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (56,'Toddy','Dutnell','4/27/1957','1 Anderson Drive','tdutnell1j@webnode.com',56);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (57,'Winona','Michelotti','8/23/1922','18352 1st Plaza','wmichelotti1k@trellian.com',57);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (58,'Tudor','Follos','3/16/1970','491 Bluejay Parkway','tfollos1l@foxnews.com',58);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (59,'Lynette','Golbourn','3/29/1918','94109 North Trail','lgolbourn1m@msu.edu',59);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (60,'Pattie','Selwyne','1/2/1913','2185 Welch Pass','pselwyne1n@techcrunch.com',60);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (61,'Gayler','Ellice','9/27/1912','4 Hauk Lane','gellice1o@zdnet.com',61);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (62,'Wendall','Clayborn','5/27/1985','17125 Canary Center','wclayborn1p@hc360.com',62);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (63,'Rey','Downse','1/3/1936','7 Birchwood Trail','rdownse1q@mtv.com',63);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (64,'Blanch','Swyer','3/8/1959','69799 Mockingbird Plaza','bswyer1r@wikispaces.com',64);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (65,'Ilse','Matyugin','3/1/1951','0771 7th Alley','imatyugin1s@freewebs.com',65);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (66,'Annmaria','Bowmer','10/31/1975','12917 Milwaukee Lane','abowmer1t@nifty.com',66);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (67,'Reagen','De Freyne','8/9/2018','99 Stoughton Street','rdefreyne1u@google.co.uk',67);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (68,'Cris','Gudyer','8/14/1925','89 Tennessee Plaza','cgudyer1v@cdc.gov',68);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (69,'Darby','Kennifeck','12/22/1997','91890 Havey Park','dkennifeck1w@msn.com',69);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (70,'Marcello','Ashbee','8/29/1950','5031 Meadow Valley Junction','mashbee1x@uiuc.edu',70);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (71,'Fidela','Gorriessen','10/5/1956','669 Armistice Drive','fgorriessen1y@latimes.com',71);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (72,'Eduard','Neale','3/8/2009','2168 Harper Point','eneale1z@jugem.jp',72);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (73,'Dorella','Rudeforth','2/4/1939','8 Hallows Circle','drudeforth20@feedburner.com',73);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (74,'Karalee','McPhelimy','6/28/1990','9 Myrtle Way','kmcphelimy21@cbslocal.com',74);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (75,'Sheena','Wontner','2/16/2011','0 Pleasure Parkway','swontner22@youtu.be',75);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (76,'Barbie','Hyndman','3/6/1995','9527 Superior Way','bhyndman23@sohu.com',76);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (77,'Tiebout','Salisbury','12/25/1949','4068 Carpenter Alley','tsalisbury24@vinaora.com',77);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (78,'Gifford','Mattin','5/27/1951','59 Killdeer Hill','gmattin25@fastcompany.com',78);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (79,'Geordie','Atyeo','8/21/1900','8 Twin Pines Trail','gatyeo26@usa.gov',79);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (80,'Gerri','Revens','10/31/1956','203 Elgar Lane','grevens27@theglobeandmail.com',80);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (81,'April','Brookson','1/24/1993','3 Vahlen Crossing','abrookson28@godaddy.com',81);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (82,'Vern','Stubbington','9/7/1925','976 Pepper Wood Trail','vstubbington29@pen.io',82);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (83,'Rowen','Cluckie','3/29/2015','6 Pawling Place','rcluckie2a@yandex.ru',83);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (84,'Pincas','Durdy','3/23/1947','83 Blue Bill Park Way','pdurdy2b@angelfire.com',84);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (85,'Brendan','Miliffe','4/12/1977','9 5th Court','bmiliffe2c@liveinternet.ru',85);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (86,'Dar','Alberts','4/24/1971','95928 Briar Crest Lane','dalberts2d@plala.or.jp',86);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (87,'Craggy','Edridge','3/30/2013','56379 Express Drive','cedridge2e@godaddy.com',87);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (88,'Webster','Broske','10/10/1986','2 Mesta Place','wbroske2f@ftc.gov',88);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (89,'Izak','Boor','8/5/1988','68209 Butterfield Park','iboor2g@imdb.com',89);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (90,'Patrizius','Jeste','2/5/2006','44049 Sachs Circle','pjeste2h@netvibes.com',90);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (91,'Florenza','Haugh','10/1/1963','35216 Shasta Circle','fhaugh2i@craigslist.org',91);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (92,'Nefen','Banasik','12/5/2002','759 Montana Avenue','nbanasik2j@biblegateway.com',92);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (93,'Deeanne','Lillywhite','10/30/1971','87296 American Ash Avenue','dlillywhite2k@google.co.jp',93);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (94,'Halsy','Wink','2/28/2018','2237 Melvin Street','hwink2l@census.gov',94);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (95,'Doti','Andrichuk','12/6/1925','91 Nevada Drive','dandrichuk2m@desdev.cn',95);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (96,'Onfre','Kohrs','6/17/1988','8 Buhler Pass','okohrs2n@microsoft.com',96);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (97,'Karie','Edwin','5/17/1930','03 Reinke Plaza','kedwin2o@house.gov',97);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (98,'Violet','Brownlie','11/30/1962','8 Tennessee Court','vbrownlie2p@about.me',98);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (99,'Leonanie','Opy','12/6/1907','63 Pepper Wood Hill','lopy2q@smh.com.au',99);
INSERT INTO Users(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (100,'Rubetta','Brayfield','4/21/1901','79972 Declaration Hill','rbrayfield2r@usnews.com',100);

INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (1,'Danidehe','2022-11-09 21:57:41','2022-07-19 04:47:02','2',75,14);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (2,'Binucayan','2023-04-06 21:19:08','2022-04-29 03:08:53','1',59,84);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (3,'Turku','2023-02-12 19:41:42','2022-05-15 21:04:23','4',90,67);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (4,'Shōbu','2023-03-06 14:45:45','2022-07-23 21:13:31','2',89,28);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (5,'Anshan','2023-03-29 17:27:14','2022-09-13 21:31:59','4',33,55);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (6,'Binucayan','2022-12-06 05:05:26','2022-07-22 22:19:08','3',5,17);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (7,'Aqaba','2023-01-26 22:24:32','2022-08-01 05:38:42','2',67,71);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (8,'Dongping','2022-11-06 10:58:35','2022-06-18 18:09:04','3',16,12);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (9,'Guder','2023-02-17 10:11:17','2022-08-27 00:00:24','5',61,35);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (10,'Danidehe','2022-12-02 19:34:15','2022-07-07 18:06:58','4',13,90);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (11,'Marugame','2022-11-08 05:38:34','2022-05-13 13:26:48','3',50,82);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (12,'Aqaba','2022-12-20 07:04:53','2022-08-31 21:31:11','5',10,57);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (13,'Guder','2023-01-30 07:15:00','2022-06-03 07:03:29','4',51,96);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (14,'Dongping','2022-11-22 20:00:59','2022-06-25 22:49:32','5',60,3);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (15,'Danidehe','2023-01-15 07:21:44','2022-04-22 11:41:04','5',66,81);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (16,'Turku','2022-12-17 16:06:06','2022-08-13 09:46:37','4',24,43);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (17,'Binucayan','2023-03-04 08:01:30','2022-08-03 23:07:07','5',69,13);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (18,'Shōbu','2023-03-04 13:03:26','2022-04-23 13:01:05','2',44,37);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (19,'Nancaicun','2023-03-26 07:47:30','2022-07-23 00:02:10','2',88,79);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (20,'Danidehe','2023-01-15 19:04:09','2022-08-14 06:43:59','3',40,30);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (21,'Anshan','2022-11-19 13:00:48','2022-09-08 22:35:41','4',8,48);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (22,'Binucayan','2022-10-01 07:32:31','2022-07-22 11:14:37','5',16,59);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (23,'Turku','2023-04-09 01:36:13','2022-07-17 20:42:11','5',13,53);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (24,'Danidehe','2023-01-14 17:21:32','2022-05-30 03:51:10','1',58,93);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (25,'Shōbu','2023-02-07 04:31:00','2022-09-26 19:26:24','2',29,91);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (26,'Nancaicun','2022-10-09 10:44:19','2022-04-28 22:59:16','1',85,66);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (27,'Marugame','2023-01-18 21:01:21','2022-06-11 15:52:05','2',8,16);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (28,'Shōbu','2023-01-09 15:07:50','2022-07-16 15:20:10','3',24,58);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (29,'Aqaba','2022-11-03 03:07:41','2022-09-19 07:28:53','3',40,78);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (30,'Dongping','2022-12-11 07:41:25','2022-08-16 22:32:16','4',77,44);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (31,'Shōbu','2022-11-25 23:43:06','2022-08-08 18:12:15','4',29,91);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (32,'Guder','2023-01-17 16:48:25','2022-07-16 01:19:20','5',78,16);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (33,'Anshan','2022-10-14 21:00:00','2022-09-27 13:28:47','2',26,13);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (34,'Danidehe','2022-12-28 13:20:21','2022-08-16 23:24:20','3',57,22);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (35,'Binucayan','2023-03-10 22:49:36','2022-05-18 22:26:13','1',8,65);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (36,'Shōbu','2022-12-12 22:05:12','2022-08-23 08:47:49','5',85,5);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (37,'Turku','2023-02-02 23:37:59','2022-05-20 08:15:13','3',41,95);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (38,'Anshan','2023-04-15 07:58:48','2022-08-01 22:47:58','3',13,70);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (39,'Nancaicun','2022-10-01 15:43:20','2022-04-20 11:08:10','1',34,46);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (40,'Aqaba','2022-11-30 11:20:30','2022-07-06 11:48:58','3',31,29);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (41,'Danidehe','2022-12-20 01:50:31','2022-05-09 12:07:18','4',17,29);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (42,'Guder','2023-03-16 10:28:06','2022-06-07 07:09:12','2',1,48);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (43,'Marugame','2022-10-14 18:57:26','2022-07-01 09:15:34','1',35,46);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (44,'Binucayan','2023-01-08 01:05:44','2022-08-19 10:51:47','3',8,39);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (45,'Turku','2023-03-28 23:30:15','2022-06-08 02:03:34','5',100,17);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (46,'Turku','2022-10-30 03:44:34','2022-06-29 10:00:23','5',83,79);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (47,'Anshan','2022-10-03 22:10:34','2022-08-04 20:32:28','2',92,94);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (48,'Guder','2023-04-03 06:28:05','2022-09-26 08:25:27','1',78,26);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (49,'Binucayan','2022-11-03 14:01:37','2022-08-08 14:19:23','1',65,78);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (50,'Aqaba','2022-10-18 01:56:53','2022-07-30 23:07:16','3',26,61);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (51,'Danidehe','2023-03-01 01:02:59','2022-07-02 10:14:11','4',21,62);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (52,'Aqaba','2023-01-12 21:55:34','2022-08-05 18:04:15','5',86,40);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (53,'Marugame','2022-10-01 03:45:58','2022-08-24 20:14:40','5',47,58);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (54,'Binucayan','2023-01-25 18:04:12','2022-06-07 02:19:22','2',74,18);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (55,'Anshan','2022-12-23 20:11:23','2022-08-15 18:45:16','2',96,84);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (56,'Dongping','2022-11-22 17:11:00','2022-06-29 22:04:34','3',15,68);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (57,'Marugame','2023-02-15 09:19:46','2022-06-22 01:44:16','3',20,10);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (58,'Binucayan','2022-11-16 15:44:53','2022-05-26 09:51:57','3',60,54);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (59,'Danidehe','2023-01-13 19:50:03','2022-07-31 17:18:21','1',95,81);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (60,'Turku','2023-03-30 16:25:04','2022-09-11 10:16:32','4',47,28);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (61,'Aqaba','2023-02-27 00:32:04','2022-08-01 03:06:39','5',93,93);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (62,'Turku','2023-01-05 08:40:47','2022-08-15 01:31:27','1',17,66);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (63,'Guder','2022-12-22 03:02:16','2022-06-15 02:27:53','4',2,65);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (64,'Danidehe','2023-03-03 01:36:20','2022-09-27 00:10:38','2',80,60);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (65,'Marugame','2022-12-15 12:56:18','2022-09-24 01:06:35','5',71,31);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (66,'Dongping','2023-04-16 21:20:22','2022-04-24 14:40:36','1',13,56);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (67,'Nancaicun','2023-01-21 20:33:16','2022-07-04 15:59:58','5',65,57);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (68,'Marugame','2023-03-11 23:47:51','2022-07-11 23:45:58','1',21,66);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (69,'Anshan','2022-11-13 15:43:26','2022-08-21 23:39:35','5',38,51);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (70,'Binucayan','2022-12-05 08:03:57','2022-08-04 22:34:23','3',98,17);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (71,'Anshan','2023-04-12 07:16:11','2022-08-23 16:04:10','3',65,91);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (72,'Nancaicun','2023-03-13 17:58:38','2022-09-14 09:46:41','3',31,35);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (73,'Aqaba','2023-02-04 15:55:09','2022-04-29 06:02:06','4',78,96);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (74,'Dongping','2022-11-26 02:17:01','2022-07-17 00:53:32','1',17,21);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (75,'Turku','2023-03-15 04:43:07','2022-05-19 10:33:49','1',40,70);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (76,'Dongping','2023-01-15 02:50:38','2022-09-16 22:56:19','2',46,16);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (77,'Turku','2022-10-05 17:31:10','2022-05-27 18:19:24','5',74,80);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (78,'Danidehe','2022-12-19 05:25:45','2022-07-31 22:25:54','2',50,71);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (79,'Binucayan','2022-11-24 12:01:51','2022-08-27 00:36:12','5',87,69);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (80,'Shōbu','2022-11-23 08:21:40','2022-07-17 12:50:02','1',9,54);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (81,'Anshan','2022-11-22 02:15:37','2022-09-27 07:47:43','5',85,44);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (82,'Dongping','2022-10-28 23:45:02','2022-05-24 10:13:54','4',94,96);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (83,'Shōbu','2022-11-26 14:11:03','2022-07-29 13:52:39','1',99,28);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (84,'Marugame','2023-02-08 06:31:06','2022-07-01 23:41:38','3',86,40);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (85,'Danidehe','2022-11-29 03:18:33','2022-06-07 10:49:58','4',57,56);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (86,'Anshan','2022-12-24 19:43:47','2022-08-01 11:57:48','4',77,100);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (87,'Marugame','2022-11-13 20:44:35','2022-06-05 17:08:09','5',45,47);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (88,'Guder','2022-11-18 03:59:11','2022-09-08 15:38:32','3',40,92);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (89,'Danidehe','2022-11-28 23:07:15','2022-04-20 04:08:34','3',97,69);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (90,'Turku','2023-03-03 14:48:12','2022-09-04 02:42:45','4',75,90);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (91,'Aqaba','2023-02-16 22:28:50','2022-09-02 16:02:59','3',62,38);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (92,'Binucayan','2022-12-13 12:18:05','2022-05-13 07:21:12','4',83,87);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (93,'Dongping','2023-01-10 22:13:50','2022-07-05 19:36:49','3',57,64);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (94,'Marugame','2022-11-16 17:22:42','2022-08-13 19:28:11','1',64,85);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (95,'Anshan','2023-04-14 17:03:51','2022-05-21 06:57:08','1',63,95);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (96,'Shōbu','2022-10-29 02:33:02','2022-04-23 02:01:42','2',43,2);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (97,'Danidehe','2022-10-13 08:39:46','2022-08-20 15:29:12','3',74,59);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (98,'Turku','2022-10-23 10:29:45','2022-05-07 06:21:31','4',60,68);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (99,'Guder','2023-01-29 12:58:15','2022-07-29 11:24:17','5',67,46);
INSERT INTO WorkOrders(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (100,'Dongping','2022-10-17 22:53:55','2022-05-30 00:36:33','4',71,65);
