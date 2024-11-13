USE db_EscolaIdiomas

-- Criar uma função que informada a data da matrícula converta-a no formato dd/mm/aaaa.
CREATE FUNCTION fcConverterData (@data DATE)
RETURNS VARCHAR(10)
AS 
BEGIN
    DECLARE @resultado VARCHAR(10);

    SET @resultado = FORMAT(@data, 'dd/MM/yyyy');

    RETURN @resultado;
END;

-- Testando a Funtion --

SELECT dataMatricula , 'Data Formatada' = dbo.fcConverterData (dataMatricula)
FROM tbl_matricula