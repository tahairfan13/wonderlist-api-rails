require 'rails_helper'

RSpec.describe "ProjectsApis", type: :request do
  describe "GET /projects_apis" do


    it "User is added" do
     user = FactoryGirl.build(:user)
     auth = FactoryGirl.build(:auth, user:user)
     expect {
       post auth_sign_up_path, params: {
           name: user.name,
           email: user.email,
           username: user.username,
           password: auth.password,
           password_confirmation: auth.password
       }
     }.to change(User.all, :count).by(1)

     expect(response).to have_http_status(:success)
    end


    it "User is signed In" do
      auth = FactoryGirl.create(:auth) # here we use create bcz user must be present before logged in.
      expect {
        post auth_sign_in_path, params: {
            username: auth.user.username,
            password: auth.password
        }
      }.to change(Session.all, :count).by(1)
      expect(response).to have_http_status(:success)
    end


    it "User view his lists" do
      auth = FactoryGirl.create(:auth) # here we use create bcz user must be present before logged in.

      list = List.new(name:"List",user:auth.user)
      list.save


      session = auth.user.sessions.build
      session.save

      #puts "#{session.stoken}"


      get lists_path, headers: {
          sid: session.id,
          stoken: session.stoken
          }

      expect(response).to have_http_status(200)

       json = JSON.parse(response.body)
      expect(json["lists"].length).to eq 1

       list_id = json["lists"][0]["id"]
        puts "#{list_id}"

      get list_path(list_id), headers: { # now checking the individual list
          sid: session.id,
          stoken: session.stoken
      }

      expect(response).to have_http_status(200)
      json2=JSON.parse(response.body)

      expect(json["lists"][0]["name"]).to eq "#{json2['name']}" # checking that the result is same or not

    end

    it "User update his lists" do

    end

  end
  end
