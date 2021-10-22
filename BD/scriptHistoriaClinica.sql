create table tipousuario(
	id serial primary key,
	nombretu varchar(80) not null,
	descripcion varchar(1250) null
);

create table especialidad(
	id serial primary key,
	nombreE varchar(80) not null,
	descripcion varchar(1250) null
);

create table usuario(
	id serial primary key,
	documento varchar(15) not null,
	nombre varchar(80) not null,
	apellido varchar(80) not null,
	usuario varchar(80) not null,
	clave varchar (32) not null,
	firma varchar (120) not null,
	idTipoUsuario int not null references tipousuario(id) on delete restrict on update cascade,
	celular varchar (15) null,
	direccion varchar(250) not null,
	idespecialidad int null references especialidad(id) on delete restrict on update cascade
);

create table historiaclinica(
	id serial primary key,
	fechaToma timeStamp not null,
	nombreCPaciente varchar (80) not null,
	historia varchar(50) not null
);

insert into tipousuario(nombretu, descripcion) values ('Medico', 'Profesional de la salud contratado por la empresa'),('Enfermera', 'Profesional de la salud contratado por la empresa'),('Especialista','Medico general especializado en una rama de la salud');
insert into especialidad(nombreE, descripcion) values ('Pediatra','Medico especialista en pediatria'),('Cardiologo', 'Medico especialista en cardiologia'), ('Urologo', 'Medico especialista en el sistema endocrino');
insert into usuario(documento, nombre, apellido, usuario, clave, firma, idTipoUsuario, celular, direccion, idespecialidad) 
	values ('59313951','claudia','cifuentes', 'claudia',md5('123'), 'enlace', 3, '3158985060','carrera 17 # 20 16 navarrete',2)
	,('1085327436','Edgar','Narvaez','edgar', md5('123'),'enlace',3,'31566151613','calle 23 # 17-11',3);
insert into usuario(documento, nombre, apellido, usuario, clave, firma, idTipoUsuario, celular, direccion) values('1086549350','Manuel','Buesaquillo', 'manuel', md5('123'),'enlace',1,'3153285909','carrera 20 # 11-08 las rosas');