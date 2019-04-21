class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      ItemQualityUpdaterFactory.new(item).create.update_item_quality
    end
  end
end

class ItemQualityUpdaterFactory
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def create
    if item.name == "Aged Brie"
      AgedBrieQualityUpdater.new(item)
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
      BackstagePassesQualityUpdater.new(item)
    elsif item.name == "Sulfuras, Hand of Ragnaros"
      SulfurasQualityUpdater.new(item)
    else
      NormalItemQualityUpdater.new(item)
    end
  end
end

class BaseItemQualityUpdater
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def increase_item_quality(item)
    item.quality = item.quality + 1 if item.quality < 50
  end

  def reduce_item_sell_in(item)
    item.sell_in -= 1
  end

  def reduce_item_quality(item)
    item.quality -= 1 if item.quality > 0
  end

  def reduce_item_quality_to_zero(item)
    item.quality = 0
  end

  def sell_date_passed?(item)
    item.sell_in < 0
  end
end

class AgedBrieQualityUpdater < BaseItemQualityUpdater
  def initialize(item)
    super
  end

  def update_item_quality
    increase_item_quality(item)

    reduce_item_sell_in(item)

    if sell_date_passed?(item)
      increase_item_quality(item)
    end
  end
end

class BackstagePassesQualityUpdater < BaseItemQualityUpdater
  def initialize(item)
    super
  end

  def update_item_quality
    reduce_item_sell_in(item)
    if sell_date_passed?(item)
      reduce_item_quality_to_zero(item)
    else
      increase_item_quality(item)

      if item.sell_in < 11
        increase_item_quality(item)
      end
      if item.sell_in < 6
        increase_item_quality(item)
      end
    end
  end

end

class SulfurasQualityUpdater < BaseItemQualityUpdater
  def initialize(item)
    super
  end

  def update_item_quality; end
end


class NormalItemQualityUpdater < BaseItemQualityUpdater
  def initialize(item)
    super
  end

  def update_item_quality
    reduce_item_sell_in(item)
    reduce_item_quality(item)
    reduce_item_quality(item) if sell_date_passed?(item)
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
