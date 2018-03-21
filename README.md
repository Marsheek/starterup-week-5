StarterApp

rails new starterapp

cd starterapp

atom .

rails s

rails g controller pages home contact about privacy

config/routes.rb

Rails.application.routes.draw do
  root 'pages#home'

  get 'contact', to: 'pages#contact'

  get 'about', to: 'pages#about'

  get 'privacy', to: 'pages#privacy'

end

Gemfile

add the following gems

gem 'devise'
gem 'simple_form'
gem 'country_select'
gem 'bootstrap'
gem 'rails-jquery'
gem 'font-awesome-sass'

bundle

rails g devise:install

app/views/layouts/application.html.erb

add the below above the <%= yield %>

<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>

rails g devise User

rails db:migrate

rails g simple_form:install --bootstrap

app/assets/javascripts/application.js add the following below the turbolinks

//= require jquery3
//= require popper
//= require bootstrap

app/assets/stylesheets/application.css add the following and rename the application.css file to application.scss

@import 'bootstrap';
@import 'font-awesome-sprockets';
@import 'font-awesome';

navigate to http://getbootstrap.com/docs/4.0/components/navbar/#nav and copy the first code and add the code to the application.html.erb above the <p class="notice"><%= notice %></p>

See the sample code here:

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">Navbar</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Features</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Pricing</a>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled" href="#">Disabled</a>
      </li>
    </ul>
  </div>
</nav>

Go to the starter template on http://getbootstrap.com/docs/4.0/getting-started/introduction/ and copy the below lines of code and add them to your app/views/layouts/application.html.erb within the head section above the title.

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

Now we are going to create a partial for the navbar. Go to your app/views/layouts/application.html.erb highlight the entire nav. If you have the rails partial package installed in atom you can right click and generate partial naming it layouts/narbar

Navigate to the app/config/application.rb add the following below line 12

config.generators do |g|
  g.javascripts false
  g.stylesheets false
  g.helpers     false
end

navigate to your navbar partial and add the below loop that has 2 seperate conditions depending if the user is signed in or not. Add this below line 16 above the </ul> the <i> HTML tags use fontawesome icons to help display what each one is using the html_safe on the tags as they are within the String that will define the list item for example '<i class="fa fa-sign-out-alt"></i>Sign out'.html_safe

<% if user_signed_in? %>
  <li class="nav-item">
    <%= link_to '<i class="fa fa-sign-out-alt"></i>Sign out'.html_safe, destroy_user_session_path, method: :delete, class: 'nav-link' %>
  </li>
<% else %>
  <li class="nav-item">
    <%= link_to '<i class="fa fa-user-plus"></i>Register'.html_safe, new_user_registration_path, class: 'nav-link' %>
  </li>
  <li class="nav-item">
    <%= link_to '<i class="fa fa-sign-in-alt"></i>Sign in'.html_safe, new_user_session_path, class: 'nav-link' %>
  </li>
<% end %>

Navigate to https://getbootstrap.com/docs/4.0/components/jumbotron/ and copy the jumbotron from the bootstrap site and add the code to app/views/pages/home.html.erb

<div class="jumbotron">
  <h1 class="display-4">Hello, world!</h1>
  <p class="lead">This is a simple hero unit, a simple jumbotron-style component for calling extra attention to featured content or information.</p>
  <hr class="my-4">
  <p>It uses utility classes for typography and spacing to space content out within the larger container.</p>
  <p class="lead">
    <a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a>
  </p>
</div>

app/views/layouts/application.html.erb

We are now going to add a div with a container bootstrap class that will nest the <%= yield %> within it. See below example.

<div class="container">
  <%= yield %>
</div>

Now we are going to make the title of ever page dynamic. Google likes to rank pages based on the title they have provided. In order to do this we need update the content within the <title> html tags to the following code in app/views/layouts/application.html.erb

<title><%= content_for?(:title) ? yield(:title) : 'Your Default title here' %></title>

This is looking in the other views that are imported into the application.html.erb to see if they have content for a title to be placed in the title tags. It's using what we call a conditional if the content for :title is true the title will be inherited and added to the page title else it will display Your Default title.

Now we need to navigate to each of the app/views/pages and go into each of the files and add the content for the title that will be inherited in our application.html.erb

Add the below code to the applicable files:

<% content_for :title, "About" %> at the top of about.html.erb
<% content_for :title, "Contact" %> at the top of contact.html.erb
<% content_for :title, "Home" %> at the top of home.html.erb
<% content_for :title, "Privacy policy" %> at the top of privacy.html.erb

Now before we update the other pages we are going to finish the navbar links. Add the below code before the loop we created for uses to sign in and out deleting what was previously there. The whole div should read like the code below.

<div class="collapse navbar-collapse" id="navbarNav">
  <a class="navbar-brand" href="/">My fancy app</a>
  <ul class="navbar-nav">
    <li class="nav-item">
      <a class="nav-link <%= 'active' if current_page?(root_path) %>" href="/">Home</a>
    </li>
    <li class="nav-item">
      <a class="nav-link <%= 'active' if current_page?(about_path) %>" href="#">About</a>
    </li>
    <li class="nav-item">
      <a class="nav-link <%= 'active' if current_page?(contact_path) %>" href="/contact">Contact</a>
    </li>
    <% if user_signed_in? %>
      <li class="nav-item">
        <%= link_to '<i class="fa fa-sign-out-alt"></i>Sign out'.html_safe, destroy_user_session_path, method: :delete, class: 'nav-link' %>
      </li>
    <% else %>
      <li class="nav-item">
        <%= link_to '<i class="fa fa-user-plus"></i>Register'.html_safe, new_user_registration_path, class: 'nav-link' %>
      </li>
      <li class="nav-item">
        <%= link_to '<i class="fa fa-sign-in-alt"></i>Sign in'.html_safe, new_user_session_path, class: 'nav-link' %>
      </li>
    <% end %>
  </ul>
</div>

In terminal run the below command to generate the devise views.

rails g devise:views

Now navigate to app/views/devise/registrations/new.html.erb and update the code so that it reflects the below.

<div class="row">
  <div class="col-lg-4 ml-auto mr-auto">
    <div class="card card-body">

      <h2>Sign up</h2>

      <%= simple_form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
        <%= f.error_notification %>

        <div class="form-inputs">
          <%= f.input :email, required: true, autofocus: true %>
          <%= f.input :password, required: true, hint: ("#{@minimum_password_length} characters minimum" if @minimum_password_length) %>
          <%= f.input :password_confirmation, required: true %>
        </div>

        <div class="form-actions">
          <%= f.button :submit, "Sign up", class: 'btn btn-outline-success btn-lg' %>
        </div>
      <% end %>

      <%= render "devise/shared/links" %>

    </div>
  </div>
</div>

Challenge now that you updated the signup devise view see if you can figure out how to add the same card styling to the devise login page.

Solution go to app/views/devise/sessions/new.html.erb and update it to look like the code below.

<div class="row">
  <div class="col-lg-4 ml-auto mr-auto">
    <div class="card card-body">

      <h2>Log in</h2>

      <%= simple_form_for(resource, as: resource_name, url: session_path(resource_name)) do |f| %>
        <div class="form-inputs">
          <%= f.input :email, required: false, autofocus: true %>
          <%= f.input :password, required: false %>
          <%= f.input :remember_me, as: :boolean if devise_mapping.rememberable? %>
        </div>

        <div class="form-actions">
          <%= f.button :submit, "Log in", class: 'btn btn-outline' %>
        </div>
      <% end %>

      <%= render "devise/shared/links" %>
    </div>
  </div>
</div>

It's now time to create an Enquiry object through a scaffold so that we can receive enquiries from users. Run the below command in your terminal.

rails g scaffold Enquiry name email phone subject message:text

Now navigate to app/controllers/pages_controller.rb we need to give access to the enquiry objects in the contact instance within the controller so that we can access the enquiry object from our views. Update the contact method so it reflects the below:

def contact
  @enquiry = Enquiry.new
end

Now we are going to add the enquiries form to the app/views/pages/contact.html.erb below the title add the below code.

<div class="row">
  <div class="col-md-6">
    <h2>Get in touch</h2>
    <div class="card card-body">
      <%= render 'enquiries/form' %>
    </div>
  </div>
</div>

Now it's time to update the enquiry form. Navigate to the app/views/enquiries/_form.html.erb so that it looks like the code below.

<%= simple_form_for(@enquiry) do |f| %>
  <%= f.error_notification %>

  <div class="form-inputs">
    <div class="row">
      <div class="col-md-4">
        <%= f.input :name, label: false, placeholder: 'Your name' %>
      </div>
      <div class="col-md-4">
        <%= f.input :email, label: false, placeholder: 'Your email' %>
      </div>
      <div class="col-md-4">
        <%= f.input :phone, label: false, placeholder: 'Your phone' %>
      </div>
    </div>
    <%= f.input :subject, label: false,  collection: ['General enquiry', 'Website error'], promppt: 'Choose reason for enquiry' %>
    <%= f.input :message, label: false, placeholder: "Enter your message", input_html: { rows: 5 } %>
  </div>

  <div class="form-actions">
    <button type="submit" name="button" class="btn btn-primary">
      <i class="fa fa-paper-place"></i> Send Message
    </button>
  </div>
<% end %>

app/controllers/enquiries_controller.rb

Update the create method in the enquiries controller so that after it saves it redirects to the root path instead of to the enquiry. Your enquiry create method should read like the code below:

def create
  @enquiry = Enquiry.new(enquiry_params)

  respond_to do |format|
    if @enquiry.save
      format.html { redirect_to root_path, notice: 'Enquiry was successfully created.' }
      format.json { render :show, status: :created, location: @enquiry }
    else
      format.html { render :new }
      format.json { render json: @enquiry.errors, status: :unprocessable_entity }
    end
  end
end

Now we need to allow users to be able to create a new enquiry so we need to go to our enquiries controller and add the following code. app/controllers/enquiries_controller.rb

class EnquiriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :set_enquiry, only: [:show, :edit, :update, :destroy]

This will make it so that the devise authentication is skipped allowing the user to add an enquiry without being a signed user.

Now so that all the other objects can only be created by signed in users (other than enquiries new and create) we will need to set the folllowing code in the app/controllers/application_controller.rb

before_action :authenticate_user!

This is saying before users can have any action with the data objects they will need to be signed in.

Enquiry emailing

When you receive an enquiry most websites send 2 emails. One is to the person leaving the enquiry that lets them know the website has received the enquiry and the other is to the business letting them know what the enquiry was and from who.

To do this we run the below command in the terminal.

rails g mailer EnquiryMailer response received

The response is going to be sent to the person who made the enquiry and the received is going to be sent to the website owner.

When you run this command it will create a few files they are.

create  app/mailers/enquiry_mailer.rb
   invoke  erb
   create    app/views/enquiry_mailer
   create    app/views/enquiry_mailer/response.text.erb
   create    app/views/enquiry_mailer/response.html.erb
   create    app/views/enquiry_mailer/received.text.erb
   create    app/views/enquiry_mailer/received.html.erb

Now to create emails within the rails framework there is a layout for mailers that is in the app/views/layouts/mailer.html.erb. This file inherits from the app/views/enquiry_mailers that we just generated.

The app/mailers/application_mailer.rb is like the application controller of the mailers it's code reads:

class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end

Now we are going to update this code to what is below:

class ApplicationMailer < ActionMailer::Base
  default from: 'Your business name <info@yourbusinessdomain.com>'
  layout 'mailer'
end

This will be the default from address and subject of the mail.

Navigate to the app/mailer/enquiries_mailer.rb and update the response method so that the code reads the same as below:

def response(enquiry_id)
  @enquiry = Enquiry.find(enquiry_id)
  mail to: @enquiry.email, subject: "Hi " + @enquiry.name + ", Your enquiry has been received :)"
end

Now we are going to update the received method in the app/mailer/enquiries_mailer.rb

def received(enquiry_id)
  @enquiry = Enquiry.find(enquiry_id)
  mail to: "youremail@yourdomain.com", subject: "Hey! An enquiry has been received!"
end

Navigate to app/views/enquiry_mailer/response.html.erb and add the below code.

<h1>Hello <%= @enquiry.name %></h1>

<p>
  We have received your enquiry and one of our friendly team members will respond to you very soon.
</p>

<p>Thanks for getting in touch</p>

<p>Your name here</p>


Navigate to app/views/enquiry_mailer/received.html.erb and update the page so that the code reads the same as below:

<h1>Enquiry received</h1>

<p>
  <strong>Name:</strong>
  <%= @enquiry.name %>
</p>

<p>
  <strong>Email:</strong>
  <%= @enquiry.email %>
</p>

<p>
  <strong>Phone:</strong>
  <%= @enquiry.phone %>
</p>

<p>
  <strong>Subject:</strong>
  <%= @enquiry.subject %>
</p>

<p>
  <strong>Message:</strong>
  <%= @enquiry.message %>
</p>

Navigate to the app/models/enquiry.rb and add some validations to the data input into the form. Update the enquiry.rb to read the same as below:

class Enquiry < ApplicationRecord
  validates :name, :email, :message, presence: true
end

Navigate to the app/controllers/enquiries_controller.rb and update the create method to read like the code below:

def create
  @enquiry = Enquiry.new(enquiry_params)

  respond_to do |format|
    if @enquiry.save
      EnquiryMailer.response(@enquiry.id).deliver_now
      EnquiryMailer.received(@enquiry.id).deliver_now
      format.html { redirect_to root_path, notice: 'Enquiry was successfully created.' }
      format.json { render :show, status: :created, location: @enquiry }
    else
      format.html { render :new }
      format.json { render json: @enquiry.errors, status: :unprocessable_entity }
    end
  end
end

The two lines we added were the below. Now we are

EnquiryMailer.response(@enquiry.id).deliver_now
EnquiryMailer.received(@enquiry.id).deliver_now

Now we are going to go to a mailing service that we can use to send the email this is called mailgun. Go to www.mailgun.com and either sign in if you have an account or create an account.

Once you are in your dashboard click the button invite new receipient and add your email so you can receive the mail to your email address. This needs to be the same as the mail to: address that you wrote in the enquirapp/mailers/enqiry_mailer.rb

def received(enquiry_id)
  @enquiry = Enquiry.find(enquiry_id)
  mail to: "WHAT YOU WROTE HERE", subject: "Hey! An enquiry has been received!"
end

In mailgun navigate to Domains in the nav bar and click on the sandbox domian name it should look something like this:

sandboxd2ca72c72345234a70c831db4afe806.mailgun.org

Now we are going to navigate to the guides.rubyonrails.org/action_mailer_basics.html#action-mailer-configuration and copy the code below:

config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'example.com',
  user_name:            '<username>',
  password:             '<password>',
  authentication:       'plain',
  enable_starttls_auto: true  }

Now navigate into app/config/development.rb

change line 30 to read the below:

config.action_mailer.raise_delivery_errors = true

Then add the code below directly below line 30.

config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address:              'smtp.mailgun.org',
  port:                 587,
  domain:               'example.com',
  user_name:            '<username>',
  password:             '<password>',
  authentication:       'plain',
  enable_starttls_auto: true  }

the config/environments/development.rb & config/environments/production.rb are the 2 configuration files within the rails framework

What we are doing is configuring the email service in the development.rb

update the config/environments/development.rb so that the above reflects your mailgun credentials in with the action_mailer it should look something like the below

config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
            <!-- Update this with the below -->
  address:              'smtp.mailgun.org',
  port:                 587,
            <!-- Update this with your mailgun sandbox domain -->
  domain:               'sandboxd2ca72c743834d09a70c831db4afe806.mailgun.org',
            <!-- Update this with your mailgun sandbox user name -->
  user_name:            'postmaster@sandboxd2ca72c743834d09a70c831db4afe806.mailgun.org',
            <!-- Update this with your mailgun sandbox password -->
  password:             '1b5d7b9a6f933127a7aaea201012144a-e89319ab-94a696ee',
  authentication:       'plain',
  enable_starttls_auto: false  }

Now you should be able to send an enquiry and receive a response and received message.

Now we have added some API keys into the above smtp code in the config/envirnoments/development.rb above so we need to create some ENV (environment) variables to do this we will need to set them in our bash file so that it has access to the ENV variables in the development environment. to do this we update the config/environments/development.rb to read like the below:

config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address:              'smtp.mailgun.org',
  port:                 587,
  domain:               ENV['MAILGUN_DOMAIN'],
  user_name:            'postmaster@' + ENV['MAILGUN_DOMAIN'],
  password:             ENV['MAILGUN_PASSWORD'],
  authentication:       'plain',
  enable_starttls_auto: false  }

Now you will need to set the ENV variables in your bash profile so that they are perminately available in your machine.

Run the below command in your terminal to open your bash profile in atom

atom ~/.bash_profile

You will need to then add the by adding the following to the .bash_profile they should be added using your key looking something like the below:

export MAILGUN_DOMAIN=sandboxd2ca72c123456d09a70c831db4afe806.mailgun.org MAILGUN_PASSWORD=1b5d7b9a6f123456a7aaea201012144a-e89319ab-94a696ee

This will allow you to use the ENV['MAILGUN_DOMAIN'] & ENV['MAILGUN_PASSWORD'] in your other apps when you are setting the emails in your development environment.

When you push this code live you would need to update these to the live API keys in heroku.

Add gem 'rolify' to the Gemfile

run a bundle in your terminal to install the new gems

run the command

rails g rolify Role User

run the command

rails db:migrate

Navigate to app/views/layouts/_navbar.html.erb

Update the navbar with a new list (li) item with the below code and add the ml-auto bootstrap class to the navbar so that it displays on the right of the screen. This should be below line 8.

<ul class="navbar-nav ml-auto">
  <li class="nav-item">
    <a href="/users/sign_up?user_type=seller" class="nav-link">Sell Stuff</a>
  </li>

This code is creating a nav link that we can click if we want to become a seller. In order for to let rails know the person clicking wants to become a user we need to pass the parameters. This is the ?user_type=seller add at the end of the path. We then need to create a user_type field so that we can store the user_type we are going to create. The first step is to run the below command.

rails g migration AddUserTypeToUser user_type

Navigate to app/views/devise/registrations/new

Add the below code below line 10.

<% if params[:user_type] %>
  <%= f.input :user_type, as: :hidden, input_html: { value: params[:user_type] } %>
<% end %>

What we are doing here is checking if there are parameters for the user_type within the path that the user has clicked. So if the user clicked the SELL STUFF nav item. The user_type would be true and would be hidden as a input field when a user attempts to sign in from the SELL STUFF link.

Now we need to extend the devise controller. To do this we will need to go to the app/controllers/application_controller.rb and add the below code below the protect_from_forgery line 3.

before_action :configure_permitted_parameters, if: :devise_controller?

protected

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:user_type])
end

Now we need to go to the app/models/user.rb

And after line 7 within the end we need to add the below code.

after_commit :assign_role

def assign_role
  self.add_role self.user_type.to_sym if self.user_type
end

This code is calling the assign_role method after the user commits their registration. This assign_role method assigns the role that the user has associate with it in the user_type parameter if the user has the parameter user_type. The self is refering to the specific user that is triggering the method.

Now we need to restart our server with rails s and navigate to localhost:3000 in our browser.

We are going to test to see if the seller signup role gets assigned to the user when they sign up through the sell stuff link in the navbar.

In your browser on the app click the Sell Stuff link in the nav and sign up as a Seller. Once you have done this go back to your terminal and stop your server with control c

Now we need to go into the console with the below command.

rails c

Inside the console run the below command

User.last.has_role? :seller

The result should be true.

type the word exit to exit the rails console.

Insert an ERD diagram

Seller profile
- user
- id
- Name
- bio:text
- address
- suburb
- state
- postcode
- latitude:float
- longitude:float
- logo

We are now going to create the SellerProfile object with the below command in the terminal.

rails g scaffold SellerProfile user:belongs_to name bio:text logo address suburb state postcode country latitude:float longitude:float

migrate the database in the terminal run

rails db:migrate

Now we need to overide some of the methods in the devise controller. However, the devise controller isn't automatically generated into the app. To create this we need to run the below command in the terminal.

atom/controllers/registrations_controller.rb

If this doesnt work you can go to your controllers and right click, and click create new file named registrations_controller.rb

Then we need to add the below code into the app/controllers/registrations_controller.rb

class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if resource.user_type == 'seller'
      new_seller_profile_path
    end
  end
end

Now navigate to app/config/routes.rb and update the devise_for :user route so that it looks like the code below.

devise_for :users, controllers: { registrations: "registrations" }

This is extending the devise controller with our devise controller we have written. The method in the devise controller we have written will over ride the default method in the devise registrations_controller.rb

navigate to app/models/user.rb
Add the below code beneath class User < ApplicationRecord

has_one :seller_profile

Navigate to app/views/seller_profiles/new.html.erb

update the code to look like the below.

<div class="row">
  <div class="col-md-6">
    <h1>New Seller Profile</h1>
    <%= render 'form', seller_profile: @seller_profile %>
  </div>
</div>

app/views/seller_profiles/_form.html.erb

Update the code so that it reads like the below.

<%= simple_form_for(@seller_profile) do |f| %>
  <%= f.error_notification %>

  <div class="form-inputs">
    <%= f.input :name %>
    <%= f.input :bio %>
    <%= f.input :logo %>
    <%= f.input :address %>
    <div class="row">
      <div class="col-md-4">
          <%= f.input :suburb %>
      </div>
      <div class="col-md-4">
        <%= f.input :state, collection: ['NSW', 'ACT', 'QLD', 'WA', 'NT', 'SA', 'TAS'], promt: 'State' %>
      </div>
      <div class="col-md-4">
          <%= f.input :postcode %>
      </div>
      <%= f.input :country, priority: ['Australia'] %>
    </div>
  </div>

  <div class="form-actions">
    <%= f.button :submit %>
  </div>
<% end %>

Now we want to automatically associate the current user with the seller profile.

Navigate to the app/controllers/sellers_profiles_controller.rb

under line 27 add the following code inside the create method.

@seller_profile.user = current_user

Now we are going to add the geocoder gem to the gemfile.

gem 'geocoder'

Now stop your server in your terminal with a control c

In terminal run a bundle

update the app/models/seller_profile.rb so that it looks like the coe below.

class SellerProfile < ApplicationRecord
  belongs_to :user

  validates :address, :suburb, :state, :postcode, :country, presence: true

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    [address, suburb, state, postcode, country].join(', ')
  end
end

Now navigate to the app/views/seller_profile/show.html.erb and update the code to look like the below.

<div class="row">
  <div class="col-md-4">
    <div class="card card-body">
      <p>
        <strong>Email:</strong>
        <%= @seller_profile.user.email %>
      </p>

      <p>
        <strong>Name:</strong>
        <%= @seller_profile.name %>
      </p>

      <p>
        <strong>Bio:</strong>
        <%= @seller_profile.bio %>
      </p>

      <p>
        <strong>Logo:</strong>
        <%= @seller_profile.logo %>
      </p>

      <p>
        <strong>Address:</strong>
        <%= @seller_profile.full_address %>
      </p>

      <% if @seller_profile == current_user.seller_profile %>
        <%= link_to '<i class="fa fa-edit"></i> Edit'.html_safe, edit_seller_profile_path(@seller_profile), class: 'btn btn-primary' %>
      <% end %>

    </div>
  </div>
</div>


The loop at the bottom in with the if

Now we are going to integrate geocoder with the google maps api so we are able to display the sellers location on a map.

Go to https://developers.google.com/maps/documentation/javascript/ and hit the get a key button and copy the api key and paste it somewhere in the app/views/seller_profile.html.erb. We are going to use it later. It should look something like the below:

AIzaSyAuVd57_cY4EySknVTuq7xMozHvWFEAjcY

Now go to the following link https://developers.google.com/maps/documentation/javascript/adding-a-google-map

copy the below code from the above link and paste it in the app/assets/stylesheets/application.scss

#map {
      height: 400px;
      width: 100%;
     }

Now we need to add the map into the app/views/seller_profile/show.html.erb to do this we need to make the code look like the below. Notice we added the two scripts and the div id map.

<div class="row">
  <div class="col-md-4">
    <div class="card card-body">
      <p>
        <strong>Email:</strong>
        <%= @seller_profile.user.email %>
      </p>

      <p>
        <strong>Name:</strong>
        <%= @seller_profile.name %>
      </p>

      <p>
        <strong>Bio:</strong>
        <%= @seller_profile.bio %>
      </p>

      <p>
        <strong>Logo:</strong>
        <%= @seller_profile.logo %>
      </p>

      <p>
        <strong>Address:</strong>
        <%= @seller_profile.full_address %>
      </p>

      <div id="map"></div>

      <% if @seller_profile == current_user.seller_profile %>
        <%= link_to '<i class="fa fa-edit"></i> Edit'.html_safe, edit_seller_profile_path(@seller_profile), class: 'btn btn-primary' %>
      <% end %>

    </div>
  </div>
</div>

<script>
  function initMap() {
    var uluru = {lat: -25.363, lng: 131.044};
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 4,
      center: uluru
    });
    var marker = new google.maps.Marker({
      position: uluru,
      map: map
    });
  }
</script>
<script async defer
src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap">
</script>

Now we need to add your api key to the the last script where it says YOUR_API_KEY you will need to delete this and replace it with your api key.

Change this
<script async defer
src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap">
</script>

To this
<script async defer
src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAuVd57_cY4EySknVTuq7xMozHvWFEAjcY&callback=initMap">
</script>

Now we are going to make the map dynamic so that it displays the location of the seller on the map. to do this we need to update the first script in the app/views/seller_profile/show.html.erb so that it looks like the code below

<script>
  function initMap() {
    var location = {lat: <%= seller_profile.latitude %>, lng: <%= seller_profile.longitude %>};
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 4,
      center: location
    });
    var marker = new google.maps.Marker({
      position: location,
      map: map
    });
  }
</script>

Now to test this navigate to your browser and go to localhost:3000/seller_profiles/1 making sure you're signed in as the user who owns the profile. Click the edit profile button and update the profile with the same details. When it loads you should see google maps in the card with the sellers profile details.

Now we have finished google maps we need to add the following 2 gems to allow us to upload some images within the application. The first one we will be integrating is the sellers logo.

Navigate to the gem file and add the below 2 gems



run a bundle in your terminal to install the rubygems

now we need to run the below command in the terminal
rails g uploader SellerProfileLogo

Now we need to update the app/uploders/seller_profile_logo_uploader.rb so that it has all we need in it. Update it so that it looks like the below:

class SellerProfileLogoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  # Add a white list of extensions which are allowed to be uplodaer
  # For images you might use something like this
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end

Now navigate to app/models/seller_profile.rb and add the below line of code below the geocoded_by :full_address line above the def full_address method

mount_uploader :logo, SellerProfileLogoUploader

Now we need to add the api keys from cloudinary to do this we need to go to the cloudinary dashboard. So sign up to cloudinary and get to the https://cloudinary.com/console and download the cloudinary.yml file from the download: YML section just below the nav bar to the blue join the cloudinary community button on the right.

Now once you have downloaded this you need to add the cloudinary.yml into the app/config

Now navigate to the app/views/seller_profile/show.html.erb and update the code so that it looks like the below:

<div class="row">
  <div class="col-md-4">
    <div class="card">
      <%= image_tag @seller_profile.logo_url, class: 'card-img-top' %>
      <div class="card-body">
        <h5 class="card-title"><%= @seller_profile.name %></h5>

        <p>
          <strong>Email:</strong>
          <%= @seller_profile.user.email %>
        </p>

        <p>
          <strong>Bio:</strong>
          <%= @seller_profile.bio %>
        </p>

        <p>
          <strong>Logo:</strong>
          <%= @seller_profile.logo %>
        </p>

        <p>
          <strong>Address:</strong>
          <%= @seller_profile.full_address %>
        </p>

        <div id="map"></div>

        <% if @seller_profile == current_user.seller_profile %>
          <%= link_to '<i class="fa fa-edit"></i> Edit'.html_safe, edit_seller_profile_path(@seller_profile), class: 'btn btn-primary' %>
        <% end %>
      </div>
    </div>
  </div>
</div>

<script>
  function initMap() {
    var location = {lat: <%= @seller_profile.latitude %>, lng: <%= @seller_profile.longitude %> };
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 4,
      center: location
    });
    var marker = new google.maps.Marker({
      position: location,
      map: map
    });
  }
</script>
<script async defer
src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAuVd57_cY4EySknVTuq7xMozHvWFEAjcY&callback=initMap">
</script>

Now we are going to install another gem friendly_id that makes for a unique url that displays the seller profile name.

Update the gemfile with:

gem 'friendly_id'

bundle

rails g friendly_id

rails g migration AddSlugToSellerProfile slug:uniq

Now before we migrate we need to update we need to update the migration file in the app/db/migrate/ and find the create_friendly_id_slug migration and add the below to the end of line 1:

[5.1]

rails db:migrate

Now navigate to app/models/seller_profile.rb and add below the mount_uploader

extend FriendlyId
friendly_id :name, use: :slugged

now navigate to the app/controllers/seller_profiles_controller.rb and update line 67 so that it looks like the code below:

@seller_profile = SellerProfile.friendly.find(params[:id])

Now that we have finished the seller profile we are going to work through the the product.

Insert ERD showing production

product
- id
- name
- description
SellerProfilesControllerimage
num_in_stock
seller_profile_id

In your terminal run the below command to generate the Product object with the attributes and associations.

rails g scaffold Product seller_profile:belongs_to name description:text image price:decimal num_in_stock:integer

rails db:migrate

Now go to your app/models/product.rb and check that it belongs to seller_profile and update it so that it has the validations below.

class Product < ApplicationRecord
  belongs_to :seller_profile

  validates :name, :description, :image, :price, :num_in_stock, presence: true

  validates :price, :num_in_stock, numericality: { greater_than_or_equal_to: 0 }
end

Now navigate to app/models/seller_profile.rb and underneath line 2 add the below code.

has_many :products

now we are going to generate another uploader for the Product image attribute. In your terminal run the below command.

rails g uploader ProductImage

navigate to the product_image_iploader.rb and update it so the code looks like the below:

class ProductImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end

Now navigate to your app/models/product.rb and update it so it is the same as the code below.
<!-- fix here -->

class Product < ApplicationRecord
  belongs_to :seller_profile

  mount_uploader :image, ProductImageUploader

  validates :name, :description, :image, :price, :num_in_stock, presence: true
end

In the app/views/seller_profile/show.html.erb add the below code above the last closing </div>

<div class="col-md-8">
  <button type="button" class="btn btn-primary" data-toggle="modal" data-toggle="modal" data-target="#exampleModal">
    <i class="fa fa-plus-square"></i> Add Product
  </button>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <%= render 'products/form' %>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

Update the app/views/products/_form.html.erb so that it reads the below:

<%= simple_form_for(@product, remote: true) do |f| %>
  <%= f.error_notification %>

  <div class="form-inputs">
    <%= f.input :name %>
    <%= f.input :description %>
    <%= f.input :image %>
    <%= f.input :price %>
    <%= f.input :num_in_stock %>
  </div>

  <div class="form-actions">
    <%= f.button :submit %>
  </div>
<% end %>

Update your create method and show method in your app/controllers/product_controller.rb so that it reflects the below

def show
  @product = Product.new
  @products = @seller_profile.products
end

def create
  @product = Product.new(product_params)
  @product.seller_profile = currnt_user
  respond_to do |format|
    if @product.save  
      format.js
    else
      format.html { render :new }
      format.json { render json: @product.errors, status: :unprocessable_entity }
    end
  end
end



app/views/product create a new file create.js.erb

app/views/seller_profile/show.html.erb update below the button around line 39 so that it reflects the code below:

<div class="col-md-8">
  <button type="button" class="btn btn-primary" data-toggle="modal" data-toggle="modal" data-target="#exampleModal">
    <i class="fa fa-plus-square"></i> Add Product
  </button>
  <!-- add code below here -->
  <hr>
  <div class="card">
    <div class="card-body">
      <div class="row">
        <div class="col-md-2">
          <%= image_tag product.image_url, class: 'img-fluid' %>
        </div>
        <div class="col-md-10">
          <h5 class="card-title"><%= product.name %></h5>
          <p><%= product.description %></p>
        </div>
      </div>
    </div>
  </div>
</div>


Highlight the below code within your code and right click and generate a partial. Call the partial products/product.

<div class="card">
  <div class="card-body">
    <div class="row">
      <div class="col-md-2">
        <%= image_tag product.image_url, class: 'img-fluid' %>
      </div>
      <div class="col-md-10">
        <h5 class="card-title"><%= product.name %></h5>
        <p><%= product.description %></p>
      </div>
    </div>
  </div>
</div>

Where the partial is generate and reads <%= render 'products/product' %> update it so that it reads like the code below:

<%= render @products %>

Now navigate to app/views/products/create.js.erb

$('#product-list').append('<%= j render @product %>');
$('#exampleModal').modal('hide')

Make title of product a link to the product show pages
Make  
