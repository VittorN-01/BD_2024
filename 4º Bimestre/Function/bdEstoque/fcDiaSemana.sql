USE bdEstoque

-- Criar uma fun��o que retorne o dia de semana da venda (no formato segunda, ter�a, etc) ao lado do c�digo da venda, valor total da venda e sua data
CREATE FUNCTION fcDiaSemana(@Data DATE)
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
		SET @dSemana = 'Ter�a-Feira';
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
		SET @dSemana = 'S�bado';
	END; 

	RETURN @dSemana;
END;

-- Testando a Function --

SELECT codVenda, valorTotalVenda, codCliente, dataVenda, 'Dia da Semana' = dbo.fcDiaSemana(dataVenda) 
FROM tbVenda
