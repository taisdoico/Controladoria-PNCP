
-- ============================================================
-- PROJETO FINAL SENAI - CONTROLADORIA PNCP
-- Arquivo: 02_perguntas.sql
-- Objetivo: responder às 6 perguntas de negócio da Controladoria
-- Banco de dados: pncp_controladoria
-- ============================================================

USE pncp_controladoria;


-- ============================================================
-- PERGUNTA 1: ECONOMIA GLOBAL DO PODER PÚBLICO
-- Qual é o percentual e o valor financeiro nominal economizado
-- pelo governo (diferença entre valor estimado e valor homologado)?
-- ============================================================

SELECT
    SUM(
        CASE
            WHEN comparavel = 1 THEN valor_total_estimado
            ELSE 0
        END
    ) AS valor_estimado_comparavel,


    SUM(
        CASE
            WHEN comparavel = 1 THEN economia_valor
            ELSE 0
        END
    ) AS economia_nominal,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN comparavel = 1 THEN economia_valor
                ELSE 0
            END
        ) / NULLIF(
            SUM(
                CASE
                    WHEN comparavel = 1 THEN valor_total_estimado
                    ELSE 0
                END
            ),
            0
        ),
        2
    ) AS economia_percentual

FROM fato_item_contratado;




-- ============================================================
-- PERGUNTA 2: CONCENTRAÇÃO E RISCO DE FORNECEDORES
-- Quem são os maiores fornecedores em volume financeiro e qual
-- percentual do orçamento público está concentrado neles?
-- ============================================================

SELECT
    df.ni_fornecedor,
    df.nome_fornecedor,

    SUM(f.valor_total_homologado) AS volume_homologado,

    ROUND(
        100.0 * SUM(f.valor_total_homologado) /
        NULLIF(
            (SELECT SUM(valor_total_homologado)
             FROM fato_item_contratado),
            0
        ),
        2
    ) AS participacao_volume_percentual

FROM fato_item_contratado f

INNER JOIN dim_fornecedor df
    ON f.sk_fornecedor = df.sk_fornecedor

GROUP BY
    df.ni_fornecedor,
    df.nome_fornecedor

ORDER BY volume_homologado DESC

LIMIT 10;


-- ============================================================
-- PERGUNTA 3: EFICÁCIA POR MODALIDADE
-- Quais modalidades licitatórias trazem maior deságio/economia
-- e quais concentram o maior volume de recursos?
-- ============================================================

SELECT
    dm.nome_modalidade,

    COUNT(*) AS quantidade_itens,

    SUM(f.valor_total_homologado) AS volume_homologado,

    SUM(
        CASE
            WHEN f.comparavel = 1 THEN f.valor_total_estimado
            ELSE 0
        END
    ) AS valor_estimado_comparavel,

    SUM(
        CASE
            WHEN f.comparavel = 1 THEN f.economia_valor
            ELSE 0
        END
    ) AS economia_nominal,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN f.comparavel = 1 THEN f.economia_valor
                ELSE 0
            END
        ) / NULLIF(
            SUM(
                CASE
                    WHEN f.comparavel = 1 THEN f.valor_total_estimado
                    ELSE 0
                END
            ),
            0
        ),
        2
    ) AS economia_percentual

FROM fato_item_contratado f

INNER JOIN dim_modalidade dm
    ON f.sk_modalidade = dm.sk_modalidade

GROUP BY dm.nome_modalidade

ORDER BY volume_homologado DESC;



-- ============================================================
-- PERGUNTA 4: TEMPO DO CICLO DE COMPRAS
-- Qual a duração média (em dias) entre o lançamento do edital
-- e a sua homologação final, segmentada por órgão?
-- ============================================================

SELECT
    o.nome_orgao,

    COUNT(f.dias_ciclo) AS quantidade_itens_com_ciclo,

    ROUND(AVG(f.dias_ciclo), 1) AS tempo_medio_ciclo_dias

FROM fato_item_contratado f

INNER JOIN dim_orgao o
    ON f.sk_orgao = o.sk_orgao

WHERE f.dias_ciclo IS NOT NULL

GROUP BY o.nome_orgao

HAVING COUNT(f.dias_ciclo) >= 5

ORDER BY tempo_medio_ciclo_dias DESC;


-- ============================================================
-- PERGUNTA 5: DISTRIBUIÇÃO REGIONAL
-- Quais estados e regiões concentram as maiores despesas e
-- quais apresentam os melhores indicadores de desconto?
-- ============================================================

SELECT
    l.regiao,
    l.uf_sigla,

    COUNT(*) AS quantidade_itens,

    SUM(f.valor_total_homologado) AS volume_homologado,

    SUM(
        CASE
            WHEN f.comparavel = 1 THEN f.valor_total_estimado
            ELSE 0
        END
    ) AS valor_estimado_comparavel,

    SUM(
        CASE
            WHEN f.comparavel = 1 THEN f.economia_valor
            ELSE 0
        END
    ) AS economia_nominal,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN f.comparavel = 1 THEN f.economia_valor
                ELSE 0
            END
        ) / NULLIF(
            SUM(
                CASE
                    WHEN f.comparavel = 1 THEN f.valor_total_estimado
                    ELSE 0
                END
            ),
            0
        ),
        2
    ) AS economia_percentual

FROM fato_item_contratado f

INNER JOIN dim_localidade l
    ON f.sk_localidade = l.sk_localidade

GROUP BY
    l.regiao,
    l.uf_sigla

ORDER BY volume_homologado DESC;


-- ============================================================
-- PERGUNTA 6: PERFIL DOS GASTOS
-- Como os recursos se distribuem entre bens, serviços e obras
-- e engenharia?
-- ============================================================

SELECT
    f.perfil_gasto,

    COUNT(*) AS quantidade_itens,

    SUM(f.valor_total_homologado) AS volume_homologado,

    ROUND(
        100.0 * SUM(f.valor_total_homologado) /
        NULLIF(
            (SELECT SUM(valor_total_homologado)
             FROM fato_item_contratado),
            0
        ),
        2
    ) AS participacao_volume_percentual

FROM fato_item_contratado f

GROUP BY f.perfil_gasto

ORDER BY volume_homologado DESC;


