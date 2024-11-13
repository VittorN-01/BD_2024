USE bdEstoque

-- Criar uma função que receba o código do cliente e retorne o total de vendas que o cliente já realizou
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

