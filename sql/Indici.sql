
/*Indici per opere interne */
CREATE INDEX idx_operaI_codice ON operainterna (id);
CREATE INDEX idx_operaI_autore ON operainterna (id_artista);
CREATE INDEX idx_operaI_data_produzione ON operainterna ( AnnoProduzione);

/*Indici per opere esterne */
CREATE INDEX idx_operaE_codice ON operaesterna (id);
CREATE INDEX idx_operaE_autore ON operaesterna (id_artista);
CREATE INDEX idx_operaE_data_produzione ON operaesterna  (AnnoProduzione);


/*Indici per i dipendenti */
CREATE INDEX idx_Direttore_cf ON Direttore (cf);
CREATE INDEX idx_Direttore_email ON Direttore (email);

CREATE INDEX idx_curatore_cf ON curatore (cf);
CREATE INDEX idx_curatore_email ON curatore (email);

CREATE INDEX idx_Restauratore_cf ON Restauratore (cf);
CREATE INDEX idx_Restauratoree_email ON Restauratore (email);

CREATE INDEX idx_Registrar_cf ON Registrar (cf);
CREATE INDEX idx_Registrar_email ON Registrar (email);