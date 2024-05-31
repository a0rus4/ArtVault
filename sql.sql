CREATE TABLE Piano (
    Numero INT PRIMARY KEY,
    Descrizione VARCHAR(255),
    Superficie DECIMAL(10,2)
);

CREATE TABLE Laboratorio (
    Specializzazione VARCHAR(255) PRIMARY KEY,
    Piano INT,
    Nome VARCHAR(255),
    FOREIGN KEY (Piano) REFERENCES Piano(Numero)
);

CREATE TABLE Direttore (
    CF CHAR(16) PRIMARY KEY,
    Nome VARCHAR(255),
    Cognome VARCHAR(255),
    Telefono VARCHAR(20),
    Email VARCHAR(255),
    Retribuzione DECIMAL(10,2),
    Qualifica VARCHAR(255),
    DataAssunzione DATE,
    DataLicenziamento DATE,
    CHECK (DataLicenziamento IS NULL OR DataAssunzione < DataLicenziamento)
);

CREATE TABLE Curatore (
    CF CHAR(16) PRIMARY KEY,
    Nome VARCHAR(255),
    Cognome VARCHAR(255),
    Telefono VARCHAR(20),
    Email VARCHAR(255),
    Retribuzione DECIMAL(10,2),
    Qualifica VARCHAR(255),
    DataAssunzione DATE,
    DataLicenziamento DATE,
    CHECK (DataLicenziamento IS NULL OR DataAssunzione < DataLicenziamento)
);

CREATE TABLE Restauratore (
    CF CHAR(16) PRIMARY KEY,
    Nome VARCHAR(255),
    Cognome VARCHAR(255),
    Telefono VARCHAR(20),
    Email VARCHAR(255),
    Retribuzione DECIMAL(10,2),
    Qualifica VARCHAR(255),
    Specializzazione VARCHAR(255),
    Laboratorio VARCHAR(255),
    NumeroRestauri INT,
    DataAssunzione DATE,
    DataLicenziamento DATE,
    FOREIGN KEY (Laboratorio) REFERENCES Laboratorio(Specializzazione),
    CHECK (DataLicenziamento IS NULL OR DataAssunzione < DataLicenziamento)
);

CREATE TABLE Registrar (
    CF CHAR(16) PRIMARY KEY,
    Nome VARCHAR(255),
    Cognome VARCHAR(255),
    Telefono VARCHAR(20),
    Email VARCHAR(255),
    Retribuzione DECIMAL(10,2),
    Qualifica VARCHAR(255),
    DataAssunzione DATE,
    DataLicenziamento DATE,
    CHECK (DataLicenziamento IS NULL OR DataAssunzione < DataLicenziamento)
);

CREATE TABLE Mostra (
    Nome VARCHAR(255) PRIMARY KEY,
    Prezzo DECIMAL(10,2),
    Descrizione TEXT,
    VotoMedio DECIMAL(3,2),
    Tipo VARCHAR(255),
    Curatore CHAR(16),
    FOREIGN KEY (Curatore) REFERENCES Curatore(CF)
);

CREATE TABLE MostraTemporanea (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    DataInizio DATE,
    DataFine DATE,
    FOREIGN KEY (Nome) REFERENCES Mostra(Nome),
    CHECK (DataInizio < DataFine)
);

CREATE TABLE Artista (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    Cognome VARCHAR(255),
    Biografia TEXT
);

CREATE TABLE OperaInterna (
    ID SERIAL PRIMARY KEY,
    Mostra VARCHAR(255),
    Titolo VARCHAR(255),
    DataProduzione DATE,
    Provenienza VARCHAR(255),
    Tipo VARCHAR(255),
    ID_Artista INT,
    Specializzazione VARCHAR(255),
    DataUltimoRestauro DATE,
    FOREIGN KEY (Mostra) REFERENCES Mostra(Nome),
    FOREIGN KEY (ID_Artista) REFERENCES Artista(ID)
);

CREATE TABLE OperaEsterna (
    ID SERIAL PRIMARY KEY,
    Titolo VARCHAR(255),
    DataProduzione DATE,
    Provenienza VARCHAR(255),
    Tipo VARCHAR(255),
    ID_Artista INT,
    FOREIGN KEY (ID_Artista) REFERENCES Artista(ID)
);

CREATE TABLE Sala (
    ID SERIAL PRIMARY KEY,
    Piano INT,
    Capienza INT,
    Tipo VARCHAR(255),
    Mostra VARCHAR(255),
    FOREIGN KEY (Piano) REFERENCES Piano(Numero),
    FOREIGN KEY (Mostra) REFERENCES Mostra(Nome)
);

CREATE TABLE DisposizioneMostreTemporanee (
    ID_MostraTemporanea INT,
    Sala INT,
    PRIMARY KEY (ID_MostraTemporanea, Sala),
    FOREIGN KEY (ID_MostraTemporanea) REFERENCES MostraTemporanea(ID),
    FOREIGN KEY (Sala) REFERENCES Sala(ID)
);

CREATE TABLE ComposizioneMostreTemporanee (
    ID_MostraTemporanea INT,
    ID_OperaEsterna INT,
    PRIMARY KEY (ID_MostraTemporanea, ID_OperaEsterna),
    FOREIGN KEY (ID_MostraTemporanea) REFERENCES MostraTemporanea(ID),
    FOREIGN KEY (ID_OperaEsterna) REFERENCES OperaEsterna(ID)
);

CREATE TABLE Evento (
    Sala INT,
    Data DATE,
    Nome VARCHAR(255),
    Descrizione TEXT,
    PRIMARY KEY (Sala, Data),
    FOREIGN KEY (Sala) REFERENCES Sala(ID)
);

CREATE TABLE PartecipazioneEventoCuratore (
    EventoSala INT,
    EventoData DATE,
    Curatore CHAR(16),
    PRIMARY KEY (EventoSala, EventoData, Curatore),
    FOREIGN KEY (EventoSala, EventoData) REFERENCES Evento(Sala, Data),
    FOREIGN KEY (Curatore) REFERENCES Curatore(CF)
);

CREATE TABLE PartecipazioneEventoRestauratore (
    EventoSala INT,
    EventoData DATE,
    Restauratore CHAR(16),
    PRIMARY KEY (EventoSala, EventoData, Restauratore),
    FOREIGN KEY (EventoSala, EventoData) REFERENCES Evento(Sala, Data),
    FOREIGN KEY (Restauratore) REFERENCES Restauratore(CF)
);

CREATE TABLE PartecipazioneEventoRegistrar (
    EventoSala INT,
    EventoData DATE,
    Registrar CHAR(16),
    PRIMARY KEY (EventoSala, EventoData, Registrar),
    FOREIGN KEY (EventoSala, EventoData) REFERENCES Evento(Sala, Data),
    FOREIGN KEY (Registrar) REFERENCES Registrar(CF)
);

CREATE TABLE RegistroModificheCuratore (
    Timestamp TIMESTAMP PRIMARY KEY,
    Descrizione TEXT,
    Curatore CHAR(16),
    Direttore CHAR(16),
    FOREIGN KEY (Curatore) REFERENCES Curatore(CF),
    FOREIGN KEY (Direttore) REFERENCES Direttore(CF)
);

CREATE TABLE RegistroModificheRestauratore (
    Timestamp TIMESTAMP PRIMARY KEY,
    Descrizione TEXT,
    Restauratore CHAR(16),
    Direttore CHAR(16),
    FOREIGN KEY (Restauratore) REFERENCES Restauratore(CF),
    FOREIGN KEY (Direttore) REFERENCES Direttore(CF)
);

CREATE TABLE RegistroModificheRegistrar (
    Timestamp TIMESTAMP PRIMARY KEY,
    Descrizione TEXT,
    Registrar CHAR(16),
    Direttore CHAR(16),
    FOREIGN KEY (Registrar) REFERENCES Registrar(CF),
    FOREIGN KEY (Direttore) REFERENCES Direttore(CF)
);

CREATE TABLE Restauro (
    ID INT PRIMARY KEY,
    OperaID INT NOT NULL,
    RestauratoreID INT NOT NULL,
    DataInizio DATE NOT NULL,
    DataFine DATE,
    LaboratorioID INT,
    FOREIGN KEY (OperaID) REFERENCES OperaInterna(ID),
    FOREIGN KEY (RestauratoreID) REFERENCES Restauratore(ID),
    FOREIGN KEY (LaboratorioID) REFERENCES Laboratorio(ID),
    CHECK (DataFine IS NULL OR DataFine > DataInizio)
);

CREATE TABLE Ente (
    Telefono VARCHAR(20) PRIMARY KEY,
    Nome VARCHAR(255),
    Tipo VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    Indirizzo VARCHAR(255) UNIQUE
);

CREATE TABLE Prestito (
    ID SERIAL PRIMARY KEY,
    ID_OperaInterna INT,
    ID_OperaEsterna INT,
    DataInizio DATE,
    DataFine DATE,
    Ente VARCHAR(20),
    Registrar CHAR(16),
    FOREIGN KEY (ID_OperaInterna) REFERENCES OperaInterna(ID),
    FOREIGN KEY (ID_OperaEsterna) REFERENCES OperaEsterna(ID),
    FOREIGN KEY (Ente) REFERENCES Ente(Telefono),
    FOREIGN KEY (Registrar) REFERENCES Registrar(CF),
    CHECK (DataInizio < DataFine)
);

CREATE TABLE Visitatore (
    Email VARCHAR(255) PRIMARY KEY,
    Nome VARCHAR(255),
    Cognome VARCHAR(255)
);

CREATE TABLE Recensione (
    Timestamp TIMESTAMP PRIMARY KEY,
    Commento TEXT,
    Voto INT,
    Visitatore VARCHAR(255),
    Mostra VARCHAR(255),
    FOREIGN KEY (Visitatore) REFERENCES Visitatore(Email),
    FOREIGN KEY (Mostra) REFERENCES Mostra(Nome),
    CHECK (Voto BETWEEN 1 AND 5)
);
	
CREATE TABLE Biglietto (
    NumeroSeriale INT PRIMARY KEY,
    GiornoValidità DATE,
    Audioguida BOOLEAN,
    Sconto DECIMAL(5,2),
    PrezzoTot DECIMAL(10,2),
    Visitatore VARCHAR(255),
    Mostra VARCHAR(255),
    FOREIGN KEY (Visitatore) REFERENCES Visitatore(Email),
    FOREIGN KEY (Mostra) REFERENCES Mostra(Nome)
);



/* Trigger */
CREATE TRIGGER TriggerNoEventoDuranteMostra
BEFORE INSERT ON Evento
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM DisposizioneMostreTemporanee DMT
		   		JOIN MostraTemporanea MT ON DMT.ID_MostraTemporanea = MT.ID
		   		WHERE DMT.Sala = NEW.Sala
		   		AND NEW.Data BETWEEN MT.DataInizio AND MT.DataFine) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La sala è già occupata da una mostra temporanea in questo periodo.';
    END IF;
END;

CREATE TRIGGER TriggerNoOperaInRestauroInMostra
BEFORE INSERT ON OperaInterna
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM Restauro
               WHERE OperaID = NEW.ID
               AND DataFine IS NULL) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'l opera è attualmente in restauro e non può essere esposta in una mostra.';
    END IF;
END;


CREATE TRIGGER TriggerNoMostreTemporaneeSovrapposte
BEFORE INSERT ON DisposizioneMostreTemporanee
FOR EACH ROW
BEGIN
    DECLARE dataInizio DATE;
    DECLARE dataFine DATE;

    -- Recupera le date della mostra temporanea
    SELECT DataInizio, DataFine INTO dataInizio, dataFine
    FROM MostraTemporanea
    WHERE ID = NEW.ID_MostraTemporanea;

    -- Verifica la sovrapposizione
    IF EXISTS (SELECT 1 
               FROM DisposizioneMostreTemporanee DMT
               JOIN MostraTemporanea MT ON DMT.ID_MostraTemporanea = MT.ID
               WHERE DMT.Sala = NEW.Sala
               AND dataInizio < MT.DataFine
               AND dataFine > MT.DataInizio) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La sala è già occupata da un altra mostra temporanea in questo periodo.';
    END IF;
END;


CREATE TRIGGER TriggerCheckRestauroOverlap
BEFORE INSERT ON Restauro
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM Restauro R2
        WHERE R2.OperaID = NEW.OperaID
        AND R2.DataInizio < NEW.DataFine
        AND R2.DataFine > NEW.DataInizio
        AND R2.ID <> NEW.ID
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sovrapposizione di periodi di restauro per la stessa opera.';
    END IF;
END;

CREATE TRIGGER TriggerCheckRestauroOverlapUpdate
BEFORE UPDATE ON Restauro
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM Restauro R2
        WHERE R2.OperaID = NEW.OperaID
        AND R2.DataInizio < NEW.DataFine
        AND R2.DataFine > NEW.DataInizio
        AND R2.ID <> NEW.ID
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sovrapposizione di periodi di restauro per la stessa opera.';
    END IF;
END;

CREATE TRIGGER TriggerCheckRestauratoreSpecializzazione
BEFORE INSERT ON Restauro
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM Restauratore
        WHERE Restauratore.ID = NEW.RestauratoreID
        AND Restauratore.Specializzazione = (SELECT Specializzazione FROM OperaInterna WHERE ID = NEW.OperaID)
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Il restauratore non è specializzato nell opera da restaurare.';
    END IF;
END;

CREATE TRIGGER TriggerCheckRestauratoreSpecializzazioneUpdate
BEFORE UPDATE ON Restauro
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM Restauratore
        WHERE Restauratore.ID = NEW.RestauratoreID
        AND Restauratore.Specializzazione = (SELECT Specializzazione FROM OperaInterna WHERE ID = NEW.OperaID)
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Il restauratore non è specializzato nell opera da restaurare.';
    END IF;
END;

CREATE TRIGGER TriggerNoPrestitoSeInMostra
BEFORE INSERT ON Prestito
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM OperaInterna
               WHERE ID = NEW.ID_OperaInterna
               AND Mostra IS NOT NULL) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'L opera è attualmente esposta in una mostra permanente e non può essere prestata.';
    END IF;
END;







