select Наименование, sum(Количество) as Количество,
	case 
		when sum(Количество) < 10 then 'Мало'
		when sum(Количество) between 10 and 100 then 'Достаточно'
		else 'Избыточно'
	end as Оценка
	from Склад join Товар on Склад.ID_Товара = Товар.ID
	group by Наименование;
select Наименование, sum(Количество) as Количество 
	from Склад join Товар on Склад.ID_Товара = Товар.ID
	group by Наименование
	having sum(Количество) between 1 and 200;
select top(3) Наименование, sum(Сделка.Цена - Скидка) as Сумма
	from Склад join Товар on Склад.ID_Товара = Товар.ID
		join Сделка on Склад.ID = Сделка.ID_Склада
	group by Наименование
	order by Сумма desc;
select Наименование, year(Дата) as Год, datename(month, Дата) as Месяц, sum(Сделка.Цена - Скидка) as Сумма
	from Склад join Товар on Склад.ID_Товара = Товар.ID
		join Сделка on Склад.ID = Сделка.ID_Склада
	group by Наименование, year(Дата), datename(month, Дата);
select Наименование, year(Дата) as Год, datename(month, Дата) as Месяц, sum(Сделка.Цена - Скидка) as Сумма
	from Склад join Товар on Склад.ID_Товара = Товар.ID
		join Сделка on Склад.ID = Сделка.ID_Склада
	where ID_Товара = 3
	group by Наименование, year(Дата), datename(month, Дата)
	having sum(Сделка.Цена - Скидка) < 8000;