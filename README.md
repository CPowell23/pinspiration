# <a name="top"></a> README

## Outline
  1. [Overview of Pinspiration](#overview)
  2. [Website Preview](#preview)
  3. [Setup Instructions](#setup)
  4. [Deployment Instructions](#deploy)
  5. [How to Run the Test Suite](#test)
  6. [Team Members](#team)

## <a name="overview"></a> Overview of Pinspiration
Summary of project coming soon...

## <a name="preview"></a> Website Preview
The following screen shots provide a brief visual of the appearance and functionality of the application. The full website is deployed on Heroku and accessible via this link: [https://pinspirations.herokuapp.com/](https://pinspirations.herokuapp.com/)

Insert screenshots of the app...

### Database Diagram
![alt text][database]

[database]: linkTBD "Pinspirations Database Diagram"

### User Authorizations Summary
![alt text][authorizations]

[authorizations]: linkTBD "Pinspirations Authorizations Summary"

### What to Expect When Consuming the API
  - All endpoints will return JSON data
  - All endpoints are exposed under an api and version (v1) namespace (e.g. /api/v1/boards.json)

## <a name="setup"></a> Setup Instructions
Run these commands in this order:
```
git clone https://github.com/CPowell23/pinspiration.git
cd pinspiration
bundle
rails db:create
rails db:migrate
rails db:seed
rails db:test:prepare
```
NOTE: Do we need to include setup instructions for Travis CI?

## <a name="deploy"></a> Deployment Instructions
To launch the project on local host, start up the rails server and...
```
rails s
```
### <a name="routes"></a> API Routes Available

####Comments (placeholder example)
  - **/api/v1/merchants/:id/items** - returns a collection of items associated with that merchant
  - **/api/v1/merchants/:id/items** - returns a collection of items associated with that merchant
  - **/api/v1/merchants/:id/invoices** - returns a collection of invoices associated with that merchant from their known
  - **/api/v1/merchants/:id/revenue** - returns the total revenue for that merchant across all transactions
  - **/api/v1/merchants/:id/revenue?date=x** - returns the total revenue for that merchant for a specific invoice date x
  - **/api/v1/merchants/:id/favorite_customer** - returns the customer with the highest count of succesful transactions associated with that merchant
  - **/api/v1/merchants/:id/customers_with_pending_invoices** - returns a collection of customers which have pending invoices.

####Important Notes (placeholder example)
  - The dates provided match the format of a standard ActiveRecord timestamp (e.g. 2012-03-22T03:55:09.000Z).
  - Failed charges are never counted in revenue totals or statistics.
  - All revenues are reported as a float with two decimal places, but prices are stored as integers.
  

## <a name="test"></a> How to Run the Test Suite
Run rspec from the command line:
```
rspec
```

## <a name="team"></a> Team Members
Insert summary of how we are Turing students
Include a link to the Turing website
Include links to our personal githubs, etc.

[Back to Top](#top)
