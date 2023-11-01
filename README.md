# README

The solution to the problem is adding a counter_cache counter in the
`User` model. And resetting it to 0 through a cron job at the beggining of each month depending the time zone the user is in.

To register a user:

path: '/users/register'
params: { email: 'jhondoe@mail.com', timezone: 'Australia/Sydney' }