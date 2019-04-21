require File.join(File.dirname(__FILE__), 'gilded_rose')

require './vendor/bundle/ruby/2.6.0/gems/rspec-3.8.0/lib/rspec.rb'

describe GildedRose do
  describe "#update_quality" do
    it "does not change the name" do
      items = [
        Item.new("foo", 0, 0),
        Item.new("foo", 5, 5),
        Item.new("Aged Brie", 0, 0),
        Item.new("Aged Brie", 5, 5),
        Item.new("Sulfuras, Hand of Ragnaros", 0, 0),
        Item.new("Sulfuras, Hand of Ragnaros", 5, 5),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 0),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 5),
      ]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
      expect(items[0].sell_in).to eq -1
      expect(items[0].quality).to eq 0
      expect(items[1].name).to eq "foo"
      expect(items[1].sell_in).to eq 4
      expect(items[1].quality).to eq 4
      expect(items[2].name).to eq "Aged Brie"
      expect(items[2].sell_in).to eq -1
      expect(items[2].quality).to eq 2
      expect(items[3].name).to eq "Aged Brie"
      expect(items[3].sell_in).to eq 4
      expect(items[3].quality).to eq 6
      expect(items[4].name).to eq "Sulfuras, Hand of Ragnaros"
      expect(items[4].sell_in).to eq 0
      expect(items[4].quality).to eq 0
      expect(items[5].name).to eq "Sulfuras, Hand of Ragnaros"
      expect(items[5].sell_in).to eq 5
      expect(items[5].quality).to eq 5
      expect(items[6].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(items[6].sell_in).to eq -1
      expect(items[6].quality).to eq 0
      expect(items[7].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      expect(items[7].sell_in).to eq 4
      expect(items[7].quality).to eq 8

    end
  end

end
