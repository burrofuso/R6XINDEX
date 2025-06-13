-- TABELLE PRINCIPALI

CREATE TABLE OPERATORI (
    idoperatore VARCHAR(3) NOT NULL PRIMARY KEY,
    nome VARCHAR(50)
);

CREATE TABLE ARMI (
    idarma VARCHAR(3) NOT NULL PRIMARY KEY,
    nome VARCHAR(20)
);

CREATE TABLE UTILITIES (
    idutility VARCHAR(2) NOT NULL PRIMARY KEY,
    nome VARCHAR(20)
);

CREATE TABLE ATTACHMENTS (
    idattachment VARCHAR(3) NOT NULL PRIMARY KEY,
    nome VARCHAR(20) NOT NULL,
    descrizione VARCHAR(100) NOT NULL
);

-- Tabelle ponte per relazioni n-n

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