-- TABELLE PRINCIPALI

CREATE TABLE operators (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE weapons (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE utilities (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE attachments (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- TABELLE PONTE PER LE RELAZIONI N a N

CREATE TABLE operator_weapon (
    operator_id INT NOT NULL,
    weapon_id INT NOT NULL,
    PRIMARY KEY (operator_id, weapon_id),
    FOREIGN KEY (operator_id) REFERENCES operators(id) ON DELETE CASCADE,
    FOREIGN KEY (weapon_id) REFERENCES weapons(id) ON DELETE CASCADE
);

CREATE TABLE weapon_attachment (
    weapon_id INT NOT NULL,
    attachment_id INT NOT NULL,
    PRIMARY KEY (weapon_id, attachment_id),
    FOREIGN KEY (weapon_id) REFERENCES weapons(id) ON DELETE CASCADE,
    FOREIGN KEY (attachment_id) REFERENCES attachments(id) ON DELETE CASCADE
);

CREATE TABLE operator_utility (
    operator_id INT NOT NULL,
    utility_id INT NOT NULL,
    PRIMARY KEY (operator_id, utility_id),
    FOREIGN KEY (operator_id) REFERENCES operators(id) ON DELETE CASCADE,
    FOREIGN KEY (utility_id) REFERENCES utilities(id) ON DELETE CASCADE
);