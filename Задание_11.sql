use Деканат
go

create function avg_disciplin (@ID_Disciplin int)
	returns float
	begin
		declare @avg float
		declare @sum float
		declare @count float
		select @sum = sum(Оценка)
		from (select 
				case
		            when Оценка = 'Отлично' then 5
                    when Оценка = 'Хорошо' then 4
                    when Оценка = 'Удовлетворительно' then 3
                    when Оценка = 'Неудовлетворительно' then 2
	            end as Оценка
                from Изучение
                where ID_Дисциплины = @ID_Disciplin) as Оценка
		select @count = count(Оценка)
		from Изучение
		where ID_Дисциплины = @ID_Disciplin
		select @avg = @sum / @count
		return @avg
	end
go

create procedure list_of_exams (@group nvarchar(12), @semester int)
	as select Дисциплины.Название as Дисциплины, Дисциплины.Отчетность as Отчётность
	   from Дисциплины
	   where Дисциплины.ID_Специальности = (select Группы.ID_Специальности
											from Группы
											where Группы.Название = @group) and Дисциплины.Семестр = @semester
go

select dbo.avg_disciplin(1)
execute list_of_exams @group = 'КИ19-08Б', @semester = 1
drop function dbo.avg_disciplin
drop procedure dbo.list_of_exams