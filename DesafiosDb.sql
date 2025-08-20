CREATE TABLE Aluno(
  IdAluno INT PRIMARY KEY IDENTITY(1,1),
  Nome NVARCHAR(100) NOT NULL,
  DataNascimento DATE NOT NULL
);

CREATE TABLE Notas(
  IdNota INT PRIMARY KEY IDENTITY(1,1),
  IdAluno INT NULL,
  Disciplina VARCHAR(100),
  Nota DECIMAL(4,2),
  CONSTRAINT FK_Notas_Aluno FOREIGN KEY(IdAluno) REFERENCES Aluno(IdAluno)
);

INSERT INTO Aluno(Nome,DataNascimento)
VALUES
('Rafael','2007-10-06'),
('Pedro','2008-09-29'),
('Emilly','2008-06-12');

INSERT INTO Notas(IdAluno,Disciplina,Nota)
VALUES
(1,'Artes',8),
(2,'Historia',6),
(3,'Matematica',8);


SELECT Aluno.Nome,Notas.Disciplina,Notas.Nota
FROM Aluno,Notas
WHERE Aluno.IdAluno = Notas.IdAluno;

SELECT Disciplina, AVG(Nota) AS Media
FROM Notas
GROUP BY Disciplina;

SELECT Aluno.Nome, AVG(Notas.Nota) AS Media
FROM Aluno,Notas
WHERE Aluno.IdAluno = Notas.IdAluno
GROUP BY Aluno.Nome
HAVING AVG(Notas.Nota) > 7;

SELECT Nome
FROM Aluno
WHERE IdAluno NOT IN(SELECT IdAluno FROM Notas);




----------------------------------------------------
CREATE TABLE Filmes(
 IdFilme INT PRIMARY KEY IDENTITY(1,1),
 Titulo VARCHAR(100),
 Genero VARCHAR(100),
 Ano INT NULL
);

CREATE TABLE Sessoes(
 IdSessao INT PRIMARY KEY IDENTITY(1,1),
 IdFilme INT NULL,
 Horarios NVARCHAR(100),
 Hora NVARCHAR(100),
 CONSTRAINT FK_Sessoes_Filmes FOREIGN KEY(IdFilme)
 REFERENCES Filmes(IdFilme)
);

INSERT INTO Filmes (Titulo, Genero, Ano)
VALUES
('Vingadores', 'Ação', 2018),
('Carros','Ação',2026),
('Barbie','Aventura',2025);

INSERT INTO Sessoes(IdFilme, Horarios, Hora)
VALUES
(1, '18-08-2025', '20:20'),
(2, '19-08-2025', '09:10'),
(3, '20-08-2025', '21:30');

SELECT *
FROM Filmes
WHERE Genero = 'Ação';

SELECT S.IdSessao, F.Titulo, S.Horarios, S.Hora
FROM Filmes F, Sessoes S
WHERE F.IdFilme = S.IdFilme
  AND F.Ano > 2020;

SELECT F.Titulo, COUNT(S.IdSessao) AS TotalSessoes
FROM Filmes F, Sessoes S
WHERE F.IdFilme = S.IdFilme
GROUP BY F.Titulo;

SELECT F.Titulo, S.Horarios
FROM Filmes F, Sessoes S
WHERE F.IdFilme = S.IdFilme;
---------------------------------------------------------


CREATE TABLE Pacientes(
    IdPaciente INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL,
    DataNascimento NVARCHAR(100) NOT NULL
);

CREATE TABLE Consultas(
    IdConsulta INT PRIMARY KEY IDENTITY(1,1),
    IdPaciente INT NULL,
    DataConsulta NVARCHAR(100) NOT NULL,
    Medico VARCHAR(100) NULL,
    CONSTRAINT FK_Consultas_Pacientes FOREIGN KEY(IdPaciente)
        REFERENCES Pacientes(IdPaciente)
);

INSERT INTO Pacientes(Nome, DataNascimento)
VALUES
('Emilly','12-06-2008'),
('Rafael','06-10-2007');

INSERT INTO Consultas(IdPaciente, DataConsulta, Medico)
VALUES
(1,'20-06-2020','Edson'),
(2,'20-06-2020','Marlize');

SELECT * FROM Pacientes;

SELECT Nome 
FROM Pacientes 
WHERE IdPaciente IN (
    SELECT IdPaciente 
    FROM Consultas 
    WHERE Medico = 'Edson'
);

SELECT DataConsulta, COUNT(*) AS TotalConsultas
FROM Consultas
GROUP BY DataConsulta;

SELECT Nome
FROM Pacientes
WHERE IdPaciente NOT IN (
    SELECT IdPaciente
    FROM Consultas
);

SELECT TOP 1 Nome, DataNascimento
FROM Pacientes
ORDER BY DataNascimento ASC;

------------------------------------------------------------------------------------------------------

CREATE TABLE Albuns(
IdAlbum INT PRIMARY KEY,
Nome VARCHAR(100) NULL,
Artista VARCHAR(100) NOT NULL,	
AnoLancamento INT NULL
);

CREATE TABLE Musicas(
IdMusica INT PRIMARY KEY IDENTITY(1,1),
IdAlbum INT NULL,
Titulo VARCHAR(100) NOT NULL,
DuracaoSegundos TIME NULL
);

INSERT INTO Albuns (IdAlbum,Nome,Artista,AnoLancamento)
VALUES
(1,'Case Study 01','Daniel Caesar',2019),
(2,'Channel Orange','Frank Ocean',2012);

INSERT INTO Musicas (IdAlbum, Titulo, DuracaoSegundos)
VALUES
(1, 'Entropy', '00:04:21'),
(1, 'Cyanide', '00:03:14'),
(1, 'Love Again (feat. Brandy)', '00:03:34'),
(1, 'Frontal Lobe Muzik (feat. Pharrell Williams)', '00:03:49'),
(1, 'Open Up', '00:04:26'),
(1, 'Restore the Feeling (feat. Sean Leon & Jacob Collier)', '00:03:34'),
(1, 'Superposition (feat. John Mayer)', '00:04:23'),
(1, 'Too Deep to Turn Back', '00:05:18'),
(1, 'Complexities', '00:03:50'),
(1, 'Are You Ok?', '00:06:32'),
(2, 'Start', '00:00:45'),
(2, 'Thinkin Bout You', '00:03:20'),
(2, 'Fertilizer', '00:00:39'),
(2, 'Sierra Leone', '00:02:28'),
(2, 'Sweet Life', '00:04:22'),
(2, 'Not Just Money', '00:00:59'),
(2, 'Super Rich Kids', '00:05:04'),
(2, 'Pilot Jones', '00:03:04'),
(2, 'Crack Rock', '00:03:44'),
(2, 'Pyramids', '00:09:52'),
(2, 'Lost', '00:03:54'),
(2, 'White', '00:01:16'),
(2, 'Monks', '00:03:20'),
(2, 'Bad Religion', '00:02:55'),
(2, 'Pink Matter', '00:04:28'),
(2, 'Forrest Gump', '00:03:14'),
(2, 'End', '00:02:14');

SELECT 'Case Study 01' AS Album, Musicas.Titulo, Musicas.DuracaoSegundos
FROM Musicas
WHERE Musicas.IdAlbum = 1;

SELECT 'Channel Orange' AS Album, Musicas.Titulo, Musicas.DuracaoSegundos
FROM Musicas
WHERE Musicas.IdAlbum = 2;

SELECT Albuns.Artista, COUNT(Musicas.IdMusica) AS TotalMusicas
FROM Musicas
JOIN Albuns ON Musicas.IdAlbum = Albuns.IdAlbum
GROUP BY Albuns.Artista;

SELECT TOP 1 Albuns.Nome AS Album, SUM(CONVERT(INT, DATEDIFF(SECOND, '00:00:00', Musicas.DuracaoSegundos))) AS DuracaoTotalSegundos
FROM Musicas
JOIN Albuns ON Musicas.IdAlbum = Albuns.IdAlbum
GROUP BY Albuns.Nome
ORDER BY DuracaoTotalSegundos DESC;

SELECT Albuns.Nome AS Album, Musicas.Titulo, Musicas.DuracaoSegundos
FROM Musicas
JOIN Albuns ON Musicas.IdAlbum = Albuns.IdAlbum
WHERE Musicas.DuracaoSegundos > '00:05:00';
---------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Motoristas(
IdMotorista INT PRIMARY KEY,
Nome VARCHAR(100) NOT NULL,
CNH VARCHAR(50) NOT NULL
);

CREATE TABLE Viagens(
IdViagem INT PRIMARY KEY IDENTITY(1,1),
IdMotorista INT NULL,
Origem VARCHAR(100) NOT NULL,
Destino VARCHAR(100) NOT NULL,
Data DATE NULL,
DistanciaKm INT NULL
);

INSERT INTO Motoristas (IdMotorista, Nome, CNH)
VALUES
(1,'Rafael','123456789'),
(2,'Pedro','987654321'),
(3,'Emilly','456789123');

INSERT INTO Viagens (IdMotorista, Origem, Destino, Data, DistanciaKm)
VALUES
(1,'São Paulo','Rio de Janeiro','2025-08-01',430),
(1,'São Paulo','Belo Horizonte','2025-08-05',586),
(2,'Rio de Janeiro','Salvador','2025-08-03',1500),
(2,'Rio de Janeiro','Curitiba','2025-08-06',850);

SELECT Motoristas.Nome, Viagens.Origem, Viagens.Destino, Viagens.Data, Viagens.DistanciaKm
FROM Viagens
JOIN Motoristas ON Viagens.IdMotorista = Motoristas.IdMotorista
WHERE Motoristas.IdMotorista = 1;

SELECT Motoristas.Nome, SUM(Viagens.DistanciaKm) AS DistanciaTotal
FROM Viagens
JOIN Motoristas ON Viagens.IdMotorista = Motoristas.IdMotorista
GROUP BY Motoristas.Nome;

SELECT Motoristas.Nome, Viagens.Origem, Viagens.Destino, Viagens.Data, Viagens.DistanciaKm
FROM Viagens
JOIN Motoristas ON Viagens.IdMotorista = Motoristas.IdMotorista
WHERE Viagens.DistanciaKm > 500;

SELECT Motoristas.Nome, Motoristas.CNH
FROM Motoristas
LEFT JOIN Viagens ON Motoristas.IdMotorista = Viagens.IdMotorista
WHERE Viagens.IdViagem IS NULL;
-----------------------------------------------------------

CREATE TABLE Atores(
Id INT PRIMARY KEY IDENTITY(1,1),
PrimeiroNome VARCHAR(20) NOT NULL,
UltimoNome VARCHAR(20)NOT NULL,
Genero VARCHAR(1)NOT NULL,
);

CREATE TABLE ElencoFilme(
Id INT PRIMARY KEY IDENTITY(1,1),
IdAtor INT,
IdFIlme INT NOT NULL,
Papel VARCHAR(30)NOT NULL,
);

CREATE TABLE Filmess (
Id INT PRIMARY KEY IDENTITY(1,1),
Nome VARCHAR(50)NOT NULL,
Ano INT NOT NULL,
Duracao INT NOT NULL,
);

CREATE TABLE FilmesGenero(
Id INT PRIMARY KEY IDENTITY(1,1),
IdGenero INT NOT NULL,
IdFilme INT NOT NULL,
)

CREATE TABLE Generos(
Id INT PRIMARY KEY IDENTITY(1,1),
Genero VARCHAR(20)NOT NULL,
)

INSERT INTO Atores (PrimeiroNome, UltimoNome, Genero)
VALUES
('Leonardo','DiCaprio','M'),
('Kate','Winslet','F'),
('Brad','Pitt','M'),
('Meryl','Streep','F');

INSERT INTO Filmess (Nome, Ano, Duracao)
VALUES
('Titanic',1997,195),
('Inception',2010,148),
('Fight Club',1999,139);

INSERT INTO Generos (Genero)
VALUES
('Drama'),
('Ação'),
('Romance');

INSERT INTO FilmesGenero (IdGenero, IdFilme)
VALUES
(1,1),
(3,1),
(2,2),
(1,2),
(2,3),
(1,3);

INSERT INTO ElencoFilme (IdAtor, IdFilme, Papel)
VALUES
(1,1,'Jack Dawson'),
(2,1,'Rose DeWitt Bukater'),
(1,2,'Dom Cobb'),
(3,3,'Tyler Durden'),
(4,3,'Narradora');



