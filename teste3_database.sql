CREATE TABLE IF NOT EXISTS demonstracoes_contabeis (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data DATE,
    reg_ans INT NOT NULL,
    cd_conta_contabil VARCHAR(20),
    descricao TEXT,
    vl_saldo_inicial DECIMAL(15,2),
    vl_saldo_final DECIMAL(15,2)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS operadoras_plano_saude (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registro_ans INT NOT NULL,
    cnpj VARCHAR(18) NOT NULL,
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(50),
    logradouro VARCHAR(255),
    numero VARCHAR(50),
    complemento VARCHAR(255),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf VARCHAR(2),
    cep VARCHAR(9),
    ddd CHAR(2),
    telefone VARCHAR(15),
    fax VARCHAR(15),
    endereco_eletronico VARCHAR(255),
    representante VARCHAR(255),
    cargo_representante VARCHAR(50),
    regiao_de_comercializacao VARCHAR(100),
    data_registro_ans DATE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.2/Uploads/1T2023.csv'
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@dt, reg_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET data = STR_TO_DATE(@dt, '%Y-%m-%d'),
vl_saldo_inicial = REPLACE(TRIM(@vl_saldo_inicial), ',', '.'),
vl_saldo_final = REPLACE(TRIM(@vl_saldo_final), ',', '.');

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.2/Uploads/2t2023.csv'
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@dt, reg_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET data = STR_TO_DATE(@dt, '%Y-%m-%d'),
vl_saldo_inicial = REPLACE(TRIM(@vl_saldo_inicial), ',', '.'),
vl_saldo_final = REPLACE(TRIM(@vl_saldo_final), ',', '.');

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.2/Uploads/3T2023.csv'
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@dt, reg_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET data = STR_TO_DATE(@dt, '%Y-%m-%d'),
vl_saldo_inicial = REPLACE(TRIM(@vl_saldo_inicial), ',', '.'),
vl_saldo_final = REPLACE(TRIM(@vl_saldo_final), ',', '.');

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.2/Uploads/4T2023.csv'
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@dt, reg_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET data = STR_TO_DATE(@dt, '%d/%m/%Y'),
vl_saldo_inicial = REPLACE(TRIM(@vl_saldo_inicial), ',', '.'),
vl_saldo_final = REPLACE(TRIM(@vl_saldo_final), ',', '.');

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.2/Uploads/1T2024.csv'
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@dt, reg_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET data = STR_TO_DATE(@dt, '%Y-%m-%d'),
vl_saldo_inicial = REPLACE(TRIM(@vl_saldo_inicial), ',', '.'),
vl_saldo_final = REPLACE(TRIM(@vl_saldo_final), ',', '.');

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.2/Uploads/2T2024.csv'
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@dt, reg_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET data = STR_TO_DATE(@dt, '%Y-%m-%d'),
vl_saldo_inicial = REPLACE(TRIM(@vl_saldo_inicial), ',', '.'),
vl_saldo_final = REPLACE(TRIM(@vl_saldo_final), ',', '.');

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.2/Uploads/3T2024.csv'
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@dt, reg_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET data = STR_TO_DATE(@dt, '%Y-%m-%d'),
vl_saldo_inicial = REPLACE(TRIM(@vl_saldo_inicial), ',', '.'),
vl_saldo_final = REPLACE(TRIM(@vl_saldo_final), ',', '.');

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.2/Uploads/4T2024.csv'
INTO TABLE demonstracoes_contabeis
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@dt, reg_ans, cd_conta_contabil, descricao, @vl_saldo_inicial, @vl_saldo_final)
SET data = STR_TO_DATE(@dt, '%Y-%m-%d'),
vl_saldo_inicial = REPLACE(TRIM(@vl_saldo_inicial), ',', '.'),
vl_saldo_final = REPLACE(TRIM(@vl_saldo_final), ',', '.');

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.2/Uploads/Relatorio_cadop.csv'
INTO TABLE operadoras_plano_saude
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(registro_ans, cnpj, razao_social, nome_fantasia, modalidade, logradouro, numero, complemento,
bairro, cidade, uf, cep, ddd, telefone, fax, endereco_eletronico, representante, cargo_representante,
regiao_de_comercializacao, @data_temp)
SET data_registro_ans = STR_TO_DATE(TRIM(@data_temp), '%Y-%m-%d');