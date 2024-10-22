-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 11, 2023 at 08:32 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES latin1 */;

--
-- Database: `projeto`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `TotalVendasDeFuncionarioPorLoja` (IN `lojaId` INT)   BEGIN
    SELECT f.IdFuncionario, (
        SELECT SUM(ValorVenda(v.IdVenda))
        FROM venda AS v
        WHERE v.Funcionario_IdFuncionario = f.IdFuncionario
    ) AS TotalVendas
    FROM funcionario AS f
    WHERE f.Loja_IdLoja = lojaId;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `ValorVenda` (`vendaID` INT) RETURNS INT(11)  BEGIN
    DECLARE resultado INT;

    SELECT SUM(Preco) INTO resultado
    FROM jogo
    WHERE IdJogo IN (SELECT Jogo_IdJogo_
                     FROM jogovenda
                     WHERE Venda_IdVenda_ = vendaID);

    RETURN resultado;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cargo`
--

CREATE TABLE `cargo` (
  `Sigla` varchar(3) COLLATE latin1_bin NOT NULL,
  `DesignacaoCargo` varchar(50) COLLATE latin1_bin DEFAULT NULL,
  `Ordenado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `cargo`
--

INSERT INTO `cargo` (`Sigla`, `DesignacaoCargo`, `Ordenado`) VALUES
('AUX', 'Auxiliar de limpeza', 1300),
('EMB', 'Empregado de balcao', 1450),
('GER', 'Gerente de loja', 2500),
('REP', 'Repositor', 1000),
('SEG', 'Seguranca', 1900),
('VEN', 'Vendedor', 1500);

-- --------------------------------------------------------

--
-- Table structure for table `clientecomperfil`
--

CREATE TABLE `clientecomperfil` (
  `Loja_IdLoja` int(11) NOT NULL,
  `IdCliente` int(11) NOT NULL,
  `Nome` varchar(100) COLLATE latin1_bin DEFAULT NULL,
  `Idade` int(11) DEFAULT NULL,
  `Morada` varchar(100) COLLATE latin1_bin DEFAULT NULL,
  `Telemovel` int(11) DEFAULT NULL,
  `Mail` varchar(100) COLLATE latin1_bin DEFAULT NULL,
  `Nif` int(11) DEFAULT NULL,
  `dataDeCriacao` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `clientecomperfil`
--

INSERT INTO `clientecomperfil` (`Loja_IdLoja`, `IdCliente`, `Nome`, `Idade`, `Morada`, `Telemovel`, `Mail`, `Nif`, `dataDeCriacao`) VALUES
(1, 1, 'Cliente 1', 30, 'Morada 1', 123456789, 'cliente1@example.com', 123456789, '2023-07-06'),
(1, 2, 'Cliente 2', 25, 'Morada 2', 987654321, 'cliente2@example.com', 987654321, '2023-07-06'),
(2, 3, 'Cliente 3', 35, 'Morada 3', 111111111, 'cliente3@example.com', 111111111, '2023-07-06'),
(2, 4, 'Cliente 4', 40, 'Morada 4 roroca', 222222222, 'cliente4@example.com', 222222222, '2023-07-06');

-- --------------------------------------------------------

--
-- Table structure for table `despesas`
--

CREATE TABLE `despesas` (
  `Loja_IdLoja` int(11) NOT NULL,
  `Ano` int(11) NOT NULL,
  `Mes` int(11) NOT NULL,
  `Luz` double DEFAULT NULL,
  `Agua` double DEFAULT NULL,
  `Aluguer` double DEFAULT NULL,
  `OutrosGastos` double DEFAULT NULL,
  `Imprevistos` double DEFAULT NULL,
  `IdDespesa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `despesas`
--

INSERT INTO `despesas` (`Loja_IdLoja`, `Ano`, `Mes`, `Luz`, `Agua`, `Aluguer`, `OutrosGastos`, `Imprevistos`, `IdDespesa`) VALUES
(1, 2023, 1, 100, 50, 200, 50, 20, 1),
(1, 2023, 2, 120, 60, 220, 70, 10, 2),
(2, 2023, 1, 80, 40, 180, 30, 15, 3),
(2, 2023, 2, 110, 55, 250, 60, 5, 4);

-- --------------------------------------------------------

--
-- Table structure for table `distrito`
--

CREATE TABLE `distrito` (
  `distrito` varchar(50) COLLATE latin1_bin DEFAULT NULL,
  `sigla` char(4) COLLATE latin1_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `distrito`
--

INSERT INTO `distrito` (`distrito`, `sigla`) VALUES
('Aveiro', 'AVE'),
('Beja', 'BEJ'),
('Braga', 'BRA'),
('Braganca', 'BRC'),
('Castelo Branco', 'CB'),
('Coimbra', 'COI'),
('Evora', 'EVO'),
('Faro', 'FAR'),
('Guarda', 'GUA'),
('Leiria', 'LEI'),
('Lisboa', 'LIS'),
('Porto', 'POR'),
('Portalegre', 'PTG'),
('Santarem', 'SAN'),
('Setubal', 'SET'),
('Viana do Castelo', 'VC'),
('Viseu', 'VIS'),
('Vila Real', 'VR');

-- --------------------------------------------------------

--
-- Table structure for table `formadepagamento`
--

CREATE TABLE `formadepagamento` (
  `Sigla` varchar(3) COLLATE latin1_bin NOT NULL,
  `formaDePagamento` varchar(50) COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `formadepagamento`
--

INSERT INTO `formadepagamento` (`Sigla`, `formaDePagamento`) VALUES
('FP2', 'Forma de Pagamento 2'),
('FP3', 'Forma de Pagamento 3'),
('FP4', 'Forma de Pagamento 4'),
('Num', 'Forma de Pagamento 1');

-- --------------------------------------------------------

--
-- Table structure for table `fornecedor`
--

CREATE TABLE `fornecedor` (
  `IdFornecedor` int(11) NOT NULL,
  `Nome` varchar(100) COLLATE latin1_bin DEFAULT NULL,
  `Representante` varchar(100) COLLATE latin1_bin DEFAULT NULL,
  `RepresentanteContacto` varchar(50) COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `fornecedor`
--

INSERT INTO `fornecedor` (`IdFornecedor`, `Nome`, `Representante`, `RepresentanteContacto`) VALUES
(1, 'Fornecedor 1', 'Representante 1', '123456789'),
(2, 'Fornecedor 2', 'Representante 2', '987654321'),
(3, 'Fornecedor 3', 'Representante 3', '111111111'),
(4, 'Fornecedor 4', 'Representante 4', '222222222');

-- --------------------------------------------------------

--
-- Table structure for table `funcionario`
--

CREATE TABLE `funcionario` (
  `Loja_IdLoja` int(11) NOT NULL,
  `Cargo_Sigla` varchar(3) COLLATE latin1_bin NOT NULL,
  `DataDeIngressoCargo` date DEFAULT NULL,
  `DataDeFimCargo` date DEFAULT NULL,
  `IdFuncionario` int(11) NOT NULL,
  `Nome` varchar(100) COLLATE latin1_bin NOT NULL,
  `Idade` int(11) DEFAULT NULL,
  `Morada` varchar(100) COLLATE latin1_bin DEFAULT NULL,
  `Telemovel` int(11) DEFAULT NULL,
  `Mail` varchar(100) COLLATE latin1_bin DEFAULT NULL,
  `Nif` int(11) NOT NULL,
  `DataDeIngresso` date DEFAULT NULL,
  `RegimeHorario` enum('DF','DP','NF','NP') COLLATE latin1_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `funcionario`
--

INSERT INTO `funcionario` (`Loja_IdLoja`, `Cargo_Sigla`, `DataDeIngressoCargo`, `DataDeFimCargo`, `IdFuncionario`, `Nome`, `Idade`, `Morada`, `Telemovel`, `Mail`, `Nif`, `DataDeIngresso`, `RegimeHorario`) VALUES
(1, 'GER', '2022-01-01', NULL, 1, 'Gerente 1', 30, 'Morada 1', 123456789, 'gerente1@example.com', 123456789, '2022-01-01', 'DF'),
(1, 'EMB', '2022-02-01', NULL, 2, 'Empregado 1', 25, 'Morada 2', 987654321, 'empregado1@example.com', 987654321, '2022-02-01', 'DF'),
(1, 'VEN', '2022-03-01', NULL, 3, 'Vendedor 1', 35, 'Morada 3', 111111111, 'vendedor1@example.com', 111111111, '2022-03-01', 'DF'),
(2, 'GER', '2022-04-01', NULL, 4, 'Gerente 2', 40, 'Morada 4', 222222222, 'gerente2@example.com', 222222222, '2022-04-01', 'DF'),
(2, 'EMB', '2022-05-01', NULL, 5, 'Empregado 2', 28, 'Morada 5', 333333333, 'empregado2@example.com', 333333333, '2022-05-01', 'DF'),
(2, 'VEN', '2022-06-01', NULL, 6, 'Vendedor 2', 32, 'Morada 6', 444444444, 'vendedor2@example.com', 444444444, '2022-06-01', 'DF'),
(3, 'GER', '2022-07-01', NULL, 7, 'Gerente 3', 33, 'Morada 7', 555555555, 'gerente3@example.com', 555555555, '2022-07-01', 'DF'),
(3, 'EMB', '2022-08-01', NULL, 8, 'Empregado 3', 29, 'Morada 8', 666666666, 'empregado3@example.com', 666666666, '2022-08-01', 'DF'),
(3, 'VEN', '2022-09-01', NULL, 9, 'Vendedor 3', 38, 'Morada 9', 777777777, 'vendedor3@example.com', 777777777, '2022-09-01', 'DF'),
(4, 'GER', '2022-10-01', NULL, 10, 'Gerente 4', 27, 'Morada 10', 888888888, 'gerente4@example.com', 888888888, '2022-10-01', 'DF'),
(4, 'EMB', '2022-11-01', NULL, 11, 'Empregado 4', 31, 'Morada 11', 999999999, 'empregado4@example.com', 999999999, '2022-11-01', 'DF'),
(4, 'VEN', '2022-12-01', NULL, 12, 'Vendedor 4', 36, 'Morada 12', 101010101, 'vendedor4@example.com', 101010101, '2022-12-01', 'DF'),
(1, 'GER', NULL, NULL, 13, 'Gerente 5', 39, 'Morada 13', NULL, 'gerente5@example.com', 13131313, NULL, 'NF');

--
-- Triggers `funcionario`
--
DELIMITER $$
CREATE TRIGGER `VerificarGerenteIn` BEFORE INSERT ON `funcionario` FOR EACH ROW BEGIN
  DECLARE totalGerentes INT;
  SET totalGerentes = (SELECT COUNT(IdFuncionario) FROM funcionario WHERE Loja_IdLoja = NEW.Loja_IdLoja AND Cargo_Sigla = 'GER');
  IF NEW.Cargo_Sigla != 'GER' THEN
    IF totalGerentes = 0 THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Loja sem gerencia';
    END IF;
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `VerificarGerenteUp` BEFORE UPDATE ON `funcionario` FOR EACH ROW BEGIN

  DECLARE totalGerentes INT;
  SET totalGerentes = (SELECT COUNT(IdFuncionario) FROM funcionario WHERE Loja_IdLoja = NEW.Loja_IdLoja AND Cargo_Sigla = 'GER');
 
    IF totalGerentes = 1 THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Unico gerente de loja';
   
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `genero`
--

CREATE TABLE `genero` (
  `Sigla` varchar(3) COLLATE latin1_bin NOT NULL,
  `genero` varchar(100) COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `genero`
--

INSERT INTO `genero` (`Sigla`, `genero`) VALUES
('AC', 'Acao'),
('AV', 'Aventura'),
('COR', 'Corrida'),
('DES', 'Desporto'),
('EST', 'Estrategia');

-- --------------------------------------------------------

--
-- Table structure for table `jogo`
--

CREATE TABLE `jogo` (
  `Fornecedor_IdFornecedor` int(11) NOT NULL,
  `IdJogo` int(11) NOT NULL,
  `Nome` varchar(100) COLLATE latin1_bin DEFAULT NULL,
  `Preco` double DEFAULT NULL,
  `DataLancamento` date DEFAULT NULL,
  `Gen1` varchar(3) COLLATE latin1_bin DEFAULT NULL,
  `Gen2` varchar(3) COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `jogo`
--

INSERT INTO `jogo` (`Fornecedor_IdFornecedor`, `IdJogo`, `Nome`, `Preco`, `DataLancamento`, `Gen1`, `Gen2`) VALUES
(1, 1, 'Jogo 1', 49.99, '2023-01-01', 'AC', 'AV'),
(2, 2, 'Jogo 2', 39.99, '2023-02-01', 'EST', 'DES'),
(3, 3, 'Jogo 3', 59.99, '2023-03-01', 'COR', 'AV'),
(4, 4, 'Jogo 4', 29.99, '2023-04-01', 'DES', 'AC'),
(1, 5, 'Jogo 5', 49.99, '2023-05-01', 'AC', 'AV'),
(2, 6, 'Jogo 6', 39.99, '2023-06-01', 'EST', 'DES'),
(1, 7, 'Jogo 7', 59.99, '2023-07-01', 'COR', 'AV'),
(3, 8, 'Jogo 8', 35, '2023-08-01', 'DES', 'AC');

-- --------------------------------------------------------

--
-- Stand-in structure for view `jogomaisantigoporfornecedor`
-- (See below for the actual view)
--
CREATE TABLE `jogomaisantigoporfornecedor` (
`Fornecedor_Nome` varchar(100)
,`Jogo_Mais_Antigo` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `jogovenda`
--

CREATE TABLE `jogovenda` (
  `Jogo_IdJogo_` int(11) NOT NULL,
  `Venda_IdVenda_` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `jogovenda`
--

INSERT INTO `jogovenda` (`Jogo_IdJogo_`, `Venda_IdVenda_`) VALUES
(1, 1),
(1, 4),
(1, 5),
(1, 9),
(1, 10),
(1, 11),
(1, 13),
(1, 17),
(2, 1),
(2, 2),
(2, 4),
(2, 5),
(2, 6),
(2, 10),
(2, 12),
(2, 14),
(2, 18),
(3, 3),
(3, 7),
(3, 8),
(3, 11),
(3, 15),
(3, 16),
(3, 18),
(3, 19),
(4, 4),
(4, 8),
(4, 12),
(4, 16),
(4, 20);

--
-- Triggers `jogovenda`
--
DELIMITER $$
CREATE TRIGGER `ControleStock` AFTER INSERT ON `jogovenda` FOR EACH ROW BEGIN
    DECLARE lojaID INT;
    DECLARE quantStock INT;
    
    SET lojaID = (SELECT Loja_IdLoja FROM funcionario WHERE IdFuncionario = (SELECT Funcionario_IdFuncionario FROM venda WHERE IdVenda = NEW.Venda_IdVenda_));
    SET quantStock = (SELECT Quantidade FROM stock WHERE Loja_IdLoja_ = lojaID AND Jogo_IdJogo_ = NEW.Jogo_IdJogo_);
                      
    IF quantStock > 0 THEN
        INSERT INTO `stock` (`Loja_IdLoja_`, `Jogo_IdJogo_`, `Quantidade`, `DataRegisto`)
        VALUES (lojaID, NEW.Jogo_IdJogo_, quantStock - 1, NULL);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Jogo se encontra fora de stock';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `listarordenados`
-- (See below for the actual view)
--
CREATE TABLE `listarordenados` (
`IdFuncionario` int(11)
,`Nome` varchar(100)
,`Cargo` varchar(50)
,`RH` varchar(2)
,`OrdFinal` decimal(14,3)
);

-- --------------------------------------------------------

--
-- Table structure for table `loja`
--

CREATE TABLE `loja` (
  `Distrito_sigla` char(4) COLLATE latin1_bin NOT NULL,
  `IdLoja` int(11) NOT NULL,
  `Localidade` varchar(50) COLLATE latin1_bin DEFAULT NULL,
  `Morada` varchar(100) COLLATE latin1_bin DEFAULT NULL,
  `DataAbertura` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `loja`
--

INSERT INTO `loja` (`Distrito_sigla`, `IdLoja`, `Localidade`, `Morada`, `DataAbertura`) VALUES
('LIS', 1, 'Localidade 1', 'Morada 1', '2023-01-01'),
('POR', 2, 'Localidade 2', 'Morada 2', '2023-02-01'),
('SET', 3, 'Localidade 3', 'Morada 3', '2023-03-01'),
('BRA', 4, 'Localidade 4', 'Morada 4', '2023-04-01');

-- --------------------------------------------------------

--
-- Stand-in structure for view `perfisporlojasemrepetirnif`
-- (See below for the actual view)
--
CREATE TABLE `perfisporlojasemrepetirnif` (
`IdLoja` int(11)
,`Total_Perfis` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

CREATE TABLE `stock` (
  `Loja_IdLoja_` int(11) NOT NULL,
  `Jogo_IdJogo_` int(11) NOT NULL,
  `Quantidade` int(11) DEFAULT NULL,
  `DataRegisto` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `stock`
--

INSERT INTO `stock` (`Loja_IdLoja_`, `Jogo_IdJogo_`, `Quantidade`, `DataRegisto`) VALUES
(1, 1, 10, '2023-01-01'),
(1, 2, 5, '2023-02-01'),
(2, 3, 15, '2023-03-01'),
(2, 4, 8, '2023-04-01'),
(3, 1, 20, '2023-05-01'),
(3, 2, 12, '2023-06-01'),
(4, 3, 7, '2023-07-01'),
(4, 4, 3, '2023-08-01');

-- --------------------------------------------------------

--
-- Stand-in structure for view `totaldespesaspordistrito`
-- (See below for the actual view)
--
CREATE TABLE `totaldespesaspordistrito` (
`distritoLojaSigla` char(4)
,`totalAgua` double
,`totalLuz` double
,`totalAluguer` double
,`totalOutrosGastos` double
,`totalImprevistos` double
,`totalGeral` double
);

-- --------------------------------------------------------

--
-- Table structure for table `venda`
--

CREATE TABLE `venda` (
  `Loja_IdLoja` int(11) NOT NULL,
  `Funcionario_IdFuncionario` int(11) NOT NULL,
  `ClienteComPerfil_IdCliente` int(11) DEFAULT NULL,
  `IdVenda` int(11) NOT NULL,
  `HoraDaVenda` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `venda`
--

INSERT INTO `venda` (`Loja_IdLoja`, `Funcionario_IdFuncionario`, `ClienteComPerfil_IdCliente`, `IdVenda`, `HoraDaVenda`) VALUES
(1, 1, 1, 1, '2023-01-01 10:00:00'),
(1, 1, 2, 2, '2023-01-02 11:00:00'),
(1, 1, 3, 3, '2023-01-03 12:00:00'),
(1, 2, 4, 4, '2023-01-04 13:00:00'),
(1, 2, 1, 5, '2023-01-05 14:00:00'),
(1, 2, 2, 6, '2023-01-06 15:00:00'),
(1, 3, 3, 7, '2023-01-07 16:00:00'),
(1, 3, 4, 8, '2023-01-08 17:00:00'),
(1, 3, 1, 9, '2023-01-09 18:00:00'),
(1, 4, 2, 10, '2023-01-10 19:00:00'),
(2, 4, 3, 11, '2023-02-01 20:00:00'),
(2, 4, 4, 12, '2023-02-02 21:00:00'),
(2, 5, 1, 13, '2023-02-03 22:00:00'),
(2, 5, 2, 14, '2023-02-04 23:00:00'),
(2, 5, 3, 15, '2023-02-05 10:00:00'),
(2, 6, 4, 16, '2023-02-06 11:00:00'),
(2, 6, 1, 17, '2023-02-07 12:00:00'),
(2, 6, 2, 18, '2023-02-08 13:00:00'),
(2, 7, 3, 19, '2023-02-09 14:00:00'),
(2, 7, 4, 20, '2023-02-10 15:00:00'),
(2, 1, NULL, 21, '2023-07-11 17:48:46');

-- --------------------------------------------------------

--
-- Table structure for table `vendaformadepagamento`
--

CREATE TABLE `vendaformadepagamento` (
  `Venda_IdVenda_` int(11) NOT NULL,
  `FormaDePagamento_Sigla_` varchar(3) COLLATE latin1_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumping data for table `vendaformadepagamento`
--

INSERT INTO `vendaformadepagamento` (`Venda_IdVenda_`, `FormaDePagamento_Sigla_`) VALUES
(1, 'FP2'),
(1, 'Num'),
(2, 'FP2'),
(3, 'FP3'),
(4, 'FP4'),
(5, 'FP2'),
(5, 'Num'),
(6, 'FP2'),
(7, 'FP3'),
(8, 'FP4'),
(9, 'Num'),
(10, 'FP2'),
(11, 'FP3'),
(12, 'FP4'),
(13, 'Num'),
(14, 'FP2'),
(15, 'FP3'),
(16, 'FP4'),
(17, 'Num'),
(18, 'FP2'),
(19, 'FP3'),
(20, 'FP4');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vendedormenosvendas`
-- (See below for the actual view)
--
CREATE TABLE `vendedormenosvendas` (
`IdFuncionario` int(11)
,`Funcionario_Nome` varchar(100)
,`Total_Vendas` bigint(21)
);

-- --------------------------------------------------------

--
-- Structure for view `jogomaisantigoporfornecedor`
--
DROP TABLE IF EXISTS `jogomaisantigoporfornecedor`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jogomaisantigoporfornecedor`  AS SELECT `f`.`Nome` AS `Fornecedor_Nome`, (select `j`.`Nome` from `jogo` `j` where `j`.`Fornecedor_IdFornecedor` = `f`.`IdFornecedor` order by `j`.`DataLancamento` limit 1) AS `Jogo_Mais_Antigo` FROM `fornecedor` AS `f``f`  ;

-- --------------------------------------------------------

--
-- Structure for view `listarordenados`
--
DROP TABLE IF EXISTS `listarordenados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `listarordenados`  AS SELECT `funcionario`.`IdFuncionario` AS `IdFuncionario`, `funcionario`.`Nome` AS `Nome`, (select `cargo`.`DesignacaoCargo` from `cargo` where `cargo`.`Sigla` = `funcionario`.`Cargo_Sigla`) AS `Cargo`, `funcionario`.`RegimeHorario` AS `RH`, (select `cargo`.`Ordenado` from `cargo` where `cargo`.`Sigla` = `funcionario`.`Cargo_Sigla`) * 1.000 AS `OrdFinal` FROM `funcionario` WHERE `funcionario`.`RegimeHorario` = 'DF' union select `funcionario`.`IdFuncionario` AS `IdFuncionario`,`funcionario`.`Nome` AS `Nome`,(select `cargo`.`DesignacaoCargo` from `cargo` where `cargo`.`Sigla` = `funcionario`.`Cargo_Sigla`) AS `Cargo`,`funcionario`.`RegimeHorario` AS `RH`,(select `cargo`.`Ordenado` from `cargo` where `cargo`.`Sigla` = `funcionario`.`Cargo_Sigla`) * 0.500 AS `OrdFinal` from `funcionario` where `funcionario`.`RegimeHorario` = 'DP' union select `funcionario`.`IdFuncionario` AS `IdFuncionario`,`funcionario`.`Nome` AS `Nome`,(select `cargo`.`DesignacaoCargo` from `cargo` where `cargo`.`Sigla` = `funcionario`.`Cargo_Sigla`) AS `Cargo`,`funcionario`.`RegimeHorario` AS `RH`,(select `cargo`.`Ordenado` from `cargo` where `cargo`.`Sigla` = `funcionario`.`Cargo_Sigla`) * 1.250 AS `OrdFinal` from `funcionario` where `funcionario`.`RegimeHorario` = 'NF' union select `funcionario`.`IdFuncionario` AS `IdFuncionario`,`funcionario`.`Nome` AS `Nome`,(select `cargo`.`DesignacaoCargo` from `cargo` where `cargo`.`Sigla` = `funcionario`.`Cargo_Sigla`) AS `Cargo`,`funcionario`.`RegimeHorario` AS `RH`,(select `cargo`.`Ordenado` from `cargo` where `cargo`.`Sigla` = `funcionario`.`Cargo_Sigla`) * 0.625 AS `OrdFinal` from `funcionario` where `funcionario`.`RegimeHorario` = 'NP'  ;

-- --------------------------------------------------------

--
-- Structure for view `perfisporlojasemrepetirnif`
--
DROP TABLE IF EXISTS `perfisporlojasemrepetirnif`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `perfisporlojasemrepetirnif`  AS SELECT `l`.`IdLoja` AS `IdLoja`, (select count(distinct `c`.`IdCliente`) from `clientecomperfil` `c` where `c`.`Loja_IdLoja` = `l`.`IdLoja` and !(`c`.`Nif` in (select `clientecomperfil`.`Nif` from `clientecomperfil` where `clientecomperfil`.`Loja_IdLoja` = `l`.`IdLoja` and `clientecomperfil`.`Nif` is not null group by `clientecomperfil`.`Nif` having count(0) > 1))) AS `Total_Perfis` FROM `loja` AS `l``l`  ;

-- --------------------------------------------------------

--
-- Structure for view `totaldespesaspordistrito`
--
DROP TABLE IF EXISTS `totaldespesaspordistrito`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `totaldespesaspordistrito`  AS SELECT `l`.`Distrito_sigla` AS `distritoLojaSigla`, (select sum(`despesas`.`Agua`) from `despesas` where `despesas`.`Loja_IdLoja` = `l`.`IdLoja`) AS `totalAgua`, (select sum(`despesas`.`Luz`) from `despesas` where `despesas`.`Loja_IdLoja` = `l`.`IdLoja`) AS `totalLuz`, (select sum(`despesas`.`Aluguer`) from `despesas` where `despesas`.`Loja_IdLoja` = `l`.`IdLoja`) AS `totalAluguer`, (select sum(`despesas`.`OutrosGastos`) from `despesas` where `despesas`.`Loja_IdLoja` = `l`.`IdLoja`) AS `totalOutrosGastos`, (select sum(`despesas`.`Imprevistos`) from `despesas` where `despesas`.`Loja_IdLoja` = `l`.`IdLoja`) AS `totalImprevistos`, (select sum(`despesas`.`Agua` + `despesas`.`Luz` + `despesas`.`Aluguer` + `despesas`.`OutrosGastos` + `despesas`.`Imprevistos`) from `despesas` where `despesas`.`Loja_IdLoja` = `l`.`IdLoja`) AS `totalGeral` FROM `loja` AS `l` GROUP BY `l`.`Distrito_sigla` ORDER BY `l`.`Distrito_sigla` ASC  ;

-- --------------------------------------------------------

--
-- Structure for view `vendedormenosvendas`
--
DROP TABLE IF EXISTS `vendedormenosvendas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vendedormenosvendas`  AS SELECT `f`.`IdFuncionario` AS `IdFuncionario`, `f`.`Nome` AS `Funcionario_Nome`, (select count(0) from `venda` `v` where `v`.`Funcionario_IdFuncionario` = `f`.`IdFuncionario`) AS `Total_Vendas` FROM `funcionario` AS `f` WHERE `f`.`Cargo_Sigla` = 'VEN' AND ((select count(0) from `venda` where `venda`.`Funcionario_IdFuncionario` = `f`.`IdFuncionario`) = 0 OR (select count(0) from `venda` where `venda`.`Funcionario_IdFuncionario` = `f`.`IdFuncionario`) = (select min(`subquery`.`Total_Vendas`) from (select count(0) AS `Total_Vendas` from `venda` group by `venda`.`Funcionario_IdFuncionario`) `subquery`)) WITH CASCADED CHECK OPTION  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`Sigla`);

--
-- Indexes for table `clientecomperfil`
--
ALTER TABLE `clientecomperfil`
  ADD PRIMARY KEY (`IdCliente`),
  ADD KEY `FK_ClienteComPerfil_LojaPerfilCliente_Loja` (`Loja_IdLoja`);

--
-- Indexes for table `despesas`
--
ALTER TABLE `despesas`
  ADD PRIMARY KEY (`IdDespesa`),
  ADD KEY `FK_Despesas_DespesasLoja_Loja` (`Loja_IdLoja`);

--
-- Indexes for table `distrito`
--
ALTER TABLE `distrito`
  ADD PRIMARY KEY (`sigla`);

--
-- Indexes for table `formadepagamento`
--
ALTER TABLE `formadepagamento`
  ADD PRIMARY KEY (`Sigla`);

--
-- Indexes for table `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD PRIMARY KEY (`IdFornecedor`);

--
-- Indexes for table `funcionario`
--
ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`IdFuncionario`),
  ADD KEY `FK_Funcionario_LojaFuncionario_Loja` (`Loja_IdLoja`),
  ADD KEY `FK_Funcionario_PeriodoDoCargo_Cargo` (`Cargo_Sigla`);

--
-- Indexes for table `genero`
--
ALTER TABLE `genero`
  ADD PRIMARY KEY (`Sigla`);

--
-- Indexes for table `jogo`
--
ALTER TABLE `jogo`
  ADD PRIMARY KEY (`IdJogo`),
  ADD KEY `FK_Jogo_FornecedorProduto_Fornecedor` (`Fornecedor_IdFornecedor`),
  ADD KEY `FK_Jogo_Gen1` (`Gen1`),
  ADD KEY `FK_Jogo_Gen2` (`Gen2`);

--
-- Indexes for table `jogovenda`
--
ALTER TABLE `jogovenda`
  ADD PRIMARY KEY (`Jogo_IdJogo_`,`Venda_IdVenda_`),
  ADD KEY `FK_Venda_JogoVenda_IdVenda_` (`Venda_IdVenda_`);

--
-- Indexes for table `loja`
--
ALTER TABLE `loja`
  ADD PRIMARY KEY (`IdLoja`),
  ADD KEY `FK_Loja_DistritoLoja_Distrito` (`Distrito_sigla`);

--
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`Loja_IdLoja_`,`Jogo_IdJogo_`),
  ADD KEY `FK_Jogo_Stock_Loja_` (`Jogo_IdJogo_`);

--
-- Indexes for table `venda`
--
ALTER TABLE `venda`
  ADD PRIMARY KEY (`IdVenda`),
  ADD KEY `FK_Venda_LojaVenda_Loja` (`Loja_IdLoja`),
  ADD KEY `FK_Venda_FuncionarioVenda_Funcionario` (`Funcionario_IdFuncionario`),
  ADD KEY `FK_Venda_VnedaClienteComPerfil_ClienteComPerfil` (`ClienteComPerfil_IdCliente`);

--
-- Indexes for table `vendaformadepagamento`
--
ALTER TABLE `vendaformadepagamento`
  ADD PRIMARY KEY (`Venda_IdVenda_`,`FormaDePagamento_Sigla_`),
  ADD KEY `FK_FormaDePagamento_VendaFormaDePagamento_Venda_` (`FormaDePagamento_Sigla_`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `clientecomperfil`
--
ALTER TABLE `clientecomperfil`
  ADD CONSTRAINT `FK_ClienteComPerfil_LojaPerfilCliente_Loja` FOREIGN KEY (`Loja_IdLoja`) REFERENCES `loja` (`IdLoja`) ON UPDATE CASCADE;

--
-- Constraints for table `despesas`
--
ALTER TABLE `despesas`
  ADD CONSTRAINT `FK_Despesas_DespesasLoja_Loja` FOREIGN KEY (`Loja_IdLoja`) REFERENCES `loja` (`IdLoja`) ON UPDATE CASCADE;

--
-- Constraints for table `funcionario`
--
ALTER TABLE `funcionario`
  ADD CONSTRAINT `FK_Funcionario_LojaFuncionario_Loja` FOREIGN KEY (`Loja_IdLoja`) REFERENCES `loja` (`IdLoja`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Funcionario_PeriodoDoCargo_Cargo` FOREIGN KEY (`Cargo_Sigla`) REFERENCES `cargo` (`Sigla`) ON UPDATE CASCADE;

--
-- Constraints for table `jogo`
--
ALTER TABLE `jogo`
  ADD CONSTRAINT `FK_Jogo_FornecedorProduto_Fornecedor` FOREIGN KEY (`Fornecedor_IdFornecedor`) REFERENCES `fornecedor` (`IdFornecedor`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Jogo_Gen1` FOREIGN KEY (`Gen1`) REFERENCES `genero` (`Sigla`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Jogo_Gen2` FOREIGN KEY (`Gen2`) REFERENCES `genero` (`Sigla`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `jogovenda`
--
ALTER TABLE `jogovenda`
  ADD CONSTRAINT `FK_IdJogo_JogoVenda_Jogo_` FOREIGN KEY (`Jogo_IdJogo_`) REFERENCES `jogo` (`IdJogo`),
  ADD CONSTRAINT `FK_Venda_JogoVenda_IdVenda_` FOREIGN KEY (`Venda_IdVenda_`) REFERENCES `venda` (`IdVenda`);

--
-- Constraints for table `loja`
--
ALTER TABLE `loja`
  ADD CONSTRAINT `FK_Loja_DistritoLoja_Distrito` FOREIGN KEY (`Distrito_sigla`) REFERENCES `distrito` (`sigla`) ON UPDATE CASCADE;

--
-- Constraints for table `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `FK_Jogo_Stock_Loja_` FOREIGN KEY (`Jogo_IdJogo_`) REFERENCES `jogo` (`IdJogo`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Loja_Stock_Jogo_` FOREIGN KEY (`Loja_IdLoja_`) REFERENCES `loja` (`IdLoja`) ON UPDATE CASCADE;

--
-- Constraints for table `venda`
--
ALTER TABLE `venda`
  ADD CONSTRAINT `FK_Venda_FuncionarioVenda_Funcionario` FOREIGN KEY (`Funcionario_IdFuncionario`) REFERENCES `funcionario` (`IdFuncionario`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Venda_LojaVenda_Loja` FOREIGN KEY (`Loja_IdLoja`) REFERENCES `loja` (`IdLoja`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Venda_VnedaClienteComPerfil_ClienteComPerfil` FOREIGN KEY (`ClienteComPerfil_IdCliente`) REFERENCES `clientecomperfil` (`IdCliente`) ON UPDATE CASCADE;

--
-- Constraints for table `vendaformadepagamento`
--
ALTER TABLE `vendaformadepagamento`
  ADD CONSTRAINT `FK_FormaDePagamento_VendaFormaDePagamento_Venda_` FOREIGN KEY (`FormaDePagamento_Sigla_`) REFERENCES `formadepagamento` (`Sigla`),
  ADD CONSTRAINT `FK_Venda_VendaFormaDePagamento_FormaDePagamento_` FOREIGN KEY (`Venda_IdVenda_`) REFERENCES `venda` (`IdVenda`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
