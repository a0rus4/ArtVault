-- Vincolo 4
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

-- Vincolo 4
-- Trigger per vietare la sovrapposizione tra una mostra temporanea e un evento in una stessa sala e periodo temporale
CREATE OR REPLACE FUNCTION trigger_no_mostra_temporanea_durante_evento()
RETURNS TRIGGER AS $$
BEGIN
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

CREATE TRIGGER TriggerNoMostraTemporaneaDuranteEvento
BEFORE INSERT OR UPDATE ON MostraTemporanea
FOR EACH ROW
EXECUTE FUNCTION trigger_no_mostra_temporanea_durante_evento();

-- Vincolo 5
-- Vincolo 6
-- Trigger che vieta che le date di un restauro si sovrappongano ad altri restauri
-- Inoltre, se è presente un opera attualmente in restauro, non si possono inserire/modificare 
--     restauri che iniziano o finiscono successivamente al restauro attuale
CREATE OR REPLACE FUNCTION trigger_no_sovrapposizione_restauri()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica sovrapposizione con altri restauri
    IF EXISTS (
        SELECT 1
        FROM Restauro R2
        WHERE R2.OperaID = NEW.OperaID
        AND R2.ID <> NEW.ID
        AND (
			(R2.DataFine IS NULL AND (NEW.DataInizio >= R2.DataInizio OR NEW.DataFine >= R2.DataInizio)) OR
			(NEW.DataInizio < R2.DataFine AND NEW.DataFine > R2.DataInizio)
		)
    ) THEN
        RAISE EXCEPTION 'Le date di restauro si sovrappongono con un altro restauro esistente.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerNoSovrapposizioneRestauri
BEFORE INSERT OR UPDATE ON Restauro
FOR EACH ROW
EXECUTE FUNCTION trigger_no_sovrapposizione_restauri();

-- Vincolo 7
-- Trigger che vieta l'inserimento di un opera in una mostra se l'opera è in restauro
CREATE OR REPLACE FUNCTION trigger_no_opera_in_restauro_in_mostra()
RETURNS TRIGGER AS $$
BEGIN
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

-- Vincolo 8
-- Trigger che verifica la specializzazione di un restauratore che vuole restaurare un opera
CREATE OR REPLACE FUNCTION trigger_check_restauratore_specializzazione()
RETURNS TRIGGER AS $$
BEGIN
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
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerCheckRestauratoreSpecializzazione
BEFORE INSERT OR UPDATE ON Restauro
FOR EACH ROW
EXECUTE FUNCTION trigger_check_restauratore_specializzazione();

-- Vincolo 9
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

-- Vincolo 10
-- Trigger che vieta il prestito di un'opera interna se è esposta in una mostra permanente
CREATE OR REPLACE FUNCTION trigger_no_prestito_se_in_mostra()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM OperaInterna
        WHERE ID = NEW.ID_OperaInterna
        AND Mostra IS NOT NULL
    ) THEN
        RAISE EXCEPTION 'L''opera è attualmente esposta in una mostra permanente e non può essere prestata.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerNoPrestitoSeInMostra
BEFORE INSERT OR UPDATE ON Prestito
FOR EACH ROW
EXECUTE FUNCTION trigger_no_prestito_se_in_mostra();

-- Vincolo 11
-- Trigger per impedire il prestito di un'opera interna in restauro
CREATE OR REPLACE FUNCTION trigger_no_prestito_opera_in_restauro()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se l'opera interna è attualmente in restauro (DataFine IS NULL)
    IF EXISTS (
        SELECT 1
        FROM Restauro R
        WHERE R.OperaID = NEW.ID_OperaInterna
        AND R.DataFine IS NULL
    ) THEN
        RAISE EXCEPTION 'L''opera è attualmente in restauro e non può essere prestata.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger per impedire il prestito di un'opera in restauro
CREATE TRIGGER TriggerNoPrestitoOperaInRestauro
BEFORE INSERT OR UPDATE ON Prestito
FOR EACH ROW
EXECUTE FUNCTION trigger_no_prestito_opera_in_restauro();

-- Il Vincolo 12 è verificato tramite un check nella tabella "Recensione"

-- Vincolo 13
-- Trigger che vieta la sovrapposizione di più mostre temporanee nella stessa sala nello stesso periodo temporale
CREATE OR REPLACE FUNCTION trigger_no_mostre_temporanee_sovrapposte()
RETURNS TRIGGER AS $$
DECLARE
    dataInizio DATE;
    dataFine DATE;
BEGIN
    SELECT DataInizio, DataFine INTO dataInizio, dataFine
    FROM MostraTemporanea
    WHERE ID = NEW.ID_MostraTemporanea;

    IF EXISTS (
        SELECT 1 
        FROM DisposizioneMostreTemporanee DMT
        JOIN MostraTemporanea MT ON DMT.ID_MostraTemporanea = MT.ID
        WHERE DMT.Sala = NEW.Sala
        AND dataInizio < MT.DataFine
        AND dataFine > MT.DataInizio
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

-- Vincolo 14
-- Trigger per verificare la presenza di mostre temporanee uguali nello stesso periodo temporale
CREATE OR REPLACE FUNCTION trigger_no_sovrapposizione_mostre_temporanee()
RETURNS TRIGGER AS $$
DECLARE
    data_inizio_other DATE;
    data_fine_other DATE;
BEGIN
    -- Verifica se esiste già una mostra temporanea con lo stesso nome e periodi sovrapposti
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

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerNoSovrapposizioneMostreTemporanee
BEFORE INSERT OR UPDATE ON MostraTemporanea
FOR EACH ROW
EXECUTE FUNCTION trigger_no_sovrapposizione_mostre_temporanee();

-- Vincolo 15
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

-- Vincolo 16 & 17
-- Trigger per verificare se un'opera esterna o interna è già in prestito durante un certo periodo
CREATE OR REPLACE FUNCTION trigger_verifica_prestito_conflitto()
RETURNS TRIGGER AS $$
BEGIN
    -- Controlla se esiste già un prestito per l'opera interna durante il periodo specificato
    IF EXISTS (
        SELECT 1
        FROM Prestito
        WHERE ID_OperaInterna = NEW.ID_OperaInterna
        AND DataInizio <= NEW.DataFine
        AND DataFine >= NEW.DataInizio
    ) THEN
        RAISE EXCEPTION 'L''opera è già in prestito durante il periodo specificato.';
    END IF;

    -- Controlla se esiste già un prestito per l'opera esterna durante il periodo specificato
    IF EXISTS (
        SELECT 1
        FROM Prestito
        WHERE ID_OperaEsterna = NEW.ID_OperaEsterna
        AND DataInizio <= NEW.DataFine
        AND DataFine >= NEW.DataInizio
    ) THEN
        RAISE EXCEPTION 'L''opera esterna è già in prestito durante il periodo specificato.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger per verificare se un'opera interna o esterna è già in prestito durante un certo periodo
CREATE TRIGGER TriggerVerificaPrestitoConflitto
BEFORE INSERT OR UPDATE ON Prestito
FOR EACH ROW
EXECUTE FUNCTION trigger_verifica_prestito_conflitto();
