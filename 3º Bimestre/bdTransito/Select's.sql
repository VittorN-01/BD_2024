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
SELECT SUM (pontuacaoAcumulada) AS 'Somat�ria das Pontua��es' FROM tbMotorista

--f)
SELECT AVG (pontuacaoAcumulada) AS 'M�dia das Pontua��es' FROM tbMotorista

--g)
SELECT COUNT(idVeiculo) AS 'Qnt. de ve�culos do Motorista 1' FROM tbVeiculo
	WHERE idMotorista = 1

--h)
SELECT COUNT(*) AS 'Qnt. Ve�culos com a placa que come�a com A' FROM tbVeiculo
	WHERE placa LIKE 'A%'

--i)
SELECT COUNT(*) AS 'Qnt. Ve�culos fabricados antes de 2010' FROM tbVeiculo
	WHERE anoVeiculo < 2010

--j)
SELECT AVG (anoVeiculo) AS 'M�dia dos Anos de fabrica��o' FROM tbVeiculo

--k)
SELECT COUNT (*) AS 'Qnt. modelo Sedan' FROM tbVeiculo
	WHERE modeloVeiculo LIKE 'Sedan%'

--l)
SELECT SUM (pontosMulta) AS 'Somat�ria das multas do ve�culo 2' FROM tbMultas
	WHERE idVeiculo = 2

--m)
SELECT AVG (pontosMulta) AS 'M�dia de multas aplicadas' FROM tbMultas

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
SELECT COUNT(*) AS 'Qnt. Ve�culos por Ano', anoVeiculo AS 'Ano de Fabrica��o' FROM tbVeiculo
	GROUP BY anoVeiculo 

--u)
SELECT COUNT (*) AS 'Qnt. Motoristas por Pontua��o Acumulada', pontuacaoAcumulada FROM tbMotorista
	GROUP BY pontuacaoAcumulada

--v)
SELECT COUNT (*) AS 'Qnt. Motoristas com mais de 20 pontos' FROM tbMotorista
	WHERE pontuacaoAcumulada >=20

--w)
SELECT AVG (pontuacaoAcumulada) AS 'M�dia de pontua��o dos motoristas de 2000' FROM tbMotorista
	WHERE YEAR (dataNascimentoMotorista) = 2000

--x)
SELECT AVG (pontosMulta) AS 'M�dia dos pontos aplicados em Julho de 2017' FROM tbMultas
	WHERE MONTH (dataMulta) = 07
		AND YEAR (dataMulta) = 2017

--y)
SELECT COUNT(*) AS 'Qnt. Ve�culos que n�o podem circular na Segunda-feira' FROM tbVeiculo
	WHERE placa LIKE '%1' 
		OR placa LIKE '%2';

