# README

The solution to the problem is adding a counter_cache in the hits model and the proper column in the `User` model, resetting it to 0 through a cron job at the beginning of each month based on the time zone the user is in.

To register a user:

path: ```/users/register```
params: ```{ email: 'jhondoe@mail.com', timezone: 'Australia/Sydney' }```

To install the cron jobs where the API is running:

```
$ whenever --update-crontab
```