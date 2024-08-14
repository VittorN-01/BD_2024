USE db_EscolaIdiomas
-------------------
--1)
CREATE VIEW vwPreco_Baixo AS 
	SELECT tbl_curso.codCurso AS 'Código' 
		,nomeCurso AS 'Curso'
		,cargaHorariaCurso AS 'Carga Horária'
		,valorCurso AS 'Valor do Curso'
	FROM tbl_curso
		WHERE valorCurso < (SELECT AVG(valorCurso) FROM tbl_curso)

--2)
SELECT * FROM vwPreco_Baixo
	ORDER BY [Carga Horária]

--3)
CREATE VIEW vwAlunos_Turma AS 
	SELECT nomeCurso AS 'Curso'
	,nomeTurma AS 'Turma'
	,COUNT (tbl_aluno.codAluno) AS 'Qnt. Alunos'
	FROM tbl_curso
	INNER JOIN tbl_turma ON tbl_curso.codCurso = tbl_turma.codCurso
		INNER JOIN tbl_matricula ON tbl_turma.codTurma = tbl_matricula.codTurma
			INNER JOIN tbl_aluno ON tbl_aluno.codAluno = tbl_matricula.codAluno
				GROUP BY nomeCurso, nomeTurma

--4)
SELECT * FROM vwAlunos_Turma
	WHERE [Qnt. Alunos] IN (SELECT MAX([Qnt. Alunos]) FROM vwAlunos_Turma) 

--5)
CREATE VIEW vwTurma_Curso AS
	SELECT nomeCurso AS Curso
	,COUNT (tbl_turma.codTurma) AS 'Qnt. Turmas'
	FROM tbl_curso
	INNER JOIN tbl_turma ON tbl_curso.codCurso = tbl_turma.codCurso
		GROUP BY nomeCurso	

--6)
SELECT * FROM vwTurma_Curso
	WHERE [Qnt. Turmas] IN (SELECT MIN([Qnt. Turmas]) FROM vwTurma_Curso)
