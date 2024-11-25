-- Criando Tabelas Bases para Manipulação do BD de uma OFICINA fictícia

CREATE DATABASE repairShop;
USE repairShop;

CREATE TABLE clients(
    idClient INT AUTO_INCREMENT,
    Fname VARCHAR(10) NOT NULL,
    Lname VARCHAR(20) NOT NULL,
    FedId CHAR(11) NOT NULL COMMENT 'Restrição: 1 CPF por pessoa',
    CONSTRAINT pk_Clients PRIMARY KEY(idClient),
    CONSTRAINT uq_Clients UNIQUE(FedId)
);

CREATE TABLE vehicles(
    idVehicle INT AUTO_INCREMENT,
    idClient INT,
    CarModel VARCHAR(15) NOT NULL,
    CarBrand VARCHAR(10),
    CarColor VARCHAR(10),
    LicensePlate CHAR(8) NOT NULL,
    CONSTRAINT pk_Vehicle PRIMARY KEY(idVehicle),
    CONSTRAINT uq_Plate UNIQUE(LicensePlate),
    CONSTRAINT fk_client FOREIGN KEY(idClient) REFERENCES clients(idClient)
);


CREATE TABLE mechanics(
    idMechanic INT AUTO_INCREMENT,
    Mresponsable VARCHAR(30) NOT NULL,
    MFedId CHAR(11) NOT NULL,
    HourCost FLOAT,
	CONSTRAINT pk_Mechanics PRIMARY KEY(idMechanic),
    CONSTRAINT uq_Mechanics UNIQUE(MFedId)
);

CREATE TABLE autoParts(
    idParts INT,
    Pname VARCHAR(25) NOT NULL,
    Pcost FLOAT,
    Pstatus ENUM('Disponível', 'Fora de Estoque', 'Solicitado') DEFAULT 'Disponível',
    CONSTRAINT pk_Parts PRIMARY KEY(idParts),
    CONSTRAINT uq_Parts UNIQUE(Pname)
);

CREATE TABLE serviceRequests(
    idRequest INT AUTO_INCREMENT,
    idVehicle INT,
    RequestType ENUM('Reparo', 'Revisão') DEFAULT 'Revisão',
    Description VARCHAR(255) NOT NULL,
    Status ENUM('Aprovado', 'Em andamento', 'Cancelado', 'Finalizado') DEFAULT 'Aprovado',
    CONSTRAINT pk_Requests PRIMARY KEY(idRequest),
    CONSTRAINT fk_vehicles FOREIGN KEY(idVehicle) REFERENCES vehicles(idVehicle)
);

CREATE TABLE mechanicService(
    idMService INT AUTO_INCREMENT,
    idRequest INT,
    idMechanic INT,
    workHours FLOAT,
    CONSTRAINT pk_MechanicService PRIMARY KEY(idMservice, idMechanic),
    CONSTRAINT fk_MechanicService FOREIGN KEY(idMechanic) REFERENCES mechanics(idMechanic),
    CONSTRAINT fk_RequestService FOREIGN KEY(idRequest) REFERENCES serviceRequests(idRequest)
);

CREATE TABLE partService(
    idPService INT AUTO_INCREMENT,
    idRequest INT,
    idPart INT,
    Pquantity INT,
    CONSTRAINT pk_PartService PRIMARY KEY(idPService, idPart),
    CONSTRAINT fk_PartService FOREIGN KEY(idPart) REFERENCES autoParts(idParts),
    CONSTRAINT fk_RequestPart FOREIGN KEY(idRequest) REFERENCES serviceRequests(idRequest)
);

INSERT INTO clients(Fname, Lname, FedId) VALUES
	('Marcelina', 'Barros', '12365497899'),
	('Carlos', 'Jesus', '85749658246'),
	('Silvina', 'Albuquerque', '46695877215'),
	('Jose', 'Aparecido', '96553815978'),
	('Antonia', 'Gomes', '36915984211');



INSERT INTO vehicles(idClient, CarModel, CarBrand, CarColor, LicensePlate) VALUES
	('1', 'Fiesta', 'Ford', 'Vermelho', 'ABC12D4'),
	('1', 'Kicks', 'Nissan', 'Vermelho', 'EFG43Z1'),
   	('1', 'T-Cross', 'VW', 'Chumbo', 'AAA12D3'),
    	('2', 'TAOS', 'VW', 'Chumbo', 'UFR56A6'),
    	('2', 'Kicks', 'Nissn', 'Azul', 'KLB74R8'),
    	('3', 'Palio', 'Fiat', 'Preto', 'RGB54B0'),
    	('4', 'T-Cross', 'VW', 'Branco', 'CMY55K5'),
    	('4', 'Onix', 'GM', 'Prata', 'CLE35G7'),
    	('5', 'Onix', 'GM', 'Preto', 'RAF4EL2');


INSERT INTO mechanics(Mresponsable, MFedId, HourCost) VALUES
	('Florentina de Jesus','12332112332', '7.8'), 
        ('Zezinho Noronha','95195175328', '6.95'), 
        ('Lucianinho Mello','75335775391', '6.9'),
        ('Giovana FLores', '82888999977', '7.0');


INSERT INTO autoParts(idParts, Pname, Pcost, Pstatus) VALUES
	('1', 'Motor','235.9', 'Solicitado'), 
        ('2', 'Amortecedor','199.9', 'Fora de Estoque'), 
        ('3', 'Filtro de Ar','79.8', 'Disponível'),
        ('4', 'Fluído de Freio 1L', '35.5', 'Disponível'),
        ('5', 'Óleo de Motor 1L', '49.9', 'Solicitado'),
        ('6', 'Fluído de Cambio 1L', '69.6', 'Disponível');


INSERT INTO serviceRequests(idVehicle, RequestType, Description, serviceRequests.Status) VALUES
	('3', 'Revisão','Cliente reclamou de pastilhas de freio', 'Aprovado'), 
        ('4', 'Reparo','Troca de Amortecedor Dianteiro', 'Em andamento'), 
        ('8', 'Reparo','Verificar motor', 'Finalizado'),
        ('7', 'Revisão', 'Incluir troca de filtro de Ar', 'Finalizado'),
        ('1', 'Revisão', 'Trocar Fluídos de Freio e Câmbio', 'Em andamento'),
        ('6', 'Reparo', 'Trocar Bateria', 'Cancelado');


INSERT INTO mechanicService(idRequest, idMechanic, WorkHours) VALUES
	('1', '1', '3.75'), 
        ('2', '3', '6.5'), 
        ('3', '1', '4.0'),
        ('4', '2', '1.9'),
        ('5', '4', '2.0'),
        ('6', '3', '5.8');

INSERT INTO partService(idRequest, idPart, Pquantity) VALUES
		('1', '4', '2'), 
        ('2', '2', '1'), 
        ('3', '1', '1'),
        ('4', '3', '1'),
        ('5', '4', '2'),
        ('5', '6', '3');