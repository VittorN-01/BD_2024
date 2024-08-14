USE bdEscolaDeIdiomas

---SELECT'S-----
--a) Criar uma consulta que retorne o nome e o preço dos cursos que custem abaixo do valor médio;
SELECT nomeCurso,valorCurso FROM tbCurso
	WHERE valorCurso < (SELECT AVG(valorCurso) FROM tbCurso)
	
--b) Criar uma consulta que retorne o nome e o rg do aluno mais novo;
SELECT nomeAluno, rgAluno FROM tbAluno
	WHERE dataNascAluno IN (SELECT MAX(dataNascAluno) FROM tbAluno) 

--c) Criar uma consulta que retorne o nome do aluno mais velho;
SELECT nomeAluno FROM tbAluno
	WHERE dataNascAluno IN (SELECT MIN(dataNascAluno) FROM tbAluno)

--d) Criar uma consulta que retorne o nome e o valor do curso mais caro;
SELECT nomeCurso, valorCurso FROM tbCurso
	WHERE valorCurso IN (SELECT MAX(valorCurso) FROM tbCurso) 

--e) Criar uma consulta que retorne o nome do aluno e o nome do curso, do aluno que fez a última matrícula;
SELECT nomeAluno, nomeCurso FROM tbCurso
	INNER JOIN tbTurma ON tbCurso.codCurso = tbTurma.codCurso
		INNER JOIN tbMatricula ON tbTurma.codTurma = tbMatricula.codTurma
			INNER JOIN tbAluno ON tbAluno.codAluno = tbMatricula.codAluno
			WHERE dataMatricula IN (SELECT MAX(dataMatricula) FROM tbMatricula)
	
--f) Criar uma consulta que retorne o nome do primeiro aluno a ser matriculado na escola de Idiomas;
SELECT nomeAluno FROM tbMatricula
	INNER JOIN tbAluno ON tbAluno.codAluno = tbMatricula.codAluno
	WHERE dataMatricula IN (SELECT MIN(dataMatricula) FROM tbMatricula)

--g) Criar uma consulta que retorne o nome, rg e data de nascimento de todos os alunos que estejam matriculados no curso de inglês;
SELECT nomeAluno, rgAluno, dataNascAluno FROM tbAluno
	INNER JOIN tbMatricula ON tbAluno.codAluno = tbMatricula.codAluno
		INNER JOIN tbTurma ON tbTurma.codTurma = tbMatricula.codTurma
			INNER JOIN tbCurso ON tbCurso.codCurso = tbTurma.codCurso
			WHERE nomeCurso IN (SELECT nomeCurso FROM tbCurso
								WHERE nomeCurso = 'Inglês')
