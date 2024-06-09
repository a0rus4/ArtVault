
/*Indici per opere interne */
CREATE INDEX idx_operaI_codice ON operainterna (id);
CREATE INDEX idx_operaI_autore ON operainterna (id_artista);
CREATE INDEX idx_operaI_data_produzione ON operainterna USING HASH (AnnoProduzione);

/*Indici per opere esterne */
CREATE INDEX idx_operaE_codice ON operaesterna (id);
CREATE INDEX idx_operaE_autore ON operaesterna (id_artista);
CREATE INDEX idx_operaE_data_produzione ON operaesterna USING HASH (AnnoProduzione);


/*Indici per i dipendenti */
CREATE INDEX idx_Direttore_cf ON Direttore USING HASH (cf);
CREATE INDEX idx_Direttore_email ON Direttore USING HASH (email);

CREATE INDEX idx_curatore_cf ON Curatore USING HASH (cf);
CREATE INDEX idx_curatore_email ON Curatore USING HASH (email);

CREATE INDEX idx_Restauratore_cf ON Restauratore USING HASH (cf);
CREATE INDEX idx_Restauratoree_email ON Restauratore USING HASH (email);

CREATE INDEX idx_Registrar_cf ON Registrar USING HASH (cf);
CREATE INDEX idx_Registrar_email ON Registrar USING HASH (email);