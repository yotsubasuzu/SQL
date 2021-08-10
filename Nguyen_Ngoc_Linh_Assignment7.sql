------In ra các số từ 1 -> 100---------
declare @count int = 1
while @count <=100
begin
	print @count
	set @count += 1
end
go
----- in ra số chẵn từ 1-> 100--------
declare @count int = 1
while @count <=100
begin
	if (@count % 2 = 0)
		print @count
	set @count += 1
end
go
----- in ra số lẻ từ 1-> 100--------
declare @count int = 1
while @count <=100
begin
	if (@count % 2 = 1)
		print @count
	set @count += 1
end
go
------Tính tổng từ 1 -> 100---------
declare @count int = 1, @sum int = 0
while @count <=100
begin
	set @sum += @count
	set @count += 1
end
print @sum
go
---- tinh tổng 20 số trong day 5, 10, 15----
declare @count int = 1, @sum int = 0, @i int = 5
while @count <=20
begin
	set @sum += @i
	set @i += 5
	set @count += 1
end
print @sum
go
----in ra các chuỗi sau
--* * * * * * * * * *
declare @loop int = 0, @string varchar(20) = '', @space int = 0
while @loop <=9
	begin
		set @string = concat(@string,'*')
		if @space <=8
			set @string = concat(@string, ' ')
		set @loop +=1
		set @space +=1
	end
	print @string
go
print 'a'+ space(5) + 'b'
--*
--* *
--* * *
--* * * *
--* * * * *
declare @loop int = 0, @space int, @star int, @string varchar(10)
while @loop < 5
	begin
		set @string = ''
		set @space = 3 - @loop
		set @star = 4 - @loop
		while @star < 5
			begin
				set @string = concat(@string,'*')
				if @space < 3
					set @string = concat(@string, ' ')
				set @star += 1
				set @space += 1
			end
		set @loop += 1
		print @string
	end
go

declare @p_sao nvarchar(50)
declare @p_solan int
set @p_sao = '*'
set @p_solan = 1
while @p_solan <= 5
begin
	print @p_sao
	set @p_sao = concat(@p_sao,' *') 
	set @p_solan = @p_solan + 1
end

--* * * * *
--* * * *
--* * *
--* *
--*
declare @loop int = 0, @space int, @star int, @string varchar(10)
while @loop < 5
	begin
		set @string = ''
		set @space = @loop
		set @star = @loop 
		while @star < 5
			begin
				set @string = concat(@string,'*')
				if @space < 4
					set @string = concat(@string, ' ')
				set @star += 1
				set @space += 1
			end
		set @loop += 1
		print @string
	end
go

declare @p_j int
declare @p_sao nvarchar(50)
declare @p_solan int
set @p_solan = 5
while @p_solan >= 1
begin
	set @p_sao = '*'
	set @p_j = @p_solan
	while @p_j>1
	begin 
		set @p_sao = concat(@p_sao,' *')
		set @p_j = @p_j - 1
	end
	print @p_sao
	set @p_solan = @p_solan - 1	
end

--     *
--    **
--   ***
--  ****
-- *****
declare @loop int = 0, @star int, @space int, @string varchar(10)
while @loop < 5 
	begin
		set @string = ''
		set @star = 0
		set @space = 3 - @loop
		while @space >= 0 
			begin
				set @string = concat(@string, ' ')
				set @space -= 1
			end
		while @star <= @loop
			begin
				set @string = concat(@string,'*')
				set @star += 1
			end
		set @loop += 1
		print @string
	end
go

declare @i int = 1;
declare @spa int = 4;
while @i <=5
begin
	print space(@spa) + replicate('*' , @i);
	set @i = @i + 1;
	set @spa = @spa - 1;
end

-- *****
--  ****
--   ***
--    **
--     *
declare @loop int = 0, @star int, @space int, @string varchar(10)
while @loop < 5 
	begin
		set @string = ''
		set @star = 4 - @loop
		set @space = 0
		while @space < @loop
			begin
				set @string = concat(@string, ' ')
				set @space += 1
			end
		while @star >= 0
			begin
				set @string = concat(@string,'*')
				set @star -= 1
			end
		set @loop += 1
		print @string
	end
go

declare @i int = 5;
declare @spa int = 0;
begin
	while @i > 0
	begin
		print space(@spa) + replicate('*' , @i);
		set @i = @i - 1;
		set @spa = @spa + 1;
	end
end	
