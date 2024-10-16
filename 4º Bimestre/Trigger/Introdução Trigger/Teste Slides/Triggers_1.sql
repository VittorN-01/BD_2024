CREATE TRIGGER tgVendas 
ON tbItensVenda 
FOR INSERT
AS
	DECLARE @cod INT, @qnt_Venda INT 
	SET @cod = (SELECT codProduto FROM INSERTED)
	SET @qnt_Venda = (SELECT quantidadeItensVenda FROM INSERTED) 
	UPDATE tbProduto
		SET quantidadeProduto = quantidadeProduto - @qnt_Venda
		WHERE codProduto = @cod
	PRINT ('Produto Vendido')