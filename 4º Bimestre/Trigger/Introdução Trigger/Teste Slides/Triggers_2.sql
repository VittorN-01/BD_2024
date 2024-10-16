CREATE TRIGGER tgEntradaProduto 
ON tbEntradaProduto 
FOR INSERT
AS
	DECLARE @qntEntrada INT, @codProduto INT
	SET @qntEntrada = (SELECT quantidadeEntradaProduto FROM INSERTED)
	UPDATE tbProduto 
		SET quantidadeProduto = quantidadeProduto + @qntEntrada
			WHERE @codProduto = codProduto
	PRINT 'Produto inserido com sucesso'
