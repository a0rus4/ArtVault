-- Uso procedure
CALL LicenziaDipendenteOggi('BNCLRC85M01H501Z', 'Atti osceni in luogo di lavoro');
SELECT CF, Timestamp, Descrizione, DataLicenziamento FROM RegistroModificheRestauratore JOIN Restauratore ON CF = Restauratore
	WHERE Restauratore = 'BNCLRC85M01H501Z';
	
CALL RiassumiDipendenteOggi('BNCLRC85M01H501Z', 'Atti osceni in luogo di lavoro falsi');
SELECT CF, Timestamp, Descrizione, DataLicenziamento FROM RegistroModificheRestauratore JOIN Restauratore ON CF = Restauratore
	WHERE Restauratore = 'BNCLRC85M01H501Z';

