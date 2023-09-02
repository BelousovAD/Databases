select * from Поставщик order by Наименование desc
select top(1) * from Поставщик order by len(Наименование) desc
select * from Клиент where Имя like 'Д%'
select * from Клиент where Имя like '[Д-К]о%'
select max(Цена) from Сделка where month(Дата) = month(getdate()) and year(Дата) = year(getdate())
select count(*) from Сделка where datepart(weekday, Дата) = 2 or datepart(weekday, Дата) = 3