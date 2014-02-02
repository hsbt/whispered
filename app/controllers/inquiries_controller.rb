class InquiriesController < ApplicationController
  before_filter :login_required

  respond_to :html

  def index
    @inquiries = DynamicModel.all.map{|model| model.limit(5)}.flatten
  end

  def search
    @inquiries = DynamicModel.all.map {|model|
      model.find(model.search(params[:q]).map(&:_id))
    }.flatten
    @inquiries = Kaminari.paginate_array(@inquiries).page(params[:page]).per(10)
  end

  def show
    @inquiry = params[:class_name].constantize.find(params[:id])
  end
end
