-- Criar a base de dados
CREATE DATABASE Empresa;
USE Empresa;

-- Criar a tabela de Departamentos
CREATE TABLE Departamentos (
    id_departamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
);

-- Criar a tabela de Funcionários
CREATE TABLE Funcionarios (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10,2),
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamentos(id_departamento)
);

-- Criar a tabela de Projetos
CREATE TABLE Projetos (
    id_projeto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamentos(id_departamento)
);

-- Criar a tabela de Logs
CREATE TABLE Logs (
    id_log INT PRIMARY KEY AUTO_INCREMENT,
    mensagem TEXT,
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserindo dados na tabela Departamentos
INSERT INTO Departamentos (nome) VALUES ('TI'), ('RH'), ('Marketing');

-- Inserindo dados na tabela Funcionarios
INSERT INTO Funcionarios (nome, cargo, salario, id_departamento) VALUES
('Alice Souza', 'Desenvolvedor', 7000.00, 1),
('Bruno Lima', 'Analista de RH', 5000.00, 2),
('Carlos Mendes', 'Designer', 5500.00, 3);

-- Inserindo dados na tabela Projetos
INSERT INTO Projetos (nome, descricao, id_departamento) VALUES
('Sistema de Gestão', 'Desenvolvimento de um sistema interno', 1),
('Treinamento de Funcionários', 'Programa de capacitação', 2),
('Campanha Publicitária', 'Lançamento de nova campanha', 3);

-- Criar um Trigger para registrar inserções na tabela Funcionarios
DELIMITER //
CREATE TRIGGER after_insert_funcionario
AFTER INSERT ON Funcionarios
FOR EACH ROW
BEGIN
    INSERT INTO Logs (mensagem) VALUES (CONCAT('Novo funcionário inserido: ', NEW.nome));
END;
//
DELIMITER ;

-- Consulta com INNER JOIN para exibir funcionários e seus respectivos departamentos
SELECT Funcionarios.nome AS Funcionario, Funcionarios.cargo, Departamentos.nome AS Departamento
FROM Funcionarios
INNER JOIN Departamentos ON Funcionarios.id_departamento = Departamentos.id_departamento;

-- Consulta com LEFT JOIN para exibir todos os departamentos e seus projetos (mesmo os que não possuem projetos ainda)
SELECT Departamentos.nome AS Departamento, Projetos.nome AS Projeto
FROM Departamentos
LEFT JOIN Projetos ON Departamentos.id_departamento = Projetos.id_departamento;
