USE bdRevisao
Go

CREATE TABLE Aluno 
( 
 idAluno INT PRIMARY KEY,  
 nome VARCHAR(100),  
 dataNascimento DATE,  
 CPF CHAR(11),  
 telefone VARCHAR(13),  
 curso VARCHAR(100),  
); 

CREATE TABLE Professor 
( 
 idProfessor INT PRIMARY KEY,  
 nome VARCHAR(100),  
 dataNascimento DATE,  
 CPF CHAR(11),  
 telefone CHAR(13),  
); 

CREATE TABLE Disciplina 
( 
 idDisciplina INT PRIMARY KEY,  
 idProfessor INT FOREIGN KEY(idProfessor) REFERENCES Professor (idProfessor),  
); 

CREATE TABLE Atribuição 
( 
 idAtribuicao INT PRIMARY KEY,  
 idProfessor INT FOREIGN KEY(idProfessor) REFERENCES Professor (idProfessor),  
 dataAtribuicao INT,  
); 

CREATE TABLE Curso 
( 
 idCurso INT PRIMARY KEY,  
 nomeCurso VARCHAR(100),  
 dadosAluno VARCHAR(100),  
 dadosProfessor INT,  
); 

CREATE TABLE Campus 
( 
 idCampus INT PRIMARY KEY,  
 instituicao VARCHAR(100),  
 endereco VARCHAR(100),  
);

CREATE TABLE Turma ( 
 idTurma INT PRIMARY KEY,  
 idAtribuicao INT FOREIGN KEY(idAtribuicao) REFERENCES Atribuição (idAtribuicao),  
 idCurso INT FOREIGN KEY(idCurso) REFERENCES Curso (idCurso),   
 idDisciplina INT FOREIGN KEY(idDisciplina) REFERENCES Disciplina (idDisciplina),  
 idCampus INT FOREIGN KEY(idCampus) REFERENCES Campus (idCampus),  
);

CREATE TABLE Matricula 
( 
 idMatricula INT PRIMARY KEY,  
 idTurma INT FOREIGN KEY(idTurma) REFERENCES Turma (idTurma),
 dataMatricula DATE,  
 dadosAluno VARCHAR(100),  
); 
