CREATE DATABASE bdEscolaIdiomas
USE bdEscolaIdiomas
-----------TABELAS----------------
CREATE TABLE tbAluno(
	codAluno INT PRIMARY KEY IDENTITY(1,1)
	,nomeAluno VARCHAR (1000) NOT NULL
	,dataNascAluno SMALLDATETIME NOT NULL
	,rgAluno VARCHAR (15) NOT NULL
	,naturalidadeAluno VARCHAR (1000) NOT NULL
)
CREATE TABLE tbCurso(
	codCurso INT PRIMARY KEY IDENTITY(1,1)
	,nomeCurso VARCHAR (1000) NOT NULL
	,cargahorariaCurso INT NOT NULL
	,valorCurso FLOAT NOT NULL
)
CREATE TABLE tbTurma(
	codTurma INT PRIMARY KEY IDENTITY(1,1)
	,nomeTurma VARCHAR (1000) NOT NULL
	,codCurso INT FOREIGN KEY (codCurso) REFERENCES tbCurso (codCurso)
	,horarioTurma SMALLDATETIME NOT NULL
)
CREATE TABLE tbMatricula(
	codMatricula INT PRIMARY KEY IDENTITY(1,1)
	,dataMatricula SMALLDATETIME NOT NULL
	,codAluno INT NOT NULL
	,codTurma INT FOREIGN KEY (codTurma) REFERENCES tbTurma (codTurma)
)


