/*Indice per opere interne */
CREATE INDEX idx_operaI_TitoloH ON operainterna USING HASH (Titolo);

/*Indice per opere esterne */
CREATE INDEX idx_operaE_TitoloH ON operaesterna USING HASH (Titolo);

/*Indice per biglietto*/
CREATE INDEX idx_Biglietto_NumeroSerialeH ON Biglietto USING HASH (NumeroSeriale);

/*Indice per visitatori*/
CREATE INDEX idx_Visitatori_emailH ON Visitatore USING HASH (Email)
