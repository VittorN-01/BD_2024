CREATE DATABASE bdEstoque
USE bdEstoque
GO
--Criando Tabelas

----------Tabela FORNECEDOR
CREATE TABLE tbFornecedor(
	codFornecedor INT PRIMARY KEY NOT NULL
	,nomeFornecedor VARCHAR (1000) NOT NULL
	,contatoFornecedor VARCHAR (13) NOT NULL
)
----------Tabela FABRICANTE
CREATE TABLE tbFabricante(
	codFabricante INT PRIMARY KEY NOT NULL
	,nomeFabricante Varchar (1000) NOT NULL
)
---------Tabela CLIENTE
CREATE TABLE tbCliente(
	codCliente INT PRIMARY KEY NOT NULL
	,nomeCliente VARCHAR (1000) NOT NULL
	,cpfCliente VARCHAR (15) NOT NULL
	,emailCliente VARCHAR (1000) NOT NULL
	,sexoCliente VARCHAR (1) NOT NULL
	,dataNascCliente DATE NOT NULL
)
---------Tabela VENDA
CREATE TABLE tbVenda(
	codVenda INT PRIMARY KEY NOT NULL
	,dataVenda DATE NOT NULL
	,valorTotalVenda FLOAT NOT NULL
	,codCliente INT NOT NULL
)
--------Tabela PRODUTO
CREATE TABLE tbProduto(
	codProduto INT PRIMARY KEY NOT NULL
	,descricaoProduto VARCHAR (1000) NOT NULL
	,valorProduto FLOAT NOT NULL
	,quantidadeProduto INT NOT NULL
	,codFabricante INT FOREIGN KEY (codFabricante) REFERENCES tbFabricante (codFabricante)
	,codFornecedor INT FOREIGN KEY (codFornecedor) REFERENCES tbFornecedor (codFornecedor)
)
---------Tabela Itens de Venda
CREATE TABLE tbItensVenda(
	codItensVenda INT PRIMARY KEY NOT NULL
	,codVenda INT FOREIGN KEY (codVenda) REFERENCES tbVenda (codVenda)
	,codProduto INT FOREIGN KEY (codProduto) REFERENCES tbProduto (codProduto)
	,quantidadeItensVenda INT 
	,subTotalItensVenda VARCHAR (100) NOT NULL
)
