class Public::BaseController < ApplicationController
  before_action :authenticate_customer!, if: :use_auth?
  def use_auth?
    unless controller_name == 'homes' || controller_name == 'items'
      true
    end
  end
end
