USE bdConta

CREATE TRIGGER tgSaqueConta
ON tbSaque
FOR INSERT
AS
BEGIN
	DECLARE @vSaque MONEY, @numConta INT, @saldoAtual MONEY;
  
	SELECT @vSaque = valorSaque, @numConta = numConta 
	FROM INSERTED 
  
	SELECT @saldoAtual = saldoConta
	FROM tbContaCorrente 
		WHERE numConta = @numConta
  
	IF @saldoAtual < @vSaque 
	BEGIN 
		PRINT 'Impossível Sacar'	
	END
	ELSE
	BEGIN
		UPDATE tbContaCorrente
			SET saldoConta -= @vSaque
				WHERE numConta = @numConta

		PRINT 'Saque realizado'
	END;
END;