select Наименование
	from Товар
	where id in(select ID_Товара
					from Склад 
					where Количество = (select max(Количество) from Склад))
select Наименование
	from Товар
	where id in(select ID_Товара
					from Склад
					where Количество between 100 and 400) 
	order by Наименование desc
select *
	from Поставщик
	where id in(select ID_Поставщика from Склад)
	order by Наименование asc
select *
	from Клиент
	where id in(select ID_Клиента
					from Сделка
					where dateadd(day, 30, Дата) >= getdate())
select *
	from Товар
	where (Наименование like 'Д%' or Наименование like 'Л%')
		and (id in(select ID_Товара
					from Склад where Цена <=(select max(Цена) from Склад)/5))
select *
	from Поставщик
	where (not id in(select ID_Поставщика
						from Склад
						where (ID_Товара in (select ID
												from Товар
												where (Наименование like 'Д%' or Наименование like 'Л%')))))
select Имя, case when Пол = 'М' then 'Мужской' else 'Женский' end as Пол
	from Клиент