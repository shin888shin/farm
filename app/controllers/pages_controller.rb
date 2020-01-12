class PagesController < ApplicationController
  def home
    @total_hits = Rails.cache.increment('total_hits')
    @hostname   = Socket.gethostname

    @total_animals_count = Asset.where(name: 'Animal')
      .order('created_at desc')
      .limit(1)
      .first
      .count

    @total_crops_count = Asset.where(name: 'Crop')
      .order('created_at desc')
      .limit(1)
      .first
      .count

    TotalAssetsJob.perform_later
  end

  def health_check
    head :ok
  end
end
