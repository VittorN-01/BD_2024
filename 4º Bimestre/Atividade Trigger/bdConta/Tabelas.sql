CREATE DATABASE bdConta
USE bdConta

CREATE TABLE tbCliente(
	codCliente INT PRIMARY KEY
	,nomeCliente VARCHAR (100) NOT NULL
	,cpfCliente VARCHAR (15) NOT NULL
)

CREATE TABLE tbContaCorrente (
	numConta INT PRIMARY KEY
	,saldoConta MONEY 
	,codCliente INT FOREIGN KEY (codCliente) REFERENCES tbCliente (codCliente)
)

CREATE TABLE tbDeposito (
	codDeposito INT PRIMARY KEY
	,valorDeposito MONEY
	,numConta INT FOREIGN KEY (numConta) REFERENCES tbContaCorrente (numConta)
	,dataDeposito DATE
	,horaDeposito TIME
)
 
 CREATE TABLE tbSaque (
	codSaque INT PRIMARY KEY
	,valorSaque MONEY
	,numConta INT FOREIGN KEY (numConta) REFERENCES tbContaCorrente (numConta)
	,dataSaque DATE
	,horaSaque TIME
 )