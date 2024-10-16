CREATE DATABASE bdEstoque;
USE bdEstoque;
GO

-- Tabela FORNECEDOR
CREATE TABLE tbFornecedor (
    codFornecedor INT PRIMARY KEY NOT NULL,
    nomeFornecedor VARCHAR(1000) NOT NULL,
    contatoFornecedor VARCHAR(13) NOT NULL
);

-- Tabela FABRICANTE
CREATE TABLE tbFabricante (
    codFabricante INT PRIMARY KEY NOT NULL,
    nomeFabricante VARCHAR(1000) NOT NULL
);

-- Tabela CLIENTE
CREATE TABLE tbCliente (
    codCliente INT PRIMARY KEY NOT NULL,
    nomeCliente VARCHAR(1000) NOT NULL,
    cpfCliente VARCHAR(15) NOT NULL,
    emailCliente VARCHAR(1000) NOT NULL,
    sexoCliente VARCHAR(1) NOT NULL,
    dataNascCliente DATE NOT NULL
);

-- Tabela VENDA
CREATE TABLE tbVenda (
    codVenda INT PRIMARY KEY NOT NULL,
    dataVenda DATE NOT NULL,
    valorTotalVenda FLOAT NOT NULL,
    codCliente INT NOT NULL,
    FOREIGN KEY (codCliente) REFERENCES tbCliente(codCliente)
);

-- Tabela PRODUTO
CREATE TABLE tbProduto (
    codProduto INT PRIMARY KEY NOT NULL,
    descricaoProduto VARCHAR(1000) NOT NULL,
    valorProduto FLOAT NOT NULL,
    quantidadeProduto INT NOT NULL,
    codFabricante INT FOREIGN KEY REFERENCES tbFabricante(codFabricante),
    codFornecedor INT FOREIGN KEY REFERENCES tbFornecedor(codFornecedor)
);

-- Tabela Itens de Venda
CREATE TABLE tbItensVenda (
    codItensVenda INT PRIMARY KEY NOT NULL,
    codVenda INT FOREIGN KEY REFERENCES tbVenda(codVenda),
    codProduto INT FOREIGN KEY REFERENCES tbProduto(codProduto),
    quantidadeItensVenda INT,
    subTotalItensVenda FLOAT NOT NULL
);

-- Tabela Entrada Produto
CREATE TABLE tbEntradaProduto (
    codEntrada INT PRIMARY KEY NOT NULL,
    dataEntradaProduto DATETIME,
    codProduto INT FOREIGN KEY REFERENCES tbProduto(codProduto),
    quantidadeEntradaProduto INT
);

-- Tabela Saída Produto
CREATE TABLE tbSaidaProduto (
    codSaidaProduto INT PRIMARY KEY NOT NULL,
    dataSaidaproduto DATETIME,
    codProduto INT FOREIGN KEY REFERENCES tbProduto(codProduto),
    quantidadeSaidaProduto INT
);
