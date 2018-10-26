
describe "Player" do

  describe "#nationality" do
    it "knows a player's country" do
      tim = Player.create(name: "Tim", nationality: "United States")

      expect(tim.nationality).to eq("United States")
    end
  end

  describe ".all_players_from_nation" do
    it "knows all players from a country" do
      arev = Player.create(name: "Arev Varjabedian", nationality: "Armenia")
      kim = Player.create(name: "Kim Kardashian", nationality: "Armenia")
      kevorkian = Player.create(name: "Dr. Kevorkian", nationality: "Armenia")

      expect(Player.all_players_from_nation("Armenia")).to include("Arev Varjabedian")
      expect(Player.all_players_from_nation("Armenia")).to include("Kim Kardashian")
      expect(Player.all_players_from_nation("Armenia")).to include("Dr. Kevorkian")
    end
  end
end

describe "League" do

  describe "#league_age" do

    it "knows the age of a league" do
      winner = League.create(name: "Winner's League", year_founded: "1988")

      expect(winner.league_age).to eq(30)
    end
  end

  describe ".oldest" do

    it "knows the oldest league" do

      millenials = League.create(name: "Millenial's League", year_founded: "1688")
      winner = League.create(name: "Winner's League", year_founded: "1690")
      middle = League.create(name: "Middle League", year_founded: "1692")
      gen_y = League.create(name: "Gen-Y's League", year_founded: "1698")

      expect(League.oldest).to eq("Millenial's League is the oldest league on our record. It was founded in 1688.")
    end
  end

  describe ".youngest" do

    it "knows the youngest league" do

      millenials = League.create(name: "Millenial's League", year_founded: "1688")
      winner = League.create(name: "Winner's League", year_founded: "1690")
      middle = League.create(name: "Middle League", year_founded: "1692")
      gen_y = League.create(name: "Gen-Y's League", year_founded: "2098")

      expect(League.youngest).to eq("Gen-Y's League is the youngest league on our record. It was founded in 2098.")
    end
  end
end
