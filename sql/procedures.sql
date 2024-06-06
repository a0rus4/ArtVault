-- Procedura che crea una mostra temporanea (nome, periodo, sala e opere)
CREATE OR REPLACE PROCEDURE CreaMostraTemporanea(
    IN p_NomeMostra VARCHAR(255),
    IN p_DescrizioneMostra TEXT,
    IN p_DataInizio DATE,
    IN p_DataFine DATE,
	IN p_Sala INT,
    IN p_DescrizioneSala VARCHAR(255),
    IN p_Opere INT[]
)
LANGUAGE SQL
AS $$
DECLARE
    v_MostraID INT;
BEGIN
    -- Inserimento dei dati nella tabella "Mostra"
    INSERT INTO Mostra (Nome, Descrizione, Tipo)
    VALUES (p_NomeMostra, p_DescrizioneMostra, '0'); -- 0 perchè è temporanea

    -- Inserimento dei dati nella tabella "MostraTemporanea"
    INSERT INTO MostraTemporanea (Nome, DataInizio, DataFine)
    VALUES (p_NomeMostra, p_DataInizio, p_DataFine),
	RETURNING ID INTO v_MostraID;

    -- Inserimento dei dati nella tabella "DisposizioneMostreTemporanee"
    INSERT INTO DisposizioneMostreTemporanee (ID_MostraTemporanea, Sala)
    VALUES (v_MostraID, p_Sala);

    -- Inserimento dei dati nella tabella "ComposizioneMostreTemporanee" per ogni opera nell'array
    FOREACH v_OperaID IN ARRAY p_Opere
    LOOP
        INSERT INTO ComposizioneMostreTemporanee (ID_MostraTemporanea, ID_OperaEsterna)
        VALUES (v_MostraID, v_OperaID);
    END LOOP;
END;
$$;

-- 
