class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, inverse_of: :tutorial
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def self.authorized_for_viewer(user)
    if user.nil?
      Tutorial.where(classroom: false)
    else
      Tutorial.all
    end
  end

  def import_video(video)
    videos.create!(title: video[:snippet][:title], description: video[:snippet][:description], video_id: video[:id], thumbnail: video[:snippet][:thumbnails][:default][:url])
  end
end
