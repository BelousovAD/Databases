use bus_service
go

--1. Получить данные (время, цену на билет) о рейсах в город Томск из города Новосибирск.
select DaysInRoutee as 'Дней в пути',
	   TimeDeparture as 'Время отправления',
	   TimeArrival as 'Время прибытия',
	   Price as 'Цена на билет'
    from Routee
    where ID_CityDeparture = (select ID
								from City
								where Namee = 'Новосибирск')
    and ID_CityArrival = (select ID
							from City
							where Namee = 'Томск')

--2. Получить суммарный доход какой-либо кассы.
select sum(Price) as 'Суммарный доход кассы'
	from TicketOffice
    right join Ticket on TicketOffice.ID = Ticket.ID_TicketOffice
    join Trip on ID_Trip = Trip.ID
	join Routee on ID_Routee = Routee.ID
    where TicketOffice.ID = 1

--3. Получить суммарные доходы касс в городе Томске.
select sum(Price) as 'Суммарный доход касс в городе'
	from City
	right join TicketOffice on City.ID = TicketOffice.ID_City
    right join Ticket on TicketOffice.ID = Ticket.ID_TicketOffice
    join Trip on ID_Trip = Trip.ID
	join Routee on ID_Routee = Routee.ID
    where City.Namee = 'Томск'

--4. Получить число рейсов, совершѐнных данным водителем за год.
select count(*) as 'Число рейсов'
    from Driver
	right join Trip on Driver.ID = ID_Driver
    where Driver.ID = 3
    and year(DateArrival) = 2020
go

--5. Назначить водителя на рейс.
create trigger setDriver
	on Trip
	after update
	as if (select ID_City
		       from inserted
			   join Driver on ID_Driver = Driver.ID)
	!= (select ID_CityDeparture
			from inserted
			join Routee on ID_Routee = Routee.ID)
	begin
		rollback tran
		print 'Водитель не из этого города'
	end
go

update Trip
	set Trip.ID_Driver = 2
	where Trip.ID = 1
go

--drop trigger setDriver

--6. Оформить билет для клиента в город Новосибирск из Томска, с учѐтом занятых мест в автобусе.----
create trigger setPlace
	on Ticket after insert
	as if ((select count(*)
		       from Ticket
			   where ID_Trip = (select ID_Trip
									from inserted))
	> (select QuantityPlace
			from Bus
			right join Trip on ID_Bus = Bus.ID
			right join inserted on ID_Trip = Trip.ID))
	begin
		rollback tran
		print 'Мест нет.'
	end
go

insert into Ticket
	values (1, 1, 7, getdate(), 1)
go

--drop trigger setPlace

--7. Получить число рейсов, совершённых автобусами «Икарус» и «ПАЗ».
select count(*) as 'Число рейсов, совершённых автобусами "Икарус" и "ПАЗ"'
    from Bus
    right join Trip on Bus.ID = Trip.ID_Bus
    where Trademark in ('Икарус', 'ПАЗ') and DateArrival < getdate()
go
--8. Проверить все свободные места на рейс.-----
select QuantityPlace - (select count(*)
							from Ticket
							where ID_Trip = 1)
	from Bus
	right join Trip on ID_Bus = Bus.ID
	where Trip.ID = 2
/*create procedure FreePlaces (@ID_Trip int)
	as
	begin
		create table #Table 
		(ID int not null)
		declare @i int = 1,
				@QantityPlace int
		select @QantityPlace = (select QuantityPlace
								    from Trip
								    join Bus on ID_Bus = Bus.ID
								    where Trip.ID = @ID_Trip)
		while @i <= @QantityPlace
		begin
			if @i not in (select Place
					      from Ticket
						  where ID_Trip = @ID_Trip)
			insert #Table
				values (@i)
			set @i += 1
		end
		select *
			from #Table
		drop table #Table
	end
go

execute dbo.FreePlaces @ID_Trip = 1*/

--drop procedure FreePlaces

--9. Показать число билетов, проданных кассами.------
select count(*) as 'Число билетов, проданных кассами',
	TicketOffice.ID as 'ID Кассы'
	from Ticket
	join TicketOffice on ID_TicketOffice = TicketOffice.ID
	group by TicketOffice.ID

--10. Показать среднюю цену билетов.
select avg(Price)
    from Routee

--11. Показать рейсы, цена на которые выше средней цены на билеты.
select *
    from Trip
	join Routee on Routee.ID = ID_Routee
    where Price > (select avg(Price)
					   from Routee)

--12. Отменить клиенту билет, после того как он его вернул.
delete
	from Ticket
	where Ticket.ID = 88

--13. Показать информацию о рейсах из города Томск (включая цену на билет, время рейса).
select DaysInRoutee as 'Дней в пути',
	   TimeDeparture as 'Время отправления',
	   TimeArrival as 'Время прибытия',
	   City2.Namee as 'Пункт прибытия',
	   Price as 'Цена'
    from City
	right join Routee on City.ID = ID_CityDeparture
	left join City as City2 on City2.ID = ID_CityArrival
    where City.Namee = 'Томск'

--14. Посчитать количество билетов, проданных по рейсам Томск – Новосибирск за 2019-2020.
select count(*)
    from Ticket
	left join Trip on ID_Trip = Trip.ID
	left join Routee on ID_Routee = Routee.ID
	left join City on ID_CityDeparture = City.ID
	left join City as City2 on ID_CityArrival = City2.ID
    where City.Namee = 'Томск'
    and City2.Namee = 'Новосибирск'
    and year(DateArrival) between 2019 and 2020
go
--15. Назначить автобус на рейс.
create trigger setBus
	on Trip
	after update
	as if ((select QuantityPlace
		       from Bus
			   where ID = (select ID_Bus
						       from inserted))
	< (select MIN_QuantityPlace
		   from Routee
		   where ID = (select ID_Routee
						   from inserted)))
	begin
		rollback tran
		print 'Автобус не соответствует минимальной вмещаемости пассажиров'
	end
go

update Trip
	set ID_Bus = 8
	where Trip.ID = 16

--drop trigger setBus

--16. Получить список рейсов, на которые может быть назначен данный водитель и данный автобус с числом мест, равным 30.----
select distinct Routee.ID,
	   DaysInRoutee,
	   TimeDeparture,
	   TimeArrival,
	   ID_CityDeparture,
	   ID_CityArrival,
	   Price,
	   MIN_QuantityPlace
    from Routee
	join Driver on ID_CityDeparture = ID_City
	join Bus on MIN_QuantityPlace <= QuantityPlace
    where Namee = 'Добрыня'
    and Bus.QuantityPlace = 30

--17. После ремонта в автобусе добавили 3 места, добавить эти места и в БД.
update Bus
	set Bus.QuantityPlace += 3
where Bus.ID = 2