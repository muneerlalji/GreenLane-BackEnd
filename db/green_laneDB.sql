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
    DS_stationID int,
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
    cityID int not null,
    numBikes int,
    primary key (stationID),
    Constraint fk_5 FOREIGN KEY (cityID) REFERENCES City(cityID)
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
INSERT INTO City(cityID,cityName,numStations,numBikes) VALUES (7,'Marugame',27,658);
INSERT INTO City(cityID,cityName,numStations,numBikes) VALUES (8,'Binucayan',16,996);
INSERT INTO City(cityID,cityName,numStations,numBikes) VALUES (9,'Nancaicun',8,330);
INSERT INTO City(cityID,cityName,numStations,numBikes) VALUES (10,'Aqaba',23,58);

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

INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (1,'2022-06-05 23:37:00','2022-11-20 05:11:48','1902 Reindahl Park','3845 Montana Alley',2,74);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (2,'2022-05-25 05:49:22','2022-08-13 12:41:47','3 Muir Park','1797 Ramsey Place',2,21);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (3,'2022-05-25 19:41:15','2022-07-01 20:19:48','5684 Mosinee Alley','51 Grayhawk Way',1,40);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (4,'2022-09-04 22:59:28','2022-07-01 09:12:34','806 Del Sol Way','84 Cottonwood Trail',1,16);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (5,'2022-06-24 11:26:42','2022-01-31 21:20:05','48 Thackeray Court','2 Amoth Street',4,86);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (6,'2022-05-02 17:24:03','2022-03-25 18:12:11','74 Katie Circle','93 South Way',3,70);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (7,'2022-04-20 18:56:54','2022-06-30 19:42:36','3 Pierstorff Trail','15 Sommers Terrace',4,90);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (8,'2022-08-16 00:55:55','2023-01-07 16:12:03','0 Hintze Terrace','6 Loomis Point',3,17);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (9,'2022-08-21 00:51:52','2022-01-09 16:07:01','5376 Marquette Terrace','207 Harper Place',4,89);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (10,'2022-09-28 21:07:21','2023-02-01 01:31:27','195 Mayer Plaza','77948 Namekagon Pass',3,83);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (11,'2022-06-07 04:07:28','2022-12-13 02:05:46','4446 Tennessee Point','9 Merrick Park',1,9);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (12,'2022-07-01 23:52:18','2023-03-13 07:23:27','642 Tennyson Pass','980 Dottie Lane',5,66);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (13,'2022-09-26 12:54:09','2022-01-30 19:32:25','10 Donald Plaza','7 Bay Park',2,7);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (14,'2022-09-05 13:52:56','2022-05-26 16:01:09','504 Shopko Center','3719 Del Mar Parkway',5,40);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (15,'2022-06-09 21:46:51','2023-02-12 11:39:01','044 Stoughton Street','22 Towne Way',4,84);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (16,'2022-06-28 20:53:15','2022-02-05 01:12:45','8638 Gale Junction','766 Truax Lane',1,55);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (17,'2022-05-08 09:09:20','2023-04-14 19:46:39','12747 Amoth Crossing','3 Maple Junction',1,40);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (18,'2022-08-14 20:30:53','2021-11-05 00:29:58','7 Gale Place','557 Westport Plaza',4,28);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (19,'2022-09-14 21:26:07','2022-02-04 09:41:56','266 Comanche Center','39566 Schmedeman Plaza',4,46);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (20,'2022-04-26 11:07:12','2023-01-18 12:56:58','0890 Buell Terrace','03059 Lerdahl Crossing',4,78);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (21,'2022-06-22 15:44:25','2023-02-19 11:21:34','26 Magdeline Court','0180 Coleman Trail',2,53);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (22,'2022-07-16 07:49:32','2023-01-24 12:49:00','62793 Dryden Terrace','4832 Merry Drive',1,91);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (23,'2022-09-13 01:48:42','2022-07-18 17:58:50','5980 Starling Center','2441 Mccormick Pass',3,92);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (24,'2022-08-25 03:48:29','2022-06-18 23:27:49','418 Eggendart Alley','04 Luster Pass',3,14);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (25,'2022-09-13 07:36:18','2022-06-26 15:24:30','176 Grasskamp Avenue','4 Jenna Road',2,74);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (26,'2022-09-10 21:01:31','2022-12-13 14:55:00','6 Everett Trail','2 Blaine Center',4,43);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (27,'2022-06-23 22:40:39','2021-10-29 18:11:51','66 Nelson Center','8174 Talisman Terrace',4,36);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (28,'2022-07-10 22:45:57','2022-05-28 08:08:46','9832 Eastwood Hill','21827 Granby Avenue',1,18);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (29,'2022-07-01 23:10:33','2022-07-06 06:18:48','8517 Sherman Pass','9500 Summit Crossing',1,97);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (30,'2022-05-08 18:59:24','2022-12-09 16:17:44','5 Chive Lane','66 Sheridan Terrace',5,2);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (31,'2022-05-04 00:59:19','2022-01-25 17:03:05','6 Nelson Alley','46 Bellgrove Place',1,89);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (32,'2022-08-03 07:22:57','2022-02-17 22:21:17','051 Nevada Avenue','5 Sugar Drive',3,61);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (33,'2022-06-23 11:59:55','2022-10-08 16:35:50','450 Shasta Place','4 Nancy Road',4,62);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (34,'2022-04-28 08:30:49','2022-03-25 17:25:00','61028 Bobwhite Circle','2 Bellgrove Terrace',3,12);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (35,'2022-07-20 00:14:09','2022-01-22 04:51:31','20 Ronald Regan Center','576 Arrowood Alley',3,49);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (36,'2022-05-10 15:39:28','2022-03-05 06:15:42','928 Cody Hill','3845 Jenna Trail',1,63);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (37,'2022-09-15 09:32:25','2022-06-16 11:09:14','3 Marcy Drive','714 Maple Plaza',3,47);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (38,'2022-05-05 03:54:42','2021-11-25 20:42:44','373 Stone Corner Point','3 Maple Wood Pass',4,26);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (39,'2022-08-19 08:53:31','2022-02-24 17:13:46','9 Bultman Street','2415 Cottonwood Crossing',5,17);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (40,'2022-08-15 09:20:04','2023-01-29 01:16:48','01 Arapahoe Place','594 Scott Place',5,55);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (41,'2022-06-12 11:22:39','2022-06-14 15:11:14','57 Gulseth Crossing','7317 Portage Park',4,74);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (42,'2022-09-28 06:28:32','2022-05-13 22:57:00','91 Novick Crossing','46258 Prairieview Circle',3,89);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (43,'2022-06-20 01:48:07','2023-02-12 13:19:58','415 Hooker Junction','4 Portage Crossing',5,94);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (44,'2022-06-30 18:29:26','2022-03-16 08:28:44','7 4th Point','00313 Kennedy Avenue',2,97);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (45,'2022-04-19 10:35:28','2022-04-29 03:22:44','6838 Vernon Way','50690 Manitowish Terrace',5,47);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (46,'2022-07-23 23:38:07','2023-04-14 08:31:05','34291 Di Loreto Circle','23708 Tennessee Plaza',1,83);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (47,'2022-08-21 15:15:17','2023-01-21 10:46:43','0323 Rowland Court','18 Riverside Point',4,3);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (48,'2022-08-01 20:25:53','2022-07-20 21:34:02','7 Rieder Parkway','19 Red Cloud Plaza',1,39);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (49,'2022-06-29 08:03:15','2023-01-06 10:25:46','7 Dennis Alley','0532 Schiller Trail',5,35);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (50,'2022-05-01 20:28:16','2021-10-22 16:48:03','84295 Montana Point','03 Redwing Way',5,98);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (51,'2022-04-25 10:02:34','2022-04-11 14:42:49','8 Algoma Drive','0 Buell Parkway',1,81);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (52,'2022-06-08 22:06:06','2023-02-24 09:08:29','60538 Fordem Lane','641 Arkansas Parkway',5,64);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (53,'2022-05-18 02:03:17','2022-01-13 07:06:31','5 Sage Way','11474 Stang Crossing',1,49);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (54,'2022-05-20 07:18:53','2022-02-06 14:34:06','71477 Oak Street','33 Waxwing Junction',3,20);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (55,'2022-08-08 11:35:24','2022-05-17 05:16:50','5624 Commercial Lane','4 Shoshone Street',4,14);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (56,'2022-05-09 09:25:24','2023-03-06 06:04:30','75 Mesta Circle','0333 Grasskamp Hill',3,55);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (57,'2022-07-20 07:18:22','2023-01-26 06:29:25','695 Upham Parkway','563 Londonderry Hill',1,97);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (58,'2022-06-07 02:45:13','2023-01-03 01:49:46','0 Tomscot Drive','8 Cody Drive',4,40);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (59,'2022-08-31 01:18:06','2022-05-06 01:05:32','089 Rutledge Terrace','50841 Westend Circle',5,10);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (60,'2022-09-19 06:53:36','2021-10-28 14:00:07','534 Kedzie Court','34294 Melvin Hill',3,8);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (61,'2022-04-21 23:27:01','2022-09-09 07:52:07','37 Fuller Way','64065 Utah Junction',5,26);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (62,'2022-08-28 18:22:11','2022-04-15 23:20:15','5 Golden Leaf Trail','391 Daystar Hill',3,28);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (63,'2022-04-27 07:56:29','2022-04-09 12:31:27','9958 Maryland Road','9472 Talmadge Park',2,2);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (64,'2022-05-30 15:14:04','2022-03-25 08:33:44','47 Elgar Terrace','4373 Del Sol Court',5,49);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (65,'2022-06-15 00:09:01','2022-06-13 14:30:43','136 Miller Court','46416 Vidon Street',5,64);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (66,'2022-06-16 22:28:33','2022-11-24 01:56:27','724 Moose Drive','8 Everett Circle',3,48);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (67,'2022-06-21 11:19:51','2022-11-17 17:09:35','319 Graedel Plaza','9185 Vidon Center',1,20);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (68,'2022-07-02 15:03:00','2021-11-12 11:59:41','4107 Hoard Plaza','6150 Westridge Court',4,56);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (69,'2022-06-09 13:57:31','2023-01-29 20:59:20','8 Mockingbird Road','7 Pepper Wood Alley',3,74);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (70,'2022-04-23 13:39:33','2022-04-13 07:21:10','0 Vidon Point','042 Weeping Birch Street',1,1);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (71,'2022-07-29 04:40:21','2022-06-05 20:05:11','64876 1st Avenue','2267 Darwin Street',2,59);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (72,'2022-05-16 11:35:02','2021-12-08 06:57:20','2596 Northridge Pass','3 Lawn Trail',1,2);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (73,'2022-08-14 13:26:00','2022-04-15 03:14:22','372 Lake View Place','5338 Artisan Terrace',4,14);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (74,'2022-06-12 10:54:46','2022-01-01 06:19:23','9 Bluejay Center','43 Fulton Trail',3,81);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (75,'2022-06-04 16:49:25','2022-11-11 17:24:57','1320 Waywood Circle','5252 Parkside Court',4,9);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (76,'2022-09-26 03:16:14','2022-11-12 07:48:10','5397 Starling Junction','896 Village Green Pass',2,63);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (77,'2022-08-03 08:05:47','2022-05-28 01:32:19','41152 Clove Lane','67 Lighthouse Bay Hill',5,48);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (78,'2022-04-18 23:28:05','2022-07-07 03:34:31','71 Green Ridge Road','29 Park Meadow Plaza',1,14);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (79,'2022-09-16 04:32:48','2022-05-03 03:55:52','56098 Schmedeman Avenue','41585 Stone Corner Way',2,4);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (80,'2022-08-30 00:58:02','2022-12-28 01:33:29','39478 Ridgeview Crossing','196 Westend Junction',2,56);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (81,'2022-06-09 03:51:28','2021-10-20 08:20:27','8 Dayton Circle','8283 Little Fleur Drive',4,70);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (82,'2022-09-16 07:36:34','2023-01-04 07:11:03','65278 Clyde Gallagher Center','192 Cottonwood Hill',3,9);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (83,'2022-05-16 18:34:35','2022-02-16 14:22:14','12945 Burrows Junction','1128 Raven Drive',5,58);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (84,'2022-07-26 01:42:42','2022-12-31 01:31:50','3 Maywood Terrace','395 Gale Hill',2,57);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (85,'2022-05-29 01:08:52','2022-05-11 02:52:46','604 Elmside Terrace','850 American Point',4,6);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (86,'2022-06-15 19:17:19','2022-05-05 04:17:50','8 Mayer Center','00 Corry Park',4,69);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (87,'2022-07-27 10:18:53','2023-01-09 00:09:58','1573 Kings Street','3323 Lunder Place',1,44);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (88,'2022-07-24 08:39:53','2022-01-27 13:45:08','8 Maywood Street','2 David Point',3,71);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (89,'2022-08-11 00:06:36','2022-09-16 10:33:25','63573 Summerview Drive','9 Rieder Street',2,74);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (90,'2022-08-08 05:33:50','2022-05-31 22:23:25','9394 Dapin Point','62267 Sage Junction',5,14);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (91,'2022-05-22 01:39:19','2022-11-04 13:51:33','76 Nancy Point','287 Hanover Way',5,86);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (92,'2022-09-08 07:03:59','2022-02-20 11:16:23','72 Del Mar Place','9 Bluejay Junction',5,62);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (93,'2022-07-03 05:57:33','2022-12-01 01:22:16','50705 Merry Parkway','96717 Rieder Court',4,65);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (94,'2022-06-10 12:12:19','2021-10-16 08:36:36','3 Stephen Trail','8 Lindbergh Plaza',5,58);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (95,'2022-07-24 20:34:48','2022-06-06 04:16:46','82 Kings Trail','37 Weeping Birch Terrace',5,19);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (96,'2022-08-26 20:31:23','2022-10-23 16:30:03','35 Dorton Circle','7839 Gulseth Parkway',1,50);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (97,'2022-08-04 04:14:54','2022-05-29 00:03:43','1114 Killdeer Circle','467 Buena Vista Court',2,92);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (98,'2022-05-07 18:13:14','2022-11-18 11:00:20','60 Bultman Drive','513 Nobel Plaza',1,86);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (99,'2022-06-18 05:19:04','2022-04-02 18:58:19','5754 Delladonna Road','0651 Kedzie Circle',4,29);
INSERT INTO RideHistory(historyID,startTime,endTime,startLoc,endLoc,rating,CR_rideID) VALUES (100,'2022-07-15 18:56:31','2022-09-03 22:47:27','50 Commercial Hill','4 Oak Plaza',5,99);


INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (1,'Nedi','Eadie','1968-04-22','10 Carpenter Center','neadie0@dmoz.org',1);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (2,'Zarla','O''Keefe','1915-10-12','0555 Boyd Drive','zokeefe1@scientificamerican.com',2);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (3,'Dorisa','Dow','1967-10-22','53697 Lawn Way','ddow2@arizona.edu',3);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (4,'Adah','Parnall','1954-02-23','479 Monterey Lane','aparnall3@weebly.com',4);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (5,'Burlie','Nunn','1955-01-28','5508 Prentice Circle','bnunn4@hud.gov',5);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (6,'Christel','Dilgarno','1934-01-20','2 Hallows Center','cdilgarno5@gizmodo.com',6);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (7,'Kathryne','Stredwick','1918-11-07','8608 Ruskin Hill','kstredwick6@businessinsider.com',7);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (8,'Colan','Scattergood','1949-06-11','24 Red Cloud Place','cscattergood7@free.fr',8);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (9,'Norbert','Cossans','1901-02-06','83210 Clemons Junction','ncossans8@epa.gov',9);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (10,'Marne','Bignold','1922-09-08','536 Lake View Plaza','mbignold9@wiley.com',10);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (11,'Cathie','Curbishley','1900-05-07','0301 Roth Hill','ccurbishleya@fastcompany.com',11);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (12,'Sylvia','Chilton','1981-08-31','800 Dovetail Hill','schiltonb@time.com',12);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (13,'Barbaraanne','Lante','2001-06-01','16488 Kinsman Parkway','blantec@exblog.jp',13);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (14,'Devon','Olyfat','1977-03-22','843 Harbort Crossing','dolyfatd@bloglines.com',14);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (15,'Fanya','Addyman','1954-05-03','386 Armistice Street','faddymane@scribd.com',15);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (16,'Dwayne','McCrie','1913-09-28','4811 Luster Court','dmccrief@nifty.com',16);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (17,'Wendall','Wavell','1934-06-23','702 Moulton Alley','wwavellg@creativecommons.org',17);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (18,'Ichabod','Reily','2008-10-06','55278 Merry Court','ireilyh@addthis.com',18);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (19,'Floria','Elston','1936-10-07','4160 Anniversary Terrace','felstoni@dailymotion.com',19);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (20,'Morganne','Arends','1959-03-05','0 Browning Road','marendsj@amazon.co.jp',20);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (21,'Revkah','Spreadbury','1902-10-09','821 Burrows Circle','rspreadburyk@amazon.de',21);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (22,'Jackson','Haliday','1908-06-17','9473 Northwestern Place','jhalidayl@dropbox.com',22);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (23,'Franky','Dearnaley','2021-10-29','59 Magdeline Plaza','fdearnaleym@narod.ru',23);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (24,'Angela','Heaseman','1940-09-29','0 Londonderry Lane','aheasemann@posterous.com',24);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (25,'Joshia','McKeurton','1972-11-20','37852 Merry Pass','jmckeurtono@java.com',25);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (26,'Gauthier','Karadzas','1928-02-01','0 Northport Road','gkaradzasp@un.org',26);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (27,'Orelle','Gowlett','1995-07-28','546 Northview Terrace','ogowlettq@networksolutions.com',27);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (28,'Waverly','Heynel','1946-10-10','90594 Kropf Hill','wheynelr@mlb.com',28);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (29,'Solly','Plows','1988-11-15','0987 Lyons Avenue','splowss@netvibes.com',29);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (30,'Sylvia','Whiff','1946-06-11','27520 Stuart Junction','swhifft@ucla.edu',30);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (31,'Kirby','Bemlott','2019-12-20','13 Namekagon Terrace','kbemlottu@ehow.com',31);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (32,'Rafael','Bourley','1929-07-08','4 Evergreen Terrace','rbourleyv@homestead.com',32);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (33,'Rees','Antonijevic','1925-10-29','34119 Delladonna Crossing','rantonijevicw@google.cn',33);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (34,'Rollie','Farbrother','1923-05-24','887 Texas Avenue','rfarbrotherx@squidoo.com',34);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (35,'Juliet','Baudic','1952-08-24','7 Clarendon Circle','jbaudicy@altervista.org',35);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (36,'Avrom','Struis','1949-12-17','598 Spaight Way','astruisz@indiatimes.com',36);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (37,'Ella','Etteridge','1975-06-24','68668 Clemons Plaza','eetteridge10@umn.edu',37);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (38,'Bendick','Gherardi','2010-01-14','003 Red Cloud Hill','bgherardi11@163.com',38);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (39,'Bambie','Anersen','1943-03-29','1 5th Alley','banersen12@google.ru',39);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (40,'Ardra','Gatehouse','1914-10-06','6 Lakewood Lane','agatehouse13@parallels.com',40);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (41,'Olivette','Cawthorn','2017-08-30','0120 Golf View Avenue','ocawthorn14@cafepress.com',41);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (42,'Salvatore','Gerholz','1960-07-12','91 Golf Hill','sgerholz15@mtv.com',42);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (43,'Rivy','Geely','1967-08-01','593 Crownhardt Hill','rgeely16@issuu.com',43);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (44,'Alasdair','Beavington','1977-07-04','7271 Twin Pines Way','abeavington17@cbslocal.com',44);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (45,'Roley','Andren','1902-07-19','18 Bowman Circle','randren18@last.fm',45);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (46,'Lamont','Escalero','1932-12-12','6454 Memorial Way','lescalero19@360.cn',46);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (47,'Colver','Tweddle','1918-06-05','94879 Redwing Lane','ctweddle1a@imageshack.us',47);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (48,'Isacco','Kivelle','1997-02-04','76673 Arrowood Drive','ikivelle1b@wiley.com',48);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (49,'Tomasine','Davsley','2016-12-18','7717 6th Way','tdavsley1c@facebook.com',49);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (50,'Basil','McQueen','1938-01-06','39 Columbus Point','bmcqueen1d@accuweather.com',50);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (51,'Mimi','Galero','2014-07-19','5971 Elgar Alley','mgalero1e@facebook.com',51);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (52,'Melina','Anyon','2009-11-08','88 Swallow Hill','manyon1f@dropbox.com',52);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (53,'Abram','Mannering','1924-12-29','9 Moose Lane','amannering1g@simplemachines.org',53);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (54,'Hewet','Uebel','1917-10-14','3420 Bluestem Way','huebel1h@npr.org',54);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (55,'Winni','Vigours','1940-11-18','954 Moland Junction','wvigours1i@ovh.net',55);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (56,'Janis','Middlemiss','1990-10-24','5 Corry Pass','jmiddlemiss1j@gravatar.com',56);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (57,'Malva','Baile','2007-01-06','57 Hoffman Crossing','mbaile1k@cornell.edu',57);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (58,'Rorie','Poker','1932-08-22','67 Loomis Way','rpoker1l@tmall.com',58);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (59,'Jackie','Castro','1997-04-21','8827 Comanche Point','jcastro1m@samsung.com',59);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (60,'Archie','Daveridge','1942-11-11','9 Summer Ridge Road','adaveridge1n@purevolume.com',60);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (61,'Brodie','Lindner','2017-07-14','224 Spohn Trail','blindner1o@state.gov',61);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (62,'Debby','Gildea','2014-09-01','3237 La Follette Street','dgildea1p@reddit.com',62);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (63,'Yuma','Patek','1965-10-09','0480 Rigney Point','ypatek1q@virginia.edu',63);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (64,'Cairistiona','Lefeaver','2006-11-21','70339 Tony Way','clefeaver1r@cdbaby.com',64);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (65,'Gav','Seabert','2000-06-04','1 Dawn Way','gseabert1s@nbcnews.com',65);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (66,'Fredek','Tzar','1955-02-21','1 Fair Oaks Trail','ftzar1t@linkedin.com',66);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (67,'Bearnard','Tewkesbury','1903-11-11','3436 Melrose Road','btewkesbury1u@google.it',67);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (68,'Ajay','McGarrie','1910-12-18','3224 Clemons Plaza','amcgarrie1v@reverbnation.com',68);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (69,'Morse','Kave','1913-05-20','15318 Melrose Junction','mkave1w@unesco.org',69);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (70,'Andeee','Wines','1938-01-03','221 Ryan Plaza','awines1x@feedburner.com',70);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (71,'Abdel','Withrington','1910-12-13','104 Dryden Court','awithrington1y@geocities.com',71);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (72,'Sibbie','Scully','1992-06-23','0 Anzinger Lane','sscully1z@dailymotion.com',72);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (73,'Milka','Stoker','1999-01-11','42665 Dixon Pass','mstoker20@fema.gov',73);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (74,'Dulci','Cuttell','1964-05-20','0476 Marquette Court','dcuttell21@buzzfeed.com',74);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (75,'Alvin','Hould','1965-11-11','0 Colorado Point','ahould22@bloglovin.com',75);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (76,'Katuscha','Dunning','2022-07-22','4691 Miller Hill','kdunning23@chron.com',76);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (77,'Adolf','Porcas','2014-06-05','8 Norway Maple Avenue','aporcas24@redcross.org',77);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (78,'Virgil','Partleton','2014-07-25','2 Sunfield Plaza','vpartleton25@marriott.com',78);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (79,'Balduin','MacDonogh','1987-10-19','9885 Fisk Way','bmacdonogh26@scientificamerican.com',79);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (80,'Papageno','Stapylton','1921-09-05','635 Erie Pass','pstapylton27@tinyurl.com',80);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (81,'Jacinthe','Berger','1942-04-05','24 Pawling Place','jberger28@spotify.com',81);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (82,'Shayla','Grigolon','1986-05-08','690 Hudson Pass','sgrigolon29@ustream.tv',82);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (83,'Carlotta','Roggeman','1929-07-28','16 Mccormick Trail','croggeman2a@sfgate.com',83);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (84,'Tarra','Avraham','1955-01-04','98 Tony Parkway','tavraham2b@taobao.com',84);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (85,'Zachariah','McRory','1978-10-11','1728 Lien Center','zmcrory2c@barnesandnoble.com',85);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (86,'Herold','von Nassau','1944-10-29','71049 Moulton Circle','hvonnassau2d@ucsd.edu',86);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (87,'Auguste','Kielt','1971-01-06','59 Hagan Drive','akielt2e@blogs.com',87);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (88,'Bettine','Autry','1952-10-02','2 Sugar Drive','bautry2f@istockphoto.com',88);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (89,'Irene','Green','1933-05-27','15 Milwaukee Avenue','igreen2g@macromedia.com',89);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (90,'Addi','Rubinshtein','1971-07-28','3260 Randy Way','arubinshtein2h@yelp.com',90);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (91,'Buck','Dungay','1983-05-22','74481 Veith Street','bdungay2i@linkedin.com',91);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (92,'Peggie','Altoft','2015-06-25','5739 Heffernan Trail','paltoft2j@macromedia.com',92);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (93,'Clem','Seden','1931-09-04','44163 Armistice Place','cseden2k@illinois.edu',93);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (94,'Spencer','Harmston','1929-09-20','059 Stang Road','sharmston2l@smh.com.au',94);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (95,'Amelia','Di Bernardo','1957-08-29','8483 Graceland Junction','adibernardo2m@seattletimes.com',95);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (96,'Milo','Carden','2022-02-24','722 Kenwood Plaza','mcarden2n@google.ca',96);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (97,'Florence','Louca','2003-12-30','82 Nevada Lane','flouca2o@sakura.ne.jp',97);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (98,'Kelvin','Rankin','1903-02-03','1040 Ridgeway Point','krankin2p@un.org',98);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (99,'Lorie','Trowle','1994-09-17','52253 Kings Alley','ltrowle2q@friendfeed.com',99);
INSERT INTO Users(userID, lName, fName, dob, address, email, CR_rideID) VALUES (100,'Julian','Merrien','1904-06-11','99 Anniversary Avenue','jmerrien2r@globo.com',100);

INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (1,'Danidehe','2022-11-09 21:57:41','2022-07-19 04:47:02','2',75,14);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (2,'Binucayan','2023-04-06 21:19:08','2022-04-29 03:08:53','1',59,84);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (3,'Turku','2023-02-12 19:41:42','2022-05-15 21:04:23','4',90,67);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (4,'Shōbu','2023-03-06 14:45:45','2022-07-23 21:13:31','2',89,28);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (5,'Anshan','2023-03-29 17:27:14','2022-09-13 21:31:59','4',33,55);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (6,'Binucayan','2022-12-06 05:05:26','2022-07-22 22:19:08','3',5,17);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (7,'Aqaba','2023-01-26 22:24:32','2022-08-01 05:38:42','2',67,71);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (8,'Dongping','2022-11-06 10:58:35','2022-06-18 18:09:04','3',16,12);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (9,'Guder','2023-02-17 10:11:17','2022-08-27 00:00:24','5',61,35);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (10,'Danidehe','2022-12-02 19:34:15','2022-07-07 18:06:58','4',13,90);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (11,'Marugame','2022-11-08 05:38:34','2022-05-13 13:26:48','3',50,82);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (12,'Aqaba','2022-12-20 07:04:53','2022-08-31 21:31:11','5',10,57);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (13,'Guder','2023-01-30 07:15:00','2022-06-03 07:03:29','4',51,96);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (14,'Dongping','2022-11-22 20:00:59','2022-06-25 22:49:32','5',60,3);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (15,'Danidehe','2023-01-15 07:21:44','2022-04-22 11:41:04','5',66,81);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (16,'Turku','2022-12-17 16:06:06','2022-08-13 09:46:37','4',24,43);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (17,'Binucayan','2023-03-04 08:01:30','2022-08-03 23:07:07','5',69,13);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (18,'Shōbu','2023-03-04 13:03:26','2022-04-23 13:01:05','2',44,37);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (19,'Nancaicun','2023-03-26 07:47:30','2022-07-23 00:02:10','2',88,79);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (20,'Danidehe','2023-01-15 19:04:09','2022-08-14 06:43:59','3',40,30);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (21,'Anshan','2022-11-19 13:00:48','2022-09-08 22:35:41','4',8,48);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (22,'Binucayan','2022-10-01 07:32:31','2022-07-22 11:14:37','5',16,59);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (23,'Turku','2023-04-09 01:36:13','2022-07-17 20:42:11','5',13,53);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (24,'Danidehe','2023-01-14 17:21:32','2022-05-30 03:51:10','1',58,93);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (25,'Shōbu','2023-02-07 04:31:00','2022-09-26 19:26:24','2',29,91);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (26,'Nancaicun','2022-10-09 10:44:19','2022-04-28 22:59:16','1',85,66);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (27,'Marugame','2023-01-18 21:01:21','2022-06-11 15:52:05','2',8,16);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (28,'Shōbu','2023-01-09 15:07:50','2022-07-16 15:20:10','3',24,58);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (29,'Aqaba','2022-11-03 03:07:41','2022-09-19 07:28:53','3',40,78);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (30,'Dongping','2022-12-11 07:41:25','2022-08-16 22:32:16','4',77,44);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (31,'Shōbu','2022-11-25 23:43:06','2022-08-08 18:12:15','4',29,91);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (32,'Guder','2023-01-17 16:48:25','2022-07-16 01:19:20','5',78,16);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (33,'Anshan','2022-10-14 21:00:00','2022-09-27 13:28:47','2',26,13);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (34,'Danidehe','2022-12-28 13:20:21','2022-08-16 23:24:20','3',57,22);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (35,'Binucayan','2023-03-10 22:49:36','2022-05-18 22:26:13','1',8,65);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (36,'Shōbu','2022-12-12 22:05:12','2022-08-23 08:47:49','5',85,5);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (37,'Turku','2023-02-02 23:37:59','2022-05-20 08:15:13','3',41,95);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (38,'Anshan','2023-04-15 07:58:48','2022-08-01 22:47:58','3',13,70);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (39,'Nancaicun','2022-10-01 15:43:20','2022-04-20 11:08:10','1',34,46);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (40,'Aqaba','2022-11-30 11:20:30','2022-07-06 11:48:58','3',31,29);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (41,'Danidehe','2022-12-20 01:50:31','2022-05-09 12:07:18','4',17,29);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (42,'Guder','2023-03-16 10:28:06','2022-06-07 07:09:12','2',1,48);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (43,'Marugame','2022-10-14 18:57:26','2022-07-01 09:15:34','1',35,46);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (44,'Binucayan','2023-01-08 01:05:44','2022-08-19 10:51:47','3',8,39);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (45,'Turku','2023-03-28 23:30:15','2022-06-08 02:03:34','5',100,17);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (46,'Turku','2022-10-30 03:44:34','2022-06-29 10:00:23','5',83,79);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (47,'Anshan','2022-10-03 22:10:34','2022-08-04 20:32:28','2',92,94);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (48,'Guder','2023-04-03 06:28:05','2022-09-26 08:25:27','1',78,26);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (49,'Binucayan','2022-11-03 14:01:37','2022-08-08 14:19:23','1',65,78);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (50,'Aqaba','2022-10-18 01:56:53','2022-07-30 23:07:16','3',26,61);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (51,'Danidehe','2023-03-01 01:02:59','2022-07-02 10:14:11','4',21,62);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (52,'Aqaba','2023-01-12 21:55:34','2022-08-05 18:04:15','5',86,40);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (53,'Marugame','2022-10-01 03:45:58','2022-08-24 20:14:40','5',47,58);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (54,'Binucayan','2023-01-25 18:04:12','2022-06-07 02:19:22','2',74,18);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (55,'Anshan','2022-12-23 20:11:23','2022-08-15 18:45:16','2',96,84);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (56,'Dongping','2022-11-22 17:11:00','2022-06-29 22:04:34','3',15,68);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (57,'Marugame','2023-02-15 09:19:46','2022-06-22 01:44:16','3',20,10);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (58,'Binucayan','2022-11-16 15:44:53','2022-05-26 09:51:57','3',60,54);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (59,'Danidehe','2023-01-13 19:50:03','2022-07-31 17:18:21','1',95,81);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (60,'Turku','2023-03-30 16:25:04','2022-09-11 10:16:32','4',47,28);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (61,'Aqaba','2023-02-27 00:32:04','2022-08-01 03:06:39','5',93,93);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (62,'Turku','2023-01-05 08:40:47','2022-08-15 01:31:27','1',17,66);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (63,'Guder','2022-12-22 03:02:16','2022-06-15 02:27:53','4',2,65);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (64,'Danidehe','2023-03-03 01:36:20','2022-09-27 00:10:38','2',80,60);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (65,'Marugame','2022-12-15 12:56:18','2022-09-24 01:06:35','5',71,31);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (66,'Dongping','2023-04-16 21:20:22','2022-04-24 14:40:36','1',13,56);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (67,'Nancaicun','2023-01-21 20:33:16','2022-07-04 15:59:58','5',65,57);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (68,'Marugame','2023-03-11 23:47:51','2022-07-11 23:45:58','1',21,66);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (69,'Anshan','2022-11-13 15:43:26','2022-08-21 23:39:35','5',38,51);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (70,'Binucayan','2022-12-05 08:03:57','2022-08-04 22:34:23','3',98,17);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (71,'Anshan','2023-04-12 07:16:11','2022-08-23 16:04:10','3',65,91);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (72,'Nancaicun','2023-03-13 17:58:38','2022-09-14 09:46:41','3',31,35);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (73,'Aqaba','2023-02-04 15:55:09','2022-04-29 06:02:06','4',78,96);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (74,'Dongping','2022-11-26 02:17:01','2022-07-17 00:53:32','1',17,21);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (75,'Turku','2023-03-15 04:43:07','2022-05-19 10:33:49','1',40,70);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (76,'Dongping','2023-01-15 02:50:38','2022-09-16 22:56:19','2',46,16);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (77,'Turku','2022-10-05 17:31:10','2022-05-27 18:19:24','5',74,80);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (78,'Danidehe','2022-12-19 05:25:45','2022-07-31 22:25:54','2',50,71);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (79,'Binucayan','2022-11-24 12:01:51','2022-08-27 00:36:12','5',87,69);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (80,'Shōbu','2022-11-23 08:21:40','2022-07-17 12:50:02','1',9,54);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (81,'Anshan','2022-11-22 02:15:37','2022-09-27 07:47:43','5',85,44);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (82,'Dongping','2022-10-28 23:45:02','2022-05-24 10:13:54','4',94,96);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (83,'Shōbu','2022-11-26 14:11:03','2022-07-29 13:52:39','1',99,28);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (84,'Marugame','2023-02-08 06:31:06','2022-07-01 23:41:38','3',86,40);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (85,'Danidehe','2022-11-29 03:18:33','2022-06-07 10:49:58','4',57,56);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (86,'Anshan','2022-12-24 19:43:47','2022-08-01 11:57:48','4',77,100);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (87,'Marugame','2022-11-13 20:44:35','2022-06-05 17:08:09','5',45,47);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (88,'Guder','2022-11-18 03:59:11','2022-09-08 15:38:32','3',40,92);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (89,'Danidehe','2022-11-28 23:07:15','2022-04-20 04:08:34','3',97,69);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (90,'Turku','2023-03-03 14:48:12','2022-09-04 02:42:45','4',75,90);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (91,'Aqaba','2023-02-16 22:28:50','2022-09-02 16:02:59','3',62,38);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (92,'Binucayan','2022-12-13 12:18:05','2022-05-13 07:21:12','4',83,87);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (93,'Dongping','2023-01-10 22:13:50','2022-07-05 19:36:49','3',57,64);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (94,'Marugame','2022-11-16 17:22:42','2022-08-13 19:28:11','1',64,85);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (95,'Anshan','2023-04-14 17:03:51','2022-05-21 06:57:08','1',63,95);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (96,'Shōbu','2022-10-29 02:33:02','2022-04-23 02:01:42','2',43,2);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (97,'Danidehe','2022-10-13 08:39:46','2022-08-20 15:29:12','3',74,59);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (98,'Turku','2022-10-23 10:29:45','2022-05-07 06:21:31','4',60,68);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (99,'Guder','2023-01-29 12:58:15','2022-07-29 11:24:17','5',67,46);
INSERT INTO WorkOrders(reportID, loc, timeResolved, timeReported, reportType, B_bikeID, E_employeeID) VALUES (100,'Dongping','2022-10-17 22:53:55','2022-05-30 00:36:33','4',71,65);
