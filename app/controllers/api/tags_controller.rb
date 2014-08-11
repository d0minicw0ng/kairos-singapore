class Api::TagsController < ApplicationController

  def skills
    @skills = ::ActsAsTaggableOn::Tag.where tag_type: "skill"
    render json: @skills.to_json, status: :ok
  end
end
