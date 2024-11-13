USE db_EscolaIdiomas

-- Crie uma fun��o que de acordo com a carga hor�ria do curso exiba curso r�pido ou curso extenso. (R�pido menos de 1000 horas).
CREATE FUNCTION fcCargaCurso (@carga INT)
RETURNS VARCHAR (50)
AS
BEGIN
	DECLARE @resultado VARCHAR (50)
	
	IF @carga > 1000
	BEGIN
		SET @resultado = 'Curso Extenso'
	END
	ELSE
	BEGIN
		SET @resultado = 'Curso R�pido'
	END

	RETURN @resultado
END

-- Testando a Function --

SELECT nomeCurso, cargaHorariaCurso, 'Tipo de Curso' = dbo.fcCargaCurso (cargaHorariaCurso)
FROM tbl_curso