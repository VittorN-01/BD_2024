USE db_EscolaIdiomas



--1) Criar uma stored procedure “Busca_Aluno” que receba o código do aluno e retorne seu nome e data de nascimento.
CREATE PROCEDURE spBusca_Aluno
@codAluno INT
AS
	SELECT nomeAluno, dataNascAluno FROM tbl_Aluno
		WHERE codAluno = @codAluno
		
EXEC spBusca_Aluno '7'

--2) Criar uma stored procedure “Insere_Aluno” que insira um registro na tabela de Alunos.
CREATE PROCEDURE spInsere_Aluno
@nomeAluno VARCHAR (250),
@rgAluno CHAR (9),
@dataNascAluno DATE, 
@naturalidadeAluno CHAR (2)
AS 
	INSERT INTO tbl_aluno (nomeAluno,rgAluno,dataNascAluno,naturalidadeAluno)VALUES 
							(@nomeAluno, @rgAluno, @dataNascAluno, @naturalidadeAluno)
							PRINT 'Aluno Cadastrado' 
						
	EXEC spInsere_Aluno 'Gustavo Brayan' , '345768966', '19/08/2007','SP'
	
--3) Criar uma stored procedure “Aumenta_Preco” que, dados o nome do curso e um percentual, aumente o valor do curso com a porcentagem informada.
CREATE PROCEDURE spAumenta_Preco
@nomeCurso VARCHAR (10),
@Percentual DECIMAL (5, 2)
AS 
BEGIN
	IF EXISTS (SELECT 1 FROM tbl_curso WHERE nomeCurso = @nomeCurso)
	BEGIN
		UPDATE tbl_curso
		SET valorCurso = valorCurso + (valorCurso * @Percentual / 100)
		WHERE nomeCurso = @nomeCurso

		PRINT 'Preço do curso de '+ @nomeCurso + ' atualizado'
	END
	ELSE
	BEGIN
		PRINT 'Curso não encontrado'
	END
END

EXEC spAumenta_Preco 'Inglês', '10'
SELECT * FROM tbl_curso

--4) Criar uma stored procedure “Exibe_Turma” que, dado o nome da turma, exiba todas as informações dela.
CREATE PROCEDURE spExibe_Turma
@nomeTurma VARCHAR (10)
AS 
BEGIN
	SELECT * FROM tbl_turma
		WHERE nomeTurma = @nomeTurma
END

EXEC spExibe_Turma '1|B'
 SELECT * FROM tbl_turma
--5) Criar uma stored procedure “Exibe_AlunosdaTurma” que, dado o nome da turma, exiba os seus alunos.
CREATE PROCEDURE spExibe_AlunosdaTurma
@nomeTurma VARCHAR(10)
AS
BEGIN
	SELECT tbl_aluno.nomeAluno FROM tbl_turma
		INNER JOIN tbl_matricula ON tbl_turma.codTurma = tbl_matricula.codTurma
			INNER JOIN tbl_aluno ON tbl_aluno.codAluno = tbl_matricula.codAluno
			WHERE tbl_turma.nomeTurma = @nomeTurma;
END

EXEC spExibe_AlunosdaTurma '1EC'

--6) Criar uma stored procedure para inserir alunos, verificando pelo CPF se o aluno existe ou não, e informar essa condição via mensagem.
CREATE PROCEDURE spInserir_comVerificacao
@nomeAluno VARCHAR(250)
,@dataNascAluno DATE
,@rgAluno CHAR(9)
,@naturalidadeAluno CHAR(2)
AS 
	IF EXISTS (SELECT rgAluno FROM tbl_aluno WHERE rgAluno LIKE @rgAluno)
	BEGIN 
		PRINT ('Não é possivel Cadastrar! RG ' + @rgAluno + '	 já existe!')
		END
		ELSE
		BEGIN
				INSERT tbl_aluno(nomeAluno, dataNascAluno, rgAluno, naturalidadeAluno) VALUES
								(@nomeAluno,@dataNascAluno, @rgAluno, @naturalidadeAluno)
				PRINT ('Aluno cadastrado')
			END

EXEC spInserir_comVerificacao 'Vittor Nascimento','2007/06/01','987654321','SP'

--7) Criar uma stored procedure que receba o nome do curso e o nome do aluno e matricule o mesmo no curso pretendido.
CREATE PROCEDURE spMatricula_Aluno
@nomeAluno VARCHAR(250)
,@nomeCurso VARCHAR(10)
AS
BEGIN
    DECLARE @codAluno INT
    DECLARE @codCurso INT
    DECLARE @codTurma INT

    SELECT @codAluno = codAluno FROM tbl_aluno
		WHERE nomeAluno = @nomeAluno

    IF @codAluno IS NULL
    BEGIN
        INSERT INTO tbl_aluno (nomeAluno, dataNascAluno, rgAluno, naturalidadeAluno) VALUES 
							  (@nomeAluno, '2007/12/21','102030405', 'AM') --Dados Fictícios
        SELECT @codAluno = SCOPE_IDENTITY()
    END

    SELECT @codCurso = codCurso FROM tbl_curso
	    WHERE nomeCurso = @nomeCurso

    SELECT TOP 1 @codTurma = codTurma FROM tbl_turma
		WHERE codCurso = @codCurso

    IF @codCurso IS NULL
    BEGIN
        PRINT 'Curso não encontrado.'
        RETURN
    END
    IF @codTurma IS NULL
    BEGIN
        PRINT 'Nenhuma turma disponível para o curso.'
        RETURN
    END

    INSERT INTO tbl_matricula (dataMatricula, codAluno, codTurma) VALUES 
								(GETDATE(), @codAluno, @codTurma)

    PRINT 'Matrícula realizada com sucesso!'
END

EXEC spMatricula_Aluno 'Gustavo Quintanilia', 'Inglês'
