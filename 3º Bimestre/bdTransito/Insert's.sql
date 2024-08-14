USE bdTransito
--------------------------
--- Insert's ---
INSERT INTO tbMotorista (nomeMotorista, dataNascimentoMotorista, cpfMotorista, CNHMotorista, pontuacaoAcumulada) VALUES 
	('Jo�o Silva', '20/05/1980', '12345678900', '12345678901', 10)
	,('Maria Oliveira', '15/03/1975', '98765432100', '23456789012', 5)
	,('Carlos Souza', '25/11/1990', '11122233344', '34567890123', 8)
	

INSERT INTO tbVeiculo (modeloVeiculo, placa, renavam, anoVeiculo, idMotorista) VALUES 
	('Fiat Uno', 'ABC1234', 123456789, 2010, 1)
	,('Ford Ka', 'DEF5678', 987654321, 2012, 1)
	,('VW Gol', 'GHI9012', 135791357, 2015, 1)
	,('Chevrolet Onix', 'JKL3456', 246802468, 2018, 2)
	,('Renault Sandero', 'MNO7890', 357913579, 2016, 2)
	,('Toyota Corolla', 'PQR2345', 468024680, 2020, 2)
	,('Honda Civic', 'STU6789', 579135791, 2019, 3)
	,('Hyundai HB20', 'VWX1234', 680246802, 2017, 3)
	,('Jeep Compass', 'YZA5678', 791357913, 2021, 3)


INSERT INTO tbMultas (dataMulta, horaMulta, pontosMulta, idVeiculo) VALUES 
	('10/01/2023', '14:30:00', 3, 1)
	,('15/02/2023', '10:15:00', 2, 1)
	,('22/03/2023', '16:45:00', 5, 2)
	,('10/04/2023', '09:00:00', 4, 2)
	,('05/05/2023', '12:30:00', 6, 3)
	,('18/06/2023', '11:00:00', 1, 3)
	,('20/07/2023', '08:45:00', 3, 4)
	,('15/08/2023', '13:15:00', 4, 4)
	,('25/09/2023', '15:30:00', 5, 5)
	,('12/10/2023', '10:00:00', 2, 5)
	,('03/11/2023', '17:00:00', 6, 6)
	,('01/12/2023', '14:15:00', 3, 6)
	,('15/01/2023', '09:30:00', 2, 7)
	,('20/02/2023', '11:45:00', 1, 7)
	,('10/03/2023', '13:30:00', 4, 8)
	,('05/04/2023', '10:30:00', 3, 8)
	,('25/05/2023', '14:45:00', 5, 9)
	,('10/06/2023', '16:00:00', 2, 9)
