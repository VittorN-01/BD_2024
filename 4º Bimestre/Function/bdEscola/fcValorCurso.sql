USE db_EscolaIdiomas

-- Crie uma função que de acordo com o valor do curso exiba curso caro ou curso barato. (Curso caro acima de 400).
CREATE FUNCTION fcValorCurso (@valor MONEY)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @resultado VARCHAR(50);

    IF @valor > 400
    BEGIN
        SET @resultado = 'Curso Caro';
    END
    ELSE
    BEGIN
        SET @resultado = 'Curso Barato';
    END

    RETURN @resultado;
END;

-- Testando a Function --

SELECT nomeCurso, valorCurso, 'Tipo de Curso' = dbo.fcValorCurso(valorCurso)
FROM tbl_curso