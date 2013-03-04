class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@title = "#{@user.email}"
		@following_ids = current_user.followed_user_ids #created from has_many relationship
		@feed = MomentsUsers.where("user_id = ? OR user_id IN (?)", @user.id, @following_ids)
		@moments = @feed.map {|feed| Moment.find(feed.moment_id)}
		@moments = @moments.uniq
		#@feed_items = current_user.feed
	end

	def index
		@users = User.all
		@title = "All Users"
	end
end
