USE bdProdutos

--a) Criar uma Stored Procedure para inserir as categorias de produto conforme abaixo:
CREATE PROCEDURE spInserir_CategoriaProduto
@cod INT 
,@nome VARCHAR (100)
AS
	IF EXISTS (SELECT nomeCategoriaProduto FROM tbCategoriaProduto WHERE nomeCategoriaProduto LIKE @nome)
	BEGIN
		PRINT 'ERRO: Categoria já cadastrada'
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

--verificação
SELECT * FROM tbCategoriaProduto



--b) Criar uma Stored Procedure para inserir os produtos abaixo, sendo que, a procedure deverá antes de inserir verificar se o nome do produto já existe, evitando assim que um produto seja duplicado:
CREATE PROCEDURE spInserir_Produto
@cod INT
,@nome VARCHAR (100)
,@preco MONEY
,@codCategoria INT
AS
	IF EXISTS (SELECT nomeProduto FROM tbProduto WHERE nomeProduto LIKE @nome)
	BEGIN
		PRINT 'ERRO: Produto já cadastrado'
	END
	ELSE
	BEGIN
		INSERT INTO tbProduto (codProduto,nomeProduto,precoKiloProduto,codCategoriaProduto) VALUES	
								(@cod,@nome,@preco,@codCategoria)
		PRINT 'Produto cadastrado'
	END


EXEC spInserir_Produto 1 , 'Bolo Floresta Negra', '42', 1 
EXEC spInserir_Produto 2 , 'Bolo Prestígio', '43', 1
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

--verificação
SELECT * FROM tbProduto





--c) Criar uma stored procedure para cadastrar os clientes abaixo relacionados, sendo que deverão ser feitas duas validações:
	--Verificar pelo CPF se o cliente já existe. Caso já exista emitir a mensagem: “Cliente cpf XXXXX já cadastrado” (Acrescentar a coluna CPF)
	--Verificar se o cliente é morador de Itaquera ou Guaianases, pois a confeitaria não realiza entregas para clientes que residam fora desses bairros. Caso o cliente não seja morador desses bairros enviar a mensagem “Não foi possível cadastrar o cliente XXXX pois o bairro XXXX não é atendido pela confeitaria”
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
		PRINT ('Cliente com CPF: '+ @cpf +' já foi cadastrado')
	END
	
	IF @bairro NOT IN ('Guaianases','Itaquera')
	BEGIN
		PRINT 'Não foi possível cadastrar o cliente ' + @nome +' pois o bairro '+ @bairro +' não é atendido pela confeitaria'		
	END
	ELSE
	BEGIN
		INSERT INTO tbCliente (codCliente,nomeCliente,dataNascimentoCliente,ruaCliente,numCasaCliente,cepCliente,bairroCliente,cidadeCliente,estadoCliente,cpfCliente,sexoCliente)VALUES
								(@cod,@nome,@dataNasc,@rua,@numCasa,@cep,@bairro,@cidade,@estado,@cpf,@sexo)
		PRINT 'Cadastro Concluido'
	END

EXEC spClientes 1,'Samira Fatah','1990/05/05','Rua Aguapeí','1000','08.090-00','Guaianases','SP','SP','123456789','F'
EXEC spClientes 2,'Celia Nogueira','1992/06/06','Rua Andes','234','08.456-090','Guaianases','SP','SP','001122334','F'
EXEC spClientes 3,'Paulo Cesar Siqueira','1984/04/04','Rua Castelo do Piauí','232','09.109-000','Itaquera','SP','SP','987654321','M'
EXEC spClientes 4,'Rodrigo Favaroni','1991/04/09','Rua Sansão Castelo Branco','10','08.431-090','Guaianases','SP','SP','998877665','M'
EXEC spClientes 5,'Frávia Regina Brito','1992/04/22','Rua Mariano Moro','300','08.200-123','Itaquera','SP','SP','135792468','F'

SELECT * FROM tbCliente


--d) Criar via stored procedure as encomendas abaixo relacionadas, fazendo as verificações abaixo
	--No momento da encomenda o cliente irá fornecer o seu cpf. Caso ele não tenha sido cadastrado enviar a mensagem “não foi possível efetivar a encomenda pois o cliente xxxx não está cadastrado”
	--Verificar se a data de entrega não é menor do que a data da encomenda. Caso seja enviar a mensagem “não é possível entregar uma encomenda antes da encomenda ser realizada”
	--Caso tudo esteja correto, efetuar a encomenda e emitir a mensagem: “Encomenda XXX para o cliente YYY efetuada com sucesso” sendo que no lugar de XXX deverá aparecer o número da encomenda e no YYY deverá aparecer o nome do cliente
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
        PRINT 'Não foi possível efetivar a encomenda pois o cliente com CPF: ' + @cpf + ' não está cadastrado';
        RETURN
    END

    IF @dataEntrega <= @dataEncomenda
    BEGIN
        PRINT 'Não é possível entregar uma encomenda antes da encomenda ser realizada'
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
		PRINT 'ERRO: Encomenda já registrada'
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


--f) Após todos os cadastros, criar Stored procedures para alterar o que se pede
	--O preço dos produtos da categoria “Bolo festa” sofreram um aumento de 10%
	--O preço dos produtos categoria “Bolo simples” estão em promoção e terão um desconto de 20%;
	--O preço dos produtos categoria “Torta” aumentaram 25%
	--O preço dos produtos categoria “Salgado”, com exceção da esfiha de carne, sofreram um aumento de 20%
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
        PRINT 'Categoria não encontrada.'
        RETURN
    END

    IF @Alteracao LIKE 'aumento'
    BEGIN
        UPDATE tbProduto
        SET precoKiloProduto = precoKiloProduto + (precoKiloProduto * @Percentual / 100)
        WHERE codCategoriaProduto = @codCategoriaProduto 
		AND nomeProduto != 'Esfirra carne'

        PRINT 'Preços dos produtos da categoria ' + @CategoriaProduto + ' foram aumentados em ' + CAST(@percentual AS NVARCHAR) + '%';
    END
    ELSE IF @Alteracao LIKE 'desconto'
    BEGIN
        UPDATE tbProduto
        SET precoKiloProduto = precoKiloProduto - (precoKiloProduto * @Percentual / 100)
        WHERE codCategoriaProduto = @codCategoriaProduto

        PRINT 'Preços dos produtos da categoria ' + @CategoriaProduto + ' foram reduzidos em ' + CAST(@percentual AS NVARCHAR) + '%';
    END
END

EXEC spAlterar_Precos '10', 'Bolo Festa', 'aumento'
EXEC spAlterar_Precos '20', 'Bolo Simples', 'desconto'
EXEC spAlterar_Precos '25', 'Torta', 'aumento'
EXEC spAlterar_Precos '20', 'Salgado', 'aumento'
-- Verificação
SELECT * FROM tbProduto



--g) Criar uma procedure para excluir clientes pelo CPF sendo que:
	--Caso o cliente possua encomendas emitir a mensagem “Impossivel remover esse cliente pois o cliente XXXXX possui encomendas; onde XXXXX é o nome do cliente.
	--Caso o cliente não possua encomendas realizar a remoção e emitir a mensagem “Cliente XXXX removido com sucesso”, onde XXXX é o nome do cliente;
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
        PRINT 'O cliente não foi encontrado'
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



--h) Criar uma procedure que permita excluir qualquer item de uma encomenda cuja data de entrega seja maior que a data atual. Para tal o cliente deverá fornecer o código da encomenda e o código do produto que será excluído da encomenda. A procedure deverá remover o item e atualizar o valor total da encomenda, do qual deverá ser subtraído o valor do item a ser removido. A procedure poderá remover apenas um item da encomenda de cada vez.
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
            PRINT 'O item especificado não existe nesta encomenda.'
        END
    END
    ELSE
    BEGIN
        PRINT 'A encomenda não pode ser modificada porque a data de entrega é igual ou anterior à data atual.'
    END
END

EXEC spExcluir_Encomenda 1,1
EXEC spExcluir_Encomenda 9,1


