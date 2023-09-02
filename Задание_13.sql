use Деканат
go

--При удалении некоторой дисциплины, триггер не дает удалить дисциплины, по которым хотя бы один человек получил экзамен (зачет).
create trigger del
	on Дисциплины 
	instead of delete
	as if ((select count(Изучение.ID_Дисциплины)
				from Изучение
				where Изучение.ID_Дисциплины in (select deleted.ID
												 from deleted)) != 0)
begin
	rollback tran
	print'Не удалось удалить'
end
else
	delete
	from Дисциплины
	where Дисциплины.ID in (select deleted.ID
							from deleted)
go

delete
from Дисциплины 
where Дисциплины.ID = 41
go

--Назначить нового старосту в некоторую группу. Если назначаемый на должность старосты студент не состоит в этой группе, следует отменить транзакцию.
create trigger upd
	on Группы
	after update
	as if (select inserted.Староста
		   from inserted) not in (select Студенты.Номер_зачётной_книжки
								  from Студенты
								  where (select inserted.ID
										 from inserted) = Студенты.ID_Группы)
begin
	rollback tran
	print'Не удалось обновить'
end
go

update Группы 
set Группы.Староста = '2'
where Группы.ID = 1
go

--Не позволить добавить информацию о сданном экзамене (или зачете), если дисциплина не соответствует специальности студента.
create trigger ins
	on Изучение
	after insert
	as if (select inserted.ID_Дисциплины
		   from inserted) not in (select Дисциплины.ID
								  from Дисциплины
								  where Дисциплины.ID_Специальности = (select Группы.ID_Специальности
																	   from Группы
																	   where Группы.ID = (select Студенты.ID_Группы
																						  from Студенты
																						  where Студенты.Номер_зачётной_книжки = (select inserted.Номер_зачётной_книжки
																																  from inserted))))
begin
	rollback tran
	print'Не удалось вставить'
end
go

insert into Изучение values (11, 29, '2019-12-29', 'Незачёт')
go

drop trigger del
drop trigger upd
drop trigger ins