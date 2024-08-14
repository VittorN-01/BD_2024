USE bdTransito
-------------------------
--- Select's ---
--a) 
SELECT COUNT(idMotorista) AS 'Qnt. Motoristas' FROM tbMotorista

--b)
SELECT COUNT(nomeMotorista) AS 'Qnt. sobrenome Silva' FROM tbMotorista
	WHERE nomeMotorista LIKE '%Silva%'

--c)
SELECT COUNT(*) AS 'Motoristas de 2000' FROM tbMotorista
	WHERE YEAR(dataNascimentoMotorista) = 2000

--d)
SELECT COUNT (*) AS 'Motoristas com 10 ou mais pontos acumulados' FROM tbMotorista
	WHERE pontuacaoAcumulada >= 10

--e)
SELECT SUM (pontuacaoAcumulada) AS 'Somatória das Pontuações' FROM tbMotorista

--f)
SELECT AVG (pontuacaoAcumulada) AS 'Média das Pontuações' FROM tbMotorista

--g)
SELECT COUNT(idVeiculo) AS 'Qnt. de veículos do Motorista 1' FROM tbVeiculo
	WHERE idMotorista = 1

--h)
SELECT COUNT(*) AS 'Qnt. Veículos com a placa que começa com A' FROM tbVeiculo
	WHERE placa LIKE 'A%'

--i)
SELECT COUNT(*) AS 'Qnt. Veículos fabricados antes de 2010' FROM tbVeiculo
	WHERE anoVeiculo < 2010

--j)
SELECT AVG (anoVeiculo) AS 'Média dos Anos de fabricação' FROM tbVeiculo

--k)
SELECT COUNT (*) AS 'Qnt. modelo Sedan' FROM tbVeiculo
	WHERE modeloVeiculo LIKE 'Sedan%'

--l)
SELECT SUM (pontosMulta) AS 'Somatória das multas do veículo 2' FROM tbMultas
	WHERE idVeiculo = 2

--m)
SELECT AVG (pontosMulta) AS 'Média de multas aplicadas' FROM tbMultas

--n)
SELECT COUNT (*) AS 'Qnt. Multas aplicadas em Abril de 2018' FROM tbMultas
	WHERE MONTH (dataMulta) = 04
		AND YEAR (dataMulta) = 2018

--o)
SELECT COUNT (*) AS 'Qnt. Placas com finais 1 ou 2' FROM tbVeiculo
	WHERE placa LIKE '%1'
		OR placa LIKE '%2'

--p)
SELECT COUNT (*) AS 'Qnt. Placas com finais 3 ou 4' FROM tbVeiculo
	WHERE placa LIKE '%3'
		OR placa LIKE '%4'

--q)
SELECT COUNT (*) AS 'Qnt. Placas com finais 5 ou 6' FROM tbVeiculo
	WHERE placa LIKE '%5'
		OR placa LIKE '%6'
	
--r)
SELECT COUNT (*) AS 'Qnt. Placas com finais 7 ou 8' FROM tbVeiculo
	WHERE placa LIKE '%7'
		OR placa LIKE '%8'
		
--s)
SELECT COUNT (*) AS 'Qnt. Placas com finais 9 ou 0' FROM tbVeiculo
	WHERE placa LIKE '%9'
		OR placa LIKE '%0'

--t)
SELECT COUNT(*) AS 'Qnt. Veículos por Ano', anoVeiculo AS 'Ano de Fabricação' FROM tbVeiculo
	GROUP BY anoVeiculo 

--u)
SELECT COUNT (*) AS 'Qnt. Motoristas por Pontuação Acumulada', pontuacaoAcumulada FROM tbMotorista
	GROUP BY pontuacaoAcumulada

--v)
SELECT COUNT (*) AS 'Qnt. Motoristas com mais de 20 pontos' FROM tbMotorista
	WHERE pontuacaoAcumulada >=20

--w)
SELECT AVG (pontuacaoAcumulada) AS 'Média de pontuação dos motoristas de 2000' FROM tbMotorista
	WHERE YEAR (dataNascimentoMotorista) = 2000

--x)
SELECT AVG (pontosMulta) AS 'Média dos pontos aplicados em Julho de 2017' FROM tbMultas
	WHERE MONTH (dataMulta) = 07
		AND YEAR (dataMulta) = 2017

--y)
SELECT COUNT(*) AS 'Qnt. Veículos que não podem circular na Segunda-feira' FROM tbVeiculo
	WHERE placa LIKE '%1' 
		OR placa LIKE '%2';

