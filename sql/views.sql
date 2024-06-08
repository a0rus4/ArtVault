-- Vista sulle Mostre con informazioni sui Curatori ed il numero di Recensioni
CREATE VIEW MostreCuratoriRecensioni AS
	SELECT
		M.Nome AS NomeMostra,
		M.Prezzo,
		M.Descrizione,
		M.VotoMedio,
		C.Nome AS NomeCuratore,
		C.Cognome AS CognomeCuratore,
		COUNT(R.Timestamp) AS NumeroRecensioni
	FROM Mostra M
	LEFT JOIN Curatore C ON M.Curatore = C.CF
	LEFT JOIN Recensione R ON M.Nome = R.Mostra
	GROUP BY M.Nome, M.Prezzo, M.Descrizione, M.VotoMedio, C.Nome, C.Cognome
;

-- Vista sui Restauratori e le loro operazioni di Restauro
CREATE VIEW RestauratoriRestauri AS
	SELECT
		R.CF,
		R.Nome,
		R.Cognome,
		R.Qualifica,
		COUNT(Rest.ID) AS NumeroRestauri,
		MAX(Rest.DataFine) AS UltimoRestauro,
		L.Nome AS NomeLaboratorio
	FROM Restauratore R
	LEFT JOIN Restauro Rest ON R.CF = Rest.RestauratoreID
	LEFT JOIN Laboratorio L ON R.Laboratorio = L.Specializzazione
	GROUP BY R.CF, R.Nome, R.Cognome, R.Qualifica, L.Nome
;

-- Vista sui Prestiti con informazioni sugli Enti e i Registrar coinvolti
CREATE VIEW PrestitiDettagliati AS
	SELECT
		P.ID,
		COALESCE(OI.Titolo, OE.Titolo) AS TitoloOpera,
		P.DataInizio,
		P.DataFine,
		E.Nome AS NomeEnte,
		E.Tipo AS TipoEnte,
		E.Indirizzo AS IndirizzoEnte,
		Reg.Nome AS NomeRegistrar,
		Reg.Cognome AS CognomeRegistrar
	FROM Prestito P
	LEFT JOIN OperaInterna OI ON P.ID_OperaInterna = OI.ID
	LEFT JOIN OperaEsterna OE ON P.ID_OperaEsterna = OE.ID
	LEFT JOIN Ente E ON P.Ente = E.Telefono
	LEFT JOIN Registrar Reg ON P.Registrar = Reg.CF
;

-- Vista sui Biglietti venduti per Mostra con informaizoni sui Visitatori
CREATE VIEW BigliettiMostraVisitatore AS
	SELECT
		B.NumeroSeriale,
		B.GiornoValidità,
		B.Audioguida,
		B.Sconto,
		B.PrezzoTot,
		V.Nome AS NomeVisitatore,
		V.Cognome AS CognomeVisitatore,
		M.Nome AS NomeMostra,
		M.Prezzo AS PrezzoMostra
	FROM Biglietto B
	LEFT JOIN Visitatore V ON B.Visitatore = V.Email
	LEFT JOIN Mostra M ON B.Mostra = M.Nome
;

-- Vista sulle Partecipazioni agli Eventi da parte dei dipendenti
CREATE VIEW PartecipazioniEventi AS
	SELECT
		E.Nome AS NomeEvento,
		E.Data AS DataEvento,
		E.Descrizione AS DescrizioneEvento,
		Sala.ID AS IDSala,
		Sala.Tipo AS TipoSala,
		C.Nome AS NomeCuratore,
		C.Cognome AS CognomeCuratore,
		Res.Nome AS NomeRestauratore,
		Res.Cognome AS CognomeRestauratore,
		Reg.Nome AS NomeRegistrar,
		Reg.Cognome AS CognomeRegistrar
	FROM Evento E
	LEFT JOIN Sala ON E.Sala = Sala.ID
	LEFT JOIN
		PartecipazioneEventoCuratore PEC ON E.Sala = PEC.EventoSala AND
		E.Data = PEC.EventoData
	LEFT JOIN Curatore C ON PEC.Curatore = C.CF
	LEFT JOIN
		PartecipazioneEventoRestauratore PER ON E.Sala = PER.EventoSala
		AND E.Data = PER.EventoData
	LEFT JOIN Restauratore Res ON PER.Restauratore = Res.CF
	LEFT JOIN
		PartecipazioneEventoRegistrar PERG ON E.Sala = PERG.EventoSala
		AND E.Data = PERG.EventoData
	LEFT JOIN Registrar Reg ON PERG.Registrar = Reg.CF
;

-- Vista che mostra le informazioni di ogni dipendente
CREATE VIEW SalarioDipendenti AS
	SELECT
		'Curatore' AS Ruolo,
		C.CF, C.Nome, C.Cognome, C.Telefono, C.Email, C.Retribuzione,
		C.Qualifica,
		DataAssunzione DATE,
		DataLicenziamento DATE,
	FROM Curatore C
	UNION
		SELECT
			'Restauratore' AS Ruolo,
			R.CF,
			R.Nome,
			R.Cognome,
			R.Retribuzione AS Salario
		FROM Restauratore R
	UNION
		SELECT
			'Registrar' AS Ruolo,
			Reg.CF,
			Reg.Nome,
			Reg.Cognome,
			Reg.Retribuzione AS Salario
		FROM Registrar Reg
	UNION
		SELECT
			'Direttore' AS Ruolo,
			D.CF,
			D.Nome,
			D.Cognome,
			D.Retribuzione AS Salario
		FROM Direttore D
;
