class TargetsController < ApplicationController
  before_action :set_target, only: [:show, :edit, :update, :destroy]

  # GET /targets
  def index
    @targets = Target.all
  end

  # GET /targets/1
  def show
  end

  # GET /targets/new
  def new
    @target = Target.new
  end

  # GET /targets/1/edit
  def edit
  end

  # POST /targets
  def create
    @target = Target.new(target_params)

    if @target.save
      redirect_to targets_path,
        notice: "Target #{ @target.label } was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /targets/1
  def update
    if @target.update(target_params)
      redirect_to targets_url, notice: 'Target was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /targets/1
  def destroy
    @target.destroy
    redirect_to targets_url, notice: 'Target was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_target
      @target = Target.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def target_params
      params.require(:target).permit(:label, :script)
    end
end
