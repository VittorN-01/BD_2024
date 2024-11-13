CREATE DATABASE bdMerge
USE bdMerge
-----------------------------
-- Exemplos --
CREATE TABLE tbProdutoLj1(
	idProduto INT PRIMARY KEY
	,nomeProduto VARCHAR (100)
	,precoProduto MONEY
	,qtde INT
)
CREATE TABLE tbProdutoLj2(
	idProduto INT PRIMARY KEY
	,nomeProduto VARCHAR (100)
	,precoProduto MONEY
	,qtde INT
)
----NOVA TABELA----
CREATE TABLE tbProdutos(
	idProduto INT PRIMARY KEY
	,nomeProduto VARCHAR (100)
	,precoProduto MONEY
	,qtde INT
)

MERGE tbProdutos dest
USING tbProdutoLj1 ori
ON ori.idProduto = dest.idProduto
	WHEN NOT MATCHED THEN
		INSERT values (ori.idProduto,ori.nomeProduto, ori.precoProduto,ori.qtde)
	WHEN MATCHED THEN
		UPDATE SET dest.qtde += ori.qtde;

MERGE tbProdutos dest
USING tbProdutoLj2 ori
ON ori.idProduto = dest.idProduto
	WHEN NOT MATCHED THEN
		INSERT values (ori.idProduto,ori.nomeProduto, ori.precoProduto,ori.qtde)
	WHEN MATCHED THEN
		UPDATE SET dest.qtde += ori.qtde;



