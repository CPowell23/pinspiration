# <a name="top"></a> README

## Outline
  1. [Overview of Pinspiration](#overview)
  2. [Website Preview](#preview)
  3. [Setup Instructions](#setup)
  4. [Deployment Instructions](#deploy)
  5. [How to Run the Test Suite](#test)
  6. [Team Members](#team)

## <a name="overview"></a> Overview of Pinspiration
A Pinterest clone in two weeks!

## <a name="preview"></a> Website Preview
The following screen shots provide a brief visual of the appearance and functionality of the application. The full website is deployed on Heroku and accessible via this link: [https://pinspirations.herokuapp.com/](https://pinspirations.herokuapp.com/)

Insert screenshots of the app...

### Database Diagram
![alt text][database]

[database]: https://github.com/CPowell23/pinspiration/blob/master/database_graphic_v1.png "Pinspirations Database Diagram"

### User Authorizations Summary
![alt text][authorizations]

[authorizations]: https://github.com/CPowell23/pinspiration/blob/master/authorizations_graphic.png "Pinspirations Authorizations Summary"

**Authorization Notes:**
 - Admin authorizations apply to all users’ content, including boards tagged as private.
 - Admins are not able to delete users, but they are able to take them offline under necessary circumstances, rendering their user profile inactive and preventing anyone from accessing content created by the innactive user.
 - Registered user authorizations apply only to content that is self-created or shared by other users. Registered users are able to read all public boards, pins, and comments, and they are also able to read private boards, pins, and comments that are shared with them by the owner.
 - User account information is only available to the owner and admins. Passwords are encrypted and never viewed by admins.


### What to Expect When Consuming the API
  - All endpoints will return JSON data
  - All endpoints are exposed under an api and version (v1) namespace (e.g. /api/v1/pins/pin_id/comments.json)

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

## <a name="deploy"></a> Deployment Instructions
To launch the project on local host, start up the rails server and...
```
rails s
```
### <a name="routes"></a> API Routes Available

#### Comments
  - **get /api/v1/pins/:id/comments?api_key=YOUR_API_KEY** - returns a collection of comments associated with that pin
  - **get /api/v1/pins/:id/:comment_id?api_key=YOUR_API_KEY** - returns one comment with that :comment_id
  - **post /api/v1/pins/:id/comments?api_key=YOUR_API_KEY** - returns a collection of invoices associated with that merchant from their known
  - **put /api/v1/pins/:id/:comment_id'?api_key=YOUR_API_KEY** - edits a comment associated with that :comment id, send the comment.content through the params[:body]
  - **delete /api/v1/pins/:id/:comment_id?api_key=YOUR_API_KEY** - will delete a comment associated with that :comment_id


## <a name="test"></a> How to Run the Test Suite
Run rspec from the command line:
```
rspec
```

## <a name="team"></a> Team Members

#### Group Members
* [Amy 'The Tank' Kintner](https://github.com/akintner)
* [Caroline 'Wildcard' Powell](https://github.com/CPowell23)
* [The Infamous Molly Brown](https://github.com/mollybrown)
* [Annie 'Macaroni' Wolff](https://github.com/wlffann)
* [Lucy 'Maverick' Conklin](https://github.com/lucyconklin)

[Back to Top](#top)
