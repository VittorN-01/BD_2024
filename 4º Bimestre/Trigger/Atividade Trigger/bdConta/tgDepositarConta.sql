USE bdConta

CREATE TRIGGER tgDepositarConta
ON tbDeposito
AFTER INSERT
AS
BEGIN
	DECLARE @vDeposito MONEY, @numConta INT;

	SELECT @numConta = numConta, @vDeposito = valorDeposito
	FROM INSERTED
	
	UPDATE tbContaCorrente
		SET saldoConta += @vDeposito
			WHERE numConta = @numConta;

	PRINT 'Depósito realizado'
END