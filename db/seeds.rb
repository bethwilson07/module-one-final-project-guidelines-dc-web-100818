Player.destroy_all
Team.destroy_all
League.destroy_all

epl = League.create(name: "English Primier League", nation: "England", year_founded: "1987", description: "lots of info")
liga = League.create(name: "La Liga", nation: "Spain", year_founded: "1999", description: "lots of info")
lige = League.create(name: "Lige 1", nation: "France", year_founded: "1977", description: "lots of info")
mls = League.create(name: "US Major League Soccer", nation: "USA", year_founded: "1967", description: "lots of info")
italy = League.create(name: "Serie a", nation: "Italy", year_founded: "1985", description: "lots of info")

team1 = Team.create(name: "Everton", city: "Liverpool", league: epl, year_founded: "1987", manager: "Chris Hughton", description: "lots of info", stadium_name: "FedEx Field", stadium_location: "London, England")
team2 = Team.create(name: "Liverpool", city: "Liverpool", league: epl, year_founded: "1999", manager: "Chris Hughton", description: "lots of info", stadium_name: "FedEx Field", stadium_location: "Paris, France")
team3 = Team.create(name: "Juventus", city: "Turin", league: italy, year_founded: "1987", manager: "Chris Hughton", description: "lots of info", stadium_name: "Camden Yards", stadium_location: "Baltimore, MD")
team4 = Team.create(name: "FC Barcelona", city: "Barcelona", league: liga, year_founded: "1985", manager: "Eddie Howe", description: "lots of info", stadium_name: "Camden Yards", stadium_location: "Baltimore, MD")
team5 = Team.create(name: "Manchester United", city: "Manchester", league: epl, year_founded: "1987", manager: "Eddie Howe", description: "lots of info", stadium_name: "Falmer Stadium", stadium_location: "Falmer, England")
team6 = Team.create(name: "Real Madrid", city: "Madrid", league: liga, year_founded: "1999", manager: "Eddie Howe", description: "lots of info", stadium_name: "Falmer Stadium", stadium_location: "Falmer, England")
team7 = Team.create(name: "PSG", city: "Paris", league: lige, year_founded: "1967", manager: "Sean Dyche", description: "lots of info", stadium_name: "Turf Moor", stadium_location: "Giant's Causeway, Scottland")
team8 = Team.create(name: "LA FC", city: "Los Angeles", league: mls, year_founded: "1985", manager: "Sean Dyche", description: "lots of info", stadium_name: "Turf Moor", stadium_location: "Giant's Causeway, Scottland")

player1 = Player.create(name: "Tim Howard", position: "GK", team: team1, birthdate: "1985-09-10", birth_location: "Tulle, France", nationality: "France", date_signed: "2010-07-07", signing_status: "£9,700,000", player_description: "lots of stuff", height: "1.85", weight: "73.47")
player2 = Player.create(name: "Mohammed Salah", position: "Mid", team: team2, birthdate: "1985-09-10", birth_location: "Tulle, France", nationality: "France", date_signed: "2010-07-07", signing_status: "£9,700,000", player_description: "lots of stuff", height: "1.85", weight: "73.47")
player3 = Player.create(name: "Ronaldo", position: "Forward", team: team3, birthdate: "1985-09-10", birth_location: "Tulle, France", nationality: "France", date_signed: "2010-07-07", signing_status: "£9,700,000", player_description: "lots of stuff", height: "1.85", weight: "73.47")
player4 = Player.create(name: "Lionel Messi", position: "Forward", team: team4, birthdate: "1995-03-19", birth_location: "Barcelona", nationality: "Spain", date_signed: "2012-07-01", signing_status:"Signed", player_description: "lots of stuff", height: "1.78", weight: "0")
player5 = Player.create(name: "Romelu Lukaku", position: "Forward", team: team5, birthdate: "1995-03-19", birth_location: "Barcelona", nationality: "Spain", date_signed: "2012-07-01", signing_status:"Signed", player_description: "lots of stuff", height: "1.78", weight: "0")
player6 = Player.create(name: "Sergio Ramos", position: "Defender", team: team6, birthdate: "1995-03-19", birth_location: "Barcelona", nationality: "Spain", date_signed: "2012-07-01", signing_status:"Signed", player_description: "lots of stuff", height: "1.78", weight: "0")
player7 = Player.create(name: "Luis Suarez", position: "Forward", team: team4, birthdate: "1990-12-26", birth_location: "Caerphilly, Wales", nationality: "Wales", date_signed: "2008-06-13", signing_status: "£5,000,000", player_description: "lots of stuff", height: "1.78", weight: "69.84")
player8 = Player.create(name: "Neymar, Jr.", position: "Mid", team: team7, birthdate: "1990-12-26", birth_location: "Caerphilly, Wales", nationality: "Wales", date_signed: "2008-06-13", signing_status: "£5,000,000", player_description: "lots of stuff", height: "1.78", weight: "69.84")
player9 = Player.create(name: "Carlos Vela", position: "Forward", team: team8, birthdate: "1990-12-26", birth_location: "Caerphilly, Wales", nationality: "Wales", date_signed: "2008-06-13", signing_status: "£5,000,000", player_description: "lots of stuff", height: "1.78", weight: "69.84")
player10 = Player.create(name: "Gerard Pique", position: "Defender", team: team6, birthdate: "1988-08-31", birth_location: "Medellín", nationality: "Columbia", date_signed: "2014-07-27", signing_status: "£3,000,000", player_description: "lots of stuff", height: "1.83", weight: "76.64")
player11 = Player.create(name: "Gianluigi Buffon", position: "GK", team: team7, birthdate: "1988-08-31", birth_location: "Medellín", nationality: "Columbia", date_signed: "2014-07-27", signing_status: "£3,000,000", player_description: "lots of stuff", height: "1.83", weight: "76.64")
