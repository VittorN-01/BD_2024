CREATE DATABASE bdRevisao
GO

USE bdRevisao
------------------------------
CREATE TABLE tbl_Status(
	idStatus int PRIMARY KEY IDENTITY (1,1)
	,descricaoStatus varchar (50) NOT NULL 
)
CREATE TABLE tbl_Genero(
	idGenero int PRIMARY KEY IDENTITY (1,1)
	,descricaoGenero varchar (50) NOT NULL
)
CREATE TABLE tbl_Crianca(
	idCrianca int PRIMARY KEY IDENTITY (1,1)
	,nomeCrianca varchar (100) NOT NULL
	,dtNascCrianca smalldatetime NOT NULL
	,idStatus int FOREIGN KEY REFERENCES tbl_Status (idStatus)
	,idGenero int FOREIGN KEY REFERENCES tbl_Genero (idGenero)
)
CREATE TABLE tbl_Genitor(
	idGenitor INT PRIMARY KEY IDENTITY (1,1)
	,nomeGenitor varchar (100) NOT NULL
	,cpfGenitor char (11) NOT NULL
)	
CREATE TABLE tbl_Filiacao(
	idFiliacao INT PRIMARY KEY IDENTITY (1,1)
	,idCrianca INT FOREIGN KEY REFERENCES tbl_Crianca (idCrianca)
	,idGenitor INT FOREIGN KEY REFERENCES tbl_Genitor (idGenitor)
)
CREATE TABLE tbl_Padrinho(
	idPadrinho INT PRIMARY KEY IDENTITY (1,1)
	,nomePadrinho VARCHAR (100) NOT NULL
	,cpfPadrinho char (11) NOT NULL
	,logradouro VARCHAR (100) NOT NULL
	,numero INT NOT NULL
	,complemento VARCHAR (100) NOT NULL
	,cep char (10) NOT NULL
	,bairro VARCHAR (100) NOT NULL
	,cidade VARCHAR (100) NOT NULL
	,estado VARCHAR (100) NOT NULL
)
CREATE TABLE tbl_Apadrinhamento(
	idApadrinhamento INT PRIMARY KEY IDENTITY (1,1)
	,idCrianca INT FOREIGN KEY REFERENCES tbl_Crianca (idCrianca)
	,idPadrinho INT FOREIGN KEY REFERENCES tbl_Padrinho (idPadrinho)
	,dataApadrinhamento DATE
)
CREATE TABLE tbl_Prontuario(
	idProntuario INT PRIMARY KEY IDENTITY (1,1)
	,dataAbertura DATE NOT NULL
	,idCrianca INT FOREIGN KEY REFERENCES tbl_Crianca (idCrianca)
)
CREATE TABLE tbl_Doenca(
	idDoenca INT PRIMARY KEY IDENTITY (1,1)
	,CID INT
	,nomeDoenca VARCHAR (100) NOT NULL
)
CREATE TABLE tbl_Observacoes(
	idObs INT PRIMARY KEY IDENTITY (1,1)
	,descricaoObs VARCHAR (100) NOT NULL
	,idCrianca INT FOREIGN KEY REFERENCES tbl_Crianca (idCrianca)
)
CREATE TABLE tbl_ProntuarioDoenca(
	idProntuarioDoenca INT PRIMARY KEY IDENTITY (1,1)
	,idProntuario INT FOREIGN KEY REFERENCES tbl_Prontuario (idProntuario)
	,idDoenca INT FOREIGN KEY REFERENCES tbl_Doenca (idDoenca)
)