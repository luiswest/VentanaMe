use VideoClub
go

IF OBJECT_ID ( 'NuevoEmpleado', 'P' ) IS NOT NULL 
	drop proc NuevoEmpleado
go

create proc NuevoEmpleado
  @Id			int,
  @Nombre		varchar(50),
  @Apellido1	varchar(50),
  @Apellido2	varchar(50),
  @Sexo			char(1),
  @FechaNac		date,
  @Telefono		int,
  @Celular		int,
  @Direccion	varchar(255),
  @Tipo			char(1),
  @Estado		char(1)

  as
   begin
		if (exists(select * from Empleado where Id = @Id))
			return 1
		else
			begin
				insert into Empleado (Id, Nombre, Apellido1, Apellido2, Sexo, FechaNac,
					Telefono, Celular, Direccion, Tipo, Estado)
				values (@Id, @Nombre, @Apellido1, @Apellido2, @Sexo, @FechaNac, @Telefono, @Celular,
						@Direccion, @Tipo, @Estado)
				return 0
			end
   end
 go

IF OBJECT_ID('ModificarEmpleado','P') IS NOT NULL
	drop proc ModificarEmpleado
go

create proc ModificarEmpleado
  @Id			int,
  @Nombre		varchar(50),
  @Apellido1	varchar(50),
  @Apellido2	varchar(50),
  @Sexo			char(1),
  @FechaNac		date,
  @Telefono		int,
  @Celular		int,
  @Direccion	varchar(255),
  @Tipo			char(1),
  @Estado		char(1)
  as
   begin
	  if (not exists (select * from Empleado where Id=@Id))
			return 1
	  else begin
			update Empleado set
				Nombre		= @Nombre,
				Apellido1	= @Apellido1,
				Apellido2	= @Apellido2,
				Sexo		= @Sexo,
				FechaNac	= @FechaNac,
				Telefono	= @Telefono,
				Celular		= @Celular,
				Direccion	= @Direccion,
				Tipo		= @Tipo,
				Estado		= @Estado
				where Id = @Id

				return 0
	  end
   end
   go

   if OBJECT_ID('EliminarEmpleado','P') IS NOT NULL
	drop proc EliminarEmpleado
   go

   create proc EliminarEmpleado
	@Id		int
	as
	begin
		if (exists (select * from Empleado where Id=@Id))
			begin
				if (exists(select * from Alquiler where CodigoEmp =
					(select Codigo from Empleado where Id=@Id)))
					return 1
				else begin
					delete from Empleado where Id=@Id
					return 0
				end
			end else
					return 2
	end

	go