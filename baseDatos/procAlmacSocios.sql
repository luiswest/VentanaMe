use VideoClub
go

IF OBJECT_ID ( 'NuevoSocio', 'P' ) IS NOT NULL 
	drop proc NuevoSocio
go

create proc NuevoSocio
  @Id			int,
  @Nombre		varchar(50),
  @Apellido1	varchar(50),
  @Apellido2	varchar(50),
  @Sexo			char(1),
  @FechaNac		date,
  @Telefono		int,
  @Celular		int,
  @Direccion	varchar(255),
  @Estado		char(1)

  as
   begin
		if (exists(select * from Socio where Id = @Id))
			return 1
		else
			begin
				insert into Socio (Id, Nombre, Apellido1, Apellido2, Sexo, FechaNac,
					Telefono, Celular, Direccion, Estado)
				values (@Id, @Nombre, @Apellido1, @Apellido2, @Sexo, @FechaNac, @Telefono, @Celular,
						@Direccion, @Estado)
				return 0
			end
   end
 go

IF OBJECT_ID ( 'ModificarSocio', 'P' ) IS NOT NULL 
	drop proc ModificarSocio
go

create proc ModificarSocio
  @Id			int,
  @Nombre		varchar(50),
  @Apellido1	varchar(50),
  @Apellido2	varchar(50),
  @Sexo			char(1),
  @FechaNac		date,
  @Telefono		int,
  @Celular		int,
  @Direccion	varchar(255),
  @Estado		char(1)

  as
   begin
	  if (not exists (select * from Socio where Id=@Id))
			return 0
	  else begin
			update Socio set
				Nombre		= @Nombre,
				Apellido1	= @Apellido1,
				Apellido2	= @Apellido2,
				Sexo		= @Sexo,
				FechaNac	= @FechaNac,
				Telefono	= @Telefono,
				Celular		= @Celular,
				Direccion	= @Direccion,
				Estado		= @Estado
				where Id = @Id

				return 1
	  end
   end
   go

   IF OBJECT_ID ( 'EliminarSocio', 'P' ) IS NOT NULL 
	 drop proc EliminarSocio
   go

   create proc EliminarSocio
	@Id		int
	as
	begin
		if (exists (select * from Socio where Id=@Id))
			begin
				if (exists(select * from Alquiler where CarnetSoc =
					(select Carnet from Socio where Id=@Id)))
					return 1
				else
					begin
					  delete from Socio where Id=@Id
					  return 0
					end
			end else
					return 2
	end

	go

--USE master
--+SELECT name, DB_ID(name) AS DB_ID
--+FROM sysdatabases
--+ORDER BY dbid