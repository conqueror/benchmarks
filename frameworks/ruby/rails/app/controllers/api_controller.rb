class ApiController < ApplicationController
  def index
    response['Date'] = Time.now.httpdate
    head 200
  end

  def user
    response['Date'] = Time.now.httpdate
    render plain: params['id']
  end

  def register_user
    response['Date'] = Time.now.httpdate
    head 200
  end
end
