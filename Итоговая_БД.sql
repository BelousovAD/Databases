use bus_service;
go
if object_id('Ticket', 'U') is not null 
drop table Ticket;
if object_id('TicketOffice', 'U') is not null 
drop table TicketOffice;
if object_id('Trip', 'U') is not null 
drop table Trip;
if object_id('Client', 'U') is not null 
drop table Client;
if object_id('Routee', 'U') is not null 
drop table Routee;
if object_id('Driver', 'U') is not null 
drop table Driver;
if object_id('Bus', 'U') is not null 
drop table Bus;
if object_id('City', 'U') is not null 
drop table City;
go

create table City (
ID int primary key identity not null,
Namee nvarchar(30) not null
);

create table Bus (
ID int primary key identity not null,
Trademark nvarchar(30) not null,
QuantityPlace int not null,
StateNumber nvarchar(5) not null,
);

create table Driver (
ID int primary key identity not null,
Namee nvarchar(30) not null,
ID_City int references City(ID) not null
);

create table Routee (
ID int primary key identity not null,
DaysInRoutee int not null,
TimeDeparture time(0) not null,
TimeArrival time(0) not null,
ID_CityDeparture int references City(ID) not null,
ID_CityArrival int references City(ID) not null,
Price money not null,
MIN_QuantityPlace int not null
);

create table Client (
ID int primary key identity not null,
Namee nvarchar(30) not null,
Info nvarchar
);

create table Trip (
ID int primary key identity not null,
ID_Routee int references Routee(ID) not null,
ID_Bus int references Bus(ID) not null,
ID_Driver int references Driver(ID) not null,
DateArrival date not null
);

create table TicketOffice (
ID int primary key identity not null,
ID_City int references City(ID) not null,
Addresss nvarchar(max)
);

create table Ticket (
ID int primary key identity not null,
ID_TicketOffice int references TicketOffice(ID) not null,
ID_Trip int references Trip(ID) not null,
Place int not null,
DateOfSale date not null,
ID_Client int references Client(ID) not null
);

insert City
    values ('Томск'),
		('Новосибирск'),
		('Иркутск'),
		('Красноярск')

insert Bus 
    values ('Икарус', 45, 'АО308'),
	('Икарус', 45, 'СР410'),
	('ПАЗ', 30, 'РС410'),
	('ПАЗ', 30, 'НН522'),
	('ПАЗ', 30, 'ЕК100'),
	('Икарус', 45, 'МВ737'),
	('Daewoo', 50, 'АС333'),
	('Daewoo', 50, 'СС345'),
	('ПАЗ', 30, 'РО142')

insert Driver 
	values ('Андрей', 1),
	('Максим', 2),
	('Алексей', 3),
	('Марк', 4),
	('Дмитрий', 1),
	('Леонид', 2),
	('Добрыня', 3),
	('Илья', 4),
	('Кирилл', 1),
	('Никита', 2)

insert Routee
	values (2, '20:32', '06:01', 1, 2, 67, 30),
	(7, '10:54', '09:30', 2, 4, 34, 45),
	(5, '04:30', '23:40', 3, 4, 89, 30),
	(5, '07:11', '19:45', 4, 1, 135, 30),
	(4, '14:15', '20:00', 1, 4, 45, 30),
	(3, '23:55', '17:29', 2, 1, 56, 30),
	(2, '13:28', '03:05', 3, 1, 67, 45),
	(4, '16:56', '01:19', 4, 1, 45, 50)
		
insert Client
	values ('Филипп', null),
		('Осип', null),
		('Мартын', null),
		('Георгий', null),
		('Нинель', null),
		('Аристарх', null),
		('Вольдемар', null),
		('Владислав', null),
		('Анатолий', null),
		('Тарас', null),
		('Игорь', null),
		('Руслан', null),
		('Валентин', null),
		('Мстислав', null),
		('Любомир', null),
		('Виссарион', null),
		('Евгений', null),
		('Илларион', null),
		('Моисей', null),
		('Корнелий', null),
		('Юлий', null),
		('Станислав', null),
		('Августин', null),
		('Агафон', null),
		('Леонтий', null),
		('Гордей', null),
		('Святослав', null),
		('Устин', null),
		('Анатолий', null),
		('Ермолай', null),
		('Витольд', null),
		('Богдан', null),
		('Ярослав', null),
		('Кондрат', null),
		('Август', null),
		('Мартын', null),
		('Витольд', null),
		('Александр', null),
		('Николай', null),
		('Аверкий', null),
		('Велорий', null),
		('Ким', null),
		('Артур', null),
		('Роман', null),
		('Дмитрий', null),
		('Аристарх', null),
		('Гаянэ', null),
		('Корней', null),
		('Ефим', null),
		('Георгий', null),
		('Май', null),
		('Михаил', null),
		('Исаак', null),
		('Игорь', null),
		('Панкратий', null),
		('Вилен', null),
		('Вальтер', null),
		('Ипполит', null),
		('Юлиан', null),
		('Осип', null),
		('Михаил', null),
		('Нисон', null),
		('Владлен', null),
		('Павел', null),
		('Рубен', null),
		('Флор', null),
		('Филипп', null),
		('Семен', null),
		('Кассиан', null),
		('Тимур', null),
		('Вилен', null),
		('Эльдар', null),
		('Артем', null),
		('Леонтий', null),
		('Андрей', null),
		('Исак', null),
		('Варлаам', null),
		('Панкратий', null),
		('Велорий', null),
		('Пантелеймон', null),
		('Елисей', null),
		('Мирон', null),
		('Роберт', null),
		('Вилли', null),
		('Яков', null),
		('Ростислав', null),
		('Осип', null),
		('Гордей', null)

insert Trip 
    values (1, 1, 1, '2020-11-16'),
		(2, 2, 2, '2020-11-05'),
		(3, 3, 3, '2020-12-13'),
		(4, 4, 4, '2020-11-10'),
		(5, 5, 5, '2020-01-10'),
		(6, 6, 6, '2021-12-21'),
		(7, 7, 7, '2020-11-26'),
		(8, 8, 8, '2020-11-18'),
		(1, 9, 9, '2021-11-11'),
		(2, 1, 10, '2020-11-06'),
		(3, 2, 3, '2020-11-12'),
		(4, 3, 4, '2022-03-22'),
		(5, 4, 5, '2020-07-18'),
		(6, 5, 6, '2022-11-22'),
		(7, 6, 7, '2020-11-02'),
		(8, 7, 8, '2023-12-02')

insert TicketOffice
	values (1, 'ул. Бассейная, 1'),
		(2, 'ул. Борисова, 3'),
		(3, 'пер. Депутатский, 10'),
		(1, 'ул. Ленина, 44')

insert Ticket
	values (3, 16, 1, '2013-07-06', 1),
		(4, 12, 1, '2013-06-26', 2),
		(1, 7, 1, '2014-01-25', 3),
		(4, 14, 1, '2011-03-25', 4),
		(2, 3, 1, '2018-11-22', 5),
		(2, 4, 1, '2014-05-17', 6),
		(3, 3, 2, '2017-08-02', 7),
		(2, 13, 1, '2013-09-21', 8),
		(3, 1, 1, '2011-09-17', 9),
		(1, 4, 2, '2019-06-15', 10),
		(1, 9, 1, '2018-12-05', 11),
		(4, 14, 2, '2011-11-06', 12),
		(2, 10, 1, '2014-05-05', 13),
		(2, 9, 2, '2016-12-20', 14),
		(3, 8, 1, '2017-01-04', 15),
		(4, 5, 1, '2013-08-20', 16),
		(3, 4, 3, '2016-11-13', 17),
		(2, 3, 3, '2015-07-10', 18),
		(1, 16, 1, '2019-02-15', 19),
		(3, 11, 1, '2011-03-08', 20),
		(2, 15, 1, '2012-11-28', 21),
		(1, 13, 2, '2017-12-28', 22),
		(1, 1, 2, '2017-12-15', 23),
		(3, 16, 2, '2019-01-13', 24),
		(4, 8, 2, '2016-06-11', 25),
		(3, 5, 2, '2017-03-01', 26),
		(4, 12, 2, '2019-01-06', 27),
		(3, 4, 4, '2011-12-28', 28),
		(2, 14, 3, '2017-11-23', 29),
		(2, 3, 4, '2015-12-07', 30),
		(3, 9, 3, '2014-11-14', 31),
		(2, 1, 3, '2018-08-14', 32),
		(4, 6, 1, '2012-11-11', 33),
		(2, 9, 4, '2012-08-16', 34),
		(1, 2, 1, '2013-11-01', 35),
		(4, 9, 5, '2015-06-01', 36),
		(1, 1, 4, '2016-02-21', 37),
		(4, 12, 3, '2013-11-16', 38),
		(4, 2, 2, '2019-09-26', 39),
		(3, 4, 5, '2013-08-08', 40),
		(1, 16, 3, '2012-09-23', 41),
		(3, 2, 3, '2019-12-22', 42),
		(4, 1, 5, '2015-05-15', 43),
		(3, 10, 2, '2016-04-24', 44),
		(4, 15, 2, '2018-12-27', 45),
		(4, 10, 3, '2012-03-21', 46),
		(4, 9, 6, '2018-12-14', 47),
		(4, 10, 4, '2013-12-06', 48),
		(2, 15, 3, '2017-03-20', 49),
		(1, 12, 4, '2018-11-18', 50),
		(3, 1, 6, '2012-11-12', 51),
		(3, 9, 7, '2015-12-24', 52),
		(3, 14, 4, '2015-12-24', 53),
		(3, 12, 5, '2017-07-16', 54),
		(3, 2, 4, '2014-12-03', 55),
		(3, 7, 3, '2013-02-14', 56),
		(1, 1, 3, '2012-12-01', 57),
		(4, 15, 4, '2016-04-25', 58),
		(1, 15, 5, '2013-04-01', 59),
		(3, 2, 5, '2013-11-08', 60),
		(2, 4, 6, '2017-12-01', 61),
		(4, 15, 6, '2012-06-23', 62),
		(1, 12, 6, '2013-12-06', 63),
		(2, 14, 5, '2017-01-07', 64),
		(4, 5, 3, '2014-08-08', 65),
		(4, 13, 3, '2014-12-24', 66),
		(1, 10, 5, '2014-07-12', 67),
		(2, 7, 2, '2013-01-17', 68),
		(1, 11, 2, '2017-11-12', 69),
		(4, 5, 4, '2015-09-04', 70),
		(4, 5, 5, '2016-08-01', 71),
		(4, 9, 8, '2015-11-23', 72),
		(4, 10, 6, '2017-11-01', 73),
		(1, 15, 7, '2015-11-01', 74),
		(1, 11, 3, '2013-12-02', 75),
		(1, 16, 4, '2013-07-26', 76),
		(2, 6, 2, '2013-11-23', 77),
		(1, 15, 8, '2014-12-13', 78),
		(2, 12, 7, '2018-05-06', 79),
		(4, 9, 9, '2019-01-07', 80),
		(1, 1, 4, '2015-01-13', 81),
		(2, 8, 3, '2014-03-24', 82),
		(3, 14, 6, '2019-07-14', 83),
		(1, 6, 3, '2014-08-18', 84),
		(3, 11, 4, '2019-12-11', 85),
		(4, 13, 4, '2012-11-07', 86),
		(3, 10, 7, '2017-01-06', 87),
		(3, 4, 7, '2018-06-06', 88)
go