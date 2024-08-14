USE bdEscolaIdiomas

--------------SELECT'S---------------
--1) Apresentar os nomes dos alunos ao lado do nome dos cursos que eles fazem
SELECT nomeAluno AS 'Nomes dos Alunos', nomeCurso AS 'Nome do Curso' FROM tbAluno
	INNER JOIN tbMatricula ON tbAluno.codAluno = tbMatricula.codAluno
		INNER JOIN tbTurma ON tbMatricula.codTurma = tbTurma.codTurma
			INNER JOIN tbCurso ON tbTurma.codCurso = tbCurso.codCurso
			

--2) Apresentar a quantidade de alunos matriculados por nome do curso
SELECT COUNT (codAluno) AS 'Qnt. de Alunos', nomeCurso AS 'Nome do Curso' FROM tbCurso
	INNER JOIN tbTurma ON tbCurso.codCurso = tbTurma.codCurso
		INNER JOIN tbMatricula ON tbTurma.codTurma = tbMatricula.codTurma
			GROUP BY nomeCurso


--3) Apresentar a quantidade de alunos matriculados por nome da turma
SELECT COUNT (codAluno) AS 'Qnt. de Alunos', nomeTurma AS 'Nome da Turma' FROM tbTurma
	INNER JOIN tbMatricula ON tbTurma.codTurma = tbMatricula.codTurma
			GROUP BY nomeTurma

			
--4) Apresentar a quantidade de alunos que fizeram matricula em maio de 2016
SELECT COUNT (codAluno) AS 'Qnt. de Alunos Matriculados em Maio de 2016' FROM tbMatricula
	WHERE MONTH(dataMatricula) = 5 AND YEAR(dataMatricula) = 2016;


--5)Apresentar o nome dos alunos em ordem alfabética ao lado do nome das turmas e os nomes dos cursos em que estão matriculados
SELECT nomeAluno AS 'Nome do Aluno', nomeTurma AS 'Nome da Turma', nomeCurso AS 'Nome do Curso' FROM tbAluno	
	INNER JOIN tbMatricula ON tbAluno.codAluno = tbMatricula.codAluno
		INNER JOIN tbTurma ON tbMatricula.codTurma = tbTurma.codTurma
			INNER JOIN tbCurso ON tbTurma.codCurso = tbCurso.codCurso
				ORDER BY nomeAluno


--6) Apresentar o nome dos cursos e os horários em que eles são oferecidos
SELECT DISTINCT nomeCurso AS 'Nome do Curso', horarioTurma AS 'Horário da Turma' FROM tbCurso
	INNER JOIN tbTurma	ON tbCurso.codCurso = tbTurma.codCurso
		ORDER BY nomeCurso


--7) Apresentar a quantidade de alunos nascidos por estado que estejam matriculados no curso de ingles
SELECT COUNT (tbAluno.codAluno) AS 'Qnt. Alunos', naturalidadeAluno AS 'Naturalidades' FROM tbAluno
		INNER JOIN tbMatricula ON tbAluno.codAluno = tbMatricula.codAluno
			INNER JOIN tbTurma ON tbMatricula.codTurma = tbTurma.codTurma
				INNER JOIN tbCurso ON tbTurma.codCurso = tbCurso.codCurso
					WHERE nomeCurso = 'Inglês'
						GROUP BY naturalidadeAluno


--8) Apresentar o nome dos alunos ao lado da data de matrícula no formato dd/mm/aaaa
SELECT nomeAluno AS 'Nome dos Alunos'
	,RIGHT('00' + CAST(MONTH(dataMatricula) AS VARCHAR), 2) + '/' +
    RIGHT('00' + CAST(DAY(dataMatricula) AS VARCHAR), 2) + '/' +
    CAST(YEAR(dataMatricula) AS VARCHAR) AS 'Data da Matricula'
FROM tbAluno
		INNER JOIN tbMatricula ON tbMatricula.codAluno = tbAluno.codAluno


--9) Apresentar os alunos cujo nome comece com A e que estejam matriculados no curso de inglês
-- Modificação: Alunos com a letra P
SELECT DISTINCT (nomeAluno) AS 'Alunos com a letra "P" que fazem Inglês' FROM tbAluno
		INNER JOIN tbMatricula ON tbAluno.codAluno = tbMatricula.codAluno
			INNER JOIN tbTurma ON tbMatricula.codTurma = tbTurma.codTurma
				INNER JOIN tbCurso ON tbTurma.codCurso = tbCurso.codCurso
					WHERE nomeCurso = 'Inglês' AND nomeAluno LIKE 'P%'


--10) Apresentar a quantidade de matriculas feitas no ano de 2016
	SELECT COUNT (tbMatricula.codMatricula) AS 'Matriculas de 2016' FROM tbMatricula
		WHERE YEAR (dataMatricula) = 2016


--11) Apresentar a quantidade de matriculas por nome do curso
SELECT COUNT (codMatricula) AS 'Nº de matriculas por Curso', nomeCurso AS 'Nome do Curso' FROM tbCurso
	INNER JOIN tbTurma ON tbCurso.codCurso = tbTurma.codCurso
		INNER JOIN tbMatricula ON tbTurma.codTurma = tbMatricula.codTurma
			GROUP BY nomeCurso


--12) Apresentar a quantidade de alunos que fazem os cursos que custam mais de R$ 300,00
SELECT COUNT (tbAluno.codAluno) AS 'Qnt. de Alunos' FROM tbAluno
	INNER JOIN tbMatricula ON tbMatricula.codAluno = tbAluno.codAluno
		INNER JOIN tbTurma ON tbMatricula.codTurma = tbTurma.codTurma
			INNER JOIN tbCurso ON tbTurma.codCurso = tbCurso.codCurso
				WHERE valorCurso>300


--13) Apresentar os nomes dos alunos que fazem o curso de alemão
SELECT nomeAluno AS 'Alunos que fazem Alemão' FROM tbAluno
	INNER JOIN tbMatricula ON tbMatricula.codAluno = tbAluno.codAluno
		INNER JOIN tbTurma ON tbMatricula.codTurma = tbTurma.codTurma
			INNER JOIN tbCurso ON tbTurma.codCurso = tbCurso.codCurso
				WHERE nomeCurso = 'Alemão'

