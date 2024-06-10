---
-- Procedure
----
CALL LicenziaDipendenteOggi('BNCLRC85M01H501Z', 'Atti osceni in luogo di lavoro');
SELECT CF, Timestamp, Descrizione, DataLicenziamento FROM RegistroModificheRestauratore JOIN Restauratore ON CF = Restauratore
	WHERE Restauratore = 'BNCLRC85M01H501Z';
	
CALL RiassumiDipendenteOggi('BNCLRC85M01H501Z', 'Atti osceni in luogo di lavoro falsi');
SELECT CF, Timestamp, Descrizione, DataLicenziamento FROM RegistroModificheRestauratore JOIN Restauratore ON CF = Restauratore
	WHERE Restauratore = 'BNCLRC85M01H501Z';

---
-- Query
---

-- Mostre con informazioni sui curatori e numero di recensioni, prezzo medio dei biglietti venduti 
	-- e il numero di biglietti venduti per ciascuna mostra
	
SELECT MCR.Mostra, MCR.NomeCuratore, MCR.CognomeCuratore, MCR.NumeroRecensioni,
	   AVG(B.PrezzoTot) AS PrezzoMedioBiglietti, COUNT(B.NumeroSeriale) AS NumeroBigliettiVenduti
	FROM MostreCuratoriRecensioni MCR
	JOIN Biglietto B ON MCR.Mostra = B.Mostra
	GROUP BY MCR.Mostra, MCR.NomeCuratore, MCR.CognomeCuratore, MCR.NumeroRecensioni;
	
-- Restauratori con le loro operazioni di restauro, dettagli sugli eventi a cui
	-- hanno partecipato e numero totale di partecipazioni

SELECT RR.CF, RR.Nome, RR.Cognome, RR.NumeroRestauri, RR.UltimoRestauro, RR.NomeLaboratorio,
	   COUNT(PE.EventoData) AS NumeroPartecipazioni
	FROM RestauratoriRestauri RR
	LEFT JOIN PartecipazioneEventoRestauratore PE ON RR.CF = PE.Restauratore
	GROUP BY RR.CF, RR.Nome, RR.Cognome, RR.NumeroRestauri, RR.UltimoRestauro, RR.NomeLaboratorio;
	
-- Dettagli sui prestiti con informazioni aggiuntive sui curatori associati alle
	-- mostre delle opere in prestito
SELECT PD.ID, PD.TitoloOpera, PD.DataInizio, PD.DataFine, PD.NomeEnte, PD.TipoEnte,
	   PD.IndirizzoEnte, PD.NomeRegistrar, PD.CognomeRegistrar,
	   M.Nome AS NomeMostra, M.Prezzo AS PrezzoMostra,
	   C.Nome AS NomeCuratore, C.Cognome AS CognomeCuratore
	FROM PrestitiDettagliati PD
	LEFT JOIN Mostra M ON PD.TitoloOpera = M.Nome
	LEFT JOIN Curatore C ON M.Curatore = C.CF;

-- Biglietti venduti con dettagli dei visitatori, informazioni sui curatori delle
	-- mostre e voto medio delle mostre

SELECT BMV.NumeroSeriale, BMV.GiornoValidità, BMV.Audioguida, BMV.Sconto, 
	   BMV.PrezzoTot, BMV.NomeVisitatore, BMV.CognomeVisitatore,
	   M.Nome AS NomeMostra, M.Prezzo AS PrezzoMostra, M.VotoMedio,
	   C.Nome AS NomeCuratore, C.Cognome AS CognomeCuratore
	FROM BigliettiMostraVisitatore BMV
 	LEFT JOIN Mostra M ON BMV.NomeMostra = M.Nome
	LEFT JOIN Curatore C ON M.Curatore = C.CF;

--- 
-- Query senza l'uso di viste
---

-- Trovare tutti i laboratori situati in un certo piano con superficie maggiore di una
	-- determinata soglia

SELECT l.Specializzazione, l.Nome, p.Descrizione, p.Superficie
	FROM Laboratorio l
	JOIN Piano p ON l.Piano = p.Numero
	WHERE p.Superficie > 100; -- Soglia di esempio

-- Elenco di tutti i direttori e curatori con una retribuzione maggiore di un certo
	-- valore, ordinati per nome:

SELECT 'Direttore' AS Ruolo, d.Nome, d.Cognome, d.Telefono, d.Email, d.Retribuzione
	FROM Direttore d
	WHERE d.Retribuzione > 50000 -- Soglia di esempio
UNION ALL
	SELECT 'Curatore' AS Ruolo, c.Nome, c.Cognome, c.Telefono, c.Email, c.Retribuzione
	FROM Curatore c
	WHERE c.Retribuzione > 50000 -- Soglia di esempio
	ORDER BY Nome, Cognome;

-- Contare il numero di laboratori per ogni piano

SELECT p.Numero, p.Descrizione, COUNT(l.Specializzazione) AS NumeroLaboratori
	FROM Piano p
	LEFT JOIN Laboratorio l ON p.Numero = l.Piano
	GROUP BY p.Numero, p.Descrizione;