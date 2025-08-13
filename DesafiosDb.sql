CREATE TABLE Aluno(
  IdAluno INT PRIMARY KEY IDENTITY(1,1),
  Nome NVARCHAR(100) NOT NULL,
  DataNascimento NVARCHAR(100) NOT NULL,
);

CREATE TABLE Notas(
 IdNota INT PRIMARY KEY IDENTITY(1,1),
 IdAluno INT NULL,
 Disciplina varchar(100),
 Nota NVARCHAR(100),

 CONSTRAINT FK_Notas_Aluno FOREIGN KEY(IdAluno)
 REFERENCES Aluno(IdAluno)
 
);



INSERT INTO Aluno(Nome,DataNascimento)
VALUES
('Rafael','06-10-2007'),
('Pedro','29-09-2008'),
('Emilly','12-06-2008');

INSERT INTO Notas(IdAluno,Disciplina,Nota)
VALUES
(1,'Artes',8),
(2,'Historia',6),
(3,'Matematica',8);

SELECT * FROM Aluno
SELECT * FROM Notas WHERE Nota>7;

