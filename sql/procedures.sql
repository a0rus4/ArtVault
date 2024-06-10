-- Procedura che crea una mostra temporanea (nome, periodo, sale e opere)
CREATE OR REPLACE PROCEDURE CreaMostraTemporanea(
    IN p_NomeMostra VARCHAR(255),
    IN p_DescrizioneMostra TEXT,
    IN p_DataInizio DATE,
    IN p_DataFine DATE,
	IN p_Sale INT [],
    IN p_DescrizioneSala VARCHAR(255),
    IN p_Opere INT[]
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_MostraID INT;
	v_Sala INT;
	v_OperaID INT;
	i INT;
BEGIN
    -- Inserimento dei dati nella tabella "Mostra"
    INSERT INTO Mostra (Nome, Descrizione, Tipo)
    VALUES (p_NomeMostra, p_DescrizioneMostra, '0'); -- 0 perchè è temporanea

    -- Inserimento dei dati nella tabella "MostraTemporanea"
    INSERT INTO MostraTemporanea (Nome, DataInizio, DataFine)
    VALUES (p_NomeMostra, p_DataInizio, p_DataFine)
	RETURNING ID INTO v_MostraID;

    -- Inserimento dei dati nella tabella "DisposizioneMostreTemporanee"
    FOR i IN 1 .. array_length(v_Sala, 1)
	LOOP
		v_Sala := p_Sale[i];
		INSERT INTO DisposizioneMostreTemporanee (ID_MostraTemporanea, Sala)
    	VALUES (v_MostraID, v_Sala);
	END LOOP;

    -- Inserimento dei dati nella tabella "ComposizioneMostreTemporanee" per ogni opera nell'array
    FOR i IN 1 .. array_length(v_OperaID, 1)
    LOOP
		v_OperaID := p_Opere[i];
        INSERT INTO ComposizioneMostreTemporanee (ID_MostraTemporanea, ID_OperaEsterna)
        VALUES (v_MostraID, v_OperaID);
    END LOOP;
END;
$$;

-- Procedura per l'aggiunta di un biglietto col calcolo automatico del prezzo totale
CREATE OR REPLACE PROCEDURE InserisciBiglietto(
    IN p_numero_seriale INT,
    IN p_giorno_validita DATE,
    IN p_audioguida BOOLEAN,
    IN p_sconto INT,
    IN p_visitatore VARCHAR(255),
    IN p_mostra VARCHAR(255)
)
AS $$
DECLARE
    v_prezzo_mostra DECIMAL(5,2);
    v_prezzo_totale DECIMAL(5,2);
BEGIN
    -- Ottieni il prezzo della mostra
    SELECT Prezzo INTO v_prezzo_mostra
    FROM Mostra
    WHERE Nome = p_mostra;

    -- Calcola lo sconto sul prezzo della mostra
    v_prezzo_totale := v_prezzo_mostra - (v_prezzo_mostra * (p_sconto / 100));

    -- Aggiungi il sovraprezzo dell'audioguida se è richiesta
    IF p_audioguida THEN
        v_prezzo_totale := v_prezzo_totale + 5.00; -- Supponiamo un sovraprezzo di 5 euro per l'audioguida
    END IF;

    -- Inserisci il biglietto nella tabella Biglietto
    INSERT INTO Biglietto(NumeroSeriale, GiornoValidità, Audioguida, Sconto, PrezzoTot, Visitatore, Mostra)
    VALUES (p_numero_seriale, p_giorno_validita, p_audioguida, p_sconto, v_prezzo_totale, p_visitatore, p_mostra);

    -- Visualizza un messaggio di successo
    RAISE NOTICE 'Biglietto inserito con successo con prezzo totale: %.2f', v_prezzo_totale;
END;
$$ LANGUAGE plpgsql;

-- Procedura per licenziare un dipendente
CREATE OR REPLACE PROCEDURE LicenziaDipendenteOggi(
    IN p_CF VARCHAR(16),
	IN p_descrizione TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
     v_CF_direttore_attuale VARCHAR(16);
	 v_ruolo VARCHAR(30);
	 v_query TEXT;
BEGIN
	-- Prende il direttore attuale
	SELECT CF INTO v_CF_direttore_attuale FROM Direttore WHERE DataLicenziamento IS NULL;
	
	-- Prendiamo il ruolo del dipendente tramite la vista "Dipendenti"
	SELECT Ruolo INTO v_ruolo FROM Dipendenti WHERE CF = p_CF;
	
	-- Eseguiamo query su una tabella che dipende dal nome del dipendente
	v_query = CONCAT('UPDATE ', v_ruolo, ' SET DataLicenziamento = ''', CURRENT_DATE, ''' WHERE CF = ''', p_CF, ''';');
	EXECUTE v_query;
	
	v_ruolo := 'RegistroModifiche' || v_ruolo;
	v_query = CONCAT('INSERT INTO ', v_ruolo, ' VALUES (''', CURRENT_TIMESTAMP, ' '', ''', 
					 p_descrizione, ''', ''', p_CF, ''', ''', v_CF_direttore_attuale, ''');');
	EXECUTE v_query;
	
END;
$$;

-- Procedura per riassumere un dipendente
CREATE OR REPLACE PROCEDURE RiassumiDipendenteOggi(
    IN p_CF VARCHAR(16),
	IN p_descrizione TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
     v_CF_direttore_attuale VARCHAR(16);
	 v_ruolo VARCHAR(30);
	 v_query TEXT;
BEGIN
	-- Prende il direttore attuale
	SELECT CF INTO v_CF_direttore_attuale FROM Direttore WHERE DataLicenziamento IS NULL;
	
	-- Prendiamo il ruolo del dipendente tramite la vista "Dipendenti"
	SELECT Ruolo INTO v_ruolo FROM Dipendenti WHERE CF = p_CF;
	
	-- Eseguiamo query su una tabella che dipende dal nome del dipendente
	v_query = CONCAT('UPDATE ', v_ruolo, ' SET DataLicenziamento = NULL, DataAssunzione = ''', 
					 CURRENT_DATE, ''' WHERE CF = ''', p_CF, ''';');
	EXECUTE v_query;
	
	v_ruolo := 'RegistroModifiche' || v_ruolo;
	v_query = CONCAT('INSERT INTO ', v_ruolo, ' VALUES (''', CURRENT_TIMESTAMP, ' '', ''', 
					 p_descrizione, ''', ''', p_CF, ''', ''', v_CF_direttore_attuale, ''');');
	EXECUTE v_query;
	
END;
$$;

