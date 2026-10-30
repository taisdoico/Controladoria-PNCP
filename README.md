

# Controladoria PNCP

**Projeto Final — Módulo 2 | Análise de Dados**
**Instituição:** SENAI
**Aluna:** Tais Cristina Tagliani Doico
**Ano:** 2026

---

## **1. Apresentação**

O projeto Controladoria PNCP foi desenvolvido com o objetivo de analisar dados de contratações públicas e transformar essas informações em indicadores que facilitem a compreensão e o acompanhamento dos gastos públicos.

A ideia foi desenvolver uma solução completa de análise de dados, desde a preparação e organização das informações até a criação de um dashboard interativo no Power BI.

Durante o desenvolvimento, utilizei Python para o tratamento dos dados, MySQL para armazenar e organizar as informações e Power BI para construir as análises e apresentar os resultados de forma visual.

## **2. Contexto e problema**

Ao iniciar este projeto, meu desafio foi trabalhar com uma grande quantidade de dados de contratações públicas e encontrar uma maneira de transformar essas informações em algo mais organizado, claro e útil para análise.

Percebi que, antes de construir os indicadores, era necessário entender os dados, identificar inconsistências, definir critérios de tratamento e organizar as informações de maneira adequada.

A partir disso, desenvolvi um processo que permite analisar diferentes aspectos das contratações, como valores estimados e homologados, fornecedores, modalidades, economia potencial, distribuição regional e perfil dos gastos.

## **3. Tecnologias utilizadas**

Durante o desenvolvimento do projeto, utilizei diferentes ferramentas e tecnologias, cada uma com uma função específica:

- **Python:** utilizado para auditoria, limpeza e tratamento dos dados.
- **Pandas:** biblioteca utilizada para manipulação e organização dos dados.
- **MySQL e MySQL Workbench:** utilizados para gerenciamento do banco de dados, armazenamento das informações e execução de consultas SQL.
- **SQL:** utilizado para consultas e análises diretamente no banco de dados.
- **Power BI:** utilizado para desenvolver o dashboard interativo e apresentar os indicadores.
- **DAX:** utilizado na criação de medidas e da tabela calendário no Power BI.
- **Git e GitHub:** utilizados para controle de versão e armazenamento do projeto.
- **Visual Studio Code:** ambiente utilizado para desenvolver e organizar os códigos.

## **4. Tratamento e preparação dos dados**

Nesta etapa, utilizei Python e a biblioteca Pandas para analisar, limpar e organizar os dados antes de armazená-los no banco de dados.

O processo envolveu a identificação de inconsistências, padronização de informações, tratamento de valores e aplicação das regras de negócio definidas para o projeto.

Após essa preparação, os dados foram organizados em arquivos CSV, que serviram de base para a carga das informações no MySQL.

Também foram realizados testes de validação das regras de limpeza, com 54 exemplos testados e aprovados, garantindo que o tratamento dos dados estivesse funcionando conforme o esperado.

## **5. Modelagem e banco de dados**

Para organizar os dados e facilitar as consultas e análises, desenvolvi uma modelagem dimensional do tipo **Star Schema (Esquema Estrela)** no MySQL.

O modelo é composto por uma tabela Fato, que concentra as informações numéricas das contratações, e quatro tabelas Dimensão, que permitem analisar esses dados por diferentes perspectivas.

**Estrutura do banco de dados:**

- **Tabela Fato:** fato_item_contratado.
- **Tabelas Dimensão:** dim_orgao, dim_fornecedor, dim_modalidade e dim_localidade.
- **Calendário:** criado no Power BI utilizando DAX.

Essa estrutura permite relacionar as informações e explorar os dados de forma organizada, facilitando a construção dos indicadores e das análises no Power BI.

**Diagrama da modelagem:**

![Modelo de Dados - Star Schema](docs/imagens/modelagem_star_schema.png)
