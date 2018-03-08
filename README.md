StarterApp

rails new starterapp

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

Navigate to the app/application.rb add the following below line 12

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
