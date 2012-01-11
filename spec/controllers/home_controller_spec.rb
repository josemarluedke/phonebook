require 'spec_helper'

describe HomeController do
    it "should get index" do
        get :index
        response.should be_success
    end

    it "should render the correct template" do
        get :index
        response.should render_template "index"
    end
end
