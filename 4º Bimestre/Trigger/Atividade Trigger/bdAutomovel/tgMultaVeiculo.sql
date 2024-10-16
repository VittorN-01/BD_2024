USE bdAutomovel;

CREATE TRIGGER tgMultaVeiculo 
ON tbMultas
AFTER INSERT
AS
BEGIN
    DECLARE @pontos INT, @idVeiculo INT, @idMotorista INT

	SELECT @pontos = pontosMulta, @idVeiculo = idVeiculo 
	FROM INSERTED;

    
	SELECT @idMotorista = idMotorista 
    FROM tbVeiculo 
		WHERE idVeiculo = @idVeiculo

    
	UPDATE tbMotorista 
		SET pontuacaoAcumulada = pontuacaoAcumulada + @pontos
			WHERE idMotorista = @idMotorista


    IF (SELECT pontuacaoAcumulada FROM tbMotorista WHERE idMotorista = @idMotorista) >= 20
        PRINT 'Sua habilitação pode ser Suspensa.'
    ELSE
        PRINT 'Registrado'
END;
