-- Inserimento dati per la tabella Piano
INSERT INTO Piano (Numero, Descrizione, Superficie) VALUES
(0, 'Piano terra', 1000.00),
(1, 'Primo piano', 750.00),
(2, 'Secondo piano', 800.00),
(3, 'Terzo piano', 850.00),
(4, 'Quarto piano', 900.00),
(5, 'Quinto piano', 950.00),
(6, 'Sesto piano', 1000.00);

-- Popolamento della tabella Laboratorio
INSERT INTO Laboratorio (Specializzazione, Piano, Nome) VALUES
('Pittura', 2, 'Laboratorio Pitture'),
('Scultura', 4, 'Laboratorio Sculture'),
('Tessile', 1, 'Laboratorio Tessili'),
('Ceramica', 4, 'Laboratorio Ceramiche'),
('Carta', 5, 'Laboratorio Carta'),
('Metallo', 3, 'Laboratorio Metalli'),
('Vetro', 1, 'Laboratorio Vetro'),
('Oreficeria', 2, 'Laboratorio Gioielli'),
('Fotografica', 6, 'Laboratorio Fotografie'),
('Manoscritto', 5, 'Laboratorio Manoscritti'),
('Strumentistica', 6, 'Laboratorio Strumenti Musicali'),
('Armi', 3, 'Laboratorio Armi');

-- Popolamento della tabella Direttore
INSERT INTO Direttore (CF, Nome, Cognome, Telefono, Email, Retribuzione, Qualifica, DataAssunzione, DataLicenziamento) VALUES
('RSSMRA85M01H501Z', 'Mario', 'Rossi', '3331234567', 'mario.rossi@example.com', 50000.00, 'Storia dell arte', '2022-07-01', NULL),
('BNCLRA75A41H501Z', 'Laura', 'Bianchi', '3332345678', 'laura.bianchi@example.com', 48000.00, 'Museologia', '2021-01-01', '2022-07-01'),
('VRDGNN70C14H501Z', 'Gianna', 'Verdi', '3333456789', 'gianna.verdi@example.com', 47000.00, 'Antropologia', '2020-07-01', '2021-01-01'),
('BLUCST90M20H501Z', 'Cassandra', 'Blu', '3334567890', 'cassandra.blu@example.com', 46000.00, 'Antropologia', '2018-09-10', '2020-07-01'),
('MRTGRC60E01H501Z', 'Gerardo', 'Martini', '3335678901', 'gerardo.martini@example.com', 55000.00, 'Storia dell arte', '2017-02-01', '2018-09-10'),
('BLNCHD85H15H501Z', 'Chiara', 'Bellini', '3336789012', 'chiara.bellini@example.com', 52000.00, 'Antropologia', '2016-06-30', '2017-02-01'),
('GRNFLC65D05H501Z', 'Francesca', 'Garini', '3337890123', 'francesca.garini@example.com', 51000.00, 'Archeologia', '2014-11-10', '2016-06-30'),
('BNLMRC80A12H501Z', 'Marco', 'Bianchini', '3338901234', 'marco.bianchini@example.com', 53000.00, 'Museologia', '2010-09-10', '2014-11-10'),
('NTLMSS90A23H501Z', 'Massimo', 'Natali', '3339012345', 'massimo.natali@example.com', 54000.00, 'Antropologia', '2008-11-10', '2010-09-10'),
('RMDLNC85E09H501Z', 'Lorenzo', 'Rimondi', '3330123456', 'lorenzo.rimondi@example.com', 49500.00, 'Museologia', '2006-02-01', '2008-11-10'),
('MRTLCR85H01H501Z', 'Luca', 'Martelli', '3311234567', 'luca.martelli@example.com', 51500.00, 'Archeologia', '2004-09-10', '2006-02-01'),
('RDMGRA85F09H501Z', 'Andrea', 'Rossi', '3312345678', 'andrea.rossi@example.com', 52000.00, 'Storia dell arte', '2001-05-15', '2004-09-10'),
('LNCGRC85C11H501Z', 'Giorgia', 'Lanci', '3313456789', 'giorgia.lanci@example.com', 49000.00, 'Antropologia', '2000-03-20', '2001-05-15'),
('CNTMLS85D20H501Z', 'Melissa', 'Conti', '3314567890', 'melissa.conti@example.com', 53000.00, 'Storia dell arte', '1998-09-10', '2000-03-20'),
('VRDMRA85E41H501Z', 'Maria', 'Verdi', '3315678901', 'maria.verdi@example.com', 51000.00, 'Archeologia', '1995-02-10', '1998-09-10');

-- Popolamento della tabella Curatore
INSERT INTO Curatore (CF, Nome, Cognome, Telefono, Email, Retribuzione, Qualifica, DataAssunzione, DataLicenziamento) VALUES
('BNCCHR85M01H501Z', 'Chiara', 'Bianchi', '3321234567', 'chiara.bianchi@example.com', 35000.00, 'Arti Visive', '1995-02-10', NULL),
('VRDLRS75A41H501Z', 'Lorenzo', 'Verdi', '3322345678', 'lorenzo.verdi@example.com', 34000.00, 'Arti Figurative', '1995-02-10', NULL),
('RSSMRC70C14H501Z', 'Marco', 'Rossi', '3323456789', 'marco.rossi@example.com', 33000.00, 'Arti Moderne', '2015-03-20', '2018-05-23'),
('BLNGST90M20H501Z', 'Giustina', 'Blu', '3324567890', 'giustina.blu@example.com', 32000.00, 'Architettura e Ambiente', '2018-09-10', NULL),
('MRTFRC60E01H501Z', 'Francesco', 'Martini', '3325678901', 'francesco.martini@example.com', 36000.00, 'Arti Contemporanee', '2020-07-01', NULL),
('BLNLRD85H15H501Z', 'Leonardo', 'Bellini', '3316789012', 'leonardo.bellini@example.com', 37000.00, 'Arti Figurative', '2013-04-15', NULL),
('GRNPLC65D05H501Z', 'Luca', 'Garini', '3317890123', 'luca.garini@example.com', 31000.00, 'Arti Figurative', '1995-02-10', NULL),
('BNCMRC80A12H501Z', 'Marica', 'Bianchini', '3318901234', 'marica.bianchini@example.com', 38000.00, 'Arti Moderne', '2011-08-20', NULL),
('NTLLSS90A23H501B', 'Alessia', 'Natali', '3319012345', 'alessia.natali@example.com', 34500.00, 'Arti Visive', '2014-11-10', NULL),
('RMDLZN85E09H501Z', 'Lorenza', 'Rimondi', '3310123456', 'lorenza.rimondi@example.com', 39500.00, 'Arti Contemporanee', '2017-02-01', NULL),
('MRTLCC85H01H501Z', 'Lucrezia', 'Martelli', '331234567', 'lucrezia.martelli@example.com', 35500.00, 'Arti Contemporanee', '2021-01-01', NULL),
('RDMGMR85F09H501Z', 'Mariarosa', 'Rossi', '3342345678', 'mariarosa.rossi@example.com', 32000.00, 'Architettura e Ambiente', '2018-05-15', NULL),
('LNCCRG85C11H501Z', 'Giorgio', 'Lanci', '3343456789', 'giorgio.lanci@example.com', 31000.00, 'Arti Contemporanee', '1995-02-10', NULL),
('CNTMLS85D40H501Z', 'Melania', 'Conti', '334567890', 'melania.conti@example.com', 33000.00, 'Architettura e Ambiente', '1995-02-10', '2020-12-02'),
('VRDMRA85E01H501Z', 'Mario', 'Verdi', '3345678901', 'mario.verdi@example.com', 31000.00, 'Arti Contemporanee', '2022-07-01', NULL);

-- Popolamento della tabella Restauratore
INSERT INTO Restauratore (CF, Nome, Cognome, Telefono, Email, Retribuzione, Qualifica, Specializzazione, NumeroRestauri, DataAssunzione, DataLicenziamento) VALUES
('BNCLRC85M01H501Z', 'Luca', 'Bianchi', '3351234567', 'luca.bianchi@example.com', 30000.00, 'Arti Visive', 'Scultura', 7, '1995-02-10', NULL),
('VRDLRT75A41H501Z', 'Lorenzo', 'Verdi', '3352345678', 'lorenzo.verdi9@example.com', 29000.00, 'Arti Figurative', 'Scultura', 3, '2012-05-15', NULL),
('RSSMRR70C14H501Z', 'Marco', 'Rossi', '3353456789', 'marco.rossi1@example.com', 28000.00, 'Arti Visive', 'Pittura', 7, '2015-03-20', NULL),
('BLNGSR90M20H501Z', 'Sara', 'Blu', '3354567890', 'sara.blu@example.com', 27000.00, 'Arti Figurative', 'Ceramica', 4, '2018-09-10', NULL),
('MRTFRS60E01H501Z', 'Francesca', 'Martini', '3355678901', 'francesca.martini@example.com', 32000.00, 'Arti Visive', 'Carta', 6, '1995-02-10', NULL),
('BLNLRF85H15H501Z', 'Francesco', 'Bellini', '3326789012', 'francesco.bellini@example.com', 31000.00, 'Arti Figurative', 'Metallo', 2, '2013-04-15', '2016-06-30'),
('GRNPLR65D05H501Z', 'Luca', 'Garini', '3327890123', 'luca.garini1@example.com', 33000.00, 'Arti Figurative', 'Metallo', 5, '2016-06-30', NULL),
('BNCMRL80A12H501Z', 'Marina', 'Bianchini', '3348901234', 'marina.bianchini@example.com', 34000.00, 'Arti Figurative', 'Vetro', 3, '1995-02-10', NULL),
('NTLLSR90A23H501Z', 'Sara', 'Natali', '3329012345', 'sara.natali@example.com', 32500.00, 'Arti Figurative', 'Oreficeria', 4, '2014-11-10', NULL),
('RMDLRZ85E09H501Z', 'Rosa', 'Rimondi', '3320123456', 'rosa.rimondi@example.com', 33500.00, 'Arti Visive', 'Fotografica', 6, '2017-02-01', NULL),
('MRTLCR85H01H501P', 'Cristina', 'Martelli', '3361234567', 'cristina.martelli@example.com', 34500.00, 'Arti Figurative', 'Manoscritto', 7, '2021-01-01', NULL),
('RDMGRR85F09H501Z', 'Roberto', 'Rossi', '3362345678', 'roberto.rossi@example.com', 31000.00, 'Arti Figurative', 'Strumentistica', 8, '2018-05-15', NULL),
('LNCGRR85C11H501Z', 'Giorgio', 'Lanci', '3363456789', 'giorgio.lanci7@example.com', 30000.00, 'Arti Figurative', 'Strumentistica', 2, '2019-03-20', NULL),
('CNTMLR85D20H501Z', 'Maria', 'Conti', '3354567890', 'maria.conti@example.com', 32000.00, 'Arti Visive', 'Pittura', 3, '1995-02-10', NULL),
('VRDMRR85E01H501Z', 'Marco', 'Verdi', '3365678901', 'marco.verdi@example.com', 31000.00, 'Arti Figurative', 'Armi', 4, '2022-07-01', NULL);

-- Popolamento della tabella Registrar
INSERT INTO Registrar (CF, Nome, Cognome, Telefono, Email, Retribuzione, Qualifica, DataAssunzione, DataLicenziamento) VALUES
('BNCGRS85M01H501Z', 'Giorgio', 'Bianchi', '3371234567', 'giorgio.bianchi@example.com', 33000.00, 'Archeologia', '1995-02-10', NULL),
('VRDLRS75A41H501L', 'Lorenzo', 'Verdi', '3372345678', 'lorenzo.verdi4@example.com', 32000.00, 'Museologia', '2012-05-15', '2015-03-20'),
('RSSMRC70C14H601Z', 'Marco', 'Rossi', '3373456789', 'marco.rossi2@example.com', 31000.00, 'Museologia', '2015-03-20', NULL),
('BLNSGR90M20H501Z', 'Sara', 'Blu', '3364567890', 'sara.blue@example.com', 30000.00, 'Antropologia', '2018-09-10', NULL),
('MRTFRC60E01H501R', 'Francesca', 'Martese', '3375678901', 'francesca.martese@example.com', 34000.00, 'Storia dell arte', '2020-07-01', NULL),
('BLNLFR85H15H501Z', 'Francesco', 'Bellini', '3346789012', 'francesco.bellini2@example.com', 35000.00, 'Risorse Umane', '2013-04-15', NULL),
('GRNPLS65D05H501Z', 'Luca', 'Garini', '3347890123', 'luca.garini2@example.com', 33000.00, 'Antropologia', '2016-06-30', NULL),
('BNCLRS80A12H501Z', 'Luca', 'Bianchini', '3358901234', 'luca.bianchini@example.com', 36000.00, 'Museologia', '2011-08-20', NULL),
('NTLLSS90A23H501Z', 'Sara', 'Natalini', '3349012345', 'sara.natalini@example.com', 33500.00, 'Storia dell arte', '1995-02-10', '2011-08-20'),
('RMDLNR85E09H501Z', 'Rosa', 'Rimondi', '3340123456', 'rosa.rimondi3@example.com', 35500.00, 'Antropologia', '2017-02-01', NULL),
('MRTLCR85H01H501L', 'Cristina', 'Martelli', '3381234567', 'cristina.martelli5@example.com', 34500.00, 'Archeologia', '2021-01-01', NULL),
('RDMGLR85F09H501Z', 'Luca', 'Rossi', '3382345678', 'luca.rossi@example.com', 32000.00, 'Risorse Umane', '2018-05-15', NULL),
('LNCGRS85C11H501Z', 'Giorgio', 'Lanci', '3383456789', 'giorgio.lanci8@example.com', 31000.00, 'Storia dell arte', '1995-02-10', NULL),
('CNTMLS85D60H501Z', 'Melania', 'Conte', '3374567890', 'melania.conte@example.com', 33000.00, 'Archeologia', '2010-09-10', NULL),
('VRDMRS85E01H501Z', 'Maria', 'Verdi', '3385678901', 'maria.verdi6@example.com', 31000.00, 'Museologia', '2022-07-01', NULL);

-- Popolamento della tabella Mostra
INSERT INTO Mostra (Nome, Prezzo, Descrizione, VotoMedio, Tipo, Curatore, Stato) VALUES
('Impressionismo', 10.00, 'Mostra sulle opere impressioniste del XIX secolo', 4.5, TRUE, 'BNCCHR85M01H501Z', TRUE),
('Rinascimento', 12.00, 'Mostra sulle opere rinascimentali italiane', 4.8, TRUE, 'VRDLRS75A41H501Z', TRUE),
('Barocco', 11.00, 'Mostra sulle opere barocche europee', 4.7, TRUE, 'RDMGMR85F09H501Z', TRUE),
('Modernismo', 9.00, 'Mostra sulle opere moderniste del XX secolo', 4.2, TRUE, 'NTLLSS90A23H501B', TRUE),
('Futurismo', 8.00, 'Mostra sulle opere futuriste italiane', 4.3, TRUE, 'LNCCRG85C11H501Z', TRUE),
('Cubismo', 10.00, 'Mostra sulle opere cubiste del XX secolo', 4.6, TRUE, 'NTLLSS90A23H501B', TRUE),
('Surrealismo', 7.00, 'Mostra sulle opere surrealiste europee', 4.4, FALSE, 'BNCCHR85M01H501Z', TRUE),
('Romanticismo', 11.00, 'Mostra sulle opere romantiche del XIX secolo', 4.7, FALSE, 'RMDLZN85E09H501Z', TRUE),
('Neoclassicismo', 10.00, 'Mostra sulle opere neoclassiche europee', 4.5, TRUE, 'LNCCRG85C11H501Z', TRUE),
('Gotico', 12.00, 'Mostra sulle opere gotiche europee', 4.8, TRUE, 'RDMGMR85F09H501Z', TRUE),
('Art Nouveau', 9.00, 'Mostra sulle opere Art Nouveau', 4.3, FALSE, 'BNCCHR85M01H501Z', TRUE),
('Minimalismo', 8.00, 'Mostra sulle opere minimaliste del XX secolo', 4.2, TRUE, 'RMDLZN85E09H501Z', TRUE),
('Realismo', 7.00, 'Mostra sulle opere realiste del XIX secolo', 4.4, TRUE, 'MRTFRC60E01H501Z', TRUE),
('Astrattismo', 10.00, 'Mostra sulle opere astratte del XX secolo', 4.6, TRUE, 'GRNPLC65D05H501Z', TRUE),
('Arte Concettuale', 12.00, 'Mostra sulle opere concettuali', 4.8, FALSE, 'RMDLZN85E09H501Z', TRUE);

-- Popolare la tabella MostraTemporanea con 15 voci
INSERT INTO MostraTemporanea (Nome, DataInizio, DataFine) VALUES
('Surrealismo', '2023-01-01', '2023-02-01'),
('Art Nouveau', '2022-02-01', '2023-03-01'),
('Arte Concettuale', '2021-03-01', '2023-04-01'),
('Romanticismo', '2023-04-01', '2023-05-01');

-- Popolamento della tabella Artista
INSERT INTO Artista (Nome, Cognome, Biografia) VALUES
('Pablo', 'Picasso', 'Pablo Picasso è stato un pittore e scultore spagnolo. È considerato uno dei più grandi artisti del XX secolo.'),
('Vincent', 'Van Gogh', 'Vincent van Gogh è stato un pittore olandese, uno dei più grandi artisti di tutti i tempi.'),
('Claude', 'Monet', 'Claude Monet è stato un pittore francese, uno dei fondatori del movimento impressionista.'),
('Leonardo', 'Da Vinci', 'Leonardo da Vinci è stato un pittore, scienziato e ingegnere italiano, uno dei più grandi geni della storia.'),
('Michelangelo', 'Buonarroti', 'Michelangelo è stato un pittore, scultore e architetto italiano, uno dei più grandi artisti del Rinascimento.'),
('Salvador', 'Dali', 'Salvador Dalí è stato un pittore spagnolo, uno dei più grandi esponenti del surrealismo.'),
('Jackson', 'Pollock', 'Jackson Pollock è stato un pittore americano, uno dei maggiori esponenti dell espressionismo astratto.'),
('Andy', 'Warhol', 'Andy Warhol è stato un pittore e regista statunitense, uno dei più importanti esponenti della pop art.'),
('Frida', 'Kahlo', 'Frida Kahlo è stata una pittrice messicana, conosciuta per i suoi autoritratti e il suo stile unico.'),
('Georgia', 'O Keeffe', 'Georgia O Keeffe è stata una pittrice statunitense, conosciuta per i suoi dipinti di fiori e paesaggi.'),
('Henri', 'Matisse', 'Henri Matisse è stato un pittore francese, uno dei più importanti artisti del XX secolo.'),
('Edgar', 'Degas', 'Edgar Degas è stato un pittore e scultore francese, uno dei fondatori del movimento impressionista.'),
('Paul', 'Cezanne', 'Paul Cézanne è stato un pittore francese, uno dei più grandi artisti post-impressionisti.'),
('Rembrandt', 'Van Rijn', 'Rembrandt van Rijn è stato un pittore olandese, uno dei più grandi artisti del Seicento.'),
('Sandro', 'Botticelli', 'Sandro Botticelli è stato un pittore italiano, uno dei più grandi artisti del Rinascimento.');

-- Popolamento della tabella OperaInterna
INSERT INTO OperaInterna (Mostra, Titolo, AnnoProduzione, Provenienza, Tipo, ID_Artista, Specializzazione, DataUltimoRestauro) VALUES
('Impressionismo', 'Impression, soleil levant', 1872, 'Francia', 'Dipinto', 3, 'Pittura', '2023-01-01'),
('Rinascimento', 'Mona Lisa', 1503, 'Italia', 'Olio su Tela', 4, 'Pittura', '2023-02-01'),
('Barocco', 'Las Meninas', 1656, 'Spagna', 'Dipinto', 2, 'Pittura', '2023-03-01'),
('Modernismo', 'Les Demoiselles d Avignon', 1907, 'Francia', 'Dipinto', 1, 'Pittura', '2023-04-01'),
('Futurismo', 'Unique Forms of Continuity in Space', 1913, 'Italia', 'Scultura', 5, 'Scultura', '2023-05-01'),
('Cubismo', 'Guernica', 1937, 'Spagna', 'Dipinto', 1, 'Pittura', '2023-06-01'),
('Neoclassicismo', 'The Death of Socrates', 1787, 'Francia', 'Dipinto', 12, 'Pittura', '2023-09-01'),
('Gotico', 'The Garden of Earthly Delights', 1500, 'Olanda', 'Dipinto', 14, 'Pittura', '2023-10-01'),
('Minimalismo', 'Black Square', 1915, 'Russia', 'Dipinto', 8, 'Pittura', '2023-12-01'),
('Realismo', 'The Gleaners', 1857, 'Francia', 'Dipinto', 9, 'Pittura', '2024-01-01'),
('Astrattismo', 'Composition VIII', 1923, 'Germania', 'Dipinto', 10, 'Pittura', '2024-02-01');

-- Popolamento della tabella OperaEsterna
INSERT INTO OperaEsterna (Titolo, AnnoProduzione, Provenienza, Tipo, ID_Artista) VALUES
('The Elephants', 1948, 'Spagna', 'Dipinto', 6),
('Liberty Leading the People', 1830, 'Francia', 'Dipinto', 12),
('Portrait of Adele Bloch-Bauer I', 1907, 'Austria', 'Dipinto', 7),
('The Physical Impossibility of Death in the Mind of Someone Living', 1991, 'UK', 'Installazione', 8),
('The Raft of the Medusa', 1818, 'Francia', 'Dipinto', 13),
('The Persistence of Memory', 1931, 'Spagna', 'Dipinto', 6),
('The Kiss', 1908, 'Austria', 'Dipinto', 7),
('One and Three Chairs', 1965, 'USA', 'Installazione', 11);

-- Popolare la tabella Sala con 15 voci
INSERT INTO Sala (Piano, Capienza, Tipo, Mostra) VALUES
(3, 50, FALSE, 'Surrealismo'),
(2, 100, FALSE, 'Surrealismo'),
(4, 150, FALSE, 'Romanticismo'),
(5, 200, FALSE, 'Art Nouveau'),
(6, 50, FALSE, 'Arte Concettuale'),
(4, 100, TRUE, 'Astrattismo'),
(1, 150, TRUE, 'Realismo'),
(3, 200, TRUE, 'Minimalismo'),
(5, 50, TRUE, 'Gotico'),
(6, 100, TRUE, 'Neoclassicismo'),
(3, 150, TRUE, 'Cubismo'),
(4, 200, TRUE, 'Futurismo'),
(1, 50, TRUE, 'Modernismo'),
(5, 100, TRUE, 'Barocco'),
(2, 110, TRUE, 'Impressionismo'),
(3, 150, TRUE, 'Rinascimento');

-- Popolare la tabella DisposizioneMostreTemporanee con 15 voci
INSERT INTO DisposizioneMostreTemporanee (ID_MostraTemporanea, Sala) VALUES
(1, 1),
(1, 2),
(4, 3),
(2, 4),
(3, 5);

-- Popolare la tabella ComposizioneMostreTemporanee con 15 voci
INSERT INTO ComposizioneMostreTemporanee (ID_MostraTemporanea, ID_OperaEsterna) VALUES
(1, 1),
(4, 2),
(2, 3),
(3, 4),
(4, 5),
(1, 6),
(2, 7),
(3, 8);

-- Popolare la tabella Evento con 15 voci
INSERT INTO Evento (Sala, Data, Nome, Descrizione, Direttore) VALUES
(1, '2022-05-23', 'Assemblea', 'Descrizione dell Evento 1', 'RDMGRA85F09H501Z'),
(4, '2019-02-10', 'Evento 2', 'Descrizione dell Evento 2', 'RDMGRA85F09H501Z'),
(2, '2018-03-10', 'Evento 3', 'Descrizione dell Evento 3', 'RDMGRA85F09H501Z'),
(3, '2018-04-10', 'Evento 4', 'Descrizione dell Evento 4', 'RDMGRA85F09H501Z'),
(5, '2019-05-10', 'Evento 5', 'Descrizione dell Evento 5', 'RDMGRA85F09H501Z');

-- Popolare la tabella PartecipazioneEventoCuratore con 15 voci
INSERT INTO PartecipazioneEventoCuratore (EventoSala, EventoData, Curatore) VALUES
(2, '2018-03-10', 'BNCCHR85M01H501Z'),
(4, '2019-02-10', 'BNCCHR85M01H501Z'),
(5, '2019-05-10', 'MRTFRC60E01H501Z'),
(3, '2018-04-10', 'MRTLCC85H01H501Z'),
(1, '2022-05-23', 'MRTFRC60E01H501Z'),
(2, '2018-03-10', 'MRTFRC60E01H501Z');

-- Popolare la tabella PartecipazioneEventoRestauratore con 15 voci
INSERT INTO PartecipazioneEventoRestauratore (EventoSala, EventoData, Restauratore) VALUES
(2, '2018-03-10', 'CNTMLR85D20H501Z'),
(4, '2019-02-10', 'BLNGSR90M20H501Z'),
(5, '2019-05-10', 'CNTMLR85D20H501Z'),
(3, '2018-04-10', 'CNTMLR85D20H501Z'),
(1, '2022-05-23', 'BLNGSR90M20H501Z'),
(2, '2018-03-10', 'RMDLRZ85E09H501Z');

-- Popolare la tabella PartecipazioneEventoRegistrar con 15 voci
INSERT INTO PartecipazioneEventoRegistrar (EventoSala, EventoData, Registrar) VALUES
(2, '2018-03-10', 'BNCGRS85M01H501Z'),
(4, '2019-02-10', 'RSSMRC70C14H601Z'),
(5, '2019-05-10', 'BLNLFR85H15H501Z'),
(3, '2018-04-10', 'MRTLCR85H01H501L'),
(1, '2022-05-23', 'LNCGRS85C11H501Z'),
(2, '2018-03-10', 'VRDMRS85E01H501Z');

-- Popolare la tabella RegistroModificheCuratore con 15 voci
INSERT INTO RegistroModificheCuratore (Timestamp, Descrizione, Curatore, Direttore) VALUES
('2018-05-23 10:00:00', 'Licenziamento', 'RSSMRC70C14H501Z', 'MRTGRC60E01H501Z'),
('2020-12-02 11:00:00', 'Licenziamento', 'CNTMLS85D40H501Z', 'VRDGNN70C14H501Z'),
('2023-03-10 12:00:00', 'Aumento', 'BNCCHR85M01H501Z', 'RSSMRA85M01H501Z'),
('2023-04-10 13:00:00', 'Aumento', 'NTLLSS90A23H501B', 'RSSMRA85M01H501Z'),
('2023-05-10 14:00:00', 'Aumento', 'LNCCRG85C11H501Z', 'RSSMRA85M01H501Z');

-- Popolare la tabella RegistroModificheRestauratore con 15 voci
INSERT INTO RegistroModificheRestauratore (Timestamp, Descrizione, Restauratore, Direttore) VALUES
('2016-06-10 10:00:00', 'Licenziamento', 'BLNLRF85H15H501Z', 'GRNFLC65D05H501Z'),
('2020-12-02 11:00:00', 'Aumento', 'BLNGSR90M20H501Z', 'VRDGNN70C14H501Z'),
('2021-03-10 12:00:00', 'Aumento', 'RMDLRZ85E09H501Z', 'BNCLRA75A41H501Z'),
('2022-04-10 13:00:00', 'Aumento', 'CNTMLR85D20H501Z', 'BNCLRA75A41H501Z'),
('2023-05-10 14:00:00', 'Aumento', 'VRDMRR85E01H501Z', 'RSSMRA85M01H501Z');

-- Popolare la tabella RegistroModificheRegistrar con 15 voci
INSERT INTO RegistroModificheRegistrar (Timestamp, Descrizione, Registrar, Direttore) VALUES
('2020-12-02 11:00:00', 'Aumento', 'GRNPLS65D05H501Z', 'VRDGNN70C14H501Z'),
('2021-03-10 12:00:00', 'Aumento', 'BLNLFR85H15H501Z', 'BNCLRA75A41H501Z'),
('2022-04-10 13:00:00', 'Aumento', 'BLNSGR90M20H501Z', 'BNCLRA75A41H501Z'),
('2023-05-10 14:00:00', 'Aumento', 'VRDLRS75A41H501L', 'RSSMRA85M01H501Z');

-- Popolare la tabella Restauro con 15 voci
INSERT INTO Restauro (OperaID, RestauratoreID, DataInizio, DataFine, LaboratorioID) VALUES
(1, 'RSSMRR70C14H501Z', '2022-01-01', '2023-01-10', 'Pittura'),
(1, 'RSSMRR70C14H501Z', '2012-02-01', '2013-02-10', 'Pittura'),
(5, 'VRDLRT75A41H501Z', '2023-03-01', '2023-03-10', 'Scultura'),
(5, 'VRDLRT75A41H501Z', '2013-04-01', '2014-04-10', 'Scultura');

INSERT INTO Ente (Telefono, Nome, Tipo, Email, Indirizzo) VALUES
('3344556671', 'Museo di Belle Arti ', 'Museo', 'museobellearti@example.com', 'Via Garibaldi 1, Roma'),
('3355778892', 'Galleria Moderna', 'Galleria', 'galleriamoderna@example.com', 'Corso Vittorio Emanuele II 2, Milano'),
('3388990013', 'Collezione Arte Contemporanea', 'Collezione Privata', 'collezioneartecontemporanea@example.com', 'Via Vesuvio 3, Napoli'),
('3366112234', 'Museo Storico Nazionale', 'Museo', 'museostorico@example.com', 'Via Po 4, Torino'),
('3377223345', 'Galleria Arte Antica', 'Galleria', 'galleriaantica@example.com', 'Via dei Calzaiuoli 5, Firenze'),
('3399334456', 'Collezione di Arte Moderna', 'Collezione Privata', 'collezioneartemoderna@example.com', 'Via Manzoni 6, Bologna'),
('3300112237', 'Museo Archeologico', 'Museo', 'museoarcheologico@example.com', 'Via dei Fori Imperiali 7, Roma'),
('3311223348', 'Galleria Nazionale', 'Galleria', 'gallerianazionale@example.com', 'Piazza San Marco 8, Venezia'),
('3322334459', 'Collezione di Arte Orientale', 'Collezione Privata', 'collezionearteorientale@example.com', 'Via Libertà 9, Palermo'),
('3344559970', 'Museo d Arte Contemporanea', 'Museo', 'museocontemporanea@example.com', 'Via Poetto 10, Cagliari'),
('3355723899', 'Galleria Arte Moderna', 'Galleria', 'galleriamodernabari@example.com', 'Via Sparano 11, Bari'),
('3367990011', 'Collezione Arte Sacra', 'Collezione Privata', 'collezioneartesacra@example.com', 'Via Palmieri 12, Lecce'),
('3370011223', 'Museo delle Scienze Naturali', 'Museo', 'museosciensenaturali@example.com', 'Corso Milano 13, Padova'),
('3388203344', 'Galleria Civica', 'Galleria', 'galleriacivica@example.com', 'Via Garibaldi 14, Trento'),
('3390334455', 'Collezione di Arte Moderna e Contemporanea', 'Collezione Privata', 'collezioneartemodernacontemporanea@example.com', 'Via Trieste 15, Trieste');

-- Popolare la tabella Prestito con 15 voci
INSERT INTO Prestito (ID_OperaInterna, ID_OperaEsterna, DataInizio, DataFine, Ente, Registrar) VALUES
(NULL, 1, '2022-12-01', '2023-03-31', 'Galleria Moderna', 'BNCGRS85M01H501Z'),
(NULL, 2, '2023-02-01', '2023-07-28', 'Galleria Nazionale', 'RSSMRC70C14H601Z'),
(NULL, 3, '2022-01-08', '2023-03-31', 'Collezione di Arte Moderna e Contemporanea', 'MRTFRC60E01H501R'),
(NULL, 4, '2021-02-02', '2023-04-30', 'Museo di Belle Arti', 'BNCLRS80A12H501Z'),
(NULL, 5, '2022-01-08', '2023-06-31', 'Galleria Civica', 'BNCGRS85M01H501Z'),
(NULL, 6, '2022-02-06', '2023-02-28', 'Galleria Nazionale', 'RSSMRC70C14H601Z'),
(NULL, 7, '2022-01-08', '2023-03-31', 'Collezione di Arte Moderna e Contemporanea', 'MRTFRC60E01H501R'),
(NULL, 8, '2020-12-03', '2023-04-30', 'Museo Archeologico', 'RMDLNR85E09H501Z');

INSERT INTO Visitatore (Email, Nome, Cognome) VALUES
('alice.bianchi@example.com', 'Alice', 'Bianchi'),
('marco.rossi5@example.com', 'Marco', 'Rossi'),
('giulia.esposito@example.com', 'Giulia', 'Esposito'),
('matteo.russo@example.com', 'Matteo', 'Russo'),
('sara.ferrari@example.com', 'Sara', 'Ferrari'),
('luca.martini@example.com', 'Luca', 'Martini'),
('chiara.romano@example.com', 'Chiara', 'Romano'),
('andrea.conti@example.com', 'Andrea', 'Conti'),
('elena.ricci@example.com', 'Elena', 'Ricci'),
('davide.moretti@example.com', 'Davide', 'Moretti'),
('martina.colombo@example.com', 'Martina', 'Colombo'),
('francesco.marino@example.com', 'Francesco', 'Marino'),
('alessia.greco@example.com', 'Alessia', 'Greco'),
('simone.barbieri@example.com', 'Simone', 'Barbieri'),
('laura.deluca@example.com', 'Laura', 'De Luca');

INSERT INTO Recensione (Timestamp, Commento, Voto, Visitatore, Mostra) VALUES
('2023-01-10 10:00:00', 'Superbo', 5, 'alice.bianchi@example.com', 'Impressionismo'),
('2023-02-10 11:00:00', 'Fantastico', 4, 'marco.rossi5@example.com', 'Rinascimento'),
('2023-03-10 12:00:00', 'Interessante', 3, 'matteo.russo@example.com', 'Barocco'),
('2023-04-10 13:00:00', 'Bellissimo', 5, 'sara.ferrari@example.com', 'Modernismo'),
('2023-05-10 14:00:00', 'Deludente', 2, 'luca.martini@example.com', 'Futurismo'),
('2023-06-10 15:00:00', 'Splendido', 4, 'chiara.romano@example.com', 'Cubismo'),
('2023-07-10 16:00:00', 'Magnifico', 5, 'andrea.conti@example.com', 'Surrealismo'),
('2023-08-10 17:00:00', 'Buono', 3, 'elena.ricci@example.com', 'Romanticismo'),
('2023-09-10 18:00:00', 'Eccellente', 4, 'davide.moretti@example.com', 'Neoclassicismo'),
('2023-10-10 19:00:00', 'Straordinario', 5, 'martina.colombo@example.com', 'Gotico'),
('2023-11-10 20:00:00', 'Mediocre', 2, 'francesco.marino@example.com', 'Art Nouveau'),
('2023-12-10 21:00:00', 'Molto buono', 4, 'alessia.greco@example.com', 'Minimalismo'),
('2024-01-10 22:00:00', 'Carino', 3, 'simone.barbieri@example.com', 'Realismo'),
('2024-02-10 23:00:00', 'Interessante', 4, 'laura.deluca@example.com', 'Astrattismo'),
('2024-03-10 12:00:00', 'Fantastico', 5, 'giulia.esposito@example.com', 'Arte Concettuale');

INSERT INTO Biglietto (NumeroSeriale, GiornoValidità, Audioguida, Sconto, PrezzoTot, Visitatore, Mostra) VALUES
('000000000000000', '2023-03-15', FALSE, 0, 10.00, 'laura.deluca@example.com', 'Impressionismo'),
('000000000000001', '2023-02-15', FALSE, 0, 10.00, 'alice.bianchi@example.com', 'Impressionismo'),
('000000000000002', '2023-01-15', TRUE, 0, 15.00, 'marco.rossi5@example.com', 'Rinascimento'),
('000000000000003', '2023-04-15', FALSE, 0, 10.00, 'giulia.esposito@example.com', 'Impressionismo'),
('000000000000004', '2023-05-15', FALSE, 0, 10.00, 'matteo.russo@example.com', 'Barocco'),
('000000000000005', '2023-06-15', FALSE, 0, 10.00, 'sara.ferrari@example.com', 'Modernismo'),
('000000000000006', '2023-07-15', FALSE, 0, 10.00, 'luca.martini@example.com', 'Impressionismo'),
('000000000000007', '2023-03-15', FALSE, 0, 10.00, 'chiara.romano@example.com', 'Cubismo'),
('000000000000008', '2023-09-15', FALSE, 0, 10.00, 'andrea.conti@example.com', 'Impressionismo'),
('000000000000009', '2023-03-15', TRUE, 0, 15.00, 'elena.ricci@example.com', 'Impressionismo'),
('000000000000010', '2023-04-15', FALSE, 0, 10.00, 'davide.moretti@example.com', 'Neoclassicismo'),
('000000000000011', '2023-03-15', FALSE, 0, 10.00, 'martina.colombo@example.com', 'Gotico'),
('000000000000012', '2023-02-15', FALSE, 0, 10.00, 'francesco.marino@example.com', 'Impressionismo'),
('000000000000013', '2021-02-15', FALSE, 0, 9.00, 'alessia.greco@example.com', 'Art Nouveau'),
('000000000000014', '2023-01-15', FALSE, 0, 7.00, 'simone.barbieri@example.com', 'Surrealismo');