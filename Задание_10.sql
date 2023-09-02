use Деканат

insert Группы (Название, ID_Специальности)
	values ('КИ19-10Б', 4);
update Студенты
	set ID_Группы = 5 
		where ID_Группы = 4;
update Группы
	set Староста = (select Староста
						from Группы
						where ID = 4),
		Куратор  = (select Куратор
						from Группы
						where ID = 4)
		where ID = 5;
delete
	from Группы
	where ID = 4;