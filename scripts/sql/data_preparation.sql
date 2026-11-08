MAZANÍ A ZMĚNA NÁZVŮ SLOUPCŮ

alter table olympic_athletes
rename column athlete_url to url,
rename column athlete_full_name to full_name

DEFINOVÁNÍ PROMĚNNÝCH

alter table olympic_athletes
modify column url varchar(128) not null,
modify column full_name varchar(50) not null,
modify column games_participations tinyint not null,
modify column first_game varchar(40),
modify column athlete_year_birth smallint, 
modify column athlete_medals varchar(30);

alter table olympic_hosts
modify column id varchar(40) not null,
modify column game_location varchar(30) not null,
modify column game_name varchar(40) not null,
modify column game_season varchar(10) not null,
modify column game_year smallint not null;

alter table olympic_medals
modify column discipline_title varchar(30) not null,
modify column game_id varchar(40) not null,
modify column event_title varchar(70) not null,
modify column event_gender varchar(10) not null,
modify column medal_type varchar(10) not null,
modify column participant_type varchar(10) not null,
modify column participant_title varchar(50),
modify column athlete_url varchar(128);

VYTVOŘENÍ SLOUPCŮ TABULKY

SELECT * FROM projekt.olympic_athletes;
alter table olympic_athletes
add column gold_medals tinyint after athlete_medals;
UPDATE olympic_athletes
SET gold_medals = 
	CASE WHEN athlete_medals like '%G%' then substring(athlete_medals,4,1)
    END

alter table olympic_athletes
add column silver_medals varchar(10) after gold_medals;
UPDATE olympic_athletes
SET silver_medals = 
	CASE WHEN athlete_medals like '%S%' then substring_index(substring_index(athlete_medals,'S',1),'G',-1)
    END

SELECT * FROM projekt.olympic_athletes;
update olympic_athletes
set silver_medals = '1' 
where silver_medals like '%1%' ...až do 7

alter table olympic_athletes
add column bronze_medals tinyint after silver_medals;
UPDATE olympic_athletes
SET bronze_medals = 
	CASE WHEN athlete_medals like '%B%' then substring(athlete_medals,-5,1)
    END

VYTVOŘENÍ VIEW

CREATE VIEW `top_athletes_by_medals` AS
    SELECT 
        url,
        full_name,
        games_participations,
        first_game,
        athlete_year_birth,
        athlete_medals,
        gold_medals,
        silver_medals,
        bronze_medals,
        bio
    FROM
        olympic_athletes
    ORDER BY gold_medalsbDESC , silver_medals DESC , bronze_medals DESC


