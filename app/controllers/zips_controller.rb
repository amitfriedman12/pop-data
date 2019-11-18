class ZipsController < ApplicationController
  def show
    render json: RetrieveZipData.call(zip: params.require(:id))
  end
end