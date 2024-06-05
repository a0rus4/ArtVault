
-- Inserimento dati nella tabella Piano
INSERT INTO Piano (Numero, Descrizione, Superficie) VALUES
(1, 'Primo piano', 500.00),
(2, 'Secondo piano', 600.00);

-- Inserimento dati nella tabella Laboratorio
INSERT INTO Laboratorio (Specializzazione, Piano, Nome) VALUES
('Restauro pittorico', 1, 'Laboratorio Pittorico'),
('Restauro scultoreo', 2, 'Laboratorio Scultoreo');

-- Inserimento dati nella tabella Direttore
INSERT INTO Direttore (CF, Nome, Cognome, Telefono, Email, Retribuzione, Qualifica, DataAssunzione, DataLicenziamento) VALUES
('DIRETT001XX1', 'Giovanni', 'Rossi', '1234567890', 'giovanni.rossi@example.com', 50000.00, 'Direttore Generale', '2020-01-15', NULL);

-- Inserimento dati nella tabella Curatore
INSERT INTO Curatore (CF, Nome, Cognome, Telefono, Email, Retribuzione, Qualifica, DataAssunzione, DataLicenziamento) VALUES
('CURAT001XX1', 'Luca', 'Bianchi', '0987654321', 'luca.bianchi@example.com', 30000.00, 'Curatore', '2019-05-20', NULL);

-- Inserimento dati nella tabella Restauratore
INSERT INTO Restauratore (CF, Nome, Cognome, Telefono, Email, Retribuzione, Qualifica, Specializzazione, Laboratorio, NumeroRestauri, DataAssunzione, DataLicenziamento) VALUES
('REST001XX1', 'Maria', 'Verdi', '5678901234', 'maria.verdi@example.com', 35000.00, 'Restauratore', 'Restauro pittorico', 'Restauro pittorico', 5, '2018-03-10', NULL);

-- Inserimento dati nella tabella Registrar
INSERT INTO Registrar (CF, Nome, Cognome, Telefono, Email, Retribuzione, Qualifica, DataAssunzione, DataLicenziamento) VALUES
('REG001XX1', 'Anna', 'Neri', '2345678901', 'anna.neri@example.com', 28000.00, 'Registrar', '2021-06-25', NULL);

-- Inserimento dati nella tabella Mostra
INSERT INTO Mostra (Nome, Prezzo, Descrizione, VotoMedio, Tipo, Curatore) VALUES
('Mostra di Arte Moderna', 20.00, 'Esposizione di opere moderne', 4.5, 'Permanente', 'CURAT001XX1');

-- Inserimento dati nella tabella MostraTemporanea
INSERT INTO MostraTemporanea (Nome, DataInizio, DataFine) VALUES
('Mostra di Arte Moderna', '2024-06-01', '2024-12-31');

-- Inserimento dati nella tabella Artista
INSERT INTO Artista (Nome, Cognome, Biografia) VALUES
('Leonardo', 'Da Vinci', 'Artista e scienziato italiano del Rinascimento'),
('Michelangelo', 'Buonarroti', 'Scultore, pittore, architetto e poeta italiano del Rinascimento');

-- Inserimento dati nella tabella OperaInterna
INSERT INTO OperaInterna (Mostra, Titolo, AnnoProduzione, Provenienza, Tipo, ID_Artista, Specializzazione, DataUltimoRestauro) VALUES
('Mostra di Arte Moderna', 'Monna Lisa', 1503, 'Italia', 'Dipinto', 1, 'Restauro pittorico', '2023-12-01');

-- Inserimento dati nella tabella OperaEsterna
INSERT INTO OperaEsterna (Titolo, AnnoProduzione, Provenienza, Tipo, ID_Artista) VALUES
('David', 1504, 'Italia', 'Scultura', 2);

-- Inserimento dati nella tabella Sala
INSERT INTO Sala (Piano, Capienza, Tipo, Mostra) VALUES
(1, 100, 'Esposizione', 'Mostra di Arte Moderna');

-- Inserimento dati nella tabella DisposizioneMostreTemporanee
INSERT INTO DisposizioneMostreTemporanee (ID_MostraTemporanea, Sala) VALUES
(1, 1);

-- Inserimento dati nella tabella ComposizioneMostreTemporanee
INSERT INTO ComposizioneMostreTemporanee (ID_MostraTemporanea, ID_OperaEsterna) VALUES
(1, 1);

-- Inserimento dati nella tabella Evento
INSERT INTO Evento (Sala, Data, Nome, Descrizione) VALUES
(1, '2024-07-15', 'Conferenza sull arte moderna', 'Discussione su opere moderne e tecniche artistiche');

-- Inserimento dati nella tabella PartecipazioneEventoCuratore
INSERT INTO PartecipazioneEventoCuratore (EventoSala, EventoData, Curatore) VALUES
(1, '2024-07-15', 'CURAT001XX1');

-- Inserimento dati nella tabella PartecipazioneEventoRestauratore
INSERT INTO PartecipazioneEventoRestauratore (EventoSala, EventoData, Restauratore) VALUES
(1, '2024-07-15', 'REST001XX1');

-- Inserimento dati nella tabella PartecipazioneEventoRegistrar
INSERT INTO PartecipazioneEventoRegistrar (EventoSala, EventoData, Registrar) VALUES
(1, '2024-07-15', 'REG001XX1');

-- Inserimento dati nella tabella RegistroModificheCuratore
INSERT INTO RegistroModificheCuratore (Timestamp, Descrizione, Curatore, Direttore) VALUES
('2024-05-28 14:30:00
