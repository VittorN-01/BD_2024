USE bdEstoque

-- Criar uma função que usando o bdEstoquediga se o cpfdo cliente é ou não válido
CREATE FUNCTION fcValidarCPF (@Cpf VARCHAR(15))
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @indice INT, @soma INT, @d1 INT, @d2 INT, @cpf_temp CHAR(1), @digIguais CHAR(1), @resultado VARCHAR(20);
    
    SET @resultado = 'CPF Inválido';
    SET @cpf_temp = SUBSTRING(@Cpf, 1, 1);
    SET @indice = 2;
    SET @digIguais = 'S';
    
    -- Verifica se todos os dígitos são iguais
    WHILE (@indice <= LEN(@Cpf) AND @digIguais = 'S')
    BEGIN
        IF SUBSTRING(@Cpf, @indice, 1) <> @cpf_temp
            SET @digIguais = 'N';
        SET @indice = @indice + 1;
    END;

    IF @digIguais = 'N'
    BEGIN
        -- Cálculo do 1º dígito
        SET @soma = 0;
        SET @indice = 1;
        WHILE (@indice <= 9)
        BEGIN
            SET @soma = @soma + CONVERT(INT, SUBSTRING(@Cpf, @indice, 1)) * (11 - @indice);
            SET @indice = @indice + 1;
        END;
        SET @d1 = 11 - (@soma % 11);
        IF @d1 > 9 SET @d1 = 0;

        -- Cálculo do 2º dígito
        SET @soma = 0;
        SET @indice = 1;
        WHILE (@indice <= 10)
        BEGIN
            SET @soma = @soma + CONVERT(INT, SUBSTRING(@Cpf, @indice, 1)) * (12 - @indice);
            SET @indice = @indice + 1;
        END;
        SET @d2 = 11 - (@soma % 11);
        IF @d2 > 9 SET @d2 = 0;

        -- Validação dos dígitos
        IF (@d1 = CONVERT(INT, SUBSTRING(@Cpf, LEN(@Cpf) - 1, 1)) AND @d2 = CONVERT(INT, SUBSTRING(@Cpf, LEN(@Cpf), 1)))
            SET @resultado = 'CPF Válido';
    END

    RETURN @resultado;
END;

-- Testando a Function --
-- Cliente 1 (Armando José)
SELECT 'Estado do CPF' = dbo.fcValidarCPF (12345678900)

-- Cliente 2 (Sheila Carvalho)
SELECT 'Estado do CPF' = dbo.fcValidarCPF (45678909823)
