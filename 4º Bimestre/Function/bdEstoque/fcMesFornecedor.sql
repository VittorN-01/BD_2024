USE bdEstoque

-- Criar uma função que receba o código de um vendedor e o mês e informe o total de vendas do vendedor no mês informado 
-- Ao invés de VENDEDOR, utilizei FORNECEDOR
CREATE FUNCTION fcMesFornecedor(@codFornecedor INT, @mes INT)
RETURNS INT
AS
BEGIN
    DECLARE @totalVendas INT;

    SET @totalVendas = (SELECT COUNT(DISTINCT v.codVenda) FROM tbVenda v
							INNER JOIN tbItensVenda iv ON v.codVenda = iv.codVenda
								INNER JOIN tbProduto p ON iv.codProduto = p.codProduto
									WHERE p.codFornecedor = @codFornecedor AND MONTH(v.dataVenda) = @mes
						)
    RETURN @totalVendas;
END;

-- Testando a Function --

--Fevereiro
SELECT codFornecedor, 'Total de Vendas' = dbo.fcMesFornecedor(codFornecedor, 2) 
FROM tbFornecedor

--Março
SELECT codFornecedor, 'Total de Vendas' = dbo.fcMesFornecedor(codFornecedor, 3) 
FROM tbFornecedor

--Abril
SELECT codFornecedor, 'Total de Vendas' = dbo.fcMesFornecedor(codFornecedor, 4) 
FROM tbFornecedor