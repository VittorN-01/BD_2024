CREATE DATABASE bdMerge
USE bdMerge
-----------EXERCÍCIO---------------
--Tabelas
CREATE TABLE tb2A(
	RM INT PRIMARY KEY
	,nomeAluno VARCHAR (100)
	,status VARCHAR (10)
)
CREATE TABLE tb2B(
	RM INT PRIMARY KEY
	,nomeAluno VARCHAR (100)
	,status VARCHAR (10)
)

--Insert's
INSERT INTO tb2A (RM, nomeAluno, status) VALUES
	(1, 'João Silva', 'Aprovado'),
	(2, 'Maria Oliveira', 'Aprovado'),
	(3, 'Carlos Souza', 'Reprovado'),
	(4, 'Ana Costa', 'Aprovado'),
	(5, 'Lucas Pereira', 'Reprovado'),
	(6, 'Paula Lima', 'Aprovado'),
	(7, 'Roberta Santos', 'Aprovado'),
	(8, 'Felipe Almeida', 'Reprovado'),
	(9, 'Mariana Barbosa', 'Aprovado'),
	(10, 'Gabriel Martins', 'Aprovado');
INSERT INTO tb2B (RM, nomeAluno, status) VALUES
	(11, 'Ana Silva', 'Aprovado'),
	(12, 'Lucas Santos', 'Reprovado'),
	(13, 'Giovana Costa', 'Aprovado'),
	(14, 'Eduardo Lima', 'Aprovado'),
	(15, 'Renata Rocha', 'Reprovado'),
	(16, 'Tiago Pereira', 'Aprovado'),
	(17, 'Bruna Almeida', 'Aprovado'),
	(18, 'Sérgio Oliveira', 'Reprovado'),
	(19, 'Roberta Souza', 'Aprovado'),
	(20, 'Paulo Barbosa', 'Aprovado');
--------------------------------------------------------
--- MERGE ---
--tabela
CREATE TABLE tb3A(
	RM INT PRIMARY KEY
	,nomeAluno VARCHAR (100)
	,status VARCHAR (10)
)

-- Do 2A para o 3A
MERGE tb3A AS dest
USING (SELECT RM, nomeAluno, status FROM tb2A 
		WHERE status = 'Aprovado') ori
ON ori.RM = dest.RM
	WHEN NOT MATCHED THEN
		INSERT (RM, nomeAluno, status)
		VALUES (ori.RM, ori.nomeAluno, ori.status)
	WHEN MATCHED THEN
		UPDATE SET dest.nomeAluno = ori.nomeAluno, dest.status = ori.status;

-- Do 2B para o 3A
MERGE tb3A AS dest
USING (SELECT RM, nomeAluno, status FROM tb2B 
		WHERE status = 'Aprovado') ori
ON ori.RM = dest.RM
	WHEN NOT MATCHED THEN
		INSERT (RM, nomeAluno, status)
		VALUES (ori.RM, ori.nomeAluno, ori.status)
	WHEN MATCHED THEN
		UPDATE SET dest.nomeAluno = ori.nomeAluno, dest.status = ori.status;

		select * from tb3A