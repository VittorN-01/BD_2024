CREATE DATABASE bdProdutos
USE bdProdutos


CREATE TABLE tbCategoriaProduto(
	codCategoriaProduto INT PRIMARY KEY 
	,nomeCategoriaProduto VARCHAR (100) NOT NULL
)
CREATE TABLE tbProduto (
	codProduto INT PRIMARY KEY 
	,nomeProduto VARCHAR (100) NOT NULL
	,precoKiloProduto MONEY NOT NULL
	,codCategoriaProduto INT FOREIGN KEY REFERENCES tbCategoriaProduto (codCategoriaProduto)
)	
CREATE TABLE tbCliente(
	codCliente INT PRIMARY KEY 
	,nomeCliente VARCHAR (100) NOT NULL
	,dataNascimentoCliente DATE NOT NULL
	,ruaCliente VARCHAR (250) NOT NULL
	,numCasaCliente INT 
	,cepCliente VARCHAR (20) NOT NULL
	,bairroCliente VARCHAR (250) NOT NULL
	,cidadeCliente VARCHAR (250) NOT NULL
	,estadoCliente VARCHAR (250) NOT NULL
	,cpfCliente VARCHAR (15) NOT NULL
	,sexoCliente VARCHAR (2) NOT NULL
)

CREATE TABLE tbEncomenda(
	codEncomenda INT PRIMARY KEY IDENTITY (1,1)
	,dataEncomenda DATE NOT NULL
	,codCliente INT FOREIGN KEY REFERENCES tbCliente (codCliente)
	,valorTotalEncomenda MONEY NOT NULL
	,dataEntregaEncomenda DATE NOT NULL
)
CREATE TABLE tbItensEncomenda(
	codItensEncomenda INT PRIMARY KEY IDENTITY (1,1)
	,codEncomenda INT FOREIGN KEY REFERENCES tbEncomenda (codEncomenda)
	,codProduto INT FOREIGN KEY REFERENCES tbProduto (codProduto)
	,quantidadeKilos FLOAT NOT NULL
	,subTotal MONEY NOT NULL
)
