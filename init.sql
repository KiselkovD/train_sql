-- Schema railway
CREATE SCHEMA IF NOT EXISTS railway DEFAULT CHARACTER SET utf8 ;
USE railway ;

-- Table railway.road
CREATE TABLE IF NOT EXISTS railway.road (
  road_id INT AUTO_INCREMENT PRIMARY KEY,
  road_name VARCHAR(45) NOT NULL,
  road_length INT NULL,
  road_number_of_paths INT NULL,
  road_average_cost INT NULL
);

-- Table railway.station
CREATE TABLE IF NOT EXISTS railway.station (
  station_id INT AUTO_INCREMENT PRIMARY KEY,
  station_name VARCHAR(45) NOT NULL,
  station_number_of_paths INT NULL,
  station_ECP_code VARCHAR(5) NULL
);

-- Table railway.carriage
CREATE TABLE IF NOT EXISTS railway.carriage (
  carriage_id INT NOT NULL AUTO_INCREMENT,
  carriage_position_on_the_train INT NULL,
  carriage_brand VARCHAR(45) NULL,
  carriage_carrying_capacity INT NULL,
  carriage_cost INT NULL,
  carriage_commissioning_date DATE NULL,
  carriage_number VARCHAR(8) NULL,
  station_station_id INT NOT NULL,
  FOREIGN KEY (station_station_id) REFERENCES railway.station(station_id),
  PRIMARY KEY (carriage_id/*, station_station_id*/)
);
-- bc of 2 PRIM KEY in carriage:
-- ALTER TABLE railway.carriage ADD UNIQUE (carriage_id); 

-- Table `railway`.`carriage_group`
CREATE TABLE IF NOT EXISTS railway.carriage_group (
  carriage_group_id INT NOT NULL,
  carriage_carriage_id INT NOT NULL,
  FOREIGN KEY (carriage_carriage_id) REFERENCES railway.carriage(carriage_id),
  PRIMARY KEY (carriage_group_id/*, carriage_carriage_id*/)
);
-- bc of 2 PRIM KEY in carriage_group:
-- ALTER TABLE railway.carriage_group ADD UNIQUE (carriage_group_id); 

-- Table `railway`.`locomotive`
CREATE TABLE IF NOT EXISTS railway.locomotive (
  locomotive_id INT NOT NULL AUTO_INCREMENT,
  locomotive_price INT NULL,
  locomotive_commissioning_date DATE NULL,
  locomotive_number VARCHAR(8) NULL,
  station_station_id INT NOT NULL,
  FOREIGN KEY (station_station_id) REFERENCES railway.station(station_id),
  PRIMARY KEY (locomotive_id/*, station_station_id*/)
);
-- bc of 2 PRIM KEY in locomotive:
-- ALTER TABLE railway.locomotive ADD UNIQUE (locomotive_id); 

-- Table `railway`.`train`
CREATE TABLE IF NOT EXISTS railway.train (
  train_id INT NOT NULL AUTO_INCREMENT,
  train_cipher VARCHAR(4) NULL,
  carriage_group_carriage_group_id INT NOT NULL,
  locomotive_locomotive_id INT NOT NULL,
  FOREIGN KEY (carriage_group_carriage_group_id) REFERENCES railway.carriage_group(carriage_group_id),
  FOREIGN KEY (locomotive_locomotive_id) REFERENCES railway.locomotive(locomotive_id),
  PRIMARY KEY (train_id/*, carriage_group_carriage_group_id, locomotive_locomotive_id*/)
);
-- bc of 3 PRIM KEY in train:
-- ALTER TABLE railway.train ADD UNIQUE (train_id); 

-- Table railway.road_has_station
CREATE TABLE IF NOT EXISTS railway.road_has_station (
    road_road_id INT,
    station_station_id INT,
		FOREIGN KEY (road_road_id) REFERENCES railway.road(road_id),
    FOREIGN KEY (station_station_id) REFERENCES railway.station(station_id),
    PRIMARY KEY (road_road_id, station_station_id)
);
-- bc of 2 PRIM KEY in road_has_station:
-- ALTER TABLE railway.road_has_station ADD UNIQUE (road_road_id); 

-- Table `railway`.`existing`
CREATE TABLE IF NOT EXISTS railway.existing (
  existing_exist TINYINT NOT NULL,
  train_train_id INT NOT NULL,
  FOREIGN KEY (train_train_id) REFERENCES railway.train(train_id),
  PRIMARY KEY (train_train_id)
);

-- Table `railway`.`train_has_station`
CREATE TABLE IF NOT EXISTS railway.train_has_station (
  train_train_id INT NOT NULL,
  station_station_id INT NOT NULL,
  arrival_date DATE NULL,
  departure_date DATE NULL,
  FOREIGN KEY (train_train_id) REFERENCES railway.train(train_id),
  FOREIGN KEY (station_station_id) REFERENCES railway.station(station_id),
  PRIMARY KEY (train_train_id, station_station_id)
);
insert into railway.road values(1,'AC',1000,1000,1000);
insert into railway.road values(2,'CD',1000,1000,1000);
insert into railway.road values(3,'AD',1000,1000,1000);

insert into railway.station values(1,'NULL',NULL,NULL);
insert into railway.station values(2,'A',1000,'1111');
insert into railway.station values(3,'B',1000,'1112');
insert into railway.station values(4,'C',1000,'1113');
insert into railway.station values(5,'D',1000,'1114');

insert into railway.carriage values(1,NULL,NULL,NULL,NULL,NULL,NULL,1);
insert into railway.carriage values(2,2,'x1',1000,1000,'2000-01-01','11111111',2);
insert into railway.carriage values(3,2,'x2',1000,1000,'2000-01-01','11111111',2);
insert into railway.carriage values(4,2,'x3',1000,1000,'2000-01-01','11111111',2);
insert into railway.carriage values(5,2,'y1',1000,1000,'2000-01-01','11111111',4);
insert into railway.carriage values(6,2,'y2',1000,1000,'2000-01-01','11111111',4);

insert into railway.locomotive values(1,1000,'2000-01-01','11111111',2);
insert into railway.locomotive values(2,1000,'2000-01-01','11111111',5);

insert into railway.road_has_station values(1,2);
insert into railway.road_has_station values(1,3);
insert into railway.road_has_station values(1,4);
insert into railway.road_has_station values(2,4);
insert into railway.road_has_station values(2,5);
insert into railway.road_has_station values(3,2);
insert into railway.road_has_station values(3,5);