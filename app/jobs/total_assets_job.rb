class TotalAssetsJob < ActiveJob::Base
    queue_as :default
  
    def perform(*args)
      sleep 5
      calculate_total_animals_asset
      calculate_total_crops_asset
    end

    def calculate_total_animals_asset
      Asset.create!(
        name: 'Animal',
        count: Animal.sum(:count)
      )
    end

    def calculate_total_crops_asset
      Asset.create!(
        name: 'Crop',
        count: Crop.sum(:acre)
      )
    end
end
  