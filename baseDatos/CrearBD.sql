use master
go
-- Crea la base de datos si existía la elimina primero
if (DB_ID('bodega') is NOT NULL)
    drop database bodega
create database bodega
go

use bodega
go
-- Crear las tablas

create table Empleado (
	Codigo			int	identity(1000, 1) NOT NULL,
    Id              varchar (15) NOT NULL,
    Nombre          varchar (15) NOT NULL,
    Apellido1       varchar (15) NOT NULL,
    Apellido2       varchar (15) NOT NULL,
    Sexo			char(1)	check(Sexo in ('M','F')) NOT NULL,
    TelefonoCasa    varchar (9)  NULL,
    TelefonoCelular varchar (9)  NULL,
    FechaNac        date         NOT NULL,
	primary key clustered (Codigo ASC)
);

go

create table Articulo (
    Codigo      int             NOT NULL,
    Nombre      varchar (50)    NOT NULL,
    Descripcion varchar (100)   NOT NULL,
    IdProveedor varchar (15)    NOT NULL,
    Costo       decimal (11, 2) NOT NULL,
    min         int DEFAULT 0,
    max         int DEFAULT 0,
    existencia  int DEFAULT 0,
    primary key clustered (Codigo ASC)
);

go

create table Proveedor (
    Id        varchar (15) NOT NULL,
    Nombre    varchar (100) NOT NULL,
    Contacto  varchar (100) NOT NULL,
    Telefono1 varchar (9)   NOT NULL,
    Telefono2 varchar (9)   NULL,
    CorreoE   varchar (100) NULL,
    primary key clustered (Id ASC)
);

go

create table Movimiento (
		CodigoMov 	int	identity(1, 1) NOT NULL,
		Fecha       	date default getdate(),
		tipoMovimiento 	char(1) check(tipoMovimiento in ('E','S')) NOT NULL,
		idEmpEjecuta 	varchar(15) NOT NULL,
		idEmpAprueba 	varchar(15) NOT NULL,
		primary key clustered (CodigoMov ASC),
		constraint fk_MovEmpleado foreign key (CodigoMov)
		references Empleado(Codigo),
		constraint fk_MovArticulo foreign key (codArticulo)
		references Articulo(Codigo)
		)
	go

create table detMovimiento (
		CodDetalle 		int	identity(1, 1) NOT NULL,
		CodMovimiento 	int	NOT NULL,
		codArticulo		int NOT NULL,
		cantidad		int NOT NULL,		
		primary key clustered (CodDetalle ASC),
		constraint fk_Movimiento foreign key (CodigoMov)
		references Movimiento(CodMovimiento),
		constraint fk_MovArticulo foreign key (codArticulo)
		references Articulo(Codigo)
)
go

create table usuario (
		codigoUsr 		int	identity(1, 1) NOT NULL,
		codEmpleado		int	NOT NULL,
		rol				char(1)	check(rol in ('A','E')) NOT NULL,
		passw			varchar(255),
		primary key clustered (CodDetalle ASC),
		constraint fk_UsuarioEmp foreign key (codImpleado)
		references Empleado(Codigo),
)
go