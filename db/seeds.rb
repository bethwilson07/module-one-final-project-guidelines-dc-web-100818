Player.destroy_all
Team.destroy_all
League.destroy_all

player1 = Player.create(name: "Tim Howard", position: "GK")
player2 = Player.create(name: "Mohammed Salah", position: "Mid")
player3 = Player.create(name: "Ronaldo", position: "Forward")
player4 = Player.create(name: "Lionel Messi", position: "Forward")
player5 = Player.create(name: "Romelu Lukaku", position: "Forward")
player6 = Player.create(name: "Sergio Ramos", position: "Defender")
player7 = Player.create(name: "Luis Suarez", position: "Forward")
player8 = Player.create(name: "Neymar, Jr.", position: "Mid")
player9 = Player.create(name: "Carlos Vela", position: "Forward")
player10 = Player.create(name: "Gerard Pique", position: "Defender")
player11 = Player.create(name: "Gianluigi Buffon", position: "GK")

team1 = Team.create(name: "Everton", city: "Liverpool")
team2 = Team.create(name: "Liverpool", city: "Liverpool")
team3 = Team.create(name: "Juventus", city: "Turin")
team4 = Team.create(name: "FC Barcelona", city: "Barcelona")
team5 = Team.create(name: "Manchester United", city: "Manchester")
team6 = Team.create(name: "Real Madrid", city: "Madrid")
team7 = Team.create(name: "PSG", city: "Paris")
team8 = Team.create(name: "LA Galaxy", city: "Los Angeles")


epl = League.create(name: "English Primier League", nation: "England")
liga = League.create(name: "La Liga", nation: "Spain")
lige = League.create(name: "Lige 1", nation: "France")
mls = League.create(name: "US Major League Soccer", nation: "USA")
italy = League.create(name: "Serie a", nation: "Italy")
