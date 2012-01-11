require 'spec_helper'

describe Users::OmniauthCallbacksController do
  before do
    @user = Factory :user
    sign_in @user
  end
end