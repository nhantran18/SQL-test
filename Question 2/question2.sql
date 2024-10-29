-- QUESTION 2
-- Create schema for question 2
CREATE TABLE person (
	sin INTEGER PRIMARY KEY,
	name VARCHAR(100),
	address VARCHAR(100)
);

CREATE TABLE car (
	license VARCHAR(100) PRIMARY KEY,
	year INTEGER ,
	model VARCHAR(100)
);

CREATE TABLE owns (
	sin INTEGER,
	license VARCHAR(100)
);

CREATE TABLE accident (
	ID SERIAL PRIMARY KEY,
	acc VARCHAR(100),
	license VARCHAR(100),
	sin INTEGER,
	date DATE,
	city VARCHAR(100),
	damage VARCHAR(100)
);

-- Insert some data for testing 
INSERT INTO person (sin, name, address) 
VALUES
	('123456789', 'John Doe', '123 Elm St, Springfield'),
	('987654321', 'Jane Smith', '456 Oak St, Springfield'),
	('234567890', 'Alice Johnson', '789 Maple St, Springfield'),
	('345678901', 'Bob Brown', '321 Pine St, Springfield'),
	('456789012', 'Charlie Black', '654 Cedar St, Springfield'),
	('567890123', 'Daisy White', '987 Birch St, Springfield'),
	('678901234', 'Eve Green', '123 Walnut St, Springfield'),
	('789012345', 'Frank Blue', '456 Spruce St, Springfield'),
	('890123456', 'Grace Yellow', '789 Fir St, Springfield'),
	('901234567', 'Hank Purple', '321 Redwood St, Springfield'),
	('012345678', 'John Smith', '540 CMT8, HCMC');
	
INSERT INTO car (license, year, model) 
VALUES
	('ABC123', 2020, 'Toyota Camry'),
	('XYZ456', 2019, 'Honda Accord'),
	('LMN789', 2021, 'Ford Fusion'),
	('DEF234', 2018, 'Chevrolet Malibu'),
	('GHI567', 2020, 'Nissan Altima'),
	('JKL890', 2019, 'Hyundai Sonata'),
	('MNO123', 2021, 'Kia Optima'),
	('PQR456', 2017, 'Subaru Legacy'),
	('STU789', 2020, 'Volkswagen Passat'),
	('VWX012', 2018, 'Mazda 6'),
	('YZA345', 2021, 'Chrysler 300'),
	('BCD678', 2019, 'Dodge Charger'),
	('EFG901', 2020, 'Toyota Corolla'),
	('HIJ234', 2018, 'Honda Civic'),
	('KLM567', 2021, 'Ford Mustang'),
	('NOP890', 2019, 'Chevrolet Camaro'),
	('QRS123', 2020, 'Nissan Sentra'),
	('TUV456', 2018, 'Hyundai Elantra'),
	('WXY789', 2021, 'Kia Soul'),
	('ZAB012', 2019, 'Subaru Impreza'),
	('CDE345', 2020, 'Volkswagen Jetta'),
	('FGH678', 2020, 'Mazda'),
	('IKL901', 2020, 'Mazda');
	
INSERT INTO owns (sin, license) VALUES
	('123456789', 'ABC123'),
	('987654321', 'XYZ456'),
	('234567890', 'LMN789'),
	('345678901', 'DEF234'),
	('456789012', 'GHI567'),
	('567890123', 'JKL890'),
	('678901234', 'MNO123'),
	('789012345', 'PQR456'),
	('890123456', 'STU789'),
	('901234567', 'VWX012'),
	('123456789', 'YZA345'),
	('123456789', 'BCD678'),
	('234567890', 'EFG901'),
	('234567890', 'HIJ234'),
	('234567890', 'KLM567'),
	('567890123', 'NOP890'),
	('789012345', 'QRS123'),
	('456789012', 'TUV456'),
	('456789012', 'WXY789'),
	('456789012', 'ZAB012'),
	('456789012', 'IKL901'),
	('012345678', 'FGH678');
	
INSERT INTO accident (acc, license, sin, date, city, damage) 
VALUES
	(1, 'ABC123', '123456789', '2002-01-15', 'Springfield', 1500),
	(2, 'XYZ456', '987654321', '2002-02-20', 'Springfield', 2000),
	(3, 'LMN789', '234567890', '2023-03-10', 'Springfield', 1200),
	(4, 'DEF234', '345678901', '2023-04-05', 'Springfield', 1700),
	(5, 'GHI567', '456789012', '2002-05-25', 'Springfield', 3000),
	(6, 'JKL890', '567890123', '2023-06-12', 'Springfield', 2200),
	(7, 'MNO123', '678901234', '2023-07-19', 'Springfield', 1800),
	(8, 'PQR456', '789012345', '2023-08-30', 'Springfield', 1400),
	(9, 'STU789', '890123456', '2002-09-10', 'Springfield', 1600),
	(10, 'VWX012', '901234567', '2023-10-01', 'Springfield', 2500),
	(11, 'YZA345', '123456789', '2023-11-15', 'Springfield', 1900),
	(12, 'BCD678', '123456789', '2023-12-20', 'Springfield', 2100),
	(13, 'EFG901', '234567890', '2002-11-30', 'Springfield', 1300),
	(14, 'HIJ234', '234567890', '2023-10-12', 'Springfield', 3000),
	(15, 'KLM567', '234567890', '2002-08-05', 'Springfield', 2400),
	(16, 'NOP890', '567890123', '2023-07-18', 'Springfield', 2000),
	(17, 'QRS123', '789012345', '2023-06-29', 'Springfield', 1700),
	(18, 'TUV456', '456789012', '2002-05-15', 'Springfield', 1500),
	(19, 'WXY789', '456789012', '2023-04-11', 'Springfield', 1800),
	(20, 'ZAB012', '456789012', '2002-03-22', 'Springfield', 2200),
	(21, 'ZAB012', '123456789', '2002-03-22', 'Springfield', 2200);


-- Answer for question 2.1
-- Exist testcase that the driver is not the owner of the car -> we should join accident table on owns table (cannot get sin directed in accident table)
SELECT COUNT(DISTINCT owns.sin)
FROM accident 
JOIN owns
ON accident.license = owns.license
WHERE EXTRACT(YEAR FROM date) = 2002;

-- Answer for question 2.2
SELECT sin, COUNT(id) AS num_of_accidents
FROM accident
WHERE (accident.license, accident.sin) IN (
	SELECT license, sin 
	FROM owns
)
GROUP BY sin;

-- Answer for question 2.3
-- To delete the car 'Mazda' belonging to 'John Smith', I am going to delete record in car table and delete record in owns table
DELETE FROM owns
WHERE license IN (
	SELECT c.license
	FROM car c 
	JOIN owns o ON c.license = o.license
	JOIN person p ON o.sin = p.sin
	WHERE c.model = 'Mazda' AND p.name= 'John Smith'
);

DELETE FROM car
WHERE car.model = 'Mazda' AND car.license IN (
	SELECT c.license
	FROM car c 
	JOIN owns o ON c.license = o.license
	JOIN person p ON o.sin = p.sin
	WHERE c.model = 'Mazda' AND p.name= 'John Smith'
);