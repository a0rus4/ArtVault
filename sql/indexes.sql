
/*Indice per opere interne */
CREATE INDEX idx_operaI_Titolo ON operainterna USING HASH (Titolo);

/*Indice per opere esterne */
CREATE INDEX idx_operaE_Titolo ON operaesterna USING HASH (Titolo);

/*Indice per biglietto*/
CREATE INDEX idx_Biglietti_NumeroSeriale ON Direttore USING HASH (NumeroSeriale);

/*Indice per visitatori*/
CREATE INDEX idx_Visitatori_email ON Visitatore USING HASH (Email)
