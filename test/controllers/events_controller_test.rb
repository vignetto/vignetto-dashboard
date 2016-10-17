require "test_helper"

describe EventsController do
  let(:event) { events :one }

  it "gets index" do
    get :index
    value(response).must_be :success?
    value(assigns(:events)).wont_be :nil?
  end

  it "gets new" do
    get :new
    value(response).must_be :success?
  end

  it "creates event" do
    expect {
      post :create, event: {  }
    }.must_change "Event.count"

    must_redirect_to event_path(assigns(:event))
  end

  it "shows event" do
    get :show, id: event
    value(response).must_be :success?
  end

  it "gets edit" do
    get :edit, id: event
    value(response).must_be :success?
  end

  it "updates event" do
    put :update, id: event, event: {  }
    must_redirect_to event_path(assigns(:event))
  end

  it "destroys event" do
    expect {
      delete :destroy, id: event
    }.must_change "Event.count", -1

    must_redirect_to events_path
  end
end
