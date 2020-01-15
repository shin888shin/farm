class PagesController < ApplicationController
  def home
    @total_hits = Rails.cache.increment('total_hits')
    @hostname   = Socket.gethostname

    @total_animals_count = if Asset.where(name: 'Animal').first.present?
      Asset.where(name: 'Animal')
        .order('created_at desc')
        .limit(1)
        .first
        .count
    else
      0
    end

    @total_crops_count = if Asset.where(name: 'Crop').first.present?
      Asset.where(name: 'Crop')
        .order('created_at desc')
        .limit(1)
        .first
        .count
    else
      0
    end

    TotalAssetsJob.perform_later
  end

  def health_check
    head :ok
  end
end
