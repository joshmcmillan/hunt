class Api::V1::HuntsController < Api::V1::BaseController
  # GET /hunts
  # GET /hunts.json
  def index
  end

  # GET /hunts/1
  # GET /hunts/1.json
  def show
  end

  # POST /hunts
  # POST /hunts.json
  def create
    @hunt = Hunt.new(hunt_params)

    respond_to do |format|
      if @hunt.save
        format.html { redirect_to @hunt, notice: 'Hunt was successfully created.' }
        format.json { render action: 'show', status: :created, location: @hunt }
      else
        format.html { render action: 'new' }
        format.json { render json: @hunt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hunts/1
  # PATCH/PUT /hunts/1.json
  def update
    respond_to do |format|
      if @hunt.update(hunt_params)
        format.html { redirect_to @hunt, notice: 'Hunt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hunt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hunts/1
  # DELETE /hunts/1.json
  def destroy
    @hunt.destroy
    respond_to do |format|
      format.html { redirect_to hunts_url }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def hunt_params
      params[:hunt]
    end
end
