-- TriggerNoEventoDuranteMostra
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
BEFORE INSERT ON Evento
FOR EACH ROW
EXECUTE FUNCTION trigger_no_evento_durante_mostra();

-- TriggerNoOperaInRestauroInMostra
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
BEFORE INSERT ON OperaInterna
FOR EACH ROW
EXECUTE FUNCTION trigger_no_opera_in_restauro_in_mostra();

-- TriggerNoMostreTemporaneeSovrapposte
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
BEFORE INSERT ON DisposizioneMostreTemporanee
FOR EACH ROW
EXECUTE FUNCTION trigger_no_mostre_temporanee_sovrapposte();

-- TriggerCheckRestauroOverlap
CREATE OR REPLACE FUNCTION trigger_check_restauro_overlap()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM Restauro R2
        WHERE R2.OperaID = NEW.OperaID
        AND R2.DataInizio < NEW.DataFine
        AND R2.DataFine > NEW.DataInizio
        AND R2.ID <> NEW.ID
    ) THEN
        RAISE EXCEPTION 'Sovrapposizione di periodi di restauro per la stessa opera.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TriggerCheckRestauroOverlap
BEFORE INSERT ON Restauro
FOR EACH ROW
EXECUTE FUNCTION trigger_check_restauro_overlap();

CREATE TRIGGER TriggerCheckRestauroOverlapUpdate
BEFORE UPDATE ON Restauro
FOR EACH ROW
EXECUTE FUNCTION trigger_check_restauro_overlap();

-- TriggerCheckRestauratoreSpecializzazione
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
BEFORE INSERT ON Restauro
FOR EACH ROW
EXECUTE FUNCTION trigger_check_restauratore_specializzazione();

CREATE TRIGGER TriggerCheckRestauratoreSpecializzazioneUpdate
BEFORE UPDATE ON Restauro
FOR EACH ROW
EXECUTE FUNCTION trigger_check_restauratore_specializzazione();

-- TriggerNoPrestitoSeInMostra
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
BEFORE INSERT ON Prestito
FOR EACH ROW
EXECUTE FUNCTION trigger_no_prestito_se_in_mostra();
