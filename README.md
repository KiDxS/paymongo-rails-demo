# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## To do
- [x] Create a checkout session
- [ ] Create a webhook
- [ ] If a `checkout_session.payment.paid` event notification is sent, retrieve the session id and set the `status` to `paid` in the payments table.

## Credentials

```
  user@mail.com:user123
  test@mail.com:test123
```