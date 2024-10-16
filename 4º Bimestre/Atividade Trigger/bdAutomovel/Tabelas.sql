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