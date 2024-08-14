USE bdRecursosHumanos
---------------------
--a) Criar uma view para exibir a quantidade de funcionários por nome de departamento;
CREATE VIEW vwFuncionario_Departamento AS	SELECT COUNT(codFuncionario) AS 'Qnt. Funcionários'	,nomeDepartamento AS 'Departamento'	FROM tbFuncionario		INNER JOIN tbDepartamento ON tbFuncionario.codDepartamento = tbDepartamento.codDepartamento		GROUP BY nomeDepartamento		--b) Usando a view anterior, exibir somente o nome do departamento que possui o menor número de funcionários
SELECT * FROM vwFuncionario_Departamento
	WHERE [Qnt. Funcionários] IN (SELECT MIN ([Qnt. Funcionários])FROM vwFuncionario_Departamento)

--c) Criar uma view para exibir a soma dos salários por nome de departamento
CREATE VIEW vwSalario_Departamento AS
	SELECT SUM(salarioFuncionario) AS 'Soma dos Salários'
	,nomeDepartamento AS 'Departamento' 
	FROM tbFuncionario 
		INNER JOIN tbDepartamento ON tbFuncionario.codDepartamento = tbDepartamento.codDepartamento 
		GROUP BY nomeDepartamento  

--d) Utilizando a view do exercício anterior, mostrar somente a maior soma dentre os departamentos
SELECT * FROM vwSalario_Departamento	
	WHERE [Soma dos Salários] IN (SELECT MAX ([Soma dos Salários]) FROM vwSalario_Departamento)

--e) Criar uma view para exibir somente o nome dos funcionários e o nome dos departamentos daqueles funcionários que não possuem dependentes
CREATE VIEW vwNome_Funcionario AS 
	SELECT nomeFuncionario AS 'Funcionários'
	,nomeDepartamento 'Departamento' 
	FROM tbFuncionario
		INNER JOIN tbDepartamento ON tbFuncionario.codDepartamento = tbDepartamento.codDepartamento 
			WHERE  codFuncionario NOT IN (SELECT codFuncionario FROM tbDependente) 
			
--f) Criar uma view que exiba a quantidade de dependentes por nome de funcionário
CREATE VIEW vwDependentes_Funcionario AS
	SELECT COUNT(codDependente) AS 'Qnt. Dependentes'
	,nomeFuncionario AS 'Nome do Funcionário'
	FROM tbDependente
		INNER JOIN tbFuncionario ON tbDependente.codFuncionario = tbFuncionario.codFuncionario
		GROUP BY nomeFuncionario

--g) Utilizando a view anterior, mostrar somente o nome do funcionário que possui mais dependentes
SELECT * FROM vwDependentes_Funcionario
	WHERE [Qnt. Dependentes] IN (SELECT MAX([Qnt. Dependentes]) FROM vwDependentes_Funcionario)

--h) Criar uma view para exibir a quantidade de dependentes por departamento
CREATE VIEW vwDependentes_Departamento AS	SELECT COUNT(codDependente) AS 'Qnt. Dependentes'	,nomeDepartamento AS 'Departamento'	FROM tbDependente		INNER JOIN tbFuncionario ON tbDependente.codFuncionario = tbFuncionario.codFuncionario			INNER JOIN tbDepartamento ON tbFuncionario.codDepartamento = tbDepartamento.codDepartamento			GROUP BY nomeDepartamento--i) Utilizando a view do exercícios anterior, apresentar a soma geral dos dependentesSELECT SUM([Qnt. Dependentes])AS 'Soma dos Dependentes' FROM vwDependentes_Departamento