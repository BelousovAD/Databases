select top(3) Сотрудник.Имя as 'Сотрудник', 
	sum(Сделка.Цена - Сделка.Скидка) as 'Сумма сделок', 
	dense_rank() over(order by sum(Сделка.Цена - Сделка.Скидка) desc) as 'Занятое место'
from Сотрудник
	join Сделка on Сотрудник.ID = Сделка.ID_Сотрудника
group by Сотрудник.Имя;
select Сотрудник.Имя, 
	datepart(year, Сделка.Дата) as 'Год', 
	datepart(month, Сделка.Дата) as 'Месяц', 
	sum(Сделка.Цена - Сделка.Скидка) as 'Сумма сделок',	
	(sum(Сделка.Цена - Сделка.Скидка) - lag(sum(Сделка.Цена - Сделка.Скидка), 1, 0)
		over(partition by Сотрудник.Имя
			 order by datepart(year, Сделка.Дата),
			 datepart(month, Сделка.Дата))) as 'Разница с предыдущим'
from Сотрудник 
	join Сделка on Сотрудник.ID = Сделка.ID_Сотрудника
group by Сотрудник.Имя, 
	datepart(year, Сделка.Дата), 
	datepart(month, Сделка.Дата);