class RenameProjectVideoUrlToYoutubeId < ActiveRecord::Migration
  def change
    rename_column :projects, :video_url, :youtube_video_id
  end
end
