USE db_EscolaIdiomas

-- Crie uma função que de acordo com a carga horária do curso exiba curso rápido ou curso extenso. (Rápido menos de 1000 horas).
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
		SET @resultado = 'Curso Rápido'
	END

	RETURN @resultado
END

-- Testando a Function --

SELECT nomeCurso, cargaHorariaCurso, 'Tipo de Curso' = dbo.fcCargaCurso (cargaHorariaCurso)
FROM tbl_curso