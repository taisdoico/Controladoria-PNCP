
CREATE DATABASE IF NOT EXISTS pncp_controladoria;
USE pncp_controladoria;

-- 1. DIMENSAO: ORGAO
CREATE TABLE IF NOT EXISTS dim_orgao (
    sk_orgao INT PRIMARY KEY,
    cnpj_orgao VARCHAR(20),
    nome_orgao VARCHAR(255),
    poder VARCHAR(50)
);

-- 2. DIMENSAO: FORNECEDOR
CREATE TABLE IF NOT EXISTS dim_fornecedor (
    sk_fornecedor INT PRIMARY KEY,
    ni_fornecedor VARCHAR(20),
    nome_fornecedor VARCHAR(255),
    tipo_pessoa VARCHAR(50),
    porte VARCHAR(100)
);

-- 3. DIMENSAO: MODALIDADE
CREATE TABLE IF NOT EXISTS dim_modalidade (
    sk_modalidade INT PRIMARY KEY,
    modalidade_id VARCHAR(20),
    nome_modalidade VARCHAR(150)
);

-- 4. DIMENSAO: LOCALIDADE
CREATE TABLE IF NOT EXISTS dim_localidade (
    sk_localidade INT PRIMARY KEY,
    uf_sigla VARCHAR(2),
    uf_nome VARCHAR(50),
    regiao VARCHAR(50)
);

-- 5. TABELA FATO: ITEM CONTRATADO
CREATE TABLE IF NOT EXISTS fato_item_contratado (
    numero_controle_pncp VARCHAR(60) NOT NULL,
    numero_item INT NOT NULL,

    sk_orgao INT,
    sk_fornecedor INT,
    sk_modalidade INT,
    sk_localidade INT,

    data_publicacao DATE,
    data_homologacao DATE,
    descricao_item TEXT,
    perfil_gasto VARCHAR(100),

    quantidade DECIMAL(18,4),
    valor_unitario_estimado DECIMAL(18,4),
    valor_total_estimado DECIMAL(18,2),
    valor_unitario_homologado DECIMAL(18,4),
    valor_total_homologado DECIMAL(18,2),

    comparavel BOOLEAN,
    economia_valor DECIMAL(18,2),
    dias_ciclo INT,

    PRIMARY KEY (numero_controle_pncp, numero_item),

    CONSTRAINT fk_fato_orgao
        FOREIGN KEY (sk_orgao)
        REFERENCES dim_orgao(sk_orgao),

    CONSTRAINT fk_fato_fornecedor
        FOREIGN KEY (sk_fornecedor)
        REFERENCES dim_fornecedor(sk_fornecedor),

    CONSTRAINT fk_fato_modalidade
        FOREIGN KEY (sk_modalidade)
        REFERENCES dim_modalidade(sk_modalidade),

    CONSTRAINT fk_fato_localidade
        FOREIGN KEY (sk_localidade)
        REFERENCES dim_localidade(sk_localidade)
);
