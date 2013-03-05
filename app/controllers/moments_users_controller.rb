class MomentsUsersController < ApplicationController
  def index
  	@title = "Tag Invitations"
  	@moments_users = MomentsUsers.where("user_id = ?", current_user.id)
  	#@tags = @moments_users.map{ |moment_user| moment_user.moment_id }
  end

  def edit
  
  end

  def update
  	@moment_user = MomentsUsers.find(params[:id])
 
  	respond_to do |format|
	    if @moment_user.update_attributes(params[:moments_users])
	      format.html  { redirect_to(moments_users_path,
	                    :notice => 'Tag was successfully updated.') }
	      format.json  { head :no_content }
	    else
	      format.html  { render :action => "edit" }
	      format.json  { render :json => @moment_user.errors,
	                    :status => :unprocessable_entity }
	    end
  	end
  end
  def destroy
  	@moment_user = MomentsUsers.find(params[:id])
  	@moment_user.destroy
 
  	respond_to do |format|
    	format.html { redirect_to(moments_users_path, :notice => 'Tag was successfully deleted.') }
    	format.json { head :no_content }
  	end
  end
end
