HOUR_TIME_FORMAT = '%Y%m%d'

class PerformanceSnapshotsController < ApplicationController
  before_action :set_performance_snapshot, only: [:show, :edit, :update, :destroy]

  # GET /performance_snapshots
  def index
    epoch_date = if ENV['EPOCH_DATE']
                   Date.new(*ENV['EPOCH_DATE'].split('-'))
                 else
                   PerformanceSnapshot.minimum(:created_at)
                 end
    epoch_date ||= 1.week.ago

    @performance_snapshots =
      PerformanceSnapshot
        .order('id DESC')
        .where('created_at > ?', epoch_date)

    @ps_timedata = []
    Target.all.each do |target|
      timedata = {}
      ps_timedata = []
      @performance_snapshots.where(target_id: target.id).each do |ps|
        vc = ps.visual_complete

        key = ps.created_at.strftime(HOUR_TIME_FORMAT)
        timedata[key] ||= []
        timedata[key] << vc
      end

      timedata.each do |hour_time_key, values|
        average = values.inject(:+).to_f / values.size
        ps_timedata << [Time.parse(hour_time_key), average]
      end
      @ps_timedata << { name: target.label, data: ps_timedata }
    end
  end

  # GET /performance_snapshots/1
  def show
  end

  # GET /performance_snapshots/new
  def new
    @performance_snapshot = PerformanceSnapshot.new
  end

  # GET /performance_snapshots/1/edit
  def edit
  end

  # POST /performance_snapshots
  def create
    @performance_snapshot = PerformanceSnapshot.new(performance_snapshot_params)

    if @performance_snapshot.save
      redirect_to @performance_snapshot, notice: 'Performance snapshot was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /performance_snapshots/1
  def update
    if @performance_snapshot.update(performance_snapshot_params)
      redirect_to @performance_snapshot, notice: 'Performance snapshot was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /performance_snapshots/1
  def destroy
    @performance_snapshot.destroy
    redirect_to performance_snapshots_url, notice: 'Performance snapshot was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_performance_snapshot
      @performance_snapshot = PerformanceSnapshot.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def performance_snapshot_params
      params.require(:performance_snapshot).permit(:first_byte, :first_paint, :render, :load_time, :full_load_time, :total_bytes, :requests, :url)
    end
end
