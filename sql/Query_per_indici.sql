--Indice idx_operaE_codice su operaesterna (id)
-- Ricerca di un'opera esterna per ID (chiave primaria)

EXPLAIN ANALYZE
SELECT * FROM operaesterna
WHERE id = 1;

--Indice idx_operaE_autore su operaesterna (id_artista)
-- Ricerca di tutte le opere esterne di un determinato artista
EXPLAIN ANALYZE
SELECT * FROM operaesterna
WHERE id_artista = 1;

--Indice idx_operaE_data_produzione su operaesterna USING HASH (AnnoProduzione)
-- Ricerca di tutte le opere esterne prodotte in un anno specifico
EXPLAIN ANALYZE
SELECT * FROM operaesterna
WHERE AnnoProduzione = 1830;


--Indice idx_Direttore_cf su Direttore USING HASH (cf)
-- Ricerca di un direttore tramite il codice fiscale
EXPLAIN ANALYZE
SELECT * FROM Direttore
WHERE cf = 'RSSMRA85M01H501Z';

--Indice idx_Direttore_email su Direttore USING HASH (email)
-- Ricerca di un direttore tramite l'email
EXPLAIN ANALYZE
SELECT * FROM Direttore
WHERE email = 'gerardo.martini@example.com';

--Indice idx_curatore_cf su curatore USING HASH (cf)
-- Ricerca di un curatore tramite il codice fiscale
EXPLAIN ANALYZE
SELECT * FROM curatore
WHERE cf = 'VRDLRS75A41H501Z';

--Indice idx_curatore_email su curatore USING HASH (email)
-- Ricerca di un curatore tramite l'email
EXPLAIN ANALYZE
SELECT * FROM curatore
WHERE email = 'giustina.blu@example.com';

--Indice idx_Restauratore_cf su Restauratore USING HASH (cf)
-- Ricerca di un restauratore tramite il codice fiscale
EXPLAIN ANALYZE
SELECT * FROM Restauratore
WHERE cf = 'BLNGSR90M20H501Z';

-- Indice idx_Restauratore_email su Restauratore USING HASH (email)
-- Ricerca di un restauratore tramite l'email
EXPLAIN ANALYZE
SELECT * FROM Restauratore
WHERE email = 'roberto.rossi@example.com';

--Indice idx_Registrar_cf su Registrar USING HASH (cf)
-- Ricerca di un registrar tramite il codice fiscale
EXPLAIN ANALYZE
SELECT * FROM Registrar
WHERE cf = 'GRNPLS65D05H501Z';

-- Indice idx_Registrar_email su Registrar USING HASH (email)
-- Ricerca di un registrar tramite l'email
EXPLAIN ANALYZE
SELECT * FROM Registrar
WHERE email = 'luca.rossi@example.com';
