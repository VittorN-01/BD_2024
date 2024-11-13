USE bdEstoque

-- Criar uma fun��o que receba o c�digo do cliente e retorne o total de vendas que o cliente j� realizou
CREATE FUNCTION fcTotalVendasCliente(@Cod INT)
RETURNS INT
AS
BEGIN
	DECLARE @totalVendas INT

	SET @totalVendas = (SELECT COUNT(codVenda) FROM tbVenda WHERE codCliente = @Cod)

	RETURN @totalVendas
END;

-- Testando a Function --

SELECT codCliente, 'Total de Vendas' = dbo.fcTotalVendasCliente(codCliente) 
FROM tbVenda 
GROUP BY codCliente

