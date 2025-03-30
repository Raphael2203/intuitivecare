--10 operadoras com maiores despesas no último trimestre

SELECT 
    ops.nome_fantasia AS operadora,
    SUM(dc.vl_saldo_final) AS total_despesas
FROM 
    demonstracoes_contabeis dc
JOIN 
    operadoras_plano_saude ops ON dc.reg_ans = ops.registro_ans
WHERE 
    dc.descricao = 'EVENTOS/SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR'
    AND dc.data BETWEEN DATE_SUB(LAST_DAY(CURDATE()), INTERVAL 3 MONTH) + INTERVAL 1 DAY
    AND LAST_DAY(CURDATE())
GROUP BY 
    ops.nome_fantasia
ORDER BY 
    total_despesas DESC
LIMIT 10;

--10 operadoras com maiores despesas no último ano

SELECT 
    ops.nome_fantasia AS operadora,
    SUM(dc.vl_saldo_final) AS total_despesas
FROM 
    demonstracoes_contabeis dc
JOIN 
    operadoras_plano_saude ops ON dc.reg_ans = ops.registro_ans
WHERE 
    dc.descricao = 'EVENTOS/SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR'
    AND dc.data BETWEEN DATE_SUB(LAST_DAY(CURDATE()), INTERVAL 12 MONTH) + INTERVAL 1 DAY
    AND LAST_DAY(CURDATE())
GROUP BY 
    ops.nome_fantasia
ORDER BY 
    total_despesas DESC
LIMIT 10;