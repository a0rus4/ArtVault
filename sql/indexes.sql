
/*Indice per opere interne */
CREATE INDEX idx_operaI_TitoloB ON operainterna (Titolo);

/*Indice per opere esterne */
CREATE INDEX idx_operaE_TitoloB ON operaesterna (Titolo);

/*Indice per biglietto*/
CREATE INDEX idx_Biglietti_NumeroSerialeB ON Direttore  (NumeroSeriale);

/*Indice per visitatori*/
CREATE INDEX idx_Visitatori_emailB ON Visitatore (Email)


/*Indice per opere interne */
CREATE INDEX idx_operaI_TitoloH ON operainterna USING HASH (Titolo);

/*Indice per opere esterne */
CREATE INDEX idx_operaE_TitoloH ON operaesterna USING HASH (Titolo);

/*Indice per biglietto*/
CREATE INDEX idx_Biglietti_NumeroSerialeH ON Direttore USING HASH (NumeroSeriale);

/*Indice per visitatori*/
CREATE INDEX idx_Visitatori_emailH ON Visitatore USING HASH (Email)
