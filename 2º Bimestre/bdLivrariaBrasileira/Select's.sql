USE bdLivrariaBrasileira
GO
--------SELECT'S---------
--A) A quantidade de livros agrupado pelo nome do gênero:
SELECT COUNT (codLivro) AS 'Qnt. de Livros', nomeGenero AS 'Gêneros'FROM tbLivro
	RIGHT OUTER JOIN tbGenero ON tbLivro.codGenero = tbGenero.codGenero
		GROUP BY nomeGenero

		
--B) A soma das páginas agrupada pelo nome do autor:
SELECT SUM(numPaginas) AS 'Soma das `páginas', nomeAutor AS 'Autores' FROM tbLivro
	RIGHT OUTER JOIN tbAutor ON tbLivro.codAutor = tbAutor.codAutor
		GROUP BY nomeAutor


--C) A média de páginas agrupada pelo nome do autor em ordem alfabética (de A a Z):
SELECT AVG (numPaginas) AS 'Média de Páginas', nomeAutor AS 'Autores' FROM tbAutor
	LEFT OUTER JOIN tbLivro ON tbAutor.codAutor = tbLivro.codAutor
		GROUP BY nomeAutor


--D) A quantidade de livros agrupada pelo nome da editora em ordem alfabética inversa (de Z a A):
SELECT COUNT (codLivro) AS 'Qnt. livros', nomeEditora AS 'Editora' FROM tbLivro
	RIGHT OUTER JOIN tbEditora ON tbLivro.codEditora = tbEditora.codEditora
		GROUP BY nomeEditora 
		ORDER BY nomeEditora DESC	


--E) A soma de páginas dos livros agrupados pelo nome do autor que sejam de autores cujo nome comece com a letra “C”:
SELECT SUM(numPaginas) AS 'Soma das Páginas', nomeAutor AS 'Autores com a letra C' FROM tbLivro
	RIGHT OUTER JOIN tbAutor ON tbLivro.codAutor = tbAutor.codAutor
		WHERE nomeAutor LIKE 'C%'
		GROUP BY nomeAutor 


--F) A quantidade de livros agrupados pelo nome do autor, cujo nome do autor seja “Machado de Assis” ou “Cora Coralina” ou “Graciliano Ramos” ou “Clarice Lispector”:
SELECT COUNT(codLivro) AS 'Qnt. de livros', nomeAutor AS 'Autores' FROM tbLivro
	RIGHT OUTER JOIN tbAutor ON tbLivro.codAutor = tbAutor.codAutor
		WHERE nomeAutor = 'Machado de Assis' OR nomeAutor = 'Cora Coralina' OR nomeAutor ='Graciliano Ramos' OR nomeAutor = 'Clarice Lispector'
		GROUP BY nomeAutor
		

--G) A soma das páginas dos livros agrupadas pelo nome da editora cujo número de páginas esteja entre 200 e 500 (inclusive):
SELECT SUM(numPaginas) AS 'Soma das Páginas', nomeEditora AS 'Editora' FROM tbEditora
	LEFT OUTER JOIN tbLivro ON tbEditora.codEditora = tbLivro.codEditora
		WHERE numPaginas BETWEEN 200 AND 500
		GROUP BY nomeEditora


--H) O nome dos livros ao lado do nome das editoras e do nome dos autores:
SELECT nomeLivro, nomeEditora, nomeAutor FROM tbAutor
	LEFT OUTER JOIN tbLivro ON tbLivro.codAutor = tbAutor.codAutor
		LEFT OUTER JOIN tbEditora ON tbEditora.codEditora = tbLivro.codEditora


--I) O nome dos livros ao lado do nome do autor somente daqueles cujo nome da editora for “Cia das Letras”
SELECT nomeLivro, nomeAutor FROM tbEditora
	LEFT OUTER JOIN tbLivro ON tbEditora.codEditora = tbLivro.codEditora
		LEFT OUTER JOIN tbAutor ON tbLivro.codAutor = tbAutor.codAutor
			WHERE nomeEditora = 'Companhia das Letras'


--J) O nome dos livros ao lado dos nomes dos autores, somente dos livros que não forem do autor “Érico Veríssimo”:
SELECT nomeLivro, nomeAutor FROM tbLivro
	RIGHT OUTER JOIN tbAutor 
		ON tbLivro.codAutor = tbAutor.codAutor
			WHERE nomeAutor != 'Érico Veríssimo'
	


--K) Os nomes dos autores ao lado dos nomes dos livros, inclusive daqueles que não tem livros cadastrados:
SELECT nomeAutor, nomeLivro FROM tbLivro
	RIGHT OUTER JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor
	 

--L) Os nomes dos autores ao lado dos nomes dos livros, inclusive daqueles que não tem autores cadastrados:
SELECT nomeAutor, nomeLivro FROM tbAutor
	LEFT OUTER JOIN tbLivro ON tbAutor.codAutor = tbLivro.codAutor


--M) O nome dos autores ao lado dos nomes dos livros, indiferente do autor ter ou não livro publicado, e indiferente do livro pertencer a algum autor:
SELECT nomeAutor, nomeLivro FROM tbAutor
	FULL OUTER JOIN tbLivro ON tbAutor.codAutor = tbLivro.codAutor


--N) A editora Ática irá publicar todos os títulos dessa livraria. Criar um select que associe os nomes de todos os livros ao lado do nome da editora Ática:
SELECT nomeLivro, nomeEditora = 'Àtica' FROM tbLivro
	LEFT OUTER JOIN tbEditora ON tbLivro.codEditora = tbEditora.codEditora


--O) Somente os nomes dos autores que não tem livros cadastrados:
SELECT nomeAutor FROM tbAutor
	LEFT OUTER JOIN tbLivro ON tbAutor.codAutor = tbLivro.codAutor
		WHERE nomeLivro IS NULL


--P) Os nomes dos gêneros que não possuem nenhum livro cadastrado:
SELECT nomeGenero AS 'Gêneros sem livros' FROM tbGenero
	LEFT OUTER JOIN tbLivro ON tbLivro.codGenero = tbGenero.codGenero
		WHERE nomeLivro IS NULL

