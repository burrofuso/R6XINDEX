
use my_stefanoburro;

CREATE TABLE OPERATORI (
    idoperatore VARCHAR(3) NOT NULL PRIMARY KEY,
    nome VARCHAR(50),
    ruolo VARCHAR(20),  
    abilita VARCHAR(100),
    velocita INT,
    armatura  INT,
    difficolta INT    
);

CREATE TABLE ARMI (
    idarma VARCHAR(3) NOT NULL PRIMARY KEY,
    nome VARCHAR(20),
    tipologia VARCHAR(20), 
    categoria VARCHAR(20), 
    caricatore int,
    danni int,
    descrizione VARCHAR(100)
);

CREATE TABLE UTILITIES (
    idutility VARCHAR(2) NOT NULL PRIMARY KEY,
    nome VARCHAR(20),
    descrizione VARCHAR(100),
    numero int
);

CREATE TABLE ATTACHMENTS (
    idattachment VARCHAR(3) NOT NULL PRIMARY KEY,
    nome VARCHAR(20) NOT NULL,
    descrizione VARCHAR(100) NOT NULL,
    categoria VARCHAR(20) NOT NULL                          
);

CREATE TABLE OPERATORE_ARMA (
    idoperatore VARCHAR(3),
    idarma VARCHAR(3),
    PRIMARY KEY (idoperatore, idarma),
    FOREIGN KEY (idoperatore) REFERENCES OPERATORI(idoperatore) ON DELETE CASCADE,
    FOREIGN KEY (idarma) REFERENCES ARMI(idarma) ON DELETE CASCADE
);

CREATE TABLE OPERATORE_UTILITY (
    idoperatore VARCHAR(3),
    idutility VARCHAR(2),
    PRIMARY KEY (idoperatore, idutility),
    FOREIGN KEY (idoperatore) REFERENCES OPERATORI(idoperatore) ON DELETE CASCADE,
    FOREIGN KEY (idutility) REFERENCES UTILITIES(idutility) ON DELETE CASCADE
);

CREATE TABLE ARMA_ATTACHMENT (
    idarma VARCHAR(3),
    idattachment VARCHAR(3),
    PRIMARY KEY (idarma, idattachment),
    FOREIGN KEY (idarma) REFERENCES ARMI(idarma) ON DELETE CASCADE,
    FOREIGN KEY (idattachment) REFERENCES ATTACHMENTS(idattachment) ON DELETE CASCADE
);

COMMIT;