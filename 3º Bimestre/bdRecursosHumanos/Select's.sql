USE bdRecursosHumanos
---------------------
--a) Criar uma view para exibir a quantidade de funcion�rios por nome de departamento;
CREATE VIEW vwFuncionario_Departamento AS	SELECT COUNT(codFuncionario) AS 'Qnt. Funcion�rios'	,nomeDepartamento AS 'Departamento'	FROM tbFuncionario		INNER JOIN tbDepartamento ON tbFuncionario.codDepartamento = tbDepartamento.codDepartamento		GROUP BY nomeDepartamento		--b) Usando a view anterior, exibir somente o nome do departamento que possui o menor n�mero de funcion�rios
SELECT * FROM vwFuncionario_Departamento
	WHERE [Qnt. Funcion�rios] IN (SELECT MIN ([Qnt. Funcion�rios])FROM vwFuncionario_Departamento)

--c) Criar uma view para exibir a soma dos sal�rios por nome de departamento
CREATE VIEW vwSalario_Departamento AS
	SELECT SUM(salarioFuncionario) AS 'Soma dos Sal�rios'
	,nomeDepartamento AS 'Departamento' 
	FROM tbFuncionario 
		INNER JOIN tbDepartamento ON tbFuncionario.codDepartamento = tbDepartamento.codDepartamento 
		GROUP BY nomeDepartamento  

--d) Utilizando a view do exerc�cio anterior, mostrar somente a maior soma dentre os departamentos
SELECT * FROM vwSalario_Departamento	
	WHERE [Soma dos Sal�rios] IN (SELECT MAX ([Soma dos Sal�rios]) FROM vwSalario_Departamento)

--e) Criar uma view para exibir somente o nome dos funcion�rios e o nome dos departamentos daqueles funcion�rios que n�o possuem dependentes
CREATE VIEW vwNome_Funcionario AS 
	SELECT nomeFuncionario AS 'Funcion�rios'
	,nomeDepartamento 'Departamento' 
	FROM tbFuncionario
		INNER JOIN tbDepartamento ON tbFuncionario.codDepartamento = tbDepartamento.codDepartamento 
			WHERE  codFuncionario NOT IN (SELECT codFuncionario FROM tbDependente) 
			
--f) Criar uma view que exiba a quantidade de dependentes por nome de funcion�rio
CREATE VIEW vwDependentes_Funcionario AS
	SELECT COUNT(codDependente) AS 'Qnt. Dependentes'
	,nomeFuncionario AS 'Nome do Funcion�rio'
	FROM tbDependente
		INNER JOIN tbFuncionario ON tbDependente.codFuncionario = tbFuncionario.codFuncionario
		GROUP BY nomeFuncionario

--g) Utilizando a view anterior, mostrar somente o nome do funcion�rio que possui mais dependentes
SELECT * FROM vwDependentes_Funcionario
	WHERE [Qnt. Dependentes] IN (SELECT MAX([Qnt. Dependentes]) FROM vwDependentes_Funcionario)

--h) Criar uma view para exibir a quantidade de dependentes por departamento
CREATE VIEW vwDependentes_Departamento AS	SELECT COUNT(codDependente) AS 'Qnt. Dependentes'	,nomeDepartamento AS 'Departamento'	FROM tbDependente		INNER JOIN tbFuncionario ON tbDependente.codFuncionario = tbFuncionario.codFuncionario			INNER JOIN tbDepartamento ON tbFuncionario.codDepartamento = tbDepartamento.codDepartamento			GROUP BY nomeDepartamento--i) Utilizando a view do exerc�cios anterior, apresentar a soma geral dos dependentesSELECT SUM([Qnt. Dependentes])AS 'Soma dos Dependentes' FROM vwDependentes_Departamento