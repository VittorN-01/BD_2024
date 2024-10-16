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

--- INSERT'S para teste ---
INSERT INTO tbCliente (codCliente, nomeCliente, cpfCliente)
VALUES 
(1, 'Carlos Alberto', '123.456.789-00')
,(2, 'Ana Pereira', '987.654.321-00');

INSERT INTO tbContaCorrente (numConta, saldoConta, codCliente)
VALUES 
(1, 1000.00, 1)
,(2, 500.00, 2);

INSERT INTO tbDeposito (codDeposito, valorDeposito, numConta, dataDeposito, horaDeposito)
VALUES 
(1, 200.00, 1, '2024-10-16', '09:00:00');

INSERT INTO tbSaque (codSaque, valorSaque, numConta, dataSaque, horaSaque)
VALUES 
(1, 400.00, 1, '2024-10-16', '11:00:00');

-- Saque que dispara a mensagem 'Impossível Sacar'
INSERT INTO tbSaque (codSaque, valorSaque, numConta, dataSaque, horaSaque)
VALUES (2, 600.00, 2, '2024-10-16', '12:00:00');
