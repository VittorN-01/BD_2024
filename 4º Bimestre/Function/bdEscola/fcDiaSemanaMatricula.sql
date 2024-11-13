USE db_EscolaIdiomas

-- Crie uma função que informada uma data da matrícula , retorne o dia da semana.
CREATE FUNCTION fcDiaSemanaMatricula (@Data DATE)
RETURNS VARCHAR(50) 
AS
BEGIN
	DECLARE @dSemana VARCHAR(50)
	DECLARE @dia INT

	SET @dia = DATEPART(DW, @Data)

	IF @dia = 1
	BEGIN
		SET @dSemana = 'Domingo';
	END;
	IF @dia = 2
	BEGIN
		SET @dSemana = 'Segunda-Feira';
	END;
	IF @dia = 3
	BEGIN
		SET @dSemana = 'Terça-Feira';
	END;
	IF @dia = 4
	BEGIN
		SET @dSemana = 'Quarta-Feira';
	END;
	IF @dia = 5
	BEGIN
		SET @dSemana = 'Quinta-Feira';
	END;
	IF @dia = 6
	BEGIN
		SET @dSemana = 'Sexta-Feira';
	END;
	IF @dia = 7
	BEGIN
		SET @dSemana = 'Sábado';
	END; 

	RETURN @dSemana;
END;

-- Testando a Function --

SELECT codAluno, dataMatricula, 'Dia da Semana' = dbo.fcDiaSemanaMatriucula (dataMatricula)
FROM tbl_Matricula
