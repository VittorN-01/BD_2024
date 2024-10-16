CREATE DATABASE bdAutomovel
USE bdAutomovel

CREATE TABLE tbVeiculo(
	idVeiculo INT PRIMARY KEY
	,modeloVeiculo VARCHAR (100) NOT NULL
	,placa VARCHAR (10) NOT NULL
	,renavam VARCHAR (10) NOT NULL
	,anoVeiculo INT 
	,idMotorista INT FOREIGN KEY (idMotorista) REFERENCES tbMotorista (idMotorista)
)

CREATE TABLE tbMotorista(
	idMotorista INT PRIMARY KEY 
	,nomeMotorista VARCHAR (100) NOT NULL
	,dataNascimentoMotorista DATE 
	,cpfMotorista VARCHAR (15) NOT NULL
	,CNHMotorista VARCHAR (15) NOT NULL
	,pontuacaoAcumulada INT
)

CREATE TABLE tbMultas(
	idMulta INT PRIMARY KEY 
	,dataMulta DATE NOT NULL
	,horaMulta TIME NOT NULL
	,pontosMulta INT 
	,idVeiculo INT FOREIGN KEY (idVeiculo) REFERENCES tbVeiculo(idVeiculo)
)

--- INSERT'S para teste---
INSERT INTO tbMotorista (idMotorista, nomeMotorista, dataNascimentoMotorista, cpfMotorista, CNHMotorista, pontuacaoAcumulada)
VALUES 
(1, 'João Silva', '1985-05-10', '123.456.789-00', '12345678900', 10)
,(2, 'Maria Oliveira', '1990-07-15', '987.654.321-00', '98765432100', 5);

INSERT INTO tbVeiculo (idVeiculo, modeloVeiculo, placa, renavam, anoVeiculo, idMotorista)
VALUES 
(1, 'Honda Civic', 'ABC1234', '1234567890', 2020, 1)
,(2, 'Toyota Corolla', 'XYZ9876', '9876543210', 2019, 2);

INSERT INTO tbMultas (idMulta, dataMulta, horaMulta, pontosMulta, idVeiculo)
VALUES 
(1, '2024-10-16', '14:30:00', 7, 1)
,(2, '2024-10-17', '10:15:00', 3, 2);

-- Insert de Aviso --
INSERT INTO tbSaque (codSaque, valorSaque, numConta, dataSaque, horaSaque)
VALUES (3, '2024-10-18', '12:00:00', 10, 1);
