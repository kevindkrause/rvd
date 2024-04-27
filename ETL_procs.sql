/*******************************************************************
**					FUNCTIONS/PROCEDURES
*******************************************************************/
use rvdrehearsal
go

create function dbo.remove_non_numeric_chars_fnc( @strtext varchar(1000) )
	returns varchar(1000)
as
begin
	while patindex( '%[^0-9]%', @strtext ) > 0
	begin
		set @strtext = stuff( @strtext, patindex('%[^0-9]%', @strtext ), 1, '' )
	end
	return @strtext
end
go


create function dbo.parse_values( @SourceSql varchar(8000), @StrSeparator varchar(10) )
	returns @temp
	table( Val varchar(255) )
begin
	declare @i int
	set @SourceSql = rtrim( ltrim( @SourceSql ) )
	set @i = charindex( @StrSeparator, @SourceSql )
	
	while @i >= 1
	begin
		insert @temp values( left( @SourceSql, @i - 1 ) )

		set @SourceSql = substring( @SourceSql, @i + 1, len( @SourceSql ) - @i )
		set @i = charindex( @StrSeparator, @SourceSql )
	end

	if @SourceSql <> '\'

	insert @temp values( @SourceSql )

	return
end
go
