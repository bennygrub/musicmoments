class MomentsController < ApplicationController
  require 'uri'
  # GET /moments
  # GET /moments.json
  def index
    @moments = Moment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @moments }
    end
  end

  # GET /moments/1
  # GET /moments/1.json
  def show
    @moment = Moment.find(params[:id])
    @moment_uri = URI(@moment.song)
    @temp_users = TempUser.where("moment = ?", @moment.id)

    @regex_youtube = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]{11,11}).*/
    @regex_vimeo = /https?:\/\/(?:www\.)?vimeo.com\/(?:channels\/|groups\/([^\/]*)\/videos\/|album\/(\d+)\/video\/|)(\d+)(?:$|\/|\?)/
    
    if @moment_uri.host == 'www.youtube.com' || @moment_uri.host == 'youtu.be'
      @youtube_id = @moment.song.match(@regex_youtube)[2]
    elsif @moment_uri.host == 'vimeo.com'
      @youtube_id = @moment.song.match(@regex_vimeo)[3]
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @moment }
    end
  end

  # GET /moments/new
  # GET /moments/new.json
  def new
    @moment = Moment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @moment }
    end
  end

  # GET /moments/1/edit
  def edit
    @moment = Moment.find(params[:id])
  end

  # POST /moments
  # POST /moments.json
  def create
    @moment = Moment.new(params[:moment])
    unless @moment.song[/^https?:\/\//] 
      @moment.song = 'http://' + @moment.song
    end

    respond_to do |format|
      if @moment.save
        format.html { redirect_to @moment, notice: 'Moment was successfully created.' }
        format.json { render json: @moment, status: :created, location: @moment }
      else
        format.html { render action: "new" }
        format.json { render json: @moment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /moments/1
  # PUT /moments/1.json
  def update
    @moment = Moment.find(params[:id])

    respond_to do |format|
      if @moment.update_attributes(params[:moment])

        #@moment.split(/, */).each do |friend|
         # @user = User.find_by_email(friend)
          #if MomentsUser.where("user_id = ?", @user.id).count < 1 && TempUser.where("email = ?", friend).count < 1

         # end

        #end

        format.html { redirect_to @moment, notice: 'Moment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @moment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moments/1
  # DELETE /moments/1.json
  def destroy
    @moment = Moment.find(params[:id])
    @moment.destroy

    respond_to do |format|
      format.html { redirect_to moments_url }
      format.json { head :no_content }
    end
  end
end
