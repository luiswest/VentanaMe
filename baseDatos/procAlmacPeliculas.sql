use VideoClub
go


if OBJECT_ID('NuevaPelicula','P') IS NOT NULL
	drop procedure NuevaPelicula
go

create proc NuevaPelicula
  @Genero		varchar(50),
  @Nombre		varchar(50),
  @Valor		smallmoney,
  @Tipo			char(1)
  as
   begin
		insert into Pelicula (Genero, Nombre, Valor, Tipo)
				values (@Genero, @Nombre, @Valor, @Tipo)
   end
 go

if OBJECT_ID('ModificarPelicula','P') IS NOT NULL
	drop procedure ModificarPelicula
go

create proc ModificarPelicula
  @Codigo		int,
  @Genero		varchar(50),
  @Nombre		varchar(50),
  @Valor		smallmoney,
  @Tipo			char(1)
  as
   begin
	  if (not exists (select * from Pelicula where Codigo=@Codigo))
		return 1 
	  else begin
			update Pelicula set
				  Genero = @Genero,
				  Nombre = @Nombre,
				  Valor = @Valor,
				  Tipo  = @Tipo
			where Codigo = @Codigo
			return 0
	  end
   end
   go

   if OBJECT_ID('EliminarPelicula','P') IS NOT NULL
	drop proc EliminarPelicula
   go

   create proc EliminarPelicula
	@Codigo		int
	as
	begin
		if (exists (select * from Pelicula where Codigo=@Codigo))
			begin
				if (exists(select * from Alquiler where CodPelicula = @Codigo))
					return 2
				else begin
					delete from Pelicula where Codigo=@Codigo
					return 0
				end
			end else
					return 1
	end
	go