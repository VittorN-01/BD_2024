USE bdProdutos

--a) Criar uma Stored Procedure para inserir as categorias de produto conforme abaixo:
CREATE PROCEDURE spInserir_CategoriaProduto
@cod INT 
,@nome VARCHAR (100)
AS
	IF EXISTS (SELECT nomeCategoriaProduto FROM tbCategoriaProduto WHERE nomeCategoriaProduto LIKE @nome)
	BEGIN
		PRINT 'ERRO: Categoria j� cadastrada'
	END
	ELSE
	BEGIN
		INSERT INTO tbCategoriaproduto(codCategoriaProduto,nomeCategoriaProduto) VALUES
										(@cod, @nome)
		PRINT 'Categoria cadastrada'
	END
	
EXEC spInserir_CategoriaProduto 1, 'Bolo Festa'
EXEC spInserir_CategoriaProduto 2, 'Bolo Simples'
EXEC spInserir_CategoriaProduto 3, 'Torta'
EXEC spInserir_CategoriaProduto 4, 'Salgado'

--verifica��o
SELECT * FROM tbCategoriaProduto



--b) Criar uma Stored Procedure para inserir os produtos abaixo, sendo que, a procedure dever� antes de inserir verificar se o nome do produto j� existe, evitando assim que um produto seja duplicado:
CREATE PROCEDURE spInserir_Produto
@cod INT
,@nome VARCHAR (100)
,@preco MONEY
,@codCategoria INT
AS
	IF EXISTS (SELECT nomeProduto FROM tbProduto WHERE nomeProduto LIKE @nome)
	BEGIN
		PRINT 'ERRO: Produto j� cadastrado'
	END
	ELSE
	BEGIN
		INSERT INTO tbProduto (codProduto,nomeProduto,precoKiloProduto,codCategoriaProduto) VALUES	
								(@cod,@nome,@preco,@codCategoria)
		PRINT 'Produto cadastrado'
	END


EXEC spInserir_Produto 1 , 'Bolo Floresta Negra', '42', 1 
EXEC spInserir_Produto 2 , 'Bolo Prest�gio', '43', 1
EXEC spInserir_Produto 3 , 'Bolo Nutella', '44', 1
EXEC spInserir_Produto 4 , 'Bolo Formigueira', '17', 2
EXEC spInserir_Produto 5 , 'Bolo de cenoura', '19', 2
EXEC spInserir_Produto 6 , 'Torta de palmito', '45', 3
EXEC spInserir_Produto 7 , 'Torta de frango e catupiry', '47', 3
EXEC spInserir_Produto 8 , 'Torta de escarola', '44', 3
EXEC spInserir_Produto 9 , 'Coxinha frango', '25', 4
EXEC spInserir_Produto 10 , 'Esfirra carne', '27', 4
EXEC spInserir_Produto 11 , 'Folhado queijo', '31', 4
EXEC spInserir_Produto 12 , 'Risoles misto', '29', 4

--verifica��o
SELECT * FROM tbProduto





--c) Criar uma stored procedure para cadastrar os clientes abaixo relacionados, sendo que dever�o ser feitas duas valida��es:
	--Verificar pelo CPF se o cliente j� existe. Caso j� exista emitir a mensagem: �Cliente cpf XXXXX j� cadastrado� (Acrescentar a coluna CPF)
	--Verificar se o cliente � morador de Itaquera ou Guaianases, pois a confeitaria n�o realiza entregas para clientes que residam fora desses bairros. Caso o cliente n�o seja morador desses bairros enviar a mensagem �N�o foi poss�vel cadastrar o cliente XXXX pois o bairro XXXX n�o � atendido pela confeitaria�
CREATE PROCEDURE spClientes 
@cod INT 
,@nome VARCHAR (100) 
,@dataNasc DATE 
,@rua VARCHAR (250) 
,@numCasa INT 
,@cep VARCHAR (20)
,@bairro VARCHAR (250) 
,@cidade VARCHAR (250) 
,@estado VARCHAR (250) 
,@cpf VARCHAR (15) 
,@sexo VARCHAR (2) 
AS 
	IF EXISTS (SELECT cpfCliente FROM tbCliente WHERE cpfCliente LIKE @cpf)
	BEGIN 
		PRINT ('Cliente com CPF: '+ @cpf +' j� foi cadastrado')
	END
	
	IF @bairro NOT IN ('Guaianases','Itaquera')
	BEGIN
		PRINT 'N�o foi poss�vel cadastrar o cliente ' + @nome +' pois o bairro '+ @bairro +' n�o � atendido pela confeitaria'		
	END
	ELSE
	BEGIN
		INSERT INTO tbCliente (codCliente,nomeCliente,dataNascimentoCliente,ruaCliente,numCasaCliente,cepCliente,bairroCliente,cidadeCliente,estadoCliente,cpfCliente,sexoCliente)VALUES
								(@cod,@nome,@dataNasc,@rua,@numCasa,@cep,@bairro,@cidade,@estado,@cpf,@sexo)
		PRINT 'Cadastro Concluido'
	END

EXEC spClientes 1,'Samira Fatah','1990/05/05','Rua Aguape�','1000','08.090-00','Guaianases','SP','SP','123456789','F'
EXEC spClientes 2,'Celia Nogueira','1992/06/06','Rua Andes','234','08.456-090','Guaianases','SP','SP','001122334','F'
EXEC spClientes 3,'Paulo Cesar Siqueira','1984/04/04','Rua Castelo do Piau�','232','09.109-000','Itaquera','SP','SP','987654321','M'
EXEC spClientes 4,'Rodrigo Favaroni','1991/04/09','Rua Sans�o Castelo Branco','10','08.431-090','Guaianases','SP','SP','998877665','M'
EXEC spClientes 5,'Fr�via Regina Brito','1992/04/22','Rua Mariano Moro','300','08.200-123','Itaquera','SP','SP','135792468','F'

SELECT * FROM tbCliente


--d) Criar via stored procedure as encomendas abaixo relacionadas, fazendo as verifica��es abaixo
	--No momento da encomenda o cliente ir� fornecer o seu cpf. Caso ele n�o tenha sido cadastrado enviar a mensagem �n�o foi poss�vel efetivar a encomenda pois o cliente xxxx n�o est� cadastrado�
	--Verificar se a data de entrega n�o � menor do que a data da encomenda. Caso seja enviar a mensagem �n�o � poss�vel entregar uma encomenda antes da encomenda ser realizada�
	--Caso tudo esteja correto, efetuar a encomenda e emitir a mensagem: �Encomenda XXX para o cliente YYY efetuada com sucesso� sendo que no lugar de XXX dever� aparecer o n�mero da encomenda e no YYY dever� aparecer o nome do cliente
CREATE PROCEDURE spEncomendas
@cpf VARCHAR(15)
,@dataEncomenda DATE
,@valorEncomenda MONEY
,@dataEntrega DATE
AS
BEGIN
    DECLARE @cod INT
    DECLARE @nome VARCHAR(100)
	
    SELECT @cod = codCliente, @nome = nomeCliente FROM tbCliente
	   WHERE cpfCliente = @cpf

    IF @cod IS NULL
    BEGIN
        PRINT 'N�o foi poss�vel efetivar a encomenda pois o cliente com CPF: ' + @cpf + ' n�o est� cadastrado';
        RETURN
    END

    IF @dataEntrega <= @dataEncomenda
    BEGIN
        PRINT 'N�o � poss�vel entregar uma encomenda antes da encomenda ser realizada'
        RETURN
    END

    INSERT INTO tbEncomenda (dataEncomenda, codCliente, valorTotalEncomenda, dataEntregaEncomenda)VALUES 
							(@dataEncomenda, @cod, @valorEncomenda, @dataEntrega)

    DECLARE @codEncomenda INT
    SELECT @codEncomenda = SCOPE_IDENTITY()

    PRINT 'Encomenda ' + CAST(@codEncomenda AS VARCHAR) + ' para o cliente ' + @nome + ' efetuada com sucesso';
END

-- Certos
EXEC spEncomendas '123456789','2007/06/01', 30,'2007/06/21'
EXEC spEncomendas '987654321','2000/10/10', 40,'2000/10/20'
EXEC spEncomendas '123456789','2007/06/01', 50,'2007/06/21'
EXEC spEncomendas '987654321','2000/10/10', 80,'2000/10/20'
EXEC spEncomendas '123456789','2007/06/01', 100,'2007/06/21'
EXEC spEncomendas '123456789','2024/09/09', 60, '2025/09/09'
-- Errados
EXEC spEncomendas '000000000','2020/02/02', 10,'2020/02/10'
EXEC spEncomendas '001122334','2021/09/10', 20,'2020/02/03'

SELECT * FROM tbEncomenda

--e) Ao adicionar a encomenda, criar uma Stored procedure, para que sejam inseridos os itens da encomenda conforme tabela a seguir.
CREATE PROCEDURE spTipo_Encomenda
@codEncomenda INT 
,@codProduto INT 
,@qntKilos FLOAT 
,@subTotal MONEY 
AS
	DECLARE @cod INT
	IF EXISTS (SELECT codItensEncomenda FROM tbItensEncomenda WHERE codItensEncomenda LIKE @cod)
	BEGIN
		PRINT 'ERRO: Encomenda j� registrada'
	END
	ELSE
	BEGIN
		INSERT INTO	tbItensEncomenda(codEncomenda,codProduto, quantidadeKilos,subTotal)VALUES
									(@codEncomenda,@codProduto,@qntKilos,@subTotal)
		PRINT 'Encomenda registrada'
	END

EXEC spTipo_Encomenda  1, 1, 2.5, 105
EXEC spTipo_Encomenda  1, 10, 2.6, 70 
EXEC spTipo_Encomenda  1, 9, 6, 150
EXEC spTipo_Encomenda  1, 12, 4.3, 125
EXEC spTipo_Encomenda  2, 9, 8, 200
EXEC spTipo_Encomenda  3, 11, 3.2, 100
EXEC spTipo_Encomenda  3, 9, 2, 50
EXEC spTipo_Encomenda  4, 2, 3.5, 150
EXEC spTipo_Encomenda  4, 3, 2.2, 100
EXEC spTipo_Encomenda  5, 6, 3.4, 150


--f) Ap�s todos os cadastros, criar Stored procedures para alterar o que se pede
	--O pre�o dos produtos da categoria �Bolo festa� sofreram um aumento de 10%
	--O pre�o dos produtos categoria �Bolo simples� est�o em promo��o e ter�o um desconto de 20%;
	--O pre�o dos produtos categoria �Torta� aumentaram 25%
	--O pre�o dos produtos categoria �Salgado�, com exce��o da esfiha de carne, sofreram um aumento de 20%
CREATE PROCEDURE spAlterar_Precos
@Percentual DECIMAL(5,2)
,@CategoriaProduto VARCHAR(100)
,@Alteracao NVARCHAR(10)
AS
BEGIN
    DECLARE @codCategoriaProduto INT
    SELECT @codCategoriaProduto = codCategoriaProduto FROM tbCategoriaProduto
    WHERE nomeCategoriaProduto = @CategoriaProduto

    IF @codCategoriaProduto IS NULL
    BEGIN
        PRINT 'Categoria n�o encontrada.'
        RETURN
    END

    IF @Alteracao LIKE 'aumento'
    BEGIN
        UPDATE tbProduto
        SET precoKiloProduto = precoKiloProduto + (precoKiloProduto * @Percentual / 100)
        WHERE codCategoriaProduto = @codCategoriaProduto 
		AND nomeProduto != 'Esfirra carne'

        PRINT 'Pre�os dos produtos da categoria ' + @CategoriaProduto + ' foram aumentados em ' + CAST(@percentual AS NVARCHAR) + '%';
    END
    ELSE IF @Alteracao LIKE 'desconto'
    BEGIN
        UPDATE tbProduto
        SET precoKiloProduto = precoKiloProduto - (precoKiloProduto * @Percentual / 100)
        WHERE codCategoriaProduto = @codCategoriaProduto

        PRINT 'Pre�os dos produtos da categoria ' + @CategoriaProduto + ' foram reduzidos em ' + CAST(@percentual AS NVARCHAR) + '%';
    END
END

EXEC spAlterar_Precos '10', 'Bolo Festa', 'aumento'
EXEC spAlterar_Precos '20', 'Bolo Simples', 'desconto'
EXEC spAlterar_Precos '25', 'Torta', 'aumento'
EXEC spAlterar_Precos '20', 'Salgado', 'aumento'
-- Verifica��o
SELECT * FROM tbProduto



--g) Criar uma procedure para excluir clientes pelo CPF sendo que:
	--Caso o cliente possua encomendas emitir a mensagem �Impossivel remover esse cliente pois o cliente XXXXX possui encomendas; onde XXXXX � o nome do cliente.
	--Caso o cliente n�o possua encomendas realizar a remo��o e emitir a mensagem �Cliente XXXX removido com sucesso�, onde XXXX � o nome do cliente;
CREATE PROCEDURE spExcluir_Clientes
@cpf VARCHAR (15) 
AS
BEGIN
	DECLARE @cod INT
    DECLARE @nome VARCHAR(100)
	
    SELECT @cod = codCliente, @nome = nomeCliente FROM tbCliente
	   WHERE cpfCliente = @cpf
	   
	IF @cod IS NULL
    BEGIN
        PRINT 'O cliente n�o foi encontrado'
        RETURN
    END
	
	IF EXISTS (SELECT codCliente FROM tbEncomenda WHERE codCliente = @cod)
	BEGIN
		PRINT 'Impossivel remover esse cliente pois o cliente '+@nome+' possui encomendas'
	END
	ELSE 
	BEGIN
		DELETE FROM tbCliente
			WHERE cpfCliente = @cpf 
        PRINT 'Cliente '+@nome+' removido com sucesso'
        RETURN
    END
END

EXEC spExcluir_Clientes '123456789'
EXEC spExcluir_Clientes '998877665'

SELECT * FROM tbCliente



--h) Criar uma procedure que permita excluir qualquer item de uma encomenda cuja data de entrega seja maior que a data atual. Para tal o cliente dever� fornecer o c�digo da encomenda e o c�digo do produto que ser� exclu�do da encomenda. A procedure dever� remover o item e atualizar o valor total da encomenda, do qual dever� ser subtra�do o valor do item a ser removido. A procedure poder� remover apenas um item da encomenda de cada vez.
CREATE PROCEDURE spExcluir_Encomenda
@codEncomenda INT
,@codProduto INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM tbEncomenda WHERE codEncomenda = @codEncomenda AND dataEntregaEncomenda > GETDATE())
    BEGIN
        DECLARE @valorItem MONEY

        SELECT subTotal FROM tbItensEncomenda
			WHERE codEncomenda = @codEncomenda AND codProduto = @codProduto

        IF @valorItem IS NOT NULL
        BEGIN

            DELETE FROM tbItensEncomenda
            WHERE codEncomenda = @codEncomenda AND codProduto = @codProduto

            UPDATE tbEncomenda
            SET valorTotalEncomenda = valorTotalEncomenda - @valorItem
	            WHERE codEncomenda = @codEncomenda

            PRINT 'Item removido e o valor total foi atualizado com sucesso.'
        END
        ELSE
        BEGIN
            PRINT 'O item especificado n�o existe nesta encomenda.'
        END
    END
    ELSE
    BEGIN
        PRINT 'A encomenda n�o pode ser modificada porque a data de entrega � igual ou anterior � data atual.'
    END
END

EXEC spExcluir_Encomenda 1,1
EXEC spExcluir_Encomenda 9,1


