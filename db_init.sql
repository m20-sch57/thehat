BEGIN;
CREATE TABLE Players
(
    UserID INTEGER not null auto_increment unique,
    constraint Players_PK primary key (UserID),
    Login CHAR(32) not null unique,
    Password TEXT not null,
    Username TEXT not null
);
CREATE TABLE Games
(
    GameID INTEGER not null auto_increment unique,
    constraint Games_PK primary key (GameID),
    Settings JSON not null DEFAULT ('{}'),
    WordsList JSON not null DEFAULT ('[]'),
    State TEXT not null,
    Players JSON not null DEFAULT ('[]'),
    Host TEXT not null,
    StartTime BIGINT,
    EndTime BIGINT,
    TimeZoneOffsets JSON not null DEFAULT ('[]'),
    Results JSON,
    Sent INTEGER default 0 not null
);
CREATE TABLE Participating
(
    GameID INTEGER not null unique,
    foreign key (GameID) references Games(GameID),
    UserID INTEGER not null,
    foreign key (UserID) references Players(UserID)
);
CREATE TABLE Dictionaries
(
    DictionaryID INTEGER not null unique,
    constraint Dictionaries_PK primary key (DictionaryID),
    DictionaryName TEXT not null
);
CREATE TABLE Words
(
    Word CHAR(32) not null unique,
    constraint Words_PK primary key (Word),
    Difficulty INTEGER not null,
    Used INTEGER not null,
    Tags TEXT not null,
    DictionaryID INTEGER not null
);
CREATE TABLE Rooms
(
    RoomKey CHAR(32) not null unique,
    constraint Rooms_PK primary key(RoomKey),
    GameID INTEGER unique,
    foreign key (GameID) references Games(GameID)
);
CREATE TABLE ExplanationRecords
(
    GameID INTEGER,
    foreign key (GameID) references Games(GameID),
    ExplNo INTEGER,
    SpeakerPos INTEGER not null,
    SpeakerID INTEGER,
    ListenerPos INTEGER not null,
    ListenerID INTEGER,
    Word TEXT not null,
    Time INTEGER not null,
    ExtraTime INTEGER not null,
    Outcome TEXT,
    constraint ER_PK primary key (GameID, ExplNo)
);
CREATE INDEX Participating_GameID_Index
    on Participating (GameID);
CREATE INDEX Participating_UserID_Index
    on Participating (UserID);
CREATE UNIQUE INDEX Players_Login_UIndex
    on Players (Login);
CREATE INDEX Words_Difficulty_Index
    on Words (Difficulty);
CREATE INDEX ER_GameID_Index
    on ExplanationRecords (GameID);
COMMIT;
