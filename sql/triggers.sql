-- Il Vincolo 4 è verificato tramite un check nella tabella "Piano"

-- Vincolo 5
-- Trigger che vieta la sovrapposizione tra un evento e una mostra in una stessa sala e periodo temporale
CREATE OR REPLACE FUNCTION trigger_no_evento_durante_mostra()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM DisposizioneMostreTemporanee DMT
        JOIN MostraTemporanea MT ON DMT.ID_MostraTemporanea = MT.ID
        WHERE DMT.Sala = NEW.Sala
        AND NEW.Data BETWEEN MT.DataInizio AND MT.DataFine
    ) THEN
        RAISE EXCEPTION 'La sala è già occupata da una mostra temporanea in questo periodo.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerNoEventoDuranteMostra
BEFORE INSERT OR UPDATE ON Evento
FOR EACH ROW
EXECUTE FUNCTION trigger_no_evento_durante_mostra();

-- Vincolo 5 & 15
-- Trigger per verificare la sovrapposizione di mostre temporanee e eventi nella stessa sala e periodo temporale
-- Trigger per verificare la presenza di mostre temporanee uguali nello stesso periodo temporale
CREATE OR REPLACE FUNCTION trigger_no_sovrapposizione_mostre_ed_eventi()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica sovrapposizione mostre temporanee con lo stesso nome
    IF EXISTS (
        SELECT 1
        FROM MostraTemporanea
        WHERE Nome = NEW.Nome
        AND (
            (NEW.DataInizio >= DataInizio AND NEW.DataInizio < DataFine) OR
            (NEW.DataFine > DataInizio AND NEW.DataFine <= DataFine) OR
            (NEW.DataInizio <= DataInizio AND NEW.DataFine >= DataFine)
        )
    ) THEN
        RAISE EXCEPTION 'È già presente una mostra temporanea con lo stesso nome in questo periodo temporale.';
    END IF;

    -- Verifica sovrapposizione con eventi nella stessa sala
    IF EXISTS (
        SELECT 1
        FROM Evento E
        WHERE E.Sala = NEW.Sala
        AND NEW.DataInizio <= E.Data
        AND NEW.DataFine >= E.Data
    ) THEN
        RAISE EXCEPTION 'La mostra temporanea non può essere aggiunta perché si sovrappone ad un evento già programmato nella sala.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerNoSovrapposizioneMostreEdEventi
BEFORE INSERT OR UPDATE ON MostraTemporanea
FOR EACH ROW
EXECUTE FUNCTION trigger_no_sovrapposizione_mostre_ed_eventi();

-- Vincolo 14
-- Trigger che vieta la sovrapposizione di più mostre temporanee nella stessa sala nello stesso periodo temporale
CREATE OR REPLACE FUNCTION trigger_no_mostre_temporanee_sovrapposte()
RETURNS TRIGGER AS $$
DECLARE
    dataInizio DATE;
    dataFine DATE;
	tipoSala BOOLEAN;
BEGIN
    SELECT DataInizio, DataFine INTO dataInizio, dataFine
    FROM MostraTemporanea
    WHERE ID = NEW.ID_MostraTemporanea;

    SELECT Tipo INTO tipoSala
    FROM Sala
    WHERE ID = NEW.Sala;

    IF tipoSala = 1 THEN
        RAISE EXCEPTION 'Impossibile esporre una mostra temporanea in una sala permanente.';
    END IF;
	
    IF EXISTS (
        SELECT 1 
        FROM DisposizioneMostreTemporanee DMT
        JOIN MostraTemporanea MT ON DMT.ID_MostraTemporanea = MT.ID
		WHERE MT.ID <> NEW.ID_MostraTemporanea -- considera solo le disposizioni di altre mostre temporanee
        AND DMT.Sala = NEW.Sala AND dataInizio < MT.DataFine AND dataFine > MT.DataInizio
    ) THEN
        RAISE EXCEPTION 'La sala è già occupata da un''altra mostra temporanea in questo periodo.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerNoMostreTemporaneeSovrapposte
BEFORE INSERT OR UPDATE ON DisposizioneMostreTemporanee
FOR EACH ROW
EXECUTE FUNCTION trigger_no_mostre_temporanee_sovrapposte();

-- Vincolo 6 & 7 & 9
-- Trigger che vieta che le date di un restauro si sovrappongano ad altri restauri
-- Inoltre, se è presente un opera attualmente in restauro, non si possono inserire/modificare 
     -- restauri che iniziano o finiscono successivamente al restauro attuale
-- Trigger che verifica la specializzazione di un restauratore che vuole restaurare un opera
-- Trigger che gestisce la mostra temporanea (rimozione e reinserimento automatico) dell'opera in restauro
-- Aggiornamento del dato derivato "DataUltimoRestauro" in "OperaInterna"
CREATE OR REPLACE FUNCTION trigger_no_sovrapposizione_e_specializzazione_restauro()
RETURNS TRIGGER AS $$
DECLARE
    mostra_precedente TEXT;
	data_ultimo_restauro DATE;
BEGIN
    -- Verifica sovrapposizione con altri restauri
    IF EXISTS (
        SELECT 1
        FROM Restauro R2
        WHERE R2.OperaID = NEW.OperaID
        AND R2.ID <> NEW.ID
        AND (
            (R2.DataFine IS NULL AND (NEW.DataInizio >= R2.DataInizio OR NEW.DataFine >= R2.DataInizio OR New.DataFine IS NULL)) OR
            (NEW.DataInizio < R2.DataFine AND NEW.DataFine > R2.DataInizio)
        )
    ) THEN
        RAISE EXCEPTION 'Le date di restauro si sovrappongono con un altro restauro esistente.';
    END IF;

    -- Verifica la specializzazione del restauratore
    IF NOT EXISTS (
        SELECT 1
        FROM Restauratore
        WHERE Restauratore.ID = NEW.RestauratoreID
        AND Restauratore.Specializzazione = (
            SELECT Specializzazione FROM OperaInterna WHERE ID = NEW.OperaID
        )
    ) THEN
        RAISE EXCEPTION 'Il restauratore non è specializzato nell''opera da restaurare.';
    END IF;
	
	-- Nel caso in cui tutto vada bene, l'opera deve essere rimossa in automatico dalla mostra in cui è esposta
	-- Memorizza la mostra a cui apparteneva l'opera se DataFine è NULL
    IF NEW.DataFine IS NULL THEN
        UPDATE Restauro
        SET MostraPrecedente = (
            SELECT Mostra
            FROM OperaInterna
            WHERE ID = NEW.OperaID
        )
        WHERE ID = NEW.ID;
        
        -- Rimuove l'opera dalla mostra
        UPDATE OperaInterna
        SET Mostra = NULL
        WHERE ID = NEW.OperaID;
    ELSE
	    -- Ottieni la data di fine massima per l'opera
        SELECT MAX(DataFine) INTO data_ultimo_restauro
        FROM Restauro
        WHERE OperaID = NEW.OperaID;

		IF (NEW.DataFine > data_ultimo_restauro) THEN
			-- Aggiorna l'attributo DataUltimoRestauro nell'entità OperaInterna
			UPDATE OperaInterna
			SET DataUltimoRestauro = NEW.DataFine
			WHERE ID = NEW.OperaID;
		END IF;
		
        -- Reinserisce l'opera nella mostra precedente se DataFine non è NULL e MostraPrecedente non è NULL
        mostra_precedente := (SELECT MostraPrecedente FROM Restauro WHERE ID = NEW.ID);

        IF mostra_precedente IS NOT NULL THEN
            UPDATE OperaInterna
            SET Mostra = mostra_precedente
            WHERE ID = NEW.OperaID;
            
            -- Rimuove la mostra precedente dal restauro
            UPDATE Restauro
            SET MostraPrecedente = NULL
            WHERE ID = NEW.ID;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerNoSovrapposizioneESpecializzazioneRestauro
BEFORE INSERT OR UPDATE ON Restauro
FOR EACH ROW
EXECUTE FUNCTION trigger_no_sovrapposizione_e_specializzazione_restauro();

-- Vincolo 8
-- Trigger che vieta l'inserimento di un opera interna in una mostra se l'opera è in restauro
-- Trigger che vieta l'inserimento di un opera interna in una mostra se la mostra non è permanente
CREATE OR REPLACE FUNCTION trigger_no_opera_in_restauro_in_mostra()
RETURNS TRIGGER AS $$
BEGIN
	-- Verifica se l'opera è esposta in una mostra non permanente (Tipo != 1)
	IF NEW.Mostra IS NOT NULL AND EXISTS (
		SELECT 1
		FROM Mostra
		WHERE ID = NEW.Mostra
		AND Tipo != 1
	) THEN
		RAISE EXCEPTION 'L''opera può essere esposta solo in mostre permanenti.';
	END IF;
	
	-- Verifica se l'opera è in restauro attualmente
    IF EXISTS (
        SELECT 1
        FROM Restauro
        WHERE OperaID = NEW.ID
        AND DataFine IS NULL
    ) THEN
        RAISE EXCEPTION 'L''opera è attualmente in restauro e non può essere esposta in una mostra.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerNoOperaInRestauroInMostra
BEFORE INSERT OR UPDATE ON OperaInterna
FOR EACH ROW
EXECUTE FUNCTION trigger_no_opera_in_restauro_in_mostra();

-- Vincolo 10
-- Trigger per verificare la specializzazione del restauratore assegnato ad un laboratorio
CREATE OR REPLACE FUNCTION trigger_check_specializzazione_restauratore()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se il restauratore ha la specializzazione richiesta per il laboratorio
    IF NOT EXISTS (
        SELECT 1
        FROM Restauratore R
        WHERE R.CF = NEW.CF
        AND R.Specializzazione = NEW.Laboratorio
    ) THEN
        RAISE EXCEPTION 'Il restauratore non ha la specializzazione richiesta per il laboratorio.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerCheckSpecializzazioneRestauratore
BEFORE INSERT OR UPDATE ON Restauratore
FOR EACH ROW
EXECUTE FUNCTION trigger_check_specializzazione_restauratore();

-- Il Vincolo 13 è verificato tramite un check nella tabella "Recensione"

-- Vincolo 16
-- Trigger per verificare la coincidenza dei periodi di prestito e mostra temporanea
CREATE OR REPLACE FUNCTION trigger_verifica_coincidenza_periodi()
RETURNS TRIGGER AS $$
DECLARE
    data_inizio_mostra_temporanea DATE;
    data_fine_mostra_temporanea DATE;
BEGIN
    -- Ottenere le date di inizio e fine della mostra temporanea associata all'opera esterna
    SELECT DataInizio, DataFine INTO 
        data_inizio_mostra_temporanea, data_fine_mostra_temporanea
    FROM MostraTemporanea
    WHERE ID = NEW.ID_MostraTemporanea;

    -- Verifica se l'opera esterna ha un periodo di prestito che non coincide con il periodo di svolgimento della mostra temporanea
    IF EXISTS (
        SELECT 1
        FROM Prestito P
        WHERE P.ID_OperaEsterna = NEW.ID_OperaEsterna
        AND (
            (data_inizio_mostra_temporanea > P.DataFine) OR
            (data_fine_mostra_temporanea < P.DataInizio)
        )
    ) THEN
        RAISE EXCEPTION 'Il periodo di prestito dell''opera esterna non coincide con il periodo di svolgimento della mostra temporanea.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerVerificaCoincidenzaPeriodi
BEFORE INSERT OR UPDATE ON ComposizioneMostreTemporanee
FOR EACH ROW
EXECUTE FUNCTION trigger_verifica_coincidenza_periodi();

-- Per le opere esterne sappiamo già che non possono essere esposte in mostre permanenti perchè vengono inserite
     -- nella tabella "ComposizioneMostreTemporanee" che sfruttano un ID univoco delle mostre temporanee
-- Vincolo 11 & 12 & 17 & 18
-- Trigger per verificare se un'opera esterna o interna è già in prestito durante un certo periodo
-- Trigger per verificare se l'opera è in mostra permanente o in restauro
CREATE OR REPLACE FUNCTION trigger_verifica_prestito_conflitto_e_stato()
RETURNS TRIGGER AS $$
BEGIN
    -- Controlla se esiste già un prestito per l'opera interna durante il periodo specificato
    IF NEW.ID_OperaInterna IS NOT NULL AND EXISTS (
        SELECT 1
        FROM Prestito
        WHERE ID_OperaInterna = NEW.ID_OperaInterna
        AND DataInizio <= NEW.DataFine
        AND DataFine >= NEW.DataInizio
    ) THEN
        RAISE EXCEPTION 'L''opera interna è già in prestito durante il periodo specificato.';
    END IF;

    -- Controlla se esiste già un prestito per l'opera esterna durante il periodo specificato
    IF NEW.ID_OperaEsterna IS NOT NULL AND EXISTS (
        SELECT 1
        FROM Prestito
        WHERE ID_OperaEsterna = NEW.ID_OperaEsterna
        AND DataInizio <= NEW.DataFine
        AND DataFine >= NEW.DataInizio
    ) THEN
        RAISE EXCEPTION 'L''opera esterna è già in prestito durante il periodo specificato.';
    END IF;

    -- Verifica se l'opera interna è esposta in una mostra permanente
    IF NEW.ID_OperaInterna IS NOT NULL AND EXISTS (
        SELECT 1
        FROM OperaInterna
        WHERE ID = NEW.ID_OperaInterna
        AND Mostra IS NOT NULL
    ) THEN
        RAISE EXCEPTION 'L''opera interna è attualmente esposta in una mostra permanente e non può essere prestata.';
    END IF;

    -- Verifica se l'opera interna è in restauro
    IF NEW.ID_OperaInterna IS NOT NULL AND EXISTS (
        SELECT 1
        FROM Restauro R
        WHERE R.OperaID = NEW.ID_OperaInterna
        AND R.DataFine IS NULL
    ) THEN
        RAISE EXCEPTION 'L''opera interna è attualmente in restauro e non può essere prestata.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerVerificaPrestitoConflittoEStato
BEFORE INSERT OR UPDATE ON Prestito
FOR EACH ROW
EXECUTE FUNCTION trigger_verifica_prestito_conflitto_e_stato();

-- Trigger per il controllo della corrispondenza del Tipo tra "Sala" e "Mostra"
CREATE OR REPLACE FUNCTION trigger_controllo_tipo_mostra_sala()
RETURNS TRIGGER AS $$
BEGIN
    -- Controllo se la Mostra è NULL, in tal caso non ci sono restrizioni
    IF NEW.Mostra IS NOT NULL THEN
        -- Ottengo il tipo della mostra
        DECLARE tipoMostra BOOLEAN;
        SELECT Tipo INTO tipoMostra FROM Mostra WHERE Nome = NEW.Mostra;

        -- Controllo se il tipo della mostra e il tipo della sala coincidono
        IF NEW.Tipo <> tipoMostra THEN
            RAISE EXCEPTION 'Impossibile aggiungere o modificare la mostra nella sala. Il tipo di mostra e il tipo di sala non coincidono.';
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerControlloTipoMostraSala
BEFORE INSERT OR UPDATE ON Sala
FOR EACH ROW
EXECUTE FUNCTION trigger_controllo_tipo_mostra_sala();
