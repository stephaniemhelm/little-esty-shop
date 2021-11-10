# Little Esty Shop

"Little Esty Shop" is a fictitious e-commerce management platform for admins and merchants to oversee inventory, and track and fulfill customer invoices. "Little Esty Shop" is deployed via Heroku at [Little Esty Shop](https://rocky-tundra-78096.herokuapp.com/).

### Features: Merchants
#### Tools created to make it easy for your merchants to manage inventory and customers
Merchants can track items and invoices, and easily see favorite customers.
![Merchant Show Page](/app/assets/images/merchant_show.png)
Merchants can track and change the status of their items with the click of a button.
![Merchant Items Page](/app/assets/images/merchant_items_show.png)
Merchants can see individual items and update their attributes.
![Item Show Page](/app/assets/images/item_show.png)

### Features: Admins
#### Tools created to support site administrators simplify the tasks associated with managing complex commerce.
Admins can track merchants, invoices, and customers from a single central dashboard.
![Admin Dashboard](/app/assets/images/admin_dashboard.png)
With a simple click of a button, admins can enable or disable their merchants.
![Admin Merchants Show](/app/assets/images/admin_merchants_show.png)
Admins can track individual invoices and statistics with ease.
![Admin Invoices Show](/app/assets/images/admin_invoice_show.png)

## Shipping Changes
If you would like to make changes to this project, please contact the owner of this repository via GitHub.

## Setup

This project was developed via Ruby 2.7.2, on Rails 5.2.5. To access the dev environment for this app please follow these steps:
* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`

You can access the test suite (includes use of Capybara, FactoryBot, Faker, RSpec, and Pry) via `bundle exec rspec`. You can run the development server
with `rails s` to see the app in action.

## Contributors
This app was developed via Ruby on Rails by students at Turing School of Software and Design in 2021.
