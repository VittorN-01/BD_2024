CREATE TRIGGER tgInserirSaidaProduto
ON tbItensVenda
AFTER INSERT
AS
BEGIN
    DECLARE @novoCodSaida INT;
    SELECT @novoCodSaida = ISNULL(MAX(codSaidaProduto), 0) + 1 FROM tbSaidaProduto;

    INSERT INTO tbSaidaProduto (codSaidaProduto, dataSaidaproduto, codProduto, quantidadeSaidaProduto)
    SELECT @novoCodSaida, GETDATE(), I.codProduto, I.quantidadeItensVenda
		FROM INSERTED I;
END;
