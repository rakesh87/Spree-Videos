module Spree
  class Video < ActiveRecord::Base
    belongs_to :watchable, :polymorphic => true, :touch => true

    # attr_accessible :youtube_ref
    validates_presence_of :youtube_ref
    validates_uniqueness_of :youtube_ref, :scope => [:watchable_id, :watchable_type]

    def youtube_data
      YouTubeIt::Client.new.video_by(self.youtube_ref)
    end
  
    after_validation do
      self.youtube_ref.match(/(v=|\/)([\w-]+)(&.+)?$/) { |m| self.youtube_ref = m[2] }
    end
  end
end